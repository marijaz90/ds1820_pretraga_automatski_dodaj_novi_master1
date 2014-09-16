#line 1 "E:/Documents/PIC/Moji kodovi/mikroC/pic18f4431/DS1820/ds1820_pretraga_automatski_dodaj_novi_master/ds1820_pretraga_automatski_dodaj_novi_master.c"
#line 1 "e:/documents/pic/moji kodovi/mikroc/pic18f4431/ds1820/ds1820_pretraga_automatski_dodaj_novi_master/one_wire_functions.h"


unsigned short Ow_Read_Bit();
unsigned char Ow_Read_Byte();
void Ow_Write_One();
void Ow_Write_Zero();
void Ow_Write_Byte(unsigned char);
unsigned short Ow_Reset();
int Ow_Search();
int Ow_First();
int Ow_Next();




extern unsigned char ROM_NO[8];
#line 23 "E:/Documents/PIC/Moji kodovi/mikroC/pic18f4431/DS1820/ds1820_pretraga_automatski_dodaj_novi_master/ds1820_pretraga_automatski_dodaj_novi_master.c"
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



char i,k;
char tmp2[3];

char* tempDigitalnoString;

const unsigned short TEMP_RESOLUTION = 9;


char text[7];
char ROMByte[3];
unsigned temp;

char TextBuffer[3];
unsigned char postojeciSenzor;
unsigned char brStarihSenzora = 0;
unsigned char brTrenutnihSenzora = 0;
unsigned char brNovihSenzora = 0;
unsigned char ROMovi[ 16 ][8];
unsigned char EEPROMmatrica[ 16 ][8];
unsigned char ROM_NO[8];
unsigned int temperatureDigitalne[ 16 ];

char EEPROMFlagovi[ 16 ];
char SenzoriFlagovi[ 16 ];

void EEPROMuMatricu()
{
 char i,j;
 brStarihSenzora = EEPROM_Read(0xFF);

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
 if(rom1[i]!=rom2[i])
 {
 return 0;
 }
 }
 return 1;
}
#line 168 "E:/Documents/PIC/Moji kodovi/mikroC/pic18f4431/DS1820/ds1820_pretraga_automatski_dodaj_novi_master/ds1820_pretraga_automatski_dodaj_novi_master.c"
void skenirajSenzore()
{
 int i,j,k;

 for(i=0; i <  16 ; i++)
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
 for(k=0;k<8;k++)
 {
 EEPROM_Write(brStarihSenzora*16 +k,ROMovi[i][k]);
 EEPROMMatrica[brStarihSenzora][k] = ROMovi[i][k];
 }
 brStarihSenzora++;
 break;
 }
 }
 }

 EEPROM_Write(0xFF,brStarihSenzora);
}
void Display_Temperature(unsigned char i, unsigned char j, unsigned int temp2write) {
 const unsigned short RES_SHIFT = TEMP_RESOLUTION - 8;
 char temp_whole;
 unsigned int temp_fraction;


 if (temp2write & 0x8000)
 {
 text[0] = '-';
 temp2write = ~temp2write;

 temp_whole = temp2write >> RES_SHIFT ;
 }
 else
 {

 temp_whole = temp2write >> RES_SHIFT ;
 if (temp_whole/100)
 {
 text[0] = temp_whole/100 + 48;
 }
 else
 {
 text[0] = '0';
 }
 }



 text[1] = (temp_whole/10)%10 + 48;
 text[2] = temp_whole%10 + 48;
 text[3] ='.';


 temp_fraction = temp2write << (4-RES_SHIFT);
 temp_fraction &= 0x000F;
 temp_fraction *= 625;


 text[4] = temp_fraction/1000 + 48;
 text[5]=248;
 text[6]='\0';


 Lcd_Out(i, j, text);
}


unsigned int citajTemp(unsigned char *x)
{
 unsigned int tempDigitalno;
 unsigned char scratchPad0[9];

 Ow_Reset();
 Ow_Write_Byte(0x55);
 for(i = 0; i < 8; i++)
 {
 Ow_Write_Byte(x[7-i]);
 }
 Ow_Write_Byte(0x44);
 Delay_us(120);

 Ow_Reset();
 Ow_Write_Byte(0x55);
 for(i = 0; i < 8; i++)
 {
 Ow_Write_Byte(x[7-i]);
 }
 Ow_Write_Byte(0xBE);

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

 ANSEL0 = 0;
 ANSEL1 = 0;
 asm{
 MOVLW 15
 MOVWF ADCON1
 MOVLW 7
 MOVWF TRISB
 MOVLW 32
 MOVWF TRISA
 }
 TRISD = 0b00000000;
 TRISC.RC6 = 0;

 LATC.RC6 = 0;
 LATB.RB4 = 0;

 INTCON.GIE = 0;

 Lcd_Init();
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Cmd(_LCD_CURSOR_OFF);
 Delay_ms(100);
#line 397 "E:/Documents/PIC/Moji kodovi/mikroC/pic18f4431/DS1820/ds1820_pretraga_automatski_dodaj_novi_master/ds1820_pretraga_automatski_dodaj_novi_master.c"
 EEPROMuMatricu();




 skenirajSenzore();

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

 }

}
