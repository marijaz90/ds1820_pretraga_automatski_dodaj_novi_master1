#include "one_wire_functions.h"

#define MAX_SENZORA 16

/* ROM komande */

#define READ_ROM 0x33
#define MATCH_ROM 0x55
#define SKIP_ROM 0xCC
#define SEARCH_ROM 0xF0
//#define ALARM_SEARCH 0xEC

/* Memorijske komande */

#define READ_SCRATCHPAD 0xBE
//#define COPY_SCRATCHPAD 0x48
#define CONVERT_T 0x44
//#define RECALL_E2 0xB8
//#define READ_POWER_SUPPLY 0xB4

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

char i,k;
char tmp2[3];

char* tempDigitalnoString;

const unsigned short TEMP_RESOLUTION = 9;

//char *text = "000.0000";
char text[7];
char ROMByte[3];
unsigned temp;

char TextBuffer[3];
unsigned char postojeciSenzor;
unsigned char brStarihSenzora = 0;
unsigned char brTrenutnihSenzora = 0;
unsigned char brNovihSenzora = 0;
unsigned char ROMovi[MAX_SENZORA][8];
unsigned char EEPROMmatrica[MAX_SENZORA][8];
unsigned char ROM_NO[8];
unsigned int temperatureDigitalne[MAX_SENZORA];

char EEPROMFlagovi[MAX_SENZORA];
char SenzoriFlagovi[MAX_SENZORA];

void EEPROMuMatricu()
{
     char i,j;
     brStarihSenzora =  EEPROM_Read(0xFF);

     for(i = 0; i < brStarihSenzora; i++)
     {
           for(j = 0; j < 8; j++)
           {
                 EEPROMmatrica[i][j] = EEPROM_Read(i*16+j);
                 Delay_ms(50);
           }
     
     }
}

void MatricaUEEPROM()
{
     char i,j;
     for(i = brStarihSenzora; i < brNovihSenzora ; i++)
     {
           for(j = 0; j < 8; j++)
           {
                 EEPROM_Write(i*16+j,EEPROMmatrica[i][j]);
                 Delay_ms(50);
           }

     }
     EEPROM_Write(0xFF,brNovihSenzora);
}

unsigned char istiROMovi(unsigned char * rom1, unsigned char * rom2)
{
    char i=0;
    for(i=0;i<8;i++)
    {
        if(rom1[i]!=rom2[i])    // da bi dodajNoviSenzor radila treba rom2[7-1]
        {
         return 0;
        }
    }
    return 1;
}
/*void dodajNoviSenzor()
{
     brNovihSenzora=brStarihSenzora;
    if ( Ow_First() )
    {
       if(brStarihSenzora==0)
       {
            for(i=0;i<8;i++)
            {
                ROMovi[0][i] = ROM_NO[7-i];
            }
            brNovihSenzora++;
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
                brNovihSenzora++;
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
              brNovihSenzora++;

           }
        }
    }
    else
    {
        Lcd_out(1,1,"Nijedan senzor!");
    }
}*/
void skenirajSenzore()
{
     int i,j,k;
     
     for(i=0; i < MAX_SENZORA; i++)
     {
         SenzoriFlagovi[i]=-1;
         EEPROMFlagovi[i]=-1;
     }
    brTrenutnihSenzora = 0;
    if ( Ow_First() )
    {
         for(i=0;i<8;i++)
         {
             ROMovi[brTrenutnihSenzora][i] = ROM_NO[7-i];
         }
         postojeciSenzor = 0;
           for(i = 0; i < brStarihSenzora; i++)
           {
              if(istiROMovi(EEPROMMatrica[i],ROMovi[brTrenutnihSenzora]))
              {
                   postojeciSenzor = 1;
                   SenzoriFlagovi[brTrenutnihSenzora] = 1;
                   EEPROMFlagovi[i] = 1;
                   break;
              }
           }
           if(postojeciSenzor == 0)
           {
                SenzoriFlagovi[brTrenutnihSenzora] = 0;
           }
           brTrenutnihSenzora++;
    }
    else
    {
        if(brStarihSenzora==0)
        {
         Lcd_out(1,1,"Nijedan senzor!");
         }
    }
    while ( Ow_Next() )
    {
      for(i=0;i<8;i++)
       {
           ROMovi[brTrenutnihSenzora][i] = ROM_NO[7-i];
       }
       postojeciSenzor = 0;
       for(i = 0; i < brStarihSenzora; i++)
       {
          if(istiROMovi(EEPROMMatrica[i],ROMovi[brTrenutnihSenzora]))
          {
               postojeciSenzor = 1;
               SenzoriFlagovi[brTrenutnihSenzora] = 1;
               EEPROMFlagovi[i] = 1;
               break;
          }
       }
       if(postojeciSenzor == 0)
       {
            SenzoriFlagovi[brTrenutnihSenzora] = 0;
       }
       brTrenutnihSenzora++;
    }

    
    for(i=0;i<brStarihSenzora;i++)
    {
       if(EEPROMFlagovi[i]!=1)
       {
            EEPROMFlagovi[i]=0;
       }
    }
    
    // ubacivanje novih u EEPROM
    //INTtostr(brTrenutnihSenzora,tmp2);
    //Lcd_out(2,1,tmp2);
    //Delay_ms(1000);
    for(i=0; i<brTrenutnihSenzora; i++)
    {
        if(SenzoriFlagovi[i]==0)
        {
           postojeciSenzor=0;
           for(j=0;j<brStarihSenzora;j++)
           {

              if(EEPROMFlagovi[j]==0)
              {
                   postojeciSenzor=1;
                   for(k=0;k<8;k++)
                   {
                       EEPROM_Write(j*16 +k,ROMovi[i][k]);
                       EEPROMMatrica[j][k] = ROMovi[i][k];
                   }
                   EEPROMFlagovi[j]=1;
                   break;
              }
           }
           if(postojeciSenzor==0)
           {
                //INTtostr(i,tmp2);
                //Lcd_out(2,1,tmp2);
                //Delay_ms(1000);
                for(k=0;k<8;k++)
                {
                    EEPROM_Write(brStarihSenzora*16 +k,ROMovi[i][k]);
                    EEPROMMatrica[brStarihSenzora][k] = ROMovi[i][k];
                }
                brStarihSenzora++;

           }
        }
    }
    
    EEPROM_Write(0xFF,brStarihSenzora);
}
void Display_Temperature(unsigned char i, unsigned char j, unsigned int temp2write) {
  const unsigned short RES_SHIFT = TEMP_RESOLUTION - 8;
  char temp_whole;
  unsigned int temp_fraction;

  // Check if temperature is negative
  if (temp2write & 0x8000) 
  {
       text[0] = '-';
       temp2write = ~temp2write; //ovde bi trebalo temp2write = ~temp2write + 1, ali to u proteusu ne radi, a ovo radi
       // Extract temp_whole
       temp_whole = temp2write >> RES_SHIFT ;
  }
  else
  {
      // Extract temp_whole
      temp_whole = temp2write >> RES_SHIFT ;
      if (temp_whole/100)
      {
         text[0] = temp_whole/100  + 48;
      }
      else
      {
         text[0] = '0';
      }
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
  text[5]=223;                                   //ascii za stepen
  text[6]='\0';

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

    tempDigitalno = scratchPad0[0];
    tempDigitalno = (scratchPad0[1] << 8) + tempDigitalno;

    return tempDigitalno;
}

void main()
{
    int i,j;

    ANSEL0  = 0;                   // Configure AN pins as digital I/O
    ANSEL1 = 0;
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


/*// inicijalizacija matrice romova
    for(i=0;i<MAX_SENZORA;i++)
    {
        for(j=0;j<8;j++)
        {
            ROMovi[i][j]=0;
        }
        temperatureDigitalne[i]=0;
    }*/
    
    // inicijalizacija matrice romova citanjem iz EEPROM-a
    EEPROMuMatricu();

    //dodajNoviSenzor();

    //MatricaUEEPROM();
     skenirajSenzore();
    // Glavna petlja pocinje ovde
    while(1)
    {
        for(i = 0; i < brStarihSenzora; i++)
        {
            tmp2[0]=i+'0';
            tmp2[1]=':';
            tmp2[2]='\0';
            Lcd_out((i/2)%2 +1, i % 2 == 0 ? 1 : 9,tmp2);
            if(EEPROMFlagovi[i]==0)
            {
               Lcd_out((i/2)%2 +1, i % 2 == 0 ? 3 : 11,"xxx.xx");
               continue;
            }
            temperatureDigitalne[i] = citajTemp(EEPROMMatrica[i]);


            Display_Temperature((i/2)%2 + 1,i % 2 == 0 ? 3 : 11, temperatureDigitalne[i]);

            for(j=0;j<8;j++)
            {
             ByteToHex(EEPROMMatrica[i][j],ROMByte);
             Lcd_Out(2,2*j+1, ROMByte);
            }
            Delay_ms(1000);

        }

    }  // Glavna petlja se zavrsava ovde

}  // end main function