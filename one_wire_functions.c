#include "one_wire_functions.h"


// Variables used by the search functions

extern unsigned char ROM_NO[8];   // Holds ROM code of discovered device
int LastDiscrepancy;       // Holds last disrepancy between bits
int LastFamilyDiscrepancy;  //Holds last discrepancy between family code bits
int LastDeviceFlag;        // Flags if device is the last one left on the bus

char tmp[7];
char tmp1[7];

// Variables used by the 1-wire I/O functions
// Set these to whatever pin you have your 1-wire communication line connected to
// Default setting is RA4

sbit OW_DIR at TRISC.B2;    // Direction of I/O pin
sbit OW_READ at PORTC.B2;   // Read from I/O pin
sbit OW_WRITE at LATC.B2;   // Write to I/O pin


// Reads one bit from the I/O pin

unsigned short Ow_Read_Bit()
{
     unsigned short BitValue;    // Bit to be returned
     OW_DIR = 0;                 // Set I/O pin to output
     OW_WRITE = 0;               // Drive bus low
     delay_us(6);                // Wait 6 usecs
     OW_DIR = 1;                 // Release the bus
     delay_us(9);                // Wait 9 usecs
     BitValue = OW_READ;         // Read bit value on I/O pin
     delay_us(55);               // Wait 55 usecs
     return BitValue;            // Return bit read
}

// Reads a byte from the I/O pin

unsigned char Ow_Read_Byte()
{
     unsigned char ByteRead;     // Byte to be returned
     
     // Get the byte value by reading the I/O pin
     // once for each bit
     
     ByteRead.B0 = Ow_Read_Bit();
     ByteRead.B1 = Ow_Read_Bit();
     ByteRead.B2 = Ow_Read_Bit();
     ByteRead.B3 = Ow_Read_Bit();
     ByteRead.B4 = Ow_Read_Bit();
     ByteRead.B5 = Ow_Read_Bit();
     ByteRead.B6 = Ow_Read_Bit();
     ByteRead.B7 = Ow_Read_Bit();
     
     return ByteRead;      // Return the byte
}



// Sends a '1' bit to the I/O pin

void Ow_Write_One()
{
     OW_DIR = 0;      // Set I/O pin to output
     OW_WRITE = 0;    // Drive bus low
     delay_us(6);     // Wait 6 usecs
     OW_DIR = 1;      // Release the bus
     delay_us(64);    // Wait 64 usecs
}


// Sends a '0' bit to the I/O pin

void Ow_Write_Zero()
{
   OW_DIR = 0;     // Set I/O pin to output
   OW_WRITE = 0;   // Drive bus low
   delay_us(60);   // Wait 60 usecs
   OW_DIR = 1;     // Release the bus
   delay_us(10);   // Wait 10 usecs
}


// Sends a byte to the I/O pin

void Ow_Write_Byte(unsigned char ByteToSend)
{
     
     // Writes the byte passed by checking
     // it one bit at a time and sending the
     // bit's value to the I/O pin
     
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


// Sends a reset signal then reads the I/O pin for a device presence pulse

unsigned short Ow_Reset()
{
    unsigned short response;   // Holds the bit to be returned
    OW_DIR = 0;                // Set I/O pin to output
    OW_WRITE = 0;              // Drive bus low
    delay_us(480);             // Wait 480 usecs
    OW_DIR = 1;                // Release the bus
    delay_us(70);              // Wait 70 usecs
    response = OW_READ;        // Check I/O pin for presence pulse
                               // (0 if device(s) responded, 1 if no devices did)
    delay_us(410);             // Wait 410 usecs
    return response;           // Return result
}



//--------------------------------------------------------
//
//  The functions below are from an example published
//  in Maxim's Application Notes  ac:AN187
//
//--------------------------------------------------------

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

// Seraches the bus for any responding 1-Wire devices

int Ow_Search()
{
   int id_bit_number;
   int last_zero, rom_byte_number, search_result;
   int id_bit, cmp_id_bit;
   unsigned char rom_byte_mask, search_direction;
   // initialize for search
   id_bit_number = 1;
   last_zero = 0;
   rom_byte_number = 0;
   rom_byte_mask = 1;
   search_result = 0;
   crc8 = 0;
   // if the last call was not the last one
   if (!LastDeviceFlag)
   {
                 // 1-Wire reset
                 if (Ow_Reset())
                 {
                        // reset the search
                        LastDiscrepancy = 0;
                        LastDeviceFlag = 0;
                        LastFamilyDiscrepancy = 0;
                        return 0;
                 }


                 // issue the search command
                 Ow_Write_Byte(0xF0);

                // loop to do the search
                do
                {
                  // read a bit and its complement
                  id_bit = OW_Read_Bit();
                  cmp_id_bit = OW_Read_Bit();
                  
                  // check for no devices on 1-wire
                 if ((id_bit == 1) && (cmp_id_bit == 1))
                        break;
                 else
                 {
                        // all devices coupled have 0 or 1
                        if (id_bit != cmp_id_bit)
                          search_direction = id_bit; // bit write value for search
                        else
                        {
                           // if this discrepancy is before the Last Discrepancy
                           // on a previous next then pick the same as last time
                         
                           if (id_bit_number < LastDiscrepancy)
                                 search_direction = ((ROM_NO[rom_byte_number] &  rom_byte_mask) > 0);
                           else
                                 // if equal to last pick 1, if not then pick 0
                                 search_direction = (id_bit_number == LastDiscrepancy);
                           
                          // if 0 was picked then record its position in LastZero
                         if (search_direction == 0)
                         {
                                 last_zero = id_bit_number;
                                 // check for Last discrepancy in family
                                 if (last_zero < 9) LastFamilyDiscrepancy = last_zero;
                         }
                        }
                  
                        // set or clear the bit in the ROM byte rom_byte_number
                        // with mask rom_byte_mask
                  
                        //postavlja vrednost procitanog bita
                        if (search_direction == 1)
                           ROM_NO[rom_byte_number] |= rom_byte_mask;
                        else
                           ROM_NO[rom_byte_number] &= ~rom_byte_mask;
                         
                         
                        // serial number search direction write bit
                        if (search_direction)
                           Ow_Write_One();
                        else
                           Ow_Write_Zero();


                        // increment the byte counter id_bit_number
                        // and shift the mask rom_byte_mask
                  
                        id_bit_number++;
                        rom_byte_mask <<= 1;

                        // if the mask is 0 then go to new SerialNum byte rom_byte_number
                        //and reset mask
                  
                        if (rom_byte_mask == 0)
                        {
                           docrc8(ROM_NO[rom_byte_number]); // accumulate the CRC
                           rom_byte_number++;
                           rom_byte_mask = 1;
                        }
                  }
                }   // End of search loop
                while(rom_byte_number < 8); // loop until through all ROM bytes 0-7
                //IntToStr(id_bit_number,tmp);
                //Lcd_Out(1,1,tmp);
                // if the search was successful then
                if (id_bit_number == 65)
                {
                  // search successful so set LastDiscrepancy,LastDeviceFlag,search_result
                  LastDiscrepancy = last_zero;
                  //Lcd_Out(2,1,"mlp");
                  // check for last device
                  if (LastDiscrepancy == 0) 
                     LastDeviceFlag = 1;
                  search_result = 1;
                  //IntToStr(search_result,tmp1);
                  //Lcd_Out(1,9,tmp1);
                }
   }
   // if no device found then reset counters so next 'search' will be
   // like a first
   
  if (!search_result || !ROM_NO[0])
  {
    LastDiscrepancy = 0;
    LastDeviceFlag = 0;
    LastFamilyDiscrepancy = 0;
    search_result = 0;
  }

  return search_result;
}   // End of Ow-Search function

// Finds the first device

int Ow_First()
{
   LastDiscrepancy = 0;
   LastDeviceFlag = 0;
   LastFamilyDiscrepancy = 0;
   return Ow_Search();
}


// Finds any other devices after the first one

int Ow_Next()
{
  return Ow_Search();
}

// Set up search to look for a certain device family code

/*void Ow_Target_Setup(unsigned char family_code)
{
   int i;
   // set the search state to find SearchFamily type devices
   ROM_NO[0] = family_code;
   for (i = 1; i < 8; i++)
   ROM_NO[i] = 0;
   LastDiscrepancy = 64;
   LastFamilyDiscrepancy = 0;
   LastDeviceFlag = 0;
}*/


/*void Ow_Family_Skip_Setup()
{
// set the Last discrepancy to last family discrepancy
LastDiscrepancy = LastFamilyDiscrepancy;
LastFamilyDiscrepancy = 0;
// check for end of list
if (LastDiscrepancy == 0)
LastDeviceFlag = 1;
}*/