;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 2.9.4 #5595 (Dec 17 2009) (UNIX)
; This file was generated Mon Mar 15 11:43:33 2010
;--------------------------------------------------------
; PIC16 port for the Microchip 16-bit core micros
;--------------------------------------------------------
	list	p=18f97j60

	radix dec

;--------------------------------------------------------
; public variables in this module
;--------------------------------------------------------
	global _TickInit
	global _TickGet
	global _TickGetDiv256
	global _TickGetDiv64K
	global _TickConvertToMilliseconds
	global _TickUpdate

;--------------------------------------------------------
; extern variables in this module
;--------------------------------------------------------
	extern _EBSTCONbits
	extern _MISTATbits
	extern _EFLOCONbits
	extern _MACON1bits
	extern _MACON2bits
	extern _MACON3bits
	extern _MACON4bits
	extern _MACLCON1bits
	extern _MACLCON2bits
	extern _MICONbits
	extern _MICMDbits
	extern _EWOLIEbits
	extern _EWOLIRbits
	extern _ERXFCONbits
	extern _EIEbits
	extern _ESTATbits
	extern _ECON2bits
	extern _EIRbits
	extern _EDATAbits
	extern _SSP2CON2bits
	extern _SSP2CON1bits
	extern _SSP2STATbits
	extern _ECCP2DELbits
	extern _ECCP2ASbits
	extern _ECCP3DELbits
	extern _ECCP3ASbits
	extern _RCSTA2bits
	extern _TXSTA2bits
	extern _CCP5CONbits
	extern _CCP4CONbits
	extern _T4CONbits
	extern _ECCP1DELbits
	extern _BAUDCON2bits
	extern _BAUDCTL2bits
	extern _BAUDCONbits
	extern _BAUDCON1bits
	extern _BAUDCTLbits
	extern _BAUDCTL1bits
	extern _PORTAbits
	extern _PORTBbits
	extern _PORTCbits
	extern _PORTDbits
	extern _PORTEbits
	extern _PORTFbits
	extern _PORTGbits
	extern _PORTHbits
	extern _PORTJbits
	extern _LATAbits
	extern _LATBbits
	extern _LATCbits
	extern _LATDbits
	extern _LATEbits
	extern _LATFbits
	extern _LATGbits
	extern _LATHbits
	extern _LATJbits
	extern _DDRAbits
	extern _TRISAbits
	extern _DDRBbits
	extern _TRISBbits
	extern _DDRCbits
	extern _TRISCbits
	extern _DDRDbits
	extern _TRISDbits
	extern _DDREbits
	extern _TRISEbits
	extern _DDRFbits
	extern _TRISFbits
	extern _DDRGbits
	extern _TRISGbits
	extern _DDRHbits
	extern _TRISHbits
	extern _DDRJbits
	extern _TRISJbits
	extern _OSCTUNEbits
	extern _MEMCONbits
	extern _PIE1bits
	extern _PIR1bits
	extern _IPR1bits
	extern _PIE2bits
	extern _PIR2bits
	extern _IPR2bits
	extern _PIE3bits
	extern _PIR3bits
	extern _IPR3bits
	extern _EECON1bits
	extern _RCSTAbits
	extern _RCSTA1bits
	extern _TXSTAbits
	extern _TXSTA1bits
	extern _PSPCONbits
	extern _T3CONbits
	extern _CMCONbits
	extern _CVRCONbits
	extern _ECCP1ASbits
	extern _CCP3CONbits
	extern _ECCP3CONbits
	extern _CCP2CONbits
	extern _ECCP2CONbits
	extern _CCP1CONbits
	extern _ECCP1CONbits
	extern _ADCON2bits
	extern _ADCON1bits
	extern _ADCON0bits
	extern _SSP1CON2bits
	extern _SSPCON2bits
	extern _SSP1CON1bits
	extern _SSPCON1bits
	extern _SSP1STATbits
	extern _SSPSTATbits
	extern _T2CONbits
	extern _T1CONbits
	extern _RCONbits
	extern _WDTCONbits
	extern _ECON1bits
	extern _OSCCONbits
	extern _T0CONbits
	extern _STATUSbits
	extern _INTCON3bits
	extern _INTCON2bits
	extern _INTCONbits
	extern _STKPTRbits
	extern _stdin
	extern _stdout
	extern _AN0String
	extern _AppConfig
	extern _activeUDPSocket
	extern _UDPSocketInfo
	extern _UDPTxCount
	extern _UDPRxCount
	extern _LCDText
	extern _MAADR5
	extern _MAADR6
	extern _MAADR3
	extern _MAADR4
	extern _MAADR1
	extern _MAADR2
	extern _EBSTSD
	extern _EBSTCON
	extern _EBSTCS
	extern _EBSTCSL
	extern _EBSTCSH
	extern _MISTAT
	extern _EFLOCON
	extern _EPAUS
	extern _EPAUSL
	extern _EPAUSH
	extern _MACON1
	extern _MACON2
	extern _MACON3
	extern _MACON4
	extern _MABBIPG
	extern _MAIPG
	extern _MAIPGL
	extern _MAIPGH
	extern _MACLCON1
	extern _MACLCON2
	extern _MAMXFL
	extern _MAMXFLL
	extern _MAMXFLH
	extern _MICON
	extern _MICMD
	extern _MIREGADR
	extern _MIWR
	extern _MIWRL
	extern _MIWRH
	extern _MIRD
	extern _MIRDL
	extern _MIRDH
	extern _EHT0
	extern _EHT1
	extern _EHT2
	extern _EHT3
	extern _EHT4
	extern _EHT5
	extern _EHT6
	extern _EHT7
	extern _EPMM0
	extern _EPMM1
	extern _EPMM2
	extern _EPMM3
	extern _EPMM4
	extern _EPMM5
	extern _EPMM6
	extern _EPMM7
	extern _EPMCS
	extern _EPMCSL
	extern _EPMCSH
	extern _EPMO
	extern _EPMOL
	extern _EPMOH
	extern _EWOLIE
	extern _EWOLIR
	extern _ERXFCON
	extern _EPKTCNT
	extern _EWRPT
	extern _EWRPTL
	extern _EWRPTH
	extern _ETXST
	extern _ETXSTL
	extern _ETXSTH
	extern _ETXND
	extern _ETXNDL
	extern _ETXNDH
	extern _ERXST
	extern _ERXSTL
	extern _ERXSTH
	extern _ERXND
	extern _ERXNDL
	extern _ERXNDH
	extern _ERXRDPT
	extern _ERXRDPTL
	extern _ERXRDPTH
	extern _ERXWRPT
	extern _ERXWRPTL
	extern _ERXWRPTH
	extern _EDMAST
	extern _EDMASTL
	extern _EDMASTH
	extern _EDMAND
	extern _EDMANDL
	extern _EDMANDH
	extern _EDMADST
	extern _EDMADSTL
	extern _EDMADSTH
	extern _EDMACS
	extern _EDMACSL
	extern _EDMACSH
	extern _EIE
	extern _ESTAT
	extern _ECON2
	extern _EIR
	extern _EDATA
	extern _SSP2CON2
	extern _SSP2CON1
	extern _SSP2STAT
	extern _SSP2ADD
	extern _SSP2BUF
	extern _ECCP2DEL
	extern _ECCP2AS
	extern _ECCP3DEL
	extern _ECCP3AS
	extern _RCSTA2
	extern _TXSTA2
	extern _TXREG2
	extern _RCREG2
	extern _SPBRG2
	extern _CCP5CON
	extern _CCPR5
	extern _CCPR5L
	extern _CCPR5H
	extern _CCP4CON
	extern _CCPR4
	extern _CCPR4L
	extern _CCPR4H
	extern _T4CON
	extern _PR4
	extern _TMR4
	extern _ECCP1DEL
	extern _ERDPT
	extern _ERDPTL
	extern _ERDPTH
	extern _BAUDCON2
	extern _BAUDCTL2
	extern _SPBRGH2
	extern _BAUDCON
	extern _BAUDCON1
	extern _BAUDCTL
	extern _BAUDCTL1
	extern _SPBRGH
	extern _SPBRGH1
	extern _PORTA
	extern _PORTB
	extern _PORTC
	extern _PORTD
	extern _PORTE
	extern _PORTF
	extern _PORTG
	extern _PORTH
	extern _PORTJ
	extern _LATA
	extern _LATB
	extern _LATC
	extern _LATD
	extern _LATE
	extern _LATF
	extern _LATG
	extern _LATH
	extern _LATJ
	extern _DDRA
	extern _TRISA
	extern _DDRB
	extern _TRISB
	extern _DDRC
	extern _TRISC
	extern _DDRD
	extern _TRISD
	extern _DDRE
	extern _TRISE
	extern _DDRF
	extern _TRISF
	extern _DDRG
	extern _TRISG
	extern _DDRH
	extern _TRISH
	extern _DDRJ
	extern _TRISJ
	extern _OSCTUNE
	extern _MEMCON
	extern _PIE1
	extern _PIR1
	extern _IPR1
	extern _PIE2
	extern _PIR2
	extern _IPR2
	extern _PIE3
	extern _PIR3
	extern _IPR3
	extern _EECON1
	extern _EECON2
	extern _RCSTA
	extern _RCSTA1
	extern _TXSTA
	extern _TXSTA1
	extern _TXREG
	extern _TXREG1
	extern _RCREG
	extern _RCREG1
	extern _SPBRG
	extern _SPBRG1
	extern _PSPCON
	extern _T3CON
	extern _TMR3L
	extern _TMR3H
	extern _CMCON
	extern _CVRCON
	extern _ECCP1AS
	extern _CCP3CON
	extern _ECCP3CON
	extern _CCPR3
	extern _CCPR3L
	extern _CCPR3H
	extern _CCP2CON
	extern _ECCP2CON
	extern _CCPR2
	extern _CCPR2L
	extern _CCPR2H
	extern _CCP1CON
	extern _ECCP1CON
	extern _CCPR1
	extern _CCPR1L
	extern _CCPR1H
	extern _ADCON2
	extern _ADCON1
	extern _ADCON0
	extern _ADRES
	extern _ADRESL
	extern _ADRESH
	extern _SSP1CON2
	extern _SSPCON2
	extern _SSP1CON1
	extern _SSPCON1
	extern _SSP1STAT
	extern _SSPSTAT
	extern _SSP1ADD
	extern _SSPADD
	extern _SSP1BUF
	extern _SSPBUF
	extern _T2CON
	extern _PR2
	extern _TMR2
	extern _T1CON
	extern _TMR1L
	extern _TMR1H
	extern _RCON
	extern _WDTCON
	extern _ECON1
	extern _OSCCON
	extern _T0CON
	extern _TMR0L
	extern _TMR0H
	extern _STATUS
	extern _FSR2L
	extern _FSR2H
	extern _PLUSW2
	extern _PREINC2
	extern _POSTDEC2
	extern _POSTINC2
	extern _INDF2
	extern _BSR
	extern _FSR1L
	extern _FSR1H
	extern _PLUSW1
	extern _PREINC1
	extern _POSTDEC1
	extern _POSTINC1
	extern _INDF1
	extern _WREG
	extern _FSR0L
	extern _FSR0H
	extern _PLUSW0
	extern _PREINC0
	extern _POSTDEC0
	extern _POSTINC0
	extern _INDF0
	extern _INTCON3
	extern _INTCON2
	extern _INTCON
	extern _PROD
	extern _PRODL
	extern _PRODH
	extern _TABLAT
	extern _TBLPTR
	extern _TBLPTRL
	extern _TBLPTRH
	extern _TBLPTRU
	extern _PC
	extern _PCL
	extern _PCLATH
	extern _PCLATU
	extern _STKPTR
	extern _TOS
	extern _TOSL
	extern _TOSH
	extern _TOSU
	extern __divulong
;--------------------------------------------------------
;	Equates to used internal registers
;--------------------------------------------------------
STATUS	equ	0xfd8
WREG	equ	0xfe8
FSR0L	equ	0xfe9
FSR1L	equ	0xfe1
FSR2L	equ	0xfd9
POSTDEC1	equ	0xfe5
PREINC1	equ	0xfe4
PLUSW2	equ	0xfdb
PRODL	equ	0xff3
PRODH	equ	0xff4


	idata
_dwInternalTicks	db	0x00, 0x00, 0x00, 0x00


; Internal registers
.registers	udata_ovr	0x0000
r0x00	res	1
r0x01	res	1
r0x02	res	1
r0x03	res	1

udata_Tick_0	udata
_vTickReading	res	6

udata_Tick_1	udata
_TickGetDiv256_ret_1_1	res	4

udata_Tick_2	udata
_TickGetDiv64K_ret_1_1	res	4

;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
; I code from now on!
; ; Starting pCode block
S_Tick__TickUpdate	code
_TickUpdate:
;	.line	356; TCPIP_Stack/Tick.c	void TickUpdate(void)
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
;	.line	358; TCPIP_Stack/Tick.c	if(INTCONbits.TMR0IF)
	BTFSS	_INTCONbits, 2
	BRA	_00143_DS_
	BANKSEL	_dwInternalTicks
;	.line	361; TCPIP_Stack/Tick.c	dwInternalTicks++;
	INCF	_dwInternalTicks, F, B
	BNC	_10141_DS_
	BANKSEL	(_dwInternalTicks + 1)
	INCF	(_dwInternalTicks + 1), F, B
_10141_DS_:
	BNC	_20142_DS_
	BANKSEL	(_dwInternalTicks + 2)
	INCF	(_dwInternalTicks + 2), F, B
_20142_DS_:
	BNC	_30143_DS_
	BANKSEL	(_dwInternalTicks + 3)
	INCF	(_dwInternalTicks + 3), F, B
_30143_DS_:
;	.line	364; TCPIP_Stack/Tick.c	INTCONbits.TMR0IF = 0;
	BCF	_INTCONbits, 2
_00143_DS_:
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_Tick__TickConvertToMilliseconds	code
_TickConvertToMilliseconds:
;	.line	333; TCPIP_Stack/Tick.c	DWORD TickConvertToMilliseconds(DWORD dwTickValue)
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVFF	r0x02, POSTDEC1
	MOVFF	r0x03, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, r0x00
	MOVLW	0x03
	MOVFF	PLUSW2, r0x01
	MOVLW	0x04
	MOVFF	PLUSW2, r0x02
	MOVLW	0x05
	MOVFF	PLUSW2, r0x03
;	.line	335; TCPIP_Stack/Tick.c	return (dwTickValue+(TICKS_PER_SECOND/2000ul))/((DWORD)(TICKS_PER_SECOND/1000ul));
	MOVLW	0x14
	ADDWF	r0x00, F
	MOVLW	0x00
	ADDWFC	r0x01, F
	MOVLW	0x00
	ADDWFC	r0x02, F
	MOVLW	0x00
	ADDWFC	r0x03, F
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x28
	MOVWF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	__divulong
	MOVWF	r0x00
	MOVFF	PRODL, r0x01
	MOVFF	PRODH, r0x02
	MOVFF	FSR0L, r0x03
	MOVLW	0x08
	ADDWF	FSR1L, F
	MOVFF	r0x03, FSR0L
	MOVFF	r0x02, PRODH
	MOVFF	r0x01, PRODL
	MOVF	r0x00, W
	MOVFF	PREINC1, r0x03
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_Tick__TickGetDiv64K	code
_TickGetDiv64K:
;	.line	292; TCPIP_Stack/Tick.c	DWORD TickGetDiv64K(void)
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
;	.line	296; TCPIP_Stack/Tick.c	GetTickCopy();
	CALL	_GetTickCopy
	BANKSEL	(_vTickReading + 2)
;	.line	297; TCPIP_Stack/Tick.c	ret.v[0] = vTickReading[2];	// Note: This copy must be done one 
	MOVF	(_vTickReading + 2), W, B
	BANKSEL	_TickGetDiv64K_ret_1_1
	MOVWF	_TickGetDiv64K_ret_1_1, B
	BANKSEL	(_vTickReading + 3)
;	.line	298; TCPIP_Stack/Tick.c	ret.v[1] = vTickReading[3];	// byte at a time to prevent misaligned 
	MOVF	(_vTickReading + 3), W, B
	BANKSEL	(_TickGetDiv64K_ret_1_1 + 1)
	MOVWF	(_TickGetDiv64K_ret_1_1 + 1), B
	BANKSEL	(_vTickReading + 4)
;	.line	299; TCPIP_Stack/Tick.c	ret.v[2] = vTickReading[4];	// memory reads, which will reset the PIC.
	MOVF	(_vTickReading + 4), W, B
	BANKSEL	(_TickGetDiv64K_ret_1_1 + 2)
	MOVWF	(_TickGetDiv64K_ret_1_1 + 2), B
	BANKSEL	(_vTickReading + 5)
;	.line	300; TCPIP_Stack/Tick.c	ret.v[3] = vTickReading[5];
	MOVF	(_vTickReading + 5), W, B
	BANKSEL	(_TickGetDiv64K_ret_1_1 + 3)
	MOVWF	(_TickGetDiv64K_ret_1_1 + 3), B
;	.line	302; TCPIP_Stack/Tick.c	return ret.Val;
	MOVFF	(_TickGetDiv64K_ret_1_1 + 3), FSR0L
	MOVFF	(_TickGetDiv64K_ret_1_1 + 2), PRODH
	MOVFF	(_TickGetDiv64K_ret_1_1 + 1), PRODL
	BANKSEL	_TickGetDiv64K_ret_1_1
	MOVF	_TickGetDiv64K_ret_1_1, W, B
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_Tick__TickGetDiv256	code
_TickGetDiv256:
;	.line	255; TCPIP_Stack/Tick.c	DWORD TickGetDiv256(void)
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
;	.line	259; TCPIP_Stack/Tick.c	GetTickCopy();
	CALL	_GetTickCopy
	BANKSEL	(_vTickReading + 1)
;	.line	260; TCPIP_Stack/Tick.c	ret.v[0] = vTickReading[1];	// Note: This copy must be done one 
	MOVF	(_vTickReading + 1), W, B
	BANKSEL	_TickGetDiv256_ret_1_1
	MOVWF	_TickGetDiv256_ret_1_1, B
	BANKSEL	(_vTickReading + 2)
;	.line	261; TCPIP_Stack/Tick.c	ret.v[1] = vTickReading[2];	// byte at a time to prevent misaligned 
	MOVF	(_vTickReading + 2), W, B
	BANKSEL	(_TickGetDiv256_ret_1_1 + 1)
	MOVWF	(_TickGetDiv256_ret_1_1 + 1), B
	BANKSEL	(_vTickReading + 3)
;	.line	262; TCPIP_Stack/Tick.c	ret.v[2] = vTickReading[3];	// memory reads, which will reset the PIC.
	MOVF	(_vTickReading + 3), W, B
	BANKSEL	(_TickGetDiv256_ret_1_1 + 2)
	MOVWF	(_TickGetDiv256_ret_1_1 + 2), B
	BANKSEL	(_vTickReading + 4)
;	.line	263; TCPIP_Stack/Tick.c	ret.v[3] = vTickReading[4];
	MOVF	(_vTickReading + 4), W, B
	BANKSEL	(_TickGetDiv256_ret_1_1 + 3)
	MOVWF	(_TickGetDiv256_ret_1_1 + 3), B
;	.line	265; TCPIP_Stack/Tick.c	return ret.Val;
	MOVFF	(_TickGetDiv256_ret_1_1 + 3), FSR0L
	MOVFF	(_TickGetDiv256_ret_1_1 + 2), PRODH
	MOVFF	(_TickGetDiv256_ret_1_1 + 1), PRODL
	BANKSEL	_TickGetDiv256_ret_1_1
	MOVF	_TickGetDiv256_ret_1_1, W, B
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_Tick__TickGet	code
_TickGet:
;	.line	225; TCPIP_Stack/Tick.c	DWORD TickGet(void)
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
;	.line	227; TCPIP_Stack/Tick.c	GetTickCopy();
	CALL	_GetTickCopy
;	.line	228; TCPIP_Stack/Tick.c	return *((DWORD*)&vTickReading[0]);
	MOVFF	(_vTickReading + 3), FSR0L
	MOVFF	(_vTickReading + 2), PRODH
	MOVFF	(_vTickReading + 1), PRODL
	BANKSEL	_vTickReading
	MOVF	_vTickReading, W, B
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_Tick__GetTickCopy	code
_GetTickCopy:
;	.line	157; TCPIP_Stack/Tick.c	static void GetTickCopy(void)
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
_00113_DS_:
;	.line	164; TCPIP_Stack/Tick.c	INTCONbits.TMR0IE = 1;		// Enable interrupt
	BSF	_INTCONbits, 5
	nop 
;	.line	166; TCPIP_Stack/Tick.c	INTCONbits.TMR0IE = 0;		// Disable interrupt
	BCF	_INTCONbits, 5
;	.line	167; TCPIP_Stack/Tick.c	vTickReading[0] = TMR0L;
	MOVF	_TMR0L, W
	BANKSEL	_vTickReading
	MOVWF	_vTickReading, B
;	.line	168; TCPIP_Stack/Tick.c	vTickReading[1] = TMR0H;
	MOVF	_TMR0H, W
	BANKSEL	(_vTickReading + 1)
	MOVWF	(_vTickReading + 1), B
	BANKSEL	_dwInternalTicks
;	.line	169; TCPIP_Stack/Tick.c	*((DWORD*)&vTickReading[2]) = dwInternalTicks;
	MOVF	_dwInternalTicks, W, B
	BANKSEL	(_vTickReading + 2)
	MOVWF	(_vTickReading + 2), B
	BANKSEL	(_dwInternalTicks + 1)
	MOVF	(_dwInternalTicks + 1), W, B
	BANKSEL	(_vTickReading + 3)
	MOVWF	(_vTickReading + 3), B
	BANKSEL	(_dwInternalTicks + 2)
	MOVF	(_dwInternalTicks + 2), W, B
	BANKSEL	(_vTickReading + 4)
	MOVWF	(_vTickReading + 4), B
	BANKSEL	(_dwInternalTicks + 3)
	MOVF	(_dwInternalTicks + 3), W, B
	BANKSEL	(_vTickReading + 5)
	MOVWF	(_vTickReading + 5), B
;	.line	170; TCPIP_Stack/Tick.c	} while(INTCONbits.TMR0IF);
	BTFSC	_INTCONbits, 2
	BRA	_00113_DS_
;	.line	171; TCPIP_Stack/Tick.c	INTCONbits.TMR0IE = 1;			// Enable interrupt
	BSF	_INTCONbits, 5
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_Tick__TickInit	code
_TickInit:
;	.line	97; TCPIP_Stack/Tick.c	void TickInit(void)
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
;	.line	102; TCPIP_Stack/Tick.c	TMR0H = 0;
	CLRF	_TMR0H
;	.line	103; TCPIP_Stack/Tick.c	TMR0L = 0;
	CLRF	_TMR0L
;	.line	106; TCPIP_Stack/Tick.c	INTCON2bits.TMR0IP = 0;		// Low priority
	BCF	_INTCON2bits, 2
;	.line	107; TCPIP_Stack/Tick.c	INTCONbits.TMR0IF = 0;          //reset overflow indicator
	BCF	_INTCONbits, 2
;	.line	108; TCPIP_Stack/Tick.c	INTCONbits.TMR0IE = 1;		// Enable interrupt
	BSF	_INTCONbits, 5
;	.line	111; TCPIP_Stack/Tick.c	T0CON = 0x87;
	MOVLW	0x87
	MOVWF	_T0CON
	MOVFF	PREINC1, FSR2L
	RETURN	



; Statistics:
; code size:	  460 (0x01cc) bytes ( 0.35%)
;           	  230 (0x00e6) words
; udata size:	   14 (0x000e) bytes ( 0.36%)
; access size:	    4 (0x0004) bytes


	end
