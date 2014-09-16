#line 1 "E:/Documents/PIC/Moji kodovi/mikroC/pic18f4431/DS1820/ds1820_pretraga_automatski_dodaj_novi_master1/one_wire_functions.c"
#line 1 "e:/documents/pic/moji kodovi/mikroc/pic18f4431/ds1820/ds1820_pretraga_automatski_dodaj_novi_master1/one_wire_functions.h"


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
#line 6 "E:/Documents/PIC/Moji kodovi/mikroC/pic18f4431/DS1820/ds1820_pretraga_automatski_dodaj_novi_master1/one_wire_functions.c"
extern unsigned char ROM_NO[8];
int LastDiscrepancy;
int LastFamilyDiscrepancy;
int LastDeviceFlag;

char tmp[7];
char tmp1[7];





sbit OW_DIR at TRISC.B2;
sbit OW_READ at PORTC.B2;
sbit OW_WRITE at LATC.B2;




unsigned short Ow_Read_Bit()
{
 unsigned short BitValue;
 OW_DIR = 0;
 OW_WRITE = 0;
 delay_us(6);
 OW_DIR = 1;
 delay_us(9);
 BitValue = OW_READ;
 delay_us(55);
 return BitValue;
}



unsigned char Ow_Read_Byte()
{
 unsigned char ByteRead;




 ByteRead.B0 = Ow_Read_Bit();
 ByteRead.B1 = Ow_Read_Bit();
 ByteRead.B2 = Ow_Read_Bit();
 ByteRead.B3 = Ow_Read_Bit();
 ByteRead.B4 = Ow_Read_Bit();
 ByteRead.B5 = Ow_Read_Bit();
 ByteRead.B6 = Ow_Read_Bit();
 ByteRead.B7 = Ow_Read_Bit();

 return ByteRead;
}





void Ow_Write_One()
{
 OW_DIR = 0;
 OW_WRITE = 0;
 delay_us(6);
 OW_DIR = 1;
 delay_us(64);
}




void Ow_Write_Zero()
{
 OW_DIR = 0;
 OW_WRITE = 0;
 delay_us(60);
 OW_DIR = 1;
 delay_us(10);
}




void Ow_Write_Byte(unsigned char ByteToSend)
{





 if (ByteToSend.B0)
 Ow_Write_One();
 else
 Ow_Write_Zero();

 if (ByteToSend.B1)
 Ow_Write_One();
 else
 Ow_Write_Zero();

 if (ByteToSend.B2)
 Ow_Write_One();
 else
 Ow_Write_Zero();

 if (ByteToSend.B3)
 Ow_Write_One();
 else
 Ow_Write_Zero();

 if (ByteToSend.B4)
 Ow_Write_One();
 else
 Ow_Write_Zero();

 if (ByteToSend.B5)
 Ow_Write_One();
 else
 Ow_Write_Zero();

 if (ByteToSend.B6)
 Ow_Write_One();
 else
 Ow_Write_Zero();

 if (ByteToSend.B7)
 Ow_Write_One();
 else
 Ow_Write_Zero();
}




unsigned short Ow_Reset()
{
 unsigned short response;
 OW_DIR = 0;
 OW_WRITE = 0;
 delay_us(480);
 OW_DIR = 1;
 delay_us(70);
 response = OW_READ;

 delay_us(410);
 return response;
}










static unsigned char dscrc_table[] = {
0, 94,188,226, 97, 63,221,131,194,156,126, 32,163,253, 31, 65,
157,195, 33,127,252,162, 64, 30, 95, 1,227,189, 62, 96,130,220,
35,125,159,193, 66, 28,254,160,225,191, 93, 3,128,222, 60, 98,
190,224, 2, 92,223,129, 99, 61,124, 34,192,158, 29, 67,161,255,
70, 24,250,164, 39,121,155,197,132,218, 56,102,229,187, 89, 7,
219,133,103, 57,186,228, 6, 88, 25, 71,165,251,120, 38,196,154,
101, 59,217,135, 4, 90,184,230,167,249, 27, 69,198,152,122, 36,
248,166, 68, 26,153,199, 37,123, 58,100,134,216, 91, 5,231,185,
140,210, 48,110,237,179, 81, 15, 78, 16,242,172, 47,113,147,205,
17, 79,173,243,112, 46,204,146,211,141,111, 49,178,236, 14, 80,
175,241, 19, 77,206,144,114, 44,109, 51,209,143, 12, 82,176,238,
50,108,142,208, 83, 13,239,177,240,174, 76, 18,145,207, 45,115,
202,148,118, 40,171,245, 23, 73, 8, 86,180,234,105, 55,213,139,
87, 9,235,181, 54,104,138,212,149,203, 41,119,244,170, 72, 22,
233,183, 85, 11,136,214, 52,106, 43,117,151,201, 74, 20,246,168,
116, 42,200,150, 21, 75,169,247,182,232, 10, 84,215,137,107, 53};

unsigned char crc8;

unsigned char docrc8(unsigned char value)
{

crc8 = dscrc_table[crc8 ^ value];
return crc8;
}



int Ow_Search()
{
 int id_bit_number;
 int last_zero, rom_byte_number, search_result;
 int id_bit, cmp_id_bit;
 unsigned char rom_byte_mask, search_direction;

 id_bit_number = 1;
 last_zero = 0;
 rom_byte_number = 0;
 rom_byte_mask = 1;
 search_result = 0;
 crc8 = 0;

 if (!LastDeviceFlag)
 {

 if (Ow_Reset())
 {

 LastDiscrepancy = 0;
 LastDeviceFlag = 0;
 LastFamilyDiscrepancy = 0;
 return 0;
 }



 Ow_Write_Byte(0xF0);


 do
 {

 id_bit = OW_Read_Bit();
 cmp_id_bit = OW_Read_Bit();


 if ((id_bit == 1) && (cmp_id_bit == 1))
 break;
 else
 {

 if (id_bit != cmp_id_bit)
 search_direction = id_bit;
 else
 {



 if (id_bit_number < LastDiscrepancy)
 search_direction = ((ROM_NO[rom_byte_number] & rom_byte_mask) > 0);
 else

 search_direction = (id_bit_number == LastDiscrepancy);


 if (search_direction == 0)
 {
 last_zero = id_bit_number;

 if (last_zero < 9) LastFamilyDiscrepancy = last_zero;
 }
 }





 if (search_direction == 1)
 ROM_NO[rom_byte_number] |= rom_byte_mask;
 else
 ROM_NO[rom_byte_number] &= ~rom_byte_mask;



 if (search_direction)
 Ow_Write_One();
 else
 Ow_Write_Zero();





 id_bit_number++;
 rom_byte_mask <<= 1;




 if (rom_byte_mask == 0)
 {
 docrc8(ROM_NO[rom_byte_number]);
 rom_byte_number++;
 rom_byte_mask = 1;
 }
 }
 }
 while(rom_byte_number < 8);



 if (id_bit_number == 65)
 {

 LastDiscrepancy = last_zero;


 if (LastDiscrepancy == 0)
 LastDeviceFlag = 1;
 search_result = 1;


 }
 }



 if (!search_result || !ROM_NO[0])
 {
 LastDiscrepancy = 0;
 LastDeviceFlag = 0;
 LastFamilyDiscrepancy = 0;
 search_result = 0;
 }

 return search_result;
}



int Ow_First()
{
 LastDiscrepancy = 0;
 LastDeviceFlag = 0;
 LastFamilyDiscrepancy = 0;
 return Ow_Search();
}




int Ow_Next()
{
 return Ow_Search();
}
