// 1-wire functions

unsigned short Ow_Read_Bit();
unsigned char Ow_Read_Byte();
void Ow_Write_One();
void Ow_Write_Zero();
void Ow_Write_Byte(unsigned char);
unsigned short Ow_Reset();
int Ow_Search();
int Ow_First();
int Ow_Next();
//void OW_Family_Skip_Setup();
//void OW_Target_Setup(unsigned char);

// Buffer to hold device ROM code
extern unsigned char ROM_NO[8];