#include "one_wire_functions.h"

#define MAX_SENZORA 20

/* ROM komande */

#define READ_ROM 0x33
#define MATCH_ROM 0x55
#define SKIP_ROM 0xCC
#define SEARCH_ROM 0xF0
#define ALARM_SEARCH 0xEC

/* Memorijske komande */

#define READ_SCRATCHPAD 0xBE
#define COPY_SCRATCHPAD 0x48
#define CONVERT_T 0x44
#define RECALL_E2 0xB8
#define READ_POWER_SUPPLY 0xB4

/* Konfiguracija LCD-a */

sbit LCD_RS at RB5_bit;
sbit LCD_EN at RB3_bit;
sbit LCD_D4 at RD4_bit;
sbit LCD_D5 at RD5_bit;
sbit LCD_D6 at RD6_bit;
sbit LCD_D7 at RD7_bit;

sbit LCD_RS_Direction at TRISB5_bit;
sbit LCD_EN_Direction at TRISB3_bit;
sbit LCD_D4_Direction at TRISD4_bit;
sbit LCD_D5_Direction at TRISD5_bit;
sbit LCD_D6_Direction at TRISD6_bit;
sbit LCD_D7_Direction at TRISD7_bit;

/* Kraj konfiguracije LCD-a */

char SlaveROM0[8];
char i;
char tmp2[3];

//unsigned int tempDigitalno;
char* tempDigitalnoString;

const unsigned short TEMP_RESOLUTION = 9;

//char *text = "000.0000";
char text[8];
unsigned temp;

char TextBuffer[3];
unsigned char postojeciSenzor;
unsigned char brStarihSenzora = 0;
unsigned char ROMovi[MAX_SENZORA][8];
unsigned char ROM_NO[8];
unsigned int temperatureDigitalne[MAX_SENZORA];


unsigned char istiROMovi(unsigned char * rom1, unsigned char * rom2)
{
    int i=0;
    for(i=0;i<8;i++)
    {
        if(rom1[i]!=rom2[7-i])
             return 0;
    }
    return 1;
}
void dodajNoviSenzor()
{
    if ( Ow_First() )
    {
         if(brStarihSenzora==0)
         {
              for(i=0;i<8;i++)
              {
                  ROMovi[0][i] = ROM_NO[7-i];
              }
              brStarihSenzora++;
         }
         else
         {
              postojeciSenzor = 0;
              for(i = 0; i < brStarihSenzora; i++)
              {
                  if(istiROMovi(ROMovi[i],ROM_NO))
                  {
                      postojeciSenzor = 1;
                      break;
                  }
              }
              if(postojeciSenzor == 0)
              {
                  for(i=0;i<8;i++)
                  {
                   ROMovi[brStarihSenzora][i] = ROM_NO[7-i];
                  }
                  brStarihSenzora++;
              }
         }

        while ( Ow_Next() )
        {
           postojeciSenzor = 0;
           for(i = 0; i < brStarihSenzora; i++)
           {
              if(istiROMovi(ROMovi[i],ROM_NO))
              {
                   postojeciSenzor = 1;
                   break;
              }
           }
           if(postojeciSenzor == 0)
           {
              for(i=0;i<8;i++)
              {
                      ROMovi[brStarihSenzora][i] = ROM_NO[7-i];
              }
              brStarihSenzora++;

           }
        }
    }
    else
    {
            Lcd_out(1,1,"Nijedan senzor!");
    }
}


void Display_Temperature(unsigned char i, unsigned char j, unsigned int temp2write) {
  const unsigned short RES_SHIFT = TEMP_RESOLUTION - 8;
  char temp_whole;
  unsigned int temp_fraction;

  // Check if temperature is negative
  if (temp2write & 0x8000) {
       text[0] = '-';
       temp2write = ~temp2write;
       // Extract temp_whole
       temp_whole = temp2write >> RES_SHIFT ;
     }
   else
   {
         // Extract temp_whole
         temp_whole = temp2write >> RES_SHIFT ;
         if (temp_whole/100)
             text[0] = temp_whole/100  + 48;
  else
     text[0] = '0';
   }


  // Convert temp_whole to characters


  text[1] = (temp_whole/10)%10 + 48;             // Extract tens digit
  text[2] =  temp_whole%10     + 48;             // Extract ones digit
        text[3]  ='.';
  // Extract temp_fraction and convert it to unsigned int
  temp_fraction  = temp2write << (4-RES_SHIFT);
  temp_fraction &= 0x000F;
  temp_fraction *= 625;

  // Convert temp_fraction to characters
  text[4] =  temp_fraction/1000    + 48;         // Extract thousands digit
  text[5]=223;
  text[6]='C';
  text[7]=0;
  //text[5] = (temp_fraction/100)%10 + 48;         // Extract hundreds digit
  //text[6] = (temp_fraction/10)%10  + 48;         // Extract tens digit
  //text[7] =  temp_fraction%10      + 48;         // Extract ones digit

  // Print temperature on LCD
  Lcd_Out(i, j, text);
}


unsigned int citajTemp(unsigned char *x)
{
    unsigned int tempDigitalno;
    unsigned char scratchPad0[9];

    Ow_Reset();                         // Onewire reset signal
    Ow_Write_Byte(0x55);              // Issue command MATCH_ROM
    for(i = 0; i < 8; i++)
    {
       Ow_Write_Byte(x[7-i]);
    }
    Ow_Write_Byte(0x44);              // Issue command CONVERT_T
    Delay_us(120);

    Ow_Reset();                         // Onewire reset signal
    Ow_Write_Byte(0x55);              // Issue command MATCH_ROM
    for(i = 0; i < 8; i++)                       // This MUST follow MATCH_ROM
    {
       Ow_Write_Byte(x[7-i]);
    }
    Ow_Write_Byte(0xBE);        // Issue command READ_SCRATCHPAD

    for(i = 0; i < 2; i++)
    {
     scratchPad0[i] = Ow_Read_Byte();
    }

    //ByteToHex(scratchPad0[0],tmp2);
    //Lcd_out(2,1,tmp2);
    //ByteToHex(scratchPad0[1],tmp2);
    //Lcd_out(2,10,tmp2);

    tempDigitalno = scratchPad0[0];
    tempDigitalno = (scratchPad0[1] << 8) + tempDigitalno;
    
    return tempDigitalno;
}

void main()
{
     int i,j;
     asm{
         MOVLW 15      // Set RB<4:0> as digital I/O pins (required if config bit PBADEN is set)
         MOVWF ADCON1  //ADCON1 = 0b00001111
         MOVLW 7       //Dakle, TRISB = 0b00000111
         MOVWF TRISB   //RB<2:0> su ulazi a RB<7:3> izlazi
         MOVLW 32      //Dakle, TRISA = 0b00111111
         MOVWF TRISA
        }
        TRISD = 0b00000000;

        TRISC.RC6 = 0;

        LATC.RC6 = 0;
        LATB.RB4 = 0;

        INTCON.GIE = 0;

        Lcd_Init();
        Lcd_Cmd(_LCD_CLEAR);        // CLEAR display
        Lcd_Cmd(_LCD_CURSOR_OFF);   // Cursor off
        Delay_ms(100);


        // inicijalizacija matrice romova
        for(i=0;i<MAX_SENZORA;i++)
        {
            for(j=0;j<8;j++)
                ROMovi[i][j]=0;
            temperatureDigitalne[i]=0;
        }
        dodajNoviSenzor();
        //IntToStr(brStarihSenzora,tmp2);
        //Lcd_out(1,1,tmp2);
        //Delay_ms(1000);
           
        // Glavna petlja pocinje ovde
        while(1)
        {

                for(i = 0; i < brStarihSenzora; i++)
                {

                     temperatureDigitalne[i] = citajTemp(ROMovi[i]);
                     //Delay_ms(2000);
                     Display_Temperature((i/2)%2 + 1,i % 2 == 0 ? 1 : 9, temperatureDigitalne[i]);

                     /*
                     //ispis trenutnog ROM-a u drugom redu LCD-a
                     for( j=0;j<8;j++)
                     {
                         ByteToHex(ROMovi[i][j],tmp2);
                         Lcd_out(2,j*2+1,tmp2);
                     }*/

                }

        }  // Glavna petlja se zavrsava ovde

}  // end main function