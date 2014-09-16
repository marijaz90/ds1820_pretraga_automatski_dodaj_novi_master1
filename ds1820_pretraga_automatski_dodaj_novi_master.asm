
_EEPROMuMatricu:

;ds1820_pretraga_automatski_dodaj_novi_master.c,64 :: 		void EEPROMuMatricu()
;ds1820_pretraga_automatski_dodaj_novi_master.c,67 :: 		brStarihSenzora =  EEPROM_Read(0xFF);
	MOVLW       255
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _brStarihSenzora+0 
;ds1820_pretraga_automatski_dodaj_novi_master.c,69 :: 		for(i = 0; i < brStarihSenzora; i++)
	CLRF        EEPROMuMatricu_i_L0+0 
L_EEPROMuMatricu0:
	MOVF        _brStarihSenzora+0, 0 
	SUBWF       EEPROMuMatricu_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_EEPROMuMatricu1
;ds1820_pretraga_automatski_dodaj_novi_master.c,71 :: 		for(j = 0; j < 8; j++)
	CLRF        EEPROMuMatricu_j_L0+0 
L_EEPROMuMatricu3:
	MOVLW       8
	SUBWF       EEPROMuMatricu_j_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_EEPROMuMatricu4
;ds1820_pretraga_automatski_dodaj_novi_master.c,73 :: 		EEPROMmatrica[i][j] = EEPROM_Read(i*16+j);
	MOVLW       3
	MOVWF       R2 
	MOVF        EEPROMuMatricu_i_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        R2, 0 
L__EEPROMuMatricu93:
	BZ          L__EEPROMuMatricu94
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	ADDLW       255
	GOTO        L__EEPROMuMatricu93
L__EEPROMuMatricu94:
	MOVLW       _EEPROMmatrica+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_EEPROMmatrica+0)
	ADDWFC      R1, 1 
	MOVF        EEPROMuMatricu_j_L0+0, 0 
	ADDWF       R0, 0 
	MOVWF       FLOC__EEPROMuMatricu+0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FLOC__EEPROMuMatricu+1 
	MOVF        EEPROMuMatricu_i_L0+0, 0 
	MOVWF       FARG_EEPROM_Read_address+0 
	RLCF        FARG_EEPROM_Read_address+0, 1 
	BCF         FARG_EEPROM_Read_address+0, 0 
	RLCF        FARG_EEPROM_Read_address+0, 1 
	BCF         FARG_EEPROM_Read_address+0, 0 
	RLCF        FARG_EEPROM_Read_address+0, 1 
	BCF         FARG_EEPROM_Read_address+0, 0 
	RLCF        FARG_EEPROM_Read_address+0, 1 
	BCF         FARG_EEPROM_Read_address+0, 0 
	MOVF        EEPROMuMatricu_j_L0+0, 0 
	ADDWF       FARG_EEPROM_Read_address+0, 1 
	CALL        _EEPROM_Read+0, 0
	MOVFF       FLOC__EEPROMuMatricu+0, FSR1
	MOVFF       FLOC__EEPROMuMatricu+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;ds1820_pretraga_automatski_dodaj_novi_master.c,74 :: 		Delay_ms(50);
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       69
	MOVWF       R12, 0
	MOVLW       169
	MOVWF       R13, 0
L_EEPROMuMatricu6:
	DECFSZ      R13, 1, 1
	BRA         L_EEPROMuMatricu6
	DECFSZ      R12, 1, 1
	BRA         L_EEPROMuMatricu6
	DECFSZ      R11, 1, 1
	BRA         L_EEPROMuMatricu6
	NOP
	NOP
;ds1820_pretraga_automatski_dodaj_novi_master.c,71 :: 		for(j = 0; j < 8; j++)
	INCF        EEPROMuMatricu_j_L0+0, 1 
;ds1820_pretraga_automatski_dodaj_novi_master.c,75 :: 		}
	GOTO        L_EEPROMuMatricu3
L_EEPROMuMatricu4:
;ds1820_pretraga_automatski_dodaj_novi_master.c,69 :: 		for(i = 0; i < brStarihSenzora; i++)
	INCF        EEPROMuMatricu_i_L0+0, 1 
;ds1820_pretraga_automatski_dodaj_novi_master.c,77 :: 		}
	GOTO        L_EEPROMuMatricu0
L_EEPROMuMatricu1:
;ds1820_pretraga_automatski_dodaj_novi_master.c,78 :: 		}
L_end_EEPROMuMatricu:
	RETURN      0
; end of _EEPROMuMatricu

_MatricaUEEPROM:

;ds1820_pretraga_automatski_dodaj_novi_master.c,80 :: 		void MatricaUEEPROM()
;ds1820_pretraga_automatski_dodaj_novi_master.c,83 :: 		for(i = brStarihSenzora; i < brNovihSenzora ; i++)
	MOVF        _brStarihSenzora+0, 0 
	MOVWF       MatricaUEEPROM_i_L0+0 
L_MatricaUEEPROM7:
	MOVF        _brNovihSenzora+0, 0 
	SUBWF       MatricaUEEPROM_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_MatricaUEEPROM8
;ds1820_pretraga_automatski_dodaj_novi_master.c,85 :: 		for(j = 0; j < 8; j++)
	CLRF        MatricaUEEPROM_j_L0+0 
L_MatricaUEEPROM10:
	MOVLW       8
	SUBWF       MatricaUEEPROM_j_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_MatricaUEEPROM11
;ds1820_pretraga_automatski_dodaj_novi_master.c,87 :: 		EEPROM_Write(i*16+j,EEPROMmatrica[i][j]);
	MOVF        MatricaUEEPROM_i_L0+0, 0 
	MOVWF       FARG_EEPROM_Write_address+0 
	RLCF        FARG_EEPROM_Write_address+0, 1 
	BCF         FARG_EEPROM_Write_address+0, 0 
	RLCF        FARG_EEPROM_Write_address+0, 1 
	BCF         FARG_EEPROM_Write_address+0, 0 
	RLCF        FARG_EEPROM_Write_address+0, 1 
	BCF         FARG_EEPROM_Write_address+0, 0 
	RLCF        FARG_EEPROM_Write_address+0, 1 
	BCF         FARG_EEPROM_Write_address+0, 0 
	MOVF        MatricaUEEPROM_j_L0+0, 0 
	ADDWF       FARG_EEPROM_Write_address+0, 1 
	MOVLW       3
	MOVWF       R2 
	MOVF        MatricaUEEPROM_i_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        R2, 0 
L__MatricaUEEPROM96:
	BZ          L__MatricaUEEPROM97
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	ADDLW       255
	GOTO        L__MatricaUEEPROM96
L__MatricaUEEPROM97:
	MOVLW       _EEPROMmatrica+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_EEPROMmatrica+0)
	ADDWFC      R1, 1 
	MOVF        MatricaUEEPROM_j_L0+0, 0 
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ds1820_pretraga_automatski_dodaj_novi_master.c,88 :: 		Delay_ms(50);
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       69
	MOVWF       R12, 0
	MOVLW       169
	MOVWF       R13, 0
L_MatricaUEEPROM13:
	DECFSZ      R13, 1, 1
	BRA         L_MatricaUEEPROM13
	DECFSZ      R12, 1, 1
	BRA         L_MatricaUEEPROM13
	DECFSZ      R11, 1, 1
	BRA         L_MatricaUEEPROM13
	NOP
	NOP
;ds1820_pretraga_automatski_dodaj_novi_master.c,85 :: 		for(j = 0; j < 8; j++)
	INCF        MatricaUEEPROM_j_L0+0, 1 
;ds1820_pretraga_automatski_dodaj_novi_master.c,89 :: 		}
	GOTO        L_MatricaUEEPROM10
L_MatricaUEEPROM11:
;ds1820_pretraga_automatski_dodaj_novi_master.c,83 :: 		for(i = brStarihSenzora; i < brNovihSenzora ; i++)
	INCF        MatricaUEEPROM_i_L0+0, 1 
;ds1820_pretraga_automatski_dodaj_novi_master.c,91 :: 		}
	GOTO        L_MatricaUEEPROM7
L_MatricaUEEPROM8:
;ds1820_pretraga_automatski_dodaj_novi_master.c,92 :: 		EEPROM_Write(0xFF,brNovihSenzora);
	MOVLW       255
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _brNovihSenzora+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ds1820_pretraga_automatski_dodaj_novi_master.c,93 :: 		}
L_end_MatricaUEEPROM:
	RETURN      0
; end of _MatricaUEEPROM

_istiROMovi:

;ds1820_pretraga_automatski_dodaj_novi_master.c,95 :: 		unsigned char istiROMovi(unsigned char * rom1, unsigned char * rom2)
;ds1820_pretraga_automatski_dodaj_novi_master.c,97 :: 		char i=0;
	CLRF        istiROMovi_i_L0+0 
;ds1820_pretraga_automatski_dodaj_novi_master.c,98 :: 		for(i=0;i<8;i++)
	CLRF        istiROMovi_i_L0+0 
L_istiROMovi14:
	MOVLW       8
	SUBWF       istiROMovi_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_istiROMovi15
;ds1820_pretraga_automatski_dodaj_novi_master.c,100 :: 		if(rom1[i]!=rom2[i])    // da bi dodajNoviSenzor radila treba rom2[7-1]
	MOVF        istiROMovi_i_L0+0, 0 
	ADDWF       FARG_istiROMovi_rom1+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_istiROMovi_rom1+1, 0 
	MOVWF       FSR0H 
	MOVF        istiROMovi_i_L0+0, 0 
	ADDWF       FARG_istiROMovi_rom2+0, 0 
	MOVWF       FSR2 
	MOVLW       0
	ADDWFC      FARG_istiROMovi_rom2+1, 0 
	MOVWF       FSR2H 
	MOVF        POSTINC0+0, 0 
	XORWF       POSTINC2+0, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_istiROMovi17
;ds1820_pretraga_automatski_dodaj_novi_master.c,102 :: 		return 0;
	CLRF        R0 
	GOTO        L_end_istiROMovi
;ds1820_pretraga_automatski_dodaj_novi_master.c,103 :: 		}
L_istiROMovi17:
;ds1820_pretraga_automatski_dodaj_novi_master.c,98 :: 		for(i=0;i<8;i++)
	INCF        istiROMovi_i_L0+0, 1 
;ds1820_pretraga_automatski_dodaj_novi_master.c,104 :: 		}
	GOTO        L_istiROMovi14
L_istiROMovi15:
;ds1820_pretraga_automatski_dodaj_novi_master.c,105 :: 		return 1;
	MOVLW       1
	MOVWF       R0 
;ds1820_pretraga_automatski_dodaj_novi_master.c,106 :: 		}
L_end_istiROMovi:
	RETURN      0
; end of _istiROMovi

_skenirajSenzore:

;ds1820_pretraga_automatski_dodaj_novi_master.c,168 :: 		void skenirajSenzore()
;ds1820_pretraga_automatski_dodaj_novi_master.c,172 :: 		for(i=0; i < MAX_SENZORA; i++)
	CLRF        skenirajSenzore_i_L0+0 
	CLRF        skenirajSenzore_i_L0+1 
L_skenirajSenzore18:
	MOVLW       128
	XORWF       skenirajSenzore_i_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__skenirajSenzore100
	MOVLW       16
	SUBWF       skenirajSenzore_i_L0+0, 0 
L__skenirajSenzore100:
	BTFSC       STATUS+0, 0 
	GOTO        L_skenirajSenzore19
;ds1820_pretraga_automatski_dodaj_novi_master.c,174 :: 		SenzoriFlagovi[i]=-1;
	MOVLW       _SenzoriFlagovi+0
	ADDWF       skenirajSenzore_i_L0+0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(_SenzoriFlagovi+0)
	ADDWFC      skenirajSenzore_i_L0+1, 0 
	MOVWF       FSR1H 
	MOVLW       255
	MOVWF       POSTINC1+0 
;ds1820_pretraga_automatski_dodaj_novi_master.c,175 :: 		EEPROMFlagovi[i]=-1;
	MOVLW       _EEPROMFlagovi+0
	ADDWF       skenirajSenzore_i_L0+0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(_EEPROMFlagovi+0)
	ADDWFC      skenirajSenzore_i_L0+1, 0 
	MOVWF       FSR1H 
	MOVLW       255
	MOVWF       POSTINC1+0 
;ds1820_pretraga_automatski_dodaj_novi_master.c,172 :: 		for(i=0; i < MAX_SENZORA; i++)
	INFSNZ      skenirajSenzore_i_L0+0, 1 
	INCF        skenirajSenzore_i_L0+1, 1 
;ds1820_pretraga_automatski_dodaj_novi_master.c,176 :: 		}
	GOTO        L_skenirajSenzore18
L_skenirajSenzore19:
;ds1820_pretraga_automatski_dodaj_novi_master.c,177 :: 		brTrenutnihSenzora = 0;
	CLRF        _brTrenutnihSenzora+0 
;ds1820_pretraga_automatski_dodaj_novi_master.c,178 :: 		if ( Ow_First() )
	CALL        _Ow_First+0, 0
	MOVF        R0, 0 
	IORWF       R1, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_skenirajSenzore21
;ds1820_pretraga_automatski_dodaj_novi_master.c,180 :: 		for(i=0;i<8;i++)
	CLRF        skenirajSenzore_i_L0+0 
	CLRF        skenirajSenzore_i_L0+1 
L_skenirajSenzore22:
	MOVLW       128
	XORWF       skenirajSenzore_i_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__skenirajSenzore101
	MOVLW       8
	SUBWF       skenirajSenzore_i_L0+0, 0 
L__skenirajSenzore101:
	BTFSC       STATUS+0, 0 
	GOTO        L_skenirajSenzore23
;ds1820_pretraga_automatski_dodaj_novi_master.c,182 :: 		ROMovi[brTrenutnihSenzora][i] = ROM_NO[7-i];
	MOVLW       3
	MOVWF       R2 
	MOVF        _brTrenutnihSenzora+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        R2, 0 
L__skenirajSenzore102:
	BZ          L__skenirajSenzore103
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	ADDLW       255
	GOTO        L__skenirajSenzore102
L__skenirajSenzore103:
	MOVLW       _ROMovi+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_ROMovi+0)
	ADDWFC      R1, 1 
	MOVF        skenirajSenzore_i_L0+0, 0 
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVF        skenirajSenzore_i_L0+1, 0 
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVF        skenirajSenzore_i_L0+0, 0 
	SUBLW       7
	MOVWF       R0 
	MOVF        skenirajSenzore_i_L0+1, 0 
	MOVWF       R1 
	MOVLW       0
	SUBFWB      R1, 1 
	MOVLW       _ROM_NO+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(_ROM_NO+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
;ds1820_pretraga_automatski_dodaj_novi_master.c,180 :: 		for(i=0;i<8;i++)
	INFSNZ      skenirajSenzore_i_L0+0, 1 
	INCF        skenirajSenzore_i_L0+1, 1 
;ds1820_pretraga_automatski_dodaj_novi_master.c,183 :: 		}
	GOTO        L_skenirajSenzore22
L_skenirajSenzore23:
;ds1820_pretraga_automatski_dodaj_novi_master.c,184 :: 		postojeciSenzor = 0;
	CLRF        _postojeciSenzor+0 
;ds1820_pretraga_automatski_dodaj_novi_master.c,185 :: 		for(i = 0; i < brStarihSenzora; i++)
	CLRF        skenirajSenzore_i_L0+0 
	CLRF        skenirajSenzore_i_L0+1 
L_skenirajSenzore25:
	MOVLW       128
	XORWF       skenirajSenzore_i_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__skenirajSenzore104
	MOVF        _brStarihSenzora+0, 0 
	SUBWF       skenirajSenzore_i_L0+0, 0 
L__skenirajSenzore104:
	BTFSC       STATUS+0, 0 
	GOTO        L_skenirajSenzore26
;ds1820_pretraga_automatski_dodaj_novi_master.c,187 :: 		if(istiROMovi(EEPROMMatrica[i],ROMovi[brTrenutnihSenzora]))
	MOVLW       3
	MOVWF       R2 
	MOVF        skenirajSenzore_i_L0+0, 0 
	MOVWF       R0 
	MOVF        skenirajSenzore_i_L0+1, 0 
	MOVWF       R1 
	MOVF        R2, 0 
L__skenirajSenzore105:
	BZ          L__skenirajSenzore106
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	ADDLW       255
	GOTO        L__skenirajSenzore105
L__skenirajSenzore106:
	MOVLW       _EEPROMmatrica+0
	ADDWF       R0, 0 
	MOVWF       FARG_istiROMovi_rom1+0 
	MOVLW       hi_addr(_EEPROMmatrica+0)
	ADDWFC      R1, 0 
	MOVWF       FARG_istiROMovi_rom1+1 
	MOVLW       3
	MOVWF       R2 
	MOVF        _brTrenutnihSenzora+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        R2, 0 
L__skenirajSenzore107:
	BZ          L__skenirajSenzore108
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	ADDLW       255
	GOTO        L__skenirajSenzore107
L__skenirajSenzore108:
	MOVLW       _ROMovi+0
	ADDWF       R0, 0 
	MOVWF       FARG_istiROMovi_rom2+0 
	MOVLW       hi_addr(_ROMovi+0)
	ADDWFC      R1, 0 
	MOVWF       FARG_istiROMovi_rom2+1 
	CALL        _istiROMovi+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_skenirajSenzore28
;ds1820_pretraga_automatski_dodaj_novi_master.c,189 :: 		postojeciSenzor = 1;
	MOVLW       1
	MOVWF       _postojeciSenzor+0 
;ds1820_pretraga_automatski_dodaj_novi_master.c,190 :: 		SenzoriFlagovi[brTrenutnihSenzora] = 1;
	MOVLW       _SenzoriFlagovi+0
	MOVWF       FSR1 
	MOVLW       hi_addr(_SenzoriFlagovi+0)
	MOVWF       FSR1H 
	MOVF        _brTrenutnihSenzora+0, 0 
	ADDWF       FSR1, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	MOVLW       1
	MOVWF       POSTINC1+0 
;ds1820_pretraga_automatski_dodaj_novi_master.c,191 :: 		EEPROMFlagovi[i] = 1;
	MOVLW       _EEPROMFlagovi+0
	ADDWF       skenirajSenzore_i_L0+0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(_EEPROMFlagovi+0)
	ADDWFC      skenirajSenzore_i_L0+1, 0 
	MOVWF       FSR1H 
	MOVLW       1
	MOVWF       POSTINC1+0 
;ds1820_pretraga_automatski_dodaj_novi_master.c,192 :: 		break;
	GOTO        L_skenirajSenzore26
;ds1820_pretraga_automatski_dodaj_novi_master.c,193 :: 		}
L_skenirajSenzore28:
;ds1820_pretraga_automatski_dodaj_novi_master.c,185 :: 		for(i = 0; i < brStarihSenzora; i++)
	INFSNZ      skenirajSenzore_i_L0+0, 1 
	INCF        skenirajSenzore_i_L0+1, 1 
;ds1820_pretraga_automatski_dodaj_novi_master.c,194 :: 		}
	GOTO        L_skenirajSenzore25
L_skenirajSenzore26:
;ds1820_pretraga_automatski_dodaj_novi_master.c,195 :: 		if(postojeciSenzor == 0)
	MOVF        _postojeciSenzor+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_skenirajSenzore29
;ds1820_pretraga_automatski_dodaj_novi_master.c,197 :: 		SenzoriFlagovi[brTrenutnihSenzora] = 0;
	MOVLW       _SenzoriFlagovi+0
	MOVWF       FSR1 
	MOVLW       hi_addr(_SenzoriFlagovi+0)
	MOVWF       FSR1H 
	MOVF        _brTrenutnihSenzora+0, 0 
	ADDWF       FSR1, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	CLRF        POSTINC1+0 
;ds1820_pretraga_automatski_dodaj_novi_master.c,198 :: 		}
L_skenirajSenzore29:
;ds1820_pretraga_automatski_dodaj_novi_master.c,199 :: 		brTrenutnihSenzora++;
	INCF        _brTrenutnihSenzora+0, 1 
;ds1820_pretraga_automatski_dodaj_novi_master.c,200 :: 		}
	GOTO        L_skenirajSenzore30
L_skenirajSenzore21:
;ds1820_pretraga_automatski_dodaj_novi_master.c,203 :: 		if(brStarihSenzora==0)
	MOVF        _brStarihSenzora+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_skenirajSenzore31
;ds1820_pretraga_automatski_dodaj_novi_master.c,205 :: 		Lcd_out(1,1,"Nijedan senzor!");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr1_ds1820_pretraga_automatski_dodaj_novi_master+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr1_ds1820_pretraga_automatski_dodaj_novi_master+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;ds1820_pretraga_automatski_dodaj_novi_master.c,206 :: 		}
L_skenirajSenzore31:
;ds1820_pretraga_automatski_dodaj_novi_master.c,207 :: 		}
L_skenirajSenzore30:
;ds1820_pretraga_automatski_dodaj_novi_master.c,208 :: 		while ( Ow_Next() )
L_skenirajSenzore32:
	CALL        _Ow_Next+0, 0
	MOVF        R0, 0 
	IORWF       R1, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_skenirajSenzore33
;ds1820_pretraga_automatski_dodaj_novi_master.c,210 :: 		for(i=0;i<8;i++)
	CLRF        skenirajSenzore_i_L0+0 
	CLRF        skenirajSenzore_i_L0+1 
L_skenirajSenzore34:
	MOVLW       128
	XORWF       skenirajSenzore_i_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__skenirajSenzore109
	MOVLW       8
	SUBWF       skenirajSenzore_i_L0+0, 0 
L__skenirajSenzore109:
	BTFSC       STATUS+0, 0 
	GOTO        L_skenirajSenzore35
;ds1820_pretraga_automatski_dodaj_novi_master.c,212 :: 		ROMovi[brTrenutnihSenzora][i] = ROM_NO[7-i];
	MOVLW       3
	MOVWF       R2 
	MOVF        _brTrenutnihSenzora+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        R2, 0 
L__skenirajSenzore110:
	BZ          L__skenirajSenzore111
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	ADDLW       255
	GOTO        L__skenirajSenzore110
L__skenirajSenzore111:
	MOVLW       _ROMovi+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_ROMovi+0)
	ADDWFC      R1, 1 
	MOVF        skenirajSenzore_i_L0+0, 0 
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVF        skenirajSenzore_i_L0+1, 0 
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVF        skenirajSenzore_i_L0+0, 0 
	SUBLW       7
	MOVWF       R0 
	MOVF        skenirajSenzore_i_L0+1, 0 
	MOVWF       R1 
	MOVLW       0
	SUBFWB      R1, 1 
	MOVLW       _ROM_NO+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(_ROM_NO+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
;ds1820_pretraga_automatski_dodaj_novi_master.c,210 :: 		for(i=0;i<8;i++)
	INFSNZ      skenirajSenzore_i_L0+0, 1 
	INCF        skenirajSenzore_i_L0+1, 1 
;ds1820_pretraga_automatski_dodaj_novi_master.c,213 :: 		}
	GOTO        L_skenirajSenzore34
L_skenirajSenzore35:
;ds1820_pretraga_automatski_dodaj_novi_master.c,214 :: 		postojeciSenzor = 0;
	CLRF        _postojeciSenzor+0 
;ds1820_pretraga_automatski_dodaj_novi_master.c,215 :: 		for(i = 0; i < brStarihSenzora; i++)
	CLRF        skenirajSenzore_i_L0+0 
	CLRF        skenirajSenzore_i_L0+1 
L_skenirajSenzore37:
	MOVLW       128
	XORWF       skenirajSenzore_i_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__skenirajSenzore112
	MOVF        _brStarihSenzora+0, 0 
	SUBWF       skenirajSenzore_i_L0+0, 0 
L__skenirajSenzore112:
	BTFSC       STATUS+0, 0 
	GOTO        L_skenirajSenzore38
;ds1820_pretraga_automatski_dodaj_novi_master.c,217 :: 		if(istiROMovi(EEPROMMatrica[i],ROMovi[brTrenutnihSenzora]))
	MOVLW       3
	MOVWF       R2 
	MOVF        skenirajSenzore_i_L0+0, 0 
	MOVWF       R0 
	MOVF        skenirajSenzore_i_L0+1, 0 
	MOVWF       R1 
	MOVF        R2, 0 
L__skenirajSenzore113:
	BZ          L__skenirajSenzore114
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	ADDLW       255
	GOTO        L__skenirajSenzore113
L__skenirajSenzore114:
	MOVLW       _EEPROMmatrica+0
	ADDWF       R0, 0 
	MOVWF       FARG_istiROMovi_rom1+0 
	MOVLW       hi_addr(_EEPROMmatrica+0)
	ADDWFC      R1, 0 
	MOVWF       FARG_istiROMovi_rom1+1 
	MOVLW       3
	MOVWF       R2 
	MOVF        _brTrenutnihSenzora+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        R2, 0 
L__skenirajSenzore115:
	BZ          L__skenirajSenzore116
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	ADDLW       255
	GOTO        L__skenirajSenzore115
L__skenirajSenzore116:
	MOVLW       _ROMovi+0
	ADDWF       R0, 0 
	MOVWF       FARG_istiROMovi_rom2+0 
	MOVLW       hi_addr(_ROMovi+0)
	ADDWFC      R1, 0 
	MOVWF       FARG_istiROMovi_rom2+1 
	CALL        _istiROMovi+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_skenirajSenzore40
;ds1820_pretraga_automatski_dodaj_novi_master.c,219 :: 		postojeciSenzor = 1;
	MOVLW       1
	MOVWF       _postojeciSenzor+0 
;ds1820_pretraga_automatski_dodaj_novi_master.c,220 :: 		SenzoriFlagovi[brTrenutnihSenzora] = 1;
	MOVLW       _SenzoriFlagovi+0
	MOVWF       FSR1 
	MOVLW       hi_addr(_SenzoriFlagovi+0)
	MOVWF       FSR1H 
	MOVF        _brTrenutnihSenzora+0, 0 
	ADDWF       FSR1, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	MOVLW       1
	MOVWF       POSTINC1+0 
;ds1820_pretraga_automatski_dodaj_novi_master.c,221 :: 		EEPROMFlagovi[i] = 1;
	MOVLW       _EEPROMFlagovi+0
	ADDWF       skenirajSenzore_i_L0+0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(_EEPROMFlagovi+0)
	ADDWFC      skenirajSenzore_i_L0+1, 0 
	MOVWF       FSR1H 
	MOVLW       1
	MOVWF       POSTINC1+0 
;ds1820_pretraga_automatski_dodaj_novi_master.c,222 :: 		break;
	GOTO        L_skenirajSenzore38
;ds1820_pretraga_automatski_dodaj_novi_master.c,223 :: 		}
L_skenirajSenzore40:
;ds1820_pretraga_automatski_dodaj_novi_master.c,215 :: 		for(i = 0; i < brStarihSenzora; i++)
	INFSNZ      skenirajSenzore_i_L0+0, 1 
	INCF        skenirajSenzore_i_L0+1, 1 
;ds1820_pretraga_automatski_dodaj_novi_master.c,224 :: 		}
	GOTO        L_skenirajSenzore37
L_skenirajSenzore38:
;ds1820_pretraga_automatski_dodaj_novi_master.c,225 :: 		if(postojeciSenzor == 0)
	MOVF        _postojeciSenzor+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_skenirajSenzore41
;ds1820_pretraga_automatski_dodaj_novi_master.c,227 :: 		SenzoriFlagovi[brTrenutnihSenzora] = 0;
	MOVLW       _SenzoriFlagovi+0
	MOVWF       FSR1 
	MOVLW       hi_addr(_SenzoriFlagovi+0)
	MOVWF       FSR1H 
	MOVF        _brTrenutnihSenzora+0, 0 
	ADDWF       FSR1, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	CLRF        POSTINC1+0 
;ds1820_pretraga_automatski_dodaj_novi_master.c,228 :: 		}
L_skenirajSenzore41:
;ds1820_pretraga_automatski_dodaj_novi_master.c,229 :: 		brTrenutnihSenzora++;
	INCF        _brTrenutnihSenzora+0, 1 
;ds1820_pretraga_automatski_dodaj_novi_master.c,230 :: 		}
	GOTO        L_skenirajSenzore32
L_skenirajSenzore33:
;ds1820_pretraga_automatski_dodaj_novi_master.c,233 :: 		for(i=0;i<brStarihSenzora;i++)
	CLRF        skenirajSenzore_i_L0+0 
	CLRF        skenirajSenzore_i_L0+1 
L_skenirajSenzore42:
	MOVLW       128
	XORWF       skenirajSenzore_i_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__skenirajSenzore117
	MOVF        _brStarihSenzora+0, 0 
	SUBWF       skenirajSenzore_i_L0+0, 0 
L__skenirajSenzore117:
	BTFSC       STATUS+0, 0 
	GOTO        L_skenirajSenzore43
;ds1820_pretraga_automatski_dodaj_novi_master.c,235 :: 		if(EEPROMFlagovi[i]!=1)
	MOVLW       _EEPROMFlagovi+0
	ADDWF       skenirajSenzore_i_L0+0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(_EEPROMFlagovi+0)
	ADDWFC      skenirajSenzore_i_L0+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_skenirajSenzore45
;ds1820_pretraga_automatski_dodaj_novi_master.c,237 :: 		EEPROMFlagovi[i]=0;
	MOVLW       _EEPROMFlagovi+0
	ADDWF       skenirajSenzore_i_L0+0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(_EEPROMFlagovi+0)
	ADDWFC      skenirajSenzore_i_L0+1, 0 
	MOVWF       FSR1H 
	CLRF        POSTINC1+0 
;ds1820_pretraga_automatski_dodaj_novi_master.c,238 :: 		}
L_skenirajSenzore45:
;ds1820_pretraga_automatski_dodaj_novi_master.c,233 :: 		for(i=0;i<brStarihSenzora;i++)
	INFSNZ      skenirajSenzore_i_L0+0, 1 
	INCF        skenirajSenzore_i_L0+1, 1 
;ds1820_pretraga_automatski_dodaj_novi_master.c,239 :: 		}
	GOTO        L_skenirajSenzore42
L_skenirajSenzore43:
;ds1820_pretraga_automatski_dodaj_novi_master.c,245 :: 		for(i=0; i<brTrenutnihSenzora; i++)
	CLRF        skenirajSenzore_i_L0+0 
	CLRF        skenirajSenzore_i_L0+1 
L_skenirajSenzore46:
	MOVLW       128
	XORWF       skenirajSenzore_i_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__skenirajSenzore118
	MOVF        _brTrenutnihSenzora+0, 0 
	SUBWF       skenirajSenzore_i_L0+0, 0 
L__skenirajSenzore118:
	BTFSC       STATUS+0, 0 
	GOTO        L_skenirajSenzore47
;ds1820_pretraga_automatski_dodaj_novi_master.c,247 :: 		if(SenzoriFlagovi[i]==0)
	MOVLW       _SenzoriFlagovi+0
	ADDWF       skenirajSenzore_i_L0+0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(_SenzoriFlagovi+0)
	ADDWFC      skenirajSenzore_i_L0+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_skenirajSenzore49
;ds1820_pretraga_automatski_dodaj_novi_master.c,249 :: 		postojeciSenzor=0;
	CLRF        _postojeciSenzor+0 
;ds1820_pretraga_automatski_dodaj_novi_master.c,250 :: 		for(j=0;j<brStarihSenzora;j++)
	CLRF        skenirajSenzore_j_L0+0 
	CLRF        skenirajSenzore_j_L0+1 
L_skenirajSenzore50:
	MOVLW       128
	XORWF       skenirajSenzore_j_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__skenirajSenzore119
	MOVF        _brStarihSenzora+0, 0 
	SUBWF       skenirajSenzore_j_L0+0, 0 
L__skenirajSenzore119:
	BTFSC       STATUS+0, 0 
	GOTO        L_skenirajSenzore51
;ds1820_pretraga_automatski_dodaj_novi_master.c,253 :: 		if(EEPROMFlagovi[j]==0)
	MOVLW       _EEPROMFlagovi+0
	ADDWF       skenirajSenzore_j_L0+0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(_EEPROMFlagovi+0)
	ADDWFC      skenirajSenzore_j_L0+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_skenirajSenzore53
;ds1820_pretraga_automatski_dodaj_novi_master.c,255 :: 		postojeciSenzor=1;
	MOVLW       1
	MOVWF       _postojeciSenzor+0 
;ds1820_pretraga_automatski_dodaj_novi_master.c,256 :: 		for(k=0;k<8;k++)
	CLRF        skenirajSenzore_k_L0+0 
	CLRF        skenirajSenzore_k_L0+1 
L_skenirajSenzore54:
	MOVLW       128
	XORWF       skenirajSenzore_k_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__skenirajSenzore120
	MOVLW       8
	SUBWF       skenirajSenzore_k_L0+0, 0 
L__skenirajSenzore120:
	BTFSC       STATUS+0, 0 
	GOTO        L_skenirajSenzore55
;ds1820_pretraga_automatski_dodaj_novi_master.c,258 :: 		EEPROM_Write(j*16 +k,ROMovi[i][k]);
	MOVLW       4
	MOVWF       R0 
	MOVF        skenirajSenzore_j_L0+0, 0 
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        R0, 0 
L__skenirajSenzore121:
	BZ          L__skenirajSenzore122
	RLCF        FARG_EEPROM_Write_address+0, 1 
	BCF         FARG_EEPROM_Write_address+0, 0 
	ADDLW       255
	GOTO        L__skenirajSenzore121
L__skenirajSenzore122:
	MOVF        skenirajSenzore_k_L0+0, 0 
	ADDWF       FARG_EEPROM_Write_address+0, 1 
	MOVLW       3
	MOVWF       R2 
	MOVF        skenirajSenzore_i_L0+0, 0 
	MOVWF       R0 
	MOVF        skenirajSenzore_i_L0+1, 0 
	MOVWF       R1 
	MOVF        R2, 0 
L__skenirajSenzore123:
	BZ          L__skenirajSenzore124
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	ADDLW       255
	GOTO        L__skenirajSenzore123
L__skenirajSenzore124:
	MOVLW       _ROMovi+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_ROMovi+0)
	ADDWFC      R1, 1 
	MOVF        skenirajSenzore_k_L0+0, 0 
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVF        skenirajSenzore_k_L0+1, 0 
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ds1820_pretraga_automatski_dodaj_novi_master.c,259 :: 		EEPROMMatrica[j][k] = ROMovi[i][k];
	MOVLW       3
	MOVWF       R2 
	MOVF        skenirajSenzore_j_L0+0, 0 
	MOVWF       R0 
	MOVF        skenirajSenzore_j_L0+1, 0 
	MOVWF       R1 
	MOVF        R2, 0 
L__skenirajSenzore125:
	BZ          L__skenirajSenzore126
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	ADDLW       255
	GOTO        L__skenirajSenzore125
L__skenirajSenzore126:
	MOVLW       _EEPROMmatrica+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_EEPROMmatrica+0)
	ADDWFC      R1, 1 
	MOVF        skenirajSenzore_k_L0+0, 0 
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVF        skenirajSenzore_k_L0+1, 0 
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       3
	MOVWF       R2 
	MOVF        skenirajSenzore_i_L0+0, 0 
	MOVWF       R0 
	MOVF        skenirajSenzore_i_L0+1, 0 
	MOVWF       R1 
	MOVF        R2, 0 
L__skenirajSenzore127:
	BZ          L__skenirajSenzore128
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	ADDLW       255
	GOTO        L__skenirajSenzore127
L__skenirajSenzore128:
	MOVLW       _ROMovi+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_ROMovi+0)
	ADDWFC      R1, 1 
	MOVF        skenirajSenzore_k_L0+0, 0 
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVF        skenirajSenzore_k_L0+1, 0 
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
;ds1820_pretraga_automatski_dodaj_novi_master.c,256 :: 		for(k=0;k<8;k++)
	INFSNZ      skenirajSenzore_k_L0+0, 1 
	INCF        skenirajSenzore_k_L0+1, 1 
;ds1820_pretraga_automatski_dodaj_novi_master.c,260 :: 		}
	GOTO        L_skenirajSenzore54
L_skenirajSenzore55:
;ds1820_pretraga_automatski_dodaj_novi_master.c,261 :: 		EEPROMFlagovi[j]=1;
	MOVLW       _EEPROMFlagovi+0
	ADDWF       skenirajSenzore_j_L0+0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(_EEPROMFlagovi+0)
	ADDWFC      skenirajSenzore_j_L0+1, 0 
	MOVWF       FSR1H 
	MOVLW       1
	MOVWF       POSTINC1+0 
;ds1820_pretraga_automatski_dodaj_novi_master.c,262 :: 		break;
	GOTO        L_skenirajSenzore51
;ds1820_pretraga_automatski_dodaj_novi_master.c,263 :: 		}
L_skenirajSenzore53:
;ds1820_pretraga_automatski_dodaj_novi_master.c,250 :: 		for(j=0;j<brStarihSenzora;j++)
	INFSNZ      skenirajSenzore_j_L0+0, 1 
	INCF        skenirajSenzore_j_L0+1, 1 
;ds1820_pretraga_automatski_dodaj_novi_master.c,264 :: 		}
	GOTO        L_skenirajSenzore50
L_skenirajSenzore51:
;ds1820_pretraga_automatski_dodaj_novi_master.c,265 :: 		if(postojeciSenzor==0)
	MOVF        _postojeciSenzor+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_skenirajSenzore57
;ds1820_pretraga_automatski_dodaj_novi_master.c,270 :: 		for(k=0;k<8;k++)
	CLRF        skenirajSenzore_k_L0+0 
	CLRF        skenirajSenzore_k_L0+1 
L_skenirajSenzore58:
	MOVLW       128
	XORWF       skenirajSenzore_k_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__skenirajSenzore129
	MOVLW       8
	SUBWF       skenirajSenzore_k_L0+0, 0 
L__skenirajSenzore129:
	BTFSC       STATUS+0, 0 
	GOTO        L_skenirajSenzore59
;ds1820_pretraga_automatski_dodaj_novi_master.c,272 :: 		EEPROM_Write(brStarihSenzora*16 +k,ROMovi[i][k]);
	MOVF        _brStarihSenzora+0, 0 
	MOVWF       FARG_EEPROM_Write_address+0 
	RLCF        FARG_EEPROM_Write_address+0, 1 
	BCF         FARG_EEPROM_Write_address+0, 0 
	RLCF        FARG_EEPROM_Write_address+0, 1 
	BCF         FARG_EEPROM_Write_address+0, 0 
	RLCF        FARG_EEPROM_Write_address+0, 1 
	BCF         FARG_EEPROM_Write_address+0, 0 
	RLCF        FARG_EEPROM_Write_address+0, 1 
	BCF         FARG_EEPROM_Write_address+0, 0 
	MOVF        skenirajSenzore_k_L0+0, 0 
	ADDWF       FARG_EEPROM_Write_address+0, 1 
	MOVLW       3
	MOVWF       R2 
	MOVF        skenirajSenzore_i_L0+0, 0 
	MOVWF       R0 
	MOVF        skenirajSenzore_i_L0+1, 0 
	MOVWF       R1 
	MOVF        R2, 0 
L__skenirajSenzore130:
	BZ          L__skenirajSenzore131
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	ADDLW       255
	GOTO        L__skenirajSenzore130
L__skenirajSenzore131:
	MOVLW       _ROMovi+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_ROMovi+0)
	ADDWFC      R1, 1 
	MOVF        skenirajSenzore_k_L0+0, 0 
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVF        skenirajSenzore_k_L0+1, 0 
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ds1820_pretraga_automatski_dodaj_novi_master.c,273 :: 		EEPROMMatrica[brStarihSenzora][k] = ROMovi[i][k];
	MOVLW       3
	MOVWF       R2 
	MOVF        _brStarihSenzora+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        R2, 0 
L__skenirajSenzore132:
	BZ          L__skenirajSenzore133
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	ADDLW       255
	GOTO        L__skenirajSenzore132
L__skenirajSenzore133:
	MOVLW       _EEPROMmatrica+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_EEPROMmatrica+0)
	ADDWFC      R1, 1 
	MOVF        skenirajSenzore_k_L0+0, 0 
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVF        skenirajSenzore_k_L0+1, 0 
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       3
	MOVWF       R2 
	MOVF        skenirajSenzore_i_L0+0, 0 
	MOVWF       R0 
	MOVF        skenirajSenzore_i_L0+1, 0 
	MOVWF       R1 
	MOVF        R2, 0 
L__skenirajSenzore134:
	BZ          L__skenirajSenzore135
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	ADDLW       255
	GOTO        L__skenirajSenzore134
L__skenirajSenzore135:
	MOVLW       _ROMovi+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_ROMovi+0)
	ADDWFC      R1, 1 
	MOVF        skenirajSenzore_k_L0+0, 0 
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVF        skenirajSenzore_k_L0+1, 0 
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
;ds1820_pretraga_automatski_dodaj_novi_master.c,270 :: 		for(k=0;k<8;k++)
	INFSNZ      skenirajSenzore_k_L0+0, 1 
	INCF        skenirajSenzore_k_L0+1, 1 
;ds1820_pretraga_automatski_dodaj_novi_master.c,274 :: 		}
	GOTO        L_skenirajSenzore58
L_skenirajSenzore59:
;ds1820_pretraga_automatski_dodaj_novi_master.c,275 :: 		brStarihSenzora++;
	INCF        _brStarihSenzora+0, 1 
;ds1820_pretraga_automatski_dodaj_novi_master.c,277 :: 		}
L_skenirajSenzore57:
;ds1820_pretraga_automatski_dodaj_novi_master.c,278 :: 		}
L_skenirajSenzore49:
;ds1820_pretraga_automatski_dodaj_novi_master.c,245 :: 		for(i=0; i<brTrenutnihSenzora; i++)
	INFSNZ      skenirajSenzore_i_L0+0, 1 
	INCF        skenirajSenzore_i_L0+1, 1 
;ds1820_pretraga_automatski_dodaj_novi_master.c,279 :: 		}
	GOTO        L_skenirajSenzore46
L_skenirajSenzore47:
;ds1820_pretraga_automatski_dodaj_novi_master.c,281 :: 		EEPROM_Write(0xFF,brStarihSenzora);
	MOVLW       255
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _brStarihSenzora+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ds1820_pretraga_automatski_dodaj_novi_master.c,282 :: 		}
L_end_skenirajSenzore:
	RETURN      0
; end of _skenirajSenzore

_Display_Temperature:

;ds1820_pretraga_automatski_dodaj_novi_master.c,283 :: 		void Display_Temperature(unsigned char i, unsigned char j, unsigned int temp2write) {
;ds1820_pretraga_automatski_dodaj_novi_master.c,289 :: 		if (temp2write & 0x8000)
	BTFSS       FARG_Display_Temperature_temp2write+1, 7 
	GOTO        L_Display_Temperature61
;ds1820_pretraga_automatski_dodaj_novi_master.c,291 :: 		text[0] = '-';
	MOVLW       45
	MOVWF       _text+0 
;ds1820_pretraga_automatski_dodaj_novi_master.c,292 :: 		temp2write = ~temp2write; //ovde bi trebalo temp2write = ~temp2write + 1, ali to u proteusu ne radi, a ovo radi
	COMF        FARG_Display_Temperature_temp2write+0, 0 
	MOVWF       R3 
	COMF        FARG_Display_Temperature_temp2write+1, 0 
	MOVWF       R4 
	MOVF        R3, 0 
	MOVWF       FARG_Display_Temperature_temp2write+0 
	MOVF        R4, 0 
	MOVWF       FARG_Display_Temperature_temp2write+1 
;ds1820_pretraga_automatski_dodaj_novi_master.c,294 :: 		temp_whole = temp2write >> RES_SHIFT ;
	MOVF        R3, 0 
	MOVWF       R0 
	MOVF        R4, 0 
	MOVWF       R1 
	RRCF        R1, 1 
	RRCF        R0, 1 
	BCF         R1, 7 
	MOVF        R0, 0 
	MOVWF       Display_Temperature_temp_whole_L0+0 
;ds1820_pretraga_automatski_dodaj_novi_master.c,295 :: 		}
	GOTO        L_Display_Temperature62
L_Display_Temperature61:
;ds1820_pretraga_automatski_dodaj_novi_master.c,299 :: 		temp_whole = temp2write >> RES_SHIFT ;
	MOVF        FARG_Display_Temperature_temp2write+0, 0 
	MOVWF       R0 
	MOVF        FARG_Display_Temperature_temp2write+1, 0 
	MOVWF       R1 
	RRCF        R1, 1 
	RRCF        R0, 1 
	BCF         R1, 7 
	MOVF        R0, 0 
	MOVWF       Display_Temperature_temp_whole_L0+0 
;ds1820_pretraga_automatski_dodaj_novi_master.c,300 :: 		if (temp_whole/100)
	MOVLW       100
	MOVWF       R4 
	CALL        _Div_8x8_U+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_Display_Temperature63
;ds1820_pretraga_automatski_dodaj_novi_master.c,302 :: 		text[0] = temp_whole/100  + 48;
	MOVLW       100
	MOVWF       R4 
	MOVF        Display_Temperature_temp_whole_L0+0, 0 
	MOVWF       R0 
	CALL        _Div_8x8_U+0, 0
	MOVLW       48
	ADDWF       R0, 0 
	MOVWF       _text+0 
;ds1820_pretraga_automatski_dodaj_novi_master.c,303 :: 		}
	GOTO        L_Display_Temperature64
L_Display_Temperature63:
;ds1820_pretraga_automatski_dodaj_novi_master.c,306 :: 		text[0] = '0';
	MOVLW       48
	MOVWF       _text+0 
;ds1820_pretraga_automatski_dodaj_novi_master.c,307 :: 		}
L_Display_Temperature64:
;ds1820_pretraga_automatski_dodaj_novi_master.c,308 :: 		}
L_Display_Temperature62:
;ds1820_pretraga_automatski_dodaj_novi_master.c,312 :: 		text[1] = (temp_whole/10)%10 + 48;             // Extract tens digit
	MOVLW       10
	MOVWF       R4 
	MOVF        Display_Temperature_temp_whole_L0+0, 0 
	MOVWF       R0 
	CALL        _Div_8x8_U+0, 0
	MOVLW       10
	MOVWF       R4 
	CALL        _Div_8x8_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVLW       48
	ADDWF       R0, 0 
	MOVWF       _text+1 
;ds1820_pretraga_automatski_dodaj_novi_master.c,313 :: 		text[2] =  temp_whole%10     + 48;             // Extract ones digit
	MOVLW       10
	MOVWF       R4 
	MOVF        Display_Temperature_temp_whole_L0+0, 0 
	MOVWF       R0 
	CALL        _Div_8x8_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVLW       48
	ADDWF       R0, 0 
	MOVWF       _text+2 
;ds1820_pretraga_automatski_dodaj_novi_master.c,314 :: 		text[3]  ='.';
	MOVLW       46
	MOVWF       _text+3 
;ds1820_pretraga_automatski_dodaj_novi_master.c,317 :: 		temp_fraction  = temp2write << (4-RES_SHIFT);
	MOVF        FARG_Display_Temperature_temp2write+0, 0 
	MOVWF       R0 
	MOVF        FARG_Display_Temperature_temp2write+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
;ds1820_pretraga_automatski_dodaj_novi_master.c,318 :: 		temp_fraction &= 0x000F;
	MOVLW       15
	ANDWF       R0, 1 
	MOVLW       0
	ANDWF       R1, 1 
;ds1820_pretraga_automatski_dodaj_novi_master.c,319 :: 		temp_fraction *= 625;
	MOVLW       113
	MOVWF       R4 
	MOVLW       2
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
;ds1820_pretraga_automatski_dodaj_novi_master.c,322 :: 		text[4] =  temp_fraction/1000    + 48;         // Extract thousands digit
	MOVLW       232
	MOVWF       R4 
	MOVLW       3
	MOVWF       R5 
	CALL        _Div_16x16_U+0, 0
	MOVLW       48
	ADDWF       R0, 0 
	MOVWF       _text+4 
;ds1820_pretraga_automatski_dodaj_novi_master.c,323 :: 		text[5]=223;                                   //ascii za stepen
	MOVLW       223
	MOVWF       _text+5 
;ds1820_pretraga_automatski_dodaj_novi_master.c,324 :: 		text[6]='\0';
	CLRF        _text+6 
;ds1820_pretraga_automatski_dodaj_novi_master.c,327 :: 		Lcd_Out(i, j, text);
	MOVF        FARG_Display_Temperature_i+0, 0 
	MOVWF       FARG_Lcd_Out_row+0 
	MOVF        FARG_Display_Temperature_j+0, 0 
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _text+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_text+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;ds1820_pretraga_automatski_dodaj_novi_master.c,328 :: 		}
L_end_Display_Temperature:
	RETURN      0
; end of _Display_Temperature

_citajTemp:

;ds1820_pretraga_automatski_dodaj_novi_master.c,331 :: 		unsigned int citajTemp(unsigned char *x)
;ds1820_pretraga_automatski_dodaj_novi_master.c,336 :: 		Ow_Reset();                         // Onewire reset signal
	CALL        _Ow_Reset+0, 0
;ds1820_pretraga_automatski_dodaj_novi_master.c,337 :: 		Ow_Write_Byte(0x55);              // Issue command MATCH_ROM
	MOVLW       85
	MOVWF       FARG_Ow_Write_Byte+0 
	CALL        _Ow_Write_Byte+0, 0
;ds1820_pretraga_automatski_dodaj_novi_master.c,338 :: 		for(i = 0; i < 8; i++)
	CLRF        _i+0 
L_citajTemp65:
	MOVLW       8
	SUBWF       _i+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_citajTemp66
;ds1820_pretraga_automatski_dodaj_novi_master.c,340 :: 		Ow_Write_Byte(x[7-i]);
	MOVF        _i+0, 0 
	SUBLW       7
	MOVWF       R0 
	CLRF        R1 
	MOVLW       0
	SUBWFB      R1, 1 
	MOVF        R0, 0 
	ADDWF       FARG_citajTemp_x+0, 0 
	MOVWF       FSR0 
	MOVF        R1, 0 
	ADDWFC      FARG_citajTemp_x+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_Ow_Write_Byte+0 
	CALL        _Ow_Write_Byte+0, 0
;ds1820_pretraga_automatski_dodaj_novi_master.c,338 :: 		for(i = 0; i < 8; i++)
	INCF        _i+0, 1 
;ds1820_pretraga_automatski_dodaj_novi_master.c,341 :: 		}
	GOTO        L_citajTemp65
L_citajTemp66:
;ds1820_pretraga_automatski_dodaj_novi_master.c,342 :: 		Ow_Write_Byte(0x44);              // Issue command CONVERT_T
	MOVLW       68
	MOVWF       FARG_Ow_Write_Byte+0 
	CALL        _Ow_Write_Byte+0, 0
;ds1820_pretraga_automatski_dodaj_novi_master.c,343 :: 		Delay_us(120);
	MOVLW       199
	MOVWF       R13, 0
L_citajTemp68:
	DECFSZ      R13, 1, 1
	BRA         L_citajTemp68
	NOP
	NOP
;ds1820_pretraga_automatski_dodaj_novi_master.c,345 :: 		Ow_Reset();                         // Onewire reset signal
	CALL        _Ow_Reset+0, 0
;ds1820_pretraga_automatski_dodaj_novi_master.c,346 :: 		Ow_Write_Byte(0x55);              // Issue command MATCH_ROM
	MOVLW       85
	MOVWF       FARG_Ow_Write_Byte+0 
	CALL        _Ow_Write_Byte+0, 0
;ds1820_pretraga_automatski_dodaj_novi_master.c,347 :: 		for(i = 0; i < 8; i++)                       // This MUST follow MATCH_ROM
	CLRF        _i+0 
L_citajTemp69:
	MOVLW       8
	SUBWF       _i+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_citajTemp70
;ds1820_pretraga_automatski_dodaj_novi_master.c,349 :: 		Ow_Write_Byte(x[7-i]);
	MOVF        _i+0, 0 
	SUBLW       7
	MOVWF       R0 
	CLRF        R1 
	MOVLW       0
	SUBWFB      R1, 1 
	MOVF        R0, 0 
	ADDWF       FARG_citajTemp_x+0, 0 
	MOVWF       FSR0 
	MOVF        R1, 0 
	ADDWFC      FARG_citajTemp_x+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_Ow_Write_Byte+0 
	CALL        _Ow_Write_Byte+0, 0
;ds1820_pretraga_automatski_dodaj_novi_master.c,347 :: 		for(i = 0; i < 8; i++)                       // This MUST follow MATCH_ROM
	INCF        _i+0, 1 
;ds1820_pretraga_automatski_dodaj_novi_master.c,350 :: 		}
	GOTO        L_citajTemp69
L_citajTemp70:
;ds1820_pretraga_automatski_dodaj_novi_master.c,351 :: 		Ow_Write_Byte(0xBE);        // Issue command READ_SCRATCHPAD
	MOVLW       190
	MOVWF       FARG_Ow_Write_Byte+0 
	CALL        _Ow_Write_Byte+0, 0
;ds1820_pretraga_automatski_dodaj_novi_master.c,353 :: 		for(i = 0; i < 2; i++)
	CLRF        _i+0 
L_citajTemp72:
	MOVLW       2
	SUBWF       _i+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_citajTemp73
;ds1820_pretraga_automatski_dodaj_novi_master.c,355 :: 		scratchPad0[i] = Ow_Read_Byte();
	MOVLW       citajTemp_scratchPad0_L0+0
	MOVWF       FLOC__citajTemp+0 
	MOVLW       hi_addr(citajTemp_scratchPad0_L0+0)
	MOVWF       FLOC__citajTemp+1 
	MOVF        _i+0, 0 
	ADDWF       FLOC__citajTemp+0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FLOC__citajTemp+1, 1 
	CALL        _Ow_Read_Byte+0, 0
	MOVFF       FLOC__citajTemp+0, FSR1
	MOVFF       FLOC__citajTemp+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;ds1820_pretraga_automatski_dodaj_novi_master.c,353 :: 		for(i = 0; i < 2; i++)
	INCF        _i+0, 1 
;ds1820_pretraga_automatski_dodaj_novi_master.c,356 :: 		}
	GOTO        L_citajTemp72
L_citajTemp73:
;ds1820_pretraga_automatski_dodaj_novi_master.c,358 :: 		tempDigitalno = scratchPad0[0];
	MOVF        citajTemp_scratchPad0_L0+0, 0 
	MOVWF       citajTemp_tempDigitalno_L0+0 
	MOVLW       0
	MOVWF       citajTemp_tempDigitalno_L0+1 
;ds1820_pretraga_automatski_dodaj_novi_master.c,359 :: 		tempDigitalno = (scratchPad0[1] << 8) + tempDigitalno;
	MOVF        citajTemp_scratchPad0_L0+1, 0 
	MOVWF       R1 
	CLRF        R0 
	MOVF        citajTemp_tempDigitalno_L0+0, 0 
	ADDWF       R0, 1 
	MOVF        citajTemp_tempDigitalno_L0+1, 0 
	ADDWFC      R1, 1 
	MOVF        R0, 0 
	MOVWF       citajTemp_tempDigitalno_L0+0 
	MOVF        R1, 0 
	MOVWF       citajTemp_tempDigitalno_L0+1 
;ds1820_pretraga_automatski_dodaj_novi_master.c,361 :: 		return tempDigitalno;
;ds1820_pretraga_automatski_dodaj_novi_master.c,362 :: 		}
L_end_citajTemp:
	RETURN      0
; end of _citajTemp

_main:

;ds1820_pretraga_automatski_dodaj_novi_master.c,364 :: 		void main()
;ds1820_pretraga_automatski_dodaj_novi_master.c,368 :: 		ANSEL0  = 0;                   // Configure AN pins as digital I/O
	CLRF        ANSEL0+0 
;ds1820_pretraga_automatski_dodaj_novi_master.c,369 :: 		ANSEL1 = 0;
	CLRF        ANSEL1+0 
;ds1820_pretraga_automatski_dodaj_novi_master.c,371 :: 		MOVLW 15      // Set RB<4:0> as digital I/O pins (required if config bit PBADEN is set)
	MOVLW       15
;ds1820_pretraga_automatski_dodaj_novi_master.c,372 :: 		MOVWF ADCON1  //ADCON1 = 0b00001111
	MOVWF       ADCON1+0, 1
;ds1820_pretraga_automatski_dodaj_novi_master.c,373 :: 		MOVLW 7       //Dakle, TRISB = 0b00000111
	MOVLW       7
;ds1820_pretraga_automatski_dodaj_novi_master.c,374 :: 		MOVWF TRISB   //RB<2:0> su ulazi a RB<7:3> izlazi
	MOVWF       TRISB+0, 1
;ds1820_pretraga_automatski_dodaj_novi_master.c,375 :: 		MOVLW 32      //Dakle, TRISA = 0b00111111
	MOVLW       32
;ds1820_pretraga_automatski_dodaj_novi_master.c,376 :: 		MOVWF TRISA
	MOVWF       TRISA+0, 1
;ds1820_pretraga_automatski_dodaj_novi_master.c,378 :: 		TRISD = 0b00000000;
	CLRF        TRISD+0 
;ds1820_pretraga_automatski_dodaj_novi_master.c,379 :: 		TRISC.RC6 = 0;
	BCF         TRISC+0, 6 
;ds1820_pretraga_automatski_dodaj_novi_master.c,381 :: 		LATC.RC6 = 0;
	BCF         LATC+0, 6 
;ds1820_pretraga_automatski_dodaj_novi_master.c,382 :: 		LATB.RB4 = 0;
	BCF         LATB+0, 4 
;ds1820_pretraga_automatski_dodaj_novi_master.c,384 :: 		INTCON.GIE = 0;
	BCF         INTCON+0, 7 
;ds1820_pretraga_automatski_dodaj_novi_master.c,386 :: 		Lcd_Init();
	CALL        _Lcd_Init+0, 0
;ds1820_pretraga_automatski_dodaj_novi_master.c,387 :: 		Lcd_Cmd(_LCD_CLEAR);        // CLEAR display
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;ds1820_pretraga_automatski_dodaj_novi_master.c,388 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);   // Cursor off
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;ds1820_pretraga_automatski_dodaj_novi_master.c,389 :: 		Delay_ms(100);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       138
	MOVWF       R12, 0
	MOVLW       85
	MOVWF       R13, 0
L_main75:
	DECFSZ      R13, 1, 1
	BRA         L_main75
	DECFSZ      R12, 1, 1
	BRA         L_main75
	DECFSZ      R11, 1, 1
	BRA         L_main75
	NOP
	NOP
;ds1820_pretraga_automatski_dodaj_novi_master.c,403 :: 		EEPROMuMatricu();
	CALL        _EEPROMuMatricu+0, 0
;ds1820_pretraga_automatski_dodaj_novi_master.c,408 :: 		skenirajSenzore();
	CALL        _skenirajSenzore+0, 0
;ds1820_pretraga_automatski_dodaj_novi_master.c,410 :: 		while(1)
L_main76:
;ds1820_pretraga_automatski_dodaj_novi_master.c,412 :: 		for(i = 0; i < brStarihSenzora; i++)
	CLRF        main_i_L0+0 
	CLRF        main_i_L0+1 
L_main78:
	MOVLW       128
	XORWF       main_i_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main139
	MOVF        _brStarihSenzora+0, 0 
	SUBWF       main_i_L0+0, 0 
L__main139:
	BTFSC       STATUS+0, 0 
	GOTO        L_main79
;ds1820_pretraga_automatski_dodaj_novi_master.c,414 :: 		tmp2[0]=i+'0';
	MOVLW       48
	ADDWF       main_i_L0+0, 0 
	MOVWF       _tmp2+0 
;ds1820_pretraga_automatski_dodaj_novi_master.c,415 :: 		tmp2[1]=':';
	MOVLW       58
	MOVWF       _tmp2+1 
;ds1820_pretraga_automatski_dodaj_novi_master.c,416 :: 		tmp2[2]='\0';
	CLRF        _tmp2+2 
;ds1820_pretraga_automatski_dodaj_novi_master.c,417 :: 		Lcd_out((i/2)%2 +1, i % 2 == 0 ? 1 : 9,tmp2);
	MOVF        main_i_L0+0, 0 
	MOVWF       R0 
	MOVF        main_i_L0+1, 0 
	MOVWF       R1 
	RRCF        R1, 1 
	RRCF        R0, 1 
	BCF         R1, 7 
	BTFSC       R1, 6 
	BSF         R1, 7 
	MOVLW       2
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Div_16x16_S+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	ADDLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       2
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        main_i_L0+0, 0 
	MOVWF       R0 
	MOVF        main_i_L0+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_S+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVLW       0
	XORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main140
	MOVLW       0
	XORWF       R0, 0 
L__main140:
	BTFSS       STATUS+0, 2 
	GOTO        L_main81
	MOVLW       1
	MOVWF       ?FLOC___mainT256+0 
	GOTO        L_main82
L_main81:
	MOVLW       9
	MOVWF       ?FLOC___mainT256+0 
L_main82:
	MOVF        ?FLOC___mainT256+0, 0 
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _tmp2+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_tmp2+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;ds1820_pretraga_automatski_dodaj_novi_master.c,418 :: 		if(EEPROMFlagovi[i]==0)
	MOVLW       _EEPROMFlagovi+0
	ADDWF       main_i_L0+0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(_EEPROMFlagovi+0)
	ADDWFC      main_i_L0+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_main83
;ds1820_pretraga_automatski_dodaj_novi_master.c,420 :: 		Lcd_out((i/2)%2 +1, i % 2 == 0 ? 3 : 11,"xxx.xx");
	MOVF        main_i_L0+0, 0 
	MOVWF       R0 
	MOVF        main_i_L0+1, 0 
	MOVWF       R1 
	RRCF        R1, 1 
	RRCF        R0, 1 
	BCF         R1, 7 
	BTFSC       R1, 6 
	BSF         R1, 7 
	MOVLW       2
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Div_16x16_S+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	ADDLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       2
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        main_i_L0+0, 0 
	MOVWF       R0 
	MOVF        main_i_L0+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_S+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVLW       0
	XORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main141
	MOVLW       0
	XORWF       R0, 0 
L__main141:
	BTFSS       STATUS+0, 2 
	GOTO        L_main84
	MOVLW       3
	MOVWF       ?FLOC___mainT268+0 
	GOTO        L_main85
L_main84:
	MOVLW       11
	MOVWF       ?FLOC___mainT268+0 
L_main85:
	MOVF        ?FLOC___mainT268+0, 0 
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr2_ds1820_pretraga_automatski_dodaj_novi_master+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr2_ds1820_pretraga_automatski_dodaj_novi_master+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;ds1820_pretraga_automatski_dodaj_novi_master.c,421 :: 		continue;
	GOTO        L_main80
;ds1820_pretraga_automatski_dodaj_novi_master.c,422 :: 		}
L_main83:
;ds1820_pretraga_automatski_dodaj_novi_master.c,423 :: 		temperatureDigitalne[i] = citajTemp(EEPROMMatrica[i]);
	MOVF        main_i_L0+0, 0 
	MOVWF       R0 
	MOVF        main_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _temperatureDigitalne+0
	ADDWF       R0, 0 
	MOVWF       FLOC__main+0 
	MOVLW       hi_addr(_temperatureDigitalne+0)
	ADDWFC      R1, 0 
	MOVWF       FLOC__main+1 
	MOVLW       3
	MOVWF       R2 
	MOVF        main_i_L0+0, 0 
	MOVWF       R0 
	MOVF        main_i_L0+1, 0 
	MOVWF       R1 
	MOVF        R2, 0 
L__main142:
	BZ          L__main143
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	ADDLW       255
	GOTO        L__main142
L__main143:
	MOVLW       _EEPROMmatrica+0
	ADDWF       R0, 0 
	MOVWF       FARG_citajTemp_x+0 
	MOVLW       hi_addr(_EEPROMmatrica+0)
	ADDWFC      R1, 0 
	MOVWF       FARG_citajTemp_x+1 
	CALL        _citajTemp+0, 0
	MOVFF       FLOC__main+0, FSR1
	MOVFF       FLOC__main+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	MOVWF       POSTINC1+0 
;ds1820_pretraga_automatski_dodaj_novi_master.c,426 :: 		Display_Temperature((i/2)%2 + 1,i % 2 == 0 ? 3 : 11, temperatureDigitalne[i]);
	MOVF        main_i_L0+0, 0 
	MOVWF       R0 
	MOVF        main_i_L0+1, 0 
	MOVWF       R1 
	RRCF        R1, 1 
	RRCF        R0, 1 
	BCF         R1, 7 
	BTFSC       R1, 6 
	BSF         R1, 7 
	MOVLW       2
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Div_16x16_S+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	ADDLW       1
	MOVWF       FARG_Display_Temperature_i+0 
	MOVLW       2
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        main_i_L0+0, 0 
	MOVWF       R0 
	MOVF        main_i_L0+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_S+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVLW       0
	XORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main144
	MOVLW       0
	XORWF       R0, 0 
L__main144:
	BTFSS       STATUS+0, 2 
	GOTO        L_main86
	MOVLW       3
	MOVWF       ?FLOC___mainT282+0 
	GOTO        L_main87
L_main86:
	MOVLW       11
	MOVWF       ?FLOC___mainT282+0 
L_main87:
	MOVF        ?FLOC___mainT282+0, 0 
	MOVWF       FARG_Display_Temperature_j+0 
	MOVF        main_i_L0+0, 0 
	MOVWF       R0 
	MOVF        main_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _temperatureDigitalne+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(_temperatureDigitalne+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_Display_Temperature_temp2write+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_Display_Temperature_temp2write+1 
	CALL        _Display_Temperature+0, 0
;ds1820_pretraga_automatski_dodaj_novi_master.c,428 :: 		for(j=0;j<8;j++)
	CLRF        main_j_L0+0 
	CLRF        main_j_L0+1 
L_main88:
	MOVLW       128
	XORWF       main_j_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main145
	MOVLW       8
	SUBWF       main_j_L0+0, 0 
L__main145:
	BTFSC       STATUS+0, 0 
	GOTO        L_main89
;ds1820_pretraga_automatski_dodaj_novi_master.c,430 :: 		ByteToHex(EEPROMMatrica[i][j],ROMByte);
	MOVLW       3
	MOVWF       R2 
	MOVF        main_i_L0+0, 0 
	MOVWF       R0 
	MOVF        main_i_L0+1, 0 
	MOVWF       R1 
	MOVF        R2, 0 
L__main146:
	BZ          L__main147
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	ADDLW       255
	GOTO        L__main146
L__main147:
	MOVLW       _EEPROMmatrica+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_EEPROMmatrica+0)
	ADDWFC      R1, 1 
	MOVF        main_j_L0+0, 0 
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVF        main_j_L0+1, 0 
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_ByteToHex_input+0 
	MOVLW       _ROMByte+0
	MOVWF       FARG_ByteToHex_output+0 
	MOVLW       hi_addr(_ROMByte+0)
	MOVWF       FARG_ByteToHex_output+1 
	CALL        _ByteToHex+0, 0
;ds1820_pretraga_automatski_dodaj_novi_master.c,431 :: 		Lcd_Out(2,2*j+1, ROMByte);
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVF        main_j_L0+0, 0 
	MOVWF       FARG_Lcd_Out_column+0 
	RLCF        FARG_Lcd_Out_column+0, 1 
	BCF         FARG_Lcd_Out_column+0, 0 
	INCF        FARG_Lcd_Out_column+0, 1 
	MOVLW       _ROMByte+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_ROMByte+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;ds1820_pretraga_automatski_dodaj_novi_master.c,428 :: 		for(j=0;j<8;j++)
	INFSNZ      main_j_L0+0, 1 
	INCF        main_j_L0+1, 1 
;ds1820_pretraga_automatski_dodaj_novi_master.c,432 :: 		}
	GOTO        L_main88
L_main89:
;ds1820_pretraga_automatski_dodaj_novi_master.c,433 :: 		Delay_ms(1000);
	MOVLW       26
	MOVWF       R11, 0
	MOVLW       94
	MOVWF       R12, 0
	MOVLW       110
	MOVWF       R13, 0
L_main91:
	DECFSZ      R13, 1, 1
	BRA         L_main91
	DECFSZ      R12, 1, 1
	BRA         L_main91
	DECFSZ      R11, 1, 1
	BRA         L_main91
	NOP
;ds1820_pretraga_automatski_dodaj_novi_master.c,435 :: 		}
L_main80:
;ds1820_pretraga_automatski_dodaj_novi_master.c,412 :: 		for(i = 0; i < brStarihSenzora; i++)
	INFSNZ      main_i_L0+0, 1 
	INCF        main_i_L0+1, 1 
;ds1820_pretraga_automatski_dodaj_novi_master.c,435 :: 		}
	GOTO        L_main78
L_main79:
;ds1820_pretraga_automatski_dodaj_novi_master.c,437 :: 		}  // Glavna petlja se zavrsava ovde
	GOTO        L_main76
;ds1820_pretraga_automatski_dodaj_novi_master.c,439 :: 		}  // end main function
L_end_main:
	GOTO        $+0
; end of _main
