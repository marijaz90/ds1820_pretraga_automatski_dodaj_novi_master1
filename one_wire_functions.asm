
_Ow_Read_Bit:

;one_wire_functions.c,25 :: 		unsigned short Ow_Read_Bit()
;one_wire_functions.c,28 :: 		OW_DIR = 0;                 // Set I/O pin to output
	BCF         TRISC+0, 2 
;one_wire_functions.c,29 :: 		OW_WRITE = 0;               // Drive bus low
	BCF         LATC+0, 2 
;one_wire_functions.c,30 :: 		delay_us(6);                // Wait 6 usecs
	MOVLW       9
	MOVWF       R13, 0
L_Ow_Read_Bit0:
	DECFSZ      R13, 1, 1
	BRA         L_Ow_Read_Bit0
	NOP
	NOP
;one_wire_functions.c,31 :: 		OW_DIR = 1;                 // Release the bus
	BSF         TRISC+0, 2 
;one_wire_functions.c,32 :: 		delay_us(9);                // Wait 9 usecs
	MOVLW       14
	MOVWF       R13, 0
L_Ow_Read_Bit1:
	DECFSZ      R13, 1, 1
	BRA         L_Ow_Read_Bit1
	NOP
	NOP
;one_wire_functions.c,33 :: 		BitValue = OW_READ;         // Read bit value on I/O pin
	MOVLW       0
	BTFSC       PORTC+0, 2 
	MOVLW       1
	MOVWF       R1 
;one_wire_functions.c,34 :: 		delay_us(55);               // Wait 55 usecs
	MOVLW       91
	MOVWF       R13, 0
L_Ow_Read_Bit2:
	DECFSZ      R13, 1, 1
	BRA         L_Ow_Read_Bit2
	NOP
;one_wire_functions.c,35 :: 		return BitValue;            // Return bit read
	MOVF        R1, 0 
	MOVWF       R0 
;one_wire_functions.c,36 :: 		}
L_end_Ow_Read_Bit:
	RETURN      0
; end of _Ow_Read_Bit

_Ow_Read_Byte:

;one_wire_functions.c,40 :: 		unsigned char Ow_Read_Byte()
;one_wire_functions.c,47 :: 		ByteRead.B0 = Ow_Read_Bit();
	CALL        _Ow_Read_Bit+0, 0
	BTFSC       R0, 0 
	GOTO        L__Ow_Read_Byte55
	BCF         Ow_Read_Byte_ByteRead_L0+0, 0 
	GOTO        L__Ow_Read_Byte56
L__Ow_Read_Byte55:
	BSF         Ow_Read_Byte_ByteRead_L0+0, 0 
L__Ow_Read_Byte56:
;one_wire_functions.c,48 :: 		ByteRead.B1 = Ow_Read_Bit();
	CALL        _Ow_Read_Bit+0, 0
	BTFSC       R0, 0 
	GOTO        L__Ow_Read_Byte57
	BCF         Ow_Read_Byte_ByteRead_L0+0, 1 
	GOTO        L__Ow_Read_Byte58
L__Ow_Read_Byte57:
	BSF         Ow_Read_Byte_ByteRead_L0+0, 1 
L__Ow_Read_Byte58:
;one_wire_functions.c,49 :: 		ByteRead.B2 = Ow_Read_Bit();
	CALL        _Ow_Read_Bit+0, 0
	BTFSC       R0, 0 
	GOTO        L__Ow_Read_Byte59
	BCF         Ow_Read_Byte_ByteRead_L0+0, 2 
	GOTO        L__Ow_Read_Byte60
L__Ow_Read_Byte59:
	BSF         Ow_Read_Byte_ByteRead_L0+0, 2 
L__Ow_Read_Byte60:
;one_wire_functions.c,50 :: 		ByteRead.B3 = Ow_Read_Bit();
	CALL        _Ow_Read_Bit+0, 0
	BTFSC       R0, 0 
	GOTO        L__Ow_Read_Byte61
	BCF         Ow_Read_Byte_ByteRead_L0+0, 3 
	GOTO        L__Ow_Read_Byte62
L__Ow_Read_Byte61:
	BSF         Ow_Read_Byte_ByteRead_L0+0, 3 
L__Ow_Read_Byte62:
;one_wire_functions.c,51 :: 		ByteRead.B4 = Ow_Read_Bit();
	CALL        _Ow_Read_Bit+0, 0
	BTFSC       R0, 0 
	GOTO        L__Ow_Read_Byte63
	BCF         Ow_Read_Byte_ByteRead_L0+0, 4 
	GOTO        L__Ow_Read_Byte64
L__Ow_Read_Byte63:
	BSF         Ow_Read_Byte_ByteRead_L0+0, 4 
L__Ow_Read_Byte64:
;one_wire_functions.c,52 :: 		ByteRead.B5 = Ow_Read_Bit();
	CALL        _Ow_Read_Bit+0, 0
	BTFSC       R0, 0 
	GOTO        L__Ow_Read_Byte65
	BCF         Ow_Read_Byte_ByteRead_L0+0, 5 
	GOTO        L__Ow_Read_Byte66
L__Ow_Read_Byte65:
	BSF         Ow_Read_Byte_ByteRead_L0+0, 5 
L__Ow_Read_Byte66:
;one_wire_functions.c,53 :: 		ByteRead.B6 = Ow_Read_Bit();
	CALL        _Ow_Read_Bit+0, 0
	BTFSC       R0, 0 
	GOTO        L__Ow_Read_Byte67
	BCF         Ow_Read_Byte_ByteRead_L0+0, 6 
	GOTO        L__Ow_Read_Byte68
L__Ow_Read_Byte67:
	BSF         Ow_Read_Byte_ByteRead_L0+0, 6 
L__Ow_Read_Byte68:
;one_wire_functions.c,54 :: 		ByteRead.B7 = Ow_Read_Bit();
	CALL        _Ow_Read_Bit+0, 0
	BTFSC       R0, 0 
	GOTO        L__Ow_Read_Byte69
	BCF         Ow_Read_Byte_ByteRead_L0+0, 7 
	GOTO        L__Ow_Read_Byte70
L__Ow_Read_Byte69:
	BSF         Ow_Read_Byte_ByteRead_L0+0, 7 
L__Ow_Read_Byte70:
;one_wire_functions.c,56 :: 		return ByteRead;      // Return the byte
	MOVF        Ow_Read_Byte_ByteRead_L0+0, 0 
	MOVWF       R0 
;one_wire_functions.c,57 :: 		}
L_end_Ow_Read_Byte:
	RETURN      0
; end of _Ow_Read_Byte

_Ow_Write_One:

;one_wire_functions.c,63 :: 		void Ow_Write_One()
;one_wire_functions.c,65 :: 		OW_DIR = 0;      // Set I/O pin to output
	BCF         TRISC+0, 2 
;one_wire_functions.c,66 :: 		OW_WRITE = 0;    // Drive bus low
	BCF         LATC+0, 2 
;one_wire_functions.c,67 :: 		delay_us(6);     // Wait 6 usecs
	MOVLW       9
	MOVWF       R13, 0
L_Ow_Write_One3:
	DECFSZ      R13, 1, 1
	BRA         L_Ow_Write_One3
	NOP
	NOP
;one_wire_functions.c,68 :: 		OW_DIR = 1;      // Release the bus
	BSF         TRISC+0, 2 
;one_wire_functions.c,69 :: 		delay_us(64);    // Wait 64 usecs
	MOVLW       106
	MOVWF       R13, 0
L_Ow_Write_One4:
	DECFSZ      R13, 1, 1
	BRA         L_Ow_Write_One4
	NOP
;one_wire_functions.c,70 :: 		}
L_end_Ow_Write_One:
	RETURN      0
; end of _Ow_Write_One

_Ow_Write_Zero:

;one_wire_functions.c,75 :: 		void Ow_Write_Zero()
;one_wire_functions.c,77 :: 		OW_DIR = 0;     // Set I/O pin to output
	BCF         TRISC+0, 2 
;one_wire_functions.c,78 :: 		OW_WRITE = 0;   // Drive bus low
	BCF         LATC+0, 2 
;one_wire_functions.c,79 :: 		delay_us(60);   // Wait 60 usecs
	MOVLW       99
	MOVWF       R13, 0
L_Ow_Write_Zero5:
	DECFSZ      R13, 1, 1
	BRA         L_Ow_Write_Zero5
	NOP
	NOP
;one_wire_functions.c,80 :: 		OW_DIR = 1;     // Release the bus
	BSF         TRISC+0, 2 
;one_wire_functions.c,81 :: 		delay_us(10);   // Wait 10 usecs
	MOVLW       16
	MOVWF       R13, 0
L_Ow_Write_Zero6:
	DECFSZ      R13, 1, 1
	BRA         L_Ow_Write_Zero6
	NOP
;one_wire_functions.c,82 :: 		}
L_end_Ow_Write_Zero:
	RETURN      0
; end of _Ow_Write_Zero

_Ow_Write_Byte:

;one_wire_functions.c,87 :: 		void Ow_Write_Byte(unsigned char ByteToSend)
;one_wire_functions.c,94 :: 		if (ByteToSend.B0)
	BTFSS       FARG_Ow_Write_Byte_ByteToSend+0, 0 
	GOTO        L_Ow_Write_Byte7
;one_wire_functions.c,95 :: 		Ow_Write_One();
	CALL        _Ow_Write_One+0, 0
	GOTO        L_Ow_Write_Byte8
L_Ow_Write_Byte7:
;one_wire_functions.c,97 :: 		Ow_Write_Zero();
	CALL        _Ow_Write_Zero+0, 0
L_Ow_Write_Byte8:
;one_wire_functions.c,99 :: 		if (ByteToSend.B1)
	BTFSS       FARG_Ow_Write_Byte_ByteToSend+0, 1 
	GOTO        L_Ow_Write_Byte9
;one_wire_functions.c,100 :: 		Ow_Write_One();
	CALL        _Ow_Write_One+0, 0
	GOTO        L_Ow_Write_Byte10
L_Ow_Write_Byte9:
;one_wire_functions.c,102 :: 		Ow_Write_Zero();
	CALL        _Ow_Write_Zero+0, 0
L_Ow_Write_Byte10:
;one_wire_functions.c,104 :: 		if (ByteToSend.B2)
	BTFSS       FARG_Ow_Write_Byte_ByteToSend+0, 2 
	GOTO        L_Ow_Write_Byte11
;one_wire_functions.c,105 :: 		Ow_Write_One();
	CALL        _Ow_Write_One+0, 0
	GOTO        L_Ow_Write_Byte12
L_Ow_Write_Byte11:
;one_wire_functions.c,107 :: 		Ow_Write_Zero();
	CALL        _Ow_Write_Zero+0, 0
L_Ow_Write_Byte12:
;one_wire_functions.c,109 :: 		if (ByteToSend.B3)
	BTFSS       FARG_Ow_Write_Byte_ByteToSend+0, 3 
	GOTO        L_Ow_Write_Byte13
;one_wire_functions.c,110 :: 		Ow_Write_One();
	CALL        _Ow_Write_One+0, 0
	GOTO        L_Ow_Write_Byte14
L_Ow_Write_Byte13:
;one_wire_functions.c,112 :: 		Ow_Write_Zero();
	CALL        _Ow_Write_Zero+0, 0
L_Ow_Write_Byte14:
;one_wire_functions.c,114 :: 		if (ByteToSend.B4)
	BTFSS       FARG_Ow_Write_Byte_ByteToSend+0, 4 
	GOTO        L_Ow_Write_Byte15
;one_wire_functions.c,115 :: 		Ow_Write_One();
	CALL        _Ow_Write_One+0, 0
	GOTO        L_Ow_Write_Byte16
L_Ow_Write_Byte15:
;one_wire_functions.c,117 :: 		Ow_Write_Zero();
	CALL        _Ow_Write_Zero+0, 0
L_Ow_Write_Byte16:
;one_wire_functions.c,119 :: 		if (ByteToSend.B5)
	BTFSS       FARG_Ow_Write_Byte_ByteToSend+0, 5 
	GOTO        L_Ow_Write_Byte17
;one_wire_functions.c,120 :: 		Ow_Write_One();
	CALL        _Ow_Write_One+0, 0
	GOTO        L_Ow_Write_Byte18
L_Ow_Write_Byte17:
;one_wire_functions.c,122 :: 		Ow_Write_Zero();
	CALL        _Ow_Write_Zero+0, 0
L_Ow_Write_Byte18:
;one_wire_functions.c,124 :: 		if (ByteToSend.B6)
	BTFSS       FARG_Ow_Write_Byte_ByteToSend+0, 6 
	GOTO        L_Ow_Write_Byte19
;one_wire_functions.c,125 :: 		Ow_Write_One();
	CALL        _Ow_Write_One+0, 0
	GOTO        L_Ow_Write_Byte20
L_Ow_Write_Byte19:
;one_wire_functions.c,127 :: 		Ow_Write_Zero();
	CALL        _Ow_Write_Zero+0, 0
L_Ow_Write_Byte20:
;one_wire_functions.c,129 :: 		if (ByteToSend.B7)
	BTFSS       FARG_Ow_Write_Byte_ByteToSend+0, 7 
	GOTO        L_Ow_Write_Byte21
;one_wire_functions.c,130 :: 		Ow_Write_One();
	CALL        _Ow_Write_One+0, 0
	GOTO        L_Ow_Write_Byte22
L_Ow_Write_Byte21:
;one_wire_functions.c,132 :: 		Ow_Write_Zero();
	CALL        _Ow_Write_Zero+0, 0
L_Ow_Write_Byte22:
;one_wire_functions.c,133 :: 		}
L_end_Ow_Write_Byte:
	RETURN      0
; end of _Ow_Write_Byte

_Ow_Reset:

;one_wire_functions.c,138 :: 		unsigned short Ow_Reset()
;one_wire_functions.c,141 :: 		OW_DIR = 0;                // Set I/O pin to output
	BCF         TRISC+0, 2 
;one_wire_functions.c,142 :: 		OW_WRITE = 0;              // Drive bus low
	BCF         LATC+0, 2 
;one_wire_functions.c,143 :: 		delay_us(480);             // Wait 480 usecs
	MOVLW       4
	MOVWF       R12, 0
	MOVLW       28
	MOVWF       R13, 0
L_Ow_Reset23:
	DECFSZ      R13, 1, 1
	BRA         L_Ow_Reset23
	DECFSZ      R12, 1, 1
	BRA         L_Ow_Reset23
	NOP
;one_wire_functions.c,144 :: 		OW_DIR = 1;                // Release the bus
	BSF         TRISC+0, 2 
;one_wire_functions.c,145 :: 		delay_us(70);              // Wait 70 usecs
	MOVLW       116
	MOVWF       R13, 0
L_Ow_Reset24:
	DECFSZ      R13, 1, 1
	BRA         L_Ow_Reset24
	NOP
;one_wire_functions.c,146 :: 		response = OW_READ;        // Check I/O pin for presence pulse
	MOVLW       0
	BTFSC       PORTC+0, 2 
	MOVLW       1
	MOVWF       R1 
;one_wire_functions.c,148 :: 		delay_us(410);             // Wait 410 usecs
	MOVLW       3
	MOVWF       R12, 0
	MOVLW       168
	MOVWF       R13, 0
L_Ow_Reset25:
	DECFSZ      R13, 1, 1
	BRA         L_Ow_Reset25
	DECFSZ      R12, 1, 1
	BRA         L_Ow_Reset25
	NOP
;one_wire_functions.c,149 :: 		return response;           // Return result
	MOVF        R1, 0 
	MOVWF       R0 
;one_wire_functions.c,150 :: 		}
L_end_Ow_Reset:
	RETURN      0
; end of _Ow_Reset

_docrc8:

;one_wire_functions.c,181 :: 		unsigned char docrc8(unsigned char value)
;one_wire_functions.c,184 :: 		crc8 = dscrc_table[crc8 ^ value];
	MOVF        FARG_docrc8_value+0, 0 
	XORWF       _crc8+0, 0 
	MOVWF       R0 
	MOVLW       one_wire_functions_dscrc_table+0
	MOVWF       FSR0 
	MOVLW       hi_addr(one_wire_functions_dscrc_table+0)
	MOVWF       FSR0H 
	MOVF        R0, 0 
	ADDWF       FSR0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0H, 1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       _crc8+0 
;one_wire_functions.c,185 :: 		return crc8;
;one_wire_functions.c,186 :: 		}
L_end_docrc8:
	RETURN      0
; end of _docrc8

_Ow_Search:

;one_wire_functions.c,190 :: 		int Ow_Search()
;one_wire_functions.c,197 :: 		id_bit_number = 1;
	MOVLW       1
	MOVWF       Ow_Search_id_bit_number_L0+0 
	MOVLW       0
	MOVWF       Ow_Search_id_bit_number_L0+1 
;one_wire_functions.c,198 :: 		last_zero = 0;
	CLRF        Ow_Search_last_zero_L0+0 
	CLRF        Ow_Search_last_zero_L0+1 
;one_wire_functions.c,199 :: 		rom_byte_number = 0;
	CLRF        Ow_Search_rom_byte_number_L0+0 
	CLRF        Ow_Search_rom_byte_number_L0+1 
;one_wire_functions.c,200 :: 		rom_byte_mask = 1;
	MOVLW       1
	MOVWF       Ow_Search_rom_byte_mask_L0+0 
;one_wire_functions.c,201 :: 		search_result = 0;
	CLRF        Ow_Search_search_result_L0+0 
	CLRF        Ow_Search_search_result_L0+1 
;one_wire_functions.c,202 :: 		crc8 = 0;
	CLRF        _crc8+0 
;one_wire_functions.c,204 :: 		if (!LastDeviceFlag)
	MOVF        _LastDeviceFlag+0, 0 
	IORWF       _LastDeviceFlag+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_Ow_Search26
;one_wire_functions.c,207 :: 		if (Ow_Reset())
	CALL        _Ow_Reset+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_Ow_Search27
;one_wire_functions.c,210 :: 		LastDiscrepancy = 0;
	CLRF        _LastDiscrepancy+0 
	CLRF        _LastDiscrepancy+1 
;one_wire_functions.c,211 :: 		LastDeviceFlag = 0;
	CLRF        _LastDeviceFlag+0 
	CLRF        _LastDeviceFlag+1 
;one_wire_functions.c,212 :: 		LastFamilyDiscrepancy = 0;
	CLRF        _LastFamilyDiscrepancy+0 
	CLRF        _LastFamilyDiscrepancy+1 
;one_wire_functions.c,213 :: 		return 0;
	CLRF        R0 
	CLRF        R1 
	GOTO        L_end_Ow_Search
;one_wire_functions.c,214 :: 		}
L_Ow_Search27:
;one_wire_functions.c,218 :: 		Ow_Write_Byte(0xF0);
	MOVLW       240
	MOVWF       FARG_Ow_Write_Byte_ByteToSend+0 
	CALL        _Ow_Write_Byte+0, 0
;one_wire_functions.c,221 :: 		do
L_Ow_Search28:
;one_wire_functions.c,224 :: 		id_bit = OW_Read_Bit();
	CALL        _Ow_Read_Bit+0, 0
	MOVF        R0, 0 
	MOVWF       Ow_Search_id_bit_L0+0 
	MOVLW       0
	MOVWF       Ow_Search_id_bit_L0+1 
;one_wire_functions.c,225 :: 		cmp_id_bit = OW_Read_Bit();
	CALL        _Ow_Read_Bit+0, 0
	MOVF        R0, 0 
	MOVWF       Ow_Search_cmp_id_bit_L0+0 
	MOVLW       0
	MOVWF       Ow_Search_cmp_id_bit_L0+1 
;one_wire_functions.c,228 :: 		if ((id_bit == 1) && (cmp_id_bit == 1))
	MOVLW       0
	XORWF       Ow_Search_id_bit_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Ow_Search77
	MOVLW       1
	XORWF       Ow_Search_id_bit_L0+0, 0 
L__Ow_Search77:
	BTFSS       STATUS+0, 2 
	GOTO        L_Ow_Search33
	MOVLW       0
	XORWF       Ow_Search_cmp_id_bit_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Ow_Search78
	MOVLW       1
	XORWF       Ow_Search_cmp_id_bit_L0+0, 0 
L__Ow_Search78:
	BTFSS       STATUS+0, 2 
	GOTO        L_Ow_Search33
L__Ow_Search52:
;one_wire_functions.c,229 :: 		break;
	GOTO        L_Ow_Search29
L_Ow_Search33:
;one_wire_functions.c,233 :: 		if (id_bit != cmp_id_bit)
	MOVF        Ow_Search_id_bit_L0+1, 0 
	XORWF       Ow_Search_cmp_id_bit_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Ow_Search79
	MOVF        Ow_Search_cmp_id_bit_L0+0, 0 
	XORWF       Ow_Search_id_bit_L0+0, 0 
L__Ow_Search79:
	BTFSC       STATUS+0, 2 
	GOTO        L_Ow_Search35
;one_wire_functions.c,234 :: 		search_direction = id_bit; // bit write value for search
	MOVF        Ow_Search_id_bit_L0+0, 0 
	MOVWF       Ow_Search_search_direction_L0+0 
	GOTO        L_Ow_Search36
L_Ow_Search35:
;one_wire_functions.c,240 :: 		if (id_bit_number < LastDiscrepancy)
	MOVLW       128
	XORWF       Ow_Search_id_bit_number_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       _LastDiscrepancy+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Ow_Search80
	MOVF        _LastDiscrepancy+0, 0 
	SUBWF       Ow_Search_id_bit_number_L0+0, 0 
L__Ow_Search80:
	BTFSC       STATUS+0, 0 
	GOTO        L_Ow_Search37
;one_wire_functions.c,241 :: 		search_direction = ((ROM_NO[rom_byte_number] &  rom_byte_mask) > 0);
	MOVLW       _ROM_NO+0
	ADDWF       Ow_Search_rom_byte_number_L0+0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(_ROM_NO+0)
	ADDWFC      Ow_Search_rom_byte_number_L0+1, 0 
	MOVWF       FSR0H 
	MOVF        Ow_Search_rom_byte_mask_L0+0, 0 
	ANDWF       POSTINC0+0, 0 
	MOVWF       Ow_Search_search_direction_L0+0 
	MOVF        Ow_Search_search_direction_L0+0, 0 
	SUBLW       0
	MOVLW       1
	BTFSC       STATUS+0, 0 
	MOVLW       0
	MOVWF       Ow_Search_search_direction_L0+0 
	GOTO        L_Ow_Search38
L_Ow_Search37:
;one_wire_functions.c,244 :: 		search_direction = (id_bit_number == LastDiscrepancy);
	MOVF        Ow_Search_id_bit_number_L0+1, 0 
	XORWF       _LastDiscrepancy+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Ow_Search81
	MOVF        _LastDiscrepancy+0, 0 
	XORWF       Ow_Search_id_bit_number_L0+0, 0 
L__Ow_Search81:
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       Ow_Search_search_direction_L0+0 
L_Ow_Search38:
;one_wire_functions.c,247 :: 		if (search_direction == 0)
	MOVF        Ow_Search_search_direction_L0+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_Ow_Search39
;one_wire_functions.c,249 :: 		last_zero = id_bit_number;
	MOVF        Ow_Search_id_bit_number_L0+0, 0 
	MOVWF       Ow_Search_last_zero_L0+0 
	MOVF        Ow_Search_id_bit_number_L0+1, 0 
	MOVWF       Ow_Search_last_zero_L0+1 
;one_wire_functions.c,251 :: 		if (last_zero < 9) LastFamilyDiscrepancy = last_zero;
	MOVLW       128
	XORWF       Ow_Search_id_bit_number_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Ow_Search82
	MOVLW       9
	SUBWF       Ow_Search_id_bit_number_L0+0, 0 
L__Ow_Search82:
	BTFSC       STATUS+0, 0 
	GOTO        L_Ow_Search40
	MOVF        Ow_Search_last_zero_L0+0, 0 
	MOVWF       _LastFamilyDiscrepancy+0 
	MOVF        Ow_Search_last_zero_L0+1, 0 
	MOVWF       _LastFamilyDiscrepancy+1 
L_Ow_Search40:
;one_wire_functions.c,252 :: 		}
L_Ow_Search39:
;one_wire_functions.c,253 :: 		}
L_Ow_Search36:
;one_wire_functions.c,259 :: 		if (search_direction == 1)
	MOVF        Ow_Search_search_direction_L0+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_Ow_Search41
;one_wire_functions.c,260 :: 		ROM_NO[rom_byte_number] |= rom_byte_mask;
	MOVLW       _ROM_NO+0
	ADDWF       Ow_Search_rom_byte_number_L0+0, 0 
	MOVWF       R1 
	MOVLW       hi_addr(_ROM_NO+0)
	ADDWFC      Ow_Search_rom_byte_number_L0+1, 0 
	MOVWF       R2 
	MOVFF       R1, FSR0
	MOVFF       R2, FSR0H
	MOVF        Ow_Search_rom_byte_mask_L0+0, 0 
	IORWF       POSTINC0+0, 0 
	MOVWF       R0 
	MOVFF       R1, FSR1
	MOVFF       R2, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	GOTO        L_Ow_Search42
L_Ow_Search41:
;one_wire_functions.c,262 :: 		ROM_NO[rom_byte_number] &= ~rom_byte_mask;
	MOVLW       _ROM_NO+0
	ADDWF       Ow_Search_rom_byte_number_L0+0, 0 
	MOVWF       R1 
	MOVLW       hi_addr(_ROM_NO+0)
	ADDWFC      Ow_Search_rom_byte_number_L0+1, 0 
	MOVWF       R2 
	COMF        Ow_Search_rom_byte_mask_L0+0, 0 
	MOVWF       R0 
	MOVFF       R1, FSR0
	MOVFF       R2, FSR0H
	MOVF        POSTINC0+0, 0 
	ANDWF       R0, 1 
	MOVFF       R1, FSR1
	MOVFF       R2, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
L_Ow_Search42:
;one_wire_functions.c,266 :: 		if (search_direction)
	MOVF        Ow_Search_search_direction_L0+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_Ow_Search43
;one_wire_functions.c,267 :: 		Ow_Write_One();
	CALL        _Ow_Write_One+0, 0
	GOTO        L_Ow_Search44
L_Ow_Search43:
;one_wire_functions.c,269 :: 		Ow_Write_Zero();
	CALL        _Ow_Write_Zero+0, 0
L_Ow_Search44:
;one_wire_functions.c,275 :: 		id_bit_number++;
	INFSNZ      Ow_Search_id_bit_number_L0+0, 1 
	INCF        Ow_Search_id_bit_number_L0+1, 1 
;one_wire_functions.c,276 :: 		rom_byte_mask <<= 1;
	MOVF        Ow_Search_rom_byte_mask_L0+0, 0 
	MOVWF       R1 
	RLCF        R1, 1 
	BCF         R1, 0 
	MOVF        R1, 0 
	MOVWF       Ow_Search_rom_byte_mask_L0+0 
;one_wire_functions.c,281 :: 		if (rom_byte_mask == 0)
	MOVF        R1, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_Ow_Search45
;one_wire_functions.c,283 :: 		docrc8(ROM_NO[rom_byte_number]); // accumulate the CRC
	MOVLW       _ROM_NO+0
	ADDWF       Ow_Search_rom_byte_number_L0+0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(_ROM_NO+0)
	ADDWFC      Ow_Search_rom_byte_number_L0+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_docrc8_value+0 
	CALL        _docrc8+0, 0
;one_wire_functions.c,284 :: 		rom_byte_number++;
	INFSNZ      Ow_Search_rom_byte_number_L0+0, 1 
	INCF        Ow_Search_rom_byte_number_L0+1, 1 
;one_wire_functions.c,285 :: 		rom_byte_mask = 1;
	MOVLW       1
	MOVWF       Ow_Search_rom_byte_mask_L0+0 
;one_wire_functions.c,286 :: 		}
L_Ow_Search45:
;one_wire_functions.c,289 :: 		while(rom_byte_number < 8); // loop until through all ROM bytes 0-7
	MOVLW       128
	XORWF       Ow_Search_rom_byte_number_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Ow_Search83
	MOVLW       8
	SUBWF       Ow_Search_rom_byte_number_L0+0, 0 
L__Ow_Search83:
	BTFSS       STATUS+0, 0 
	GOTO        L_Ow_Search28
L_Ow_Search29:
;one_wire_functions.c,293 :: 		if (id_bit_number == 65)
	MOVLW       0
	XORWF       Ow_Search_id_bit_number_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Ow_Search84
	MOVLW       65
	XORWF       Ow_Search_id_bit_number_L0+0, 0 
L__Ow_Search84:
	BTFSS       STATUS+0, 2 
	GOTO        L_Ow_Search46
;one_wire_functions.c,296 :: 		LastDiscrepancy = last_zero;
	MOVF        Ow_Search_last_zero_L0+0, 0 
	MOVWF       _LastDiscrepancy+0 
	MOVF        Ow_Search_last_zero_L0+1, 0 
	MOVWF       _LastDiscrepancy+1 
;one_wire_functions.c,299 :: 		if (LastDiscrepancy == 0)
	MOVLW       0
	XORWF       Ow_Search_last_zero_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Ow_Search85
	MOVLW       0
	XORWF       Ow_Search_last_zero_L0+0, 0 
L__Ow_Search85:
	BTFSS       STATUS+0, 2 
	GOTO        L_Ow_Search47
;one_wire_functions.c,300 :: 		LastDeviceFlag = 1;
	MOVLW       1
	MOVWF       _LastDeviceFlag+0 
	MOVLW       0
	MOVWF       _LastDeviceFlag+1 
L_Ow_Search47:
;one_wire_functions.c,301 :: 		search_result = 1;
	MOVLW       1
	MOVWF       Ow_Search_search_result_L0+0 
	MOVLW       0
	MOVWF       Ow_Search_search_result_L0+1 
;one_wire_functions.c,304 :: 		}
L_Ow_Search46:
;one_wire_functions.c,305 :: 		}
L_Ow_Search26:
;one_wire_functions.c,309 :: 		if (!search_result || !ROM_NO[0])
	MOVF        Ow_Search_search_result_L0+0, 0 
	IORWF       Ow_Search_search_result_L0+1, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L__Ow_Search51
	MOVF        _ROM_NO+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L__Ow_Search51
	GOTO        L_Ow_Search50
L__Ow_Search51:
;one_wire_functions.c,311 :: 		LastDiscrepancy = 0;
	CLRF        _LastDiscrepancy+0 
	CLRF        _LastDiscrepancy+1 
;one_wire_functions.c,312 :: 		LastDeviceFlag = 0;
	CLRF        _LastDeviceFlag+0 
	CLRF        _LastDeviceFlag+1 
;one_wire_functions.c,313 :: 		LastFamilyDiscrepancy = 0;
	CLRF        _LastFamilyDiscrepancy+0 
	CLRF        _LastFamilyDiscrepancy+1 
;one_wire_functions.c,314 :: 		search_result = 0;
	CLRF        Ow_Search_search_result_L0+0 
	CLRF        Ow_Search_search_result_L0+1 
;one_wire_functions.c,315 :: 		}
L_Ow_Search50:
;one_wire_functions.c,317 :: 		return search_result;
	MOVF        Ow_Search_search_result_L0+0, 0 
	MOVWF       R0 
	MOVF        Ow_Search_search_result_L0+1, 0 
	MOVWF       R1 
;one_wire_functions.c,318 :: 		}   // End of Ow-Search function
L_end_Ow_Search:
	RETURN      0
; end of _Ow_Search

_Ow_First:

;one_wire_functions.c,322 :: 		int Ow_First()
;one_wire_functions.c,324 :: 		LastDiscrepancy = 0;
	CLRF        _LastDiscrepancy+0 
	CLRF        _LastDiscrepancy+1 
;one_wire_functions.c,325 :: 		LastDeviceFlag = 0;
	CLRF        _LastDeviceFlag+0 
	CLRF        _LastDeviceFlag+1 
;one_wire_functions.c,326 :: 		LastFamilyDiscrepancy = 0;
	CLRF        _LastFamilyDiscrepancy+0 
	CLRF        _LastFamilyDiscrepancy+1 
;one_wire_functions.c,327 :: 		return Ow_Search();
	CALL        _Ow_Search+0, 0
;one_wire_functions.c,328 :: 		}
L_end_Ow_First:
	RETURN      0
; end of _Ow_First

_Ow_Next:

;one_wire_functions.c,333 :: 		int Ow_Next()
;one_wire_functions.c,335 :: 		return Ow_Search();
	CALL        _Ow_Search+0, 0
;one_wire_functions.c,336 :: 		}
L_end_Ow_Next:
	RETURN      0
; end of _Ow_Next
