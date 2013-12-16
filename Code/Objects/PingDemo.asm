;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 2.9.4 #5582 (Dec  9 2009) (UNIX)
; This file was generated Tue Dec 15 23:56:59 2009
;--------------------------------------------------------
; PIC16 port for the Microchip 16-bit core micros
;--------------------------------------------------------
	list	p=18f97j60

	radix dec

;--------------------------------------------------------
; public variables in this module
;--------------------------------------------------------
	global _PingDemo

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
	extern _AppConfig
	extern _activeUDPSocket
	extern _UDPSocketInfo
	extern _UDPTxCount
	extern _UDPRxCount
	extern _LCDText
	extern _AN0String
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
	extern _uitoa
	extern _strcat
	extern _memcpy
	extern _TickGet
	extern _TickConvertToMilliseconds
	extern _LCDUpdate
	extern _ICMPBeginUsage
	extern _ICMPSendPing
	extern _ICMPGetReply
	extern _ICMPEndUsage
;--------------------------------------------------------
;	Equates to used internal registers
;--------------------------------------------------------
STATUS	equ	0xfd8
FSR0L	equ	0xfe9
FSR1L	equ	0xfe1
FSR2L	equ	0xfd9
POSTDEC1	equ	0xfe5
PREINC1	equ	0xfe4
PRODL	equ	0xff3
PRODH	equ	0xff4


	idata
_PingDemo_PingState_1_1	db	0x00


; Internal registers
.registers	udata_ovr	0x0000
r0x00	res	1
r0x01	res	1
r0x02	res	1
r0x03	res	1
r0x04	res	1
r0x05	res	1
r0x06	res	1

udata_PingDemo_0	udata
_PingDemo_Timer_1_1	res	4

;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
; I code from now on!
; ; Starting pCode block
S_PingDemo__PingDemo	code
_PingDemo:
;	.line	97; PingDemo.c	void PingDemo(void)
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVFF	r0x02, POSTDEC1
	MOVFF	r0x03, POSTDEC1
	MOVFF	r0x04, POSTDEC1
	MOVFF	r0x05, POSTDEC1
	MOVFF	r0x06, POSTDEC1
	BANKSEL	_PingDemo_PingState_1_1
;	.line	107; PingDemo.c	switch(PingState)
	MOVF	_PingDemo_PingState_1_1, W, B
	BZ	_00105_DS_
_00134_DS_:
	BANKSEL	_PingDemo_PingState_1_1
	MOVF	_PingDemo_PingState_1_1, W, B
	XORLW	0x01
	BNZ	_00136_DS_
	BRA	_00112_DS_
_00136_DS_:
	BRA	_00123_DS_
_00105_DS_:
;	.line	111; PingDemo.c	if(BUTTON0_IO == 0u)
	BTFSC	_PORTBbits, 3
	BRA	_00123_DS_
;	.line	114; PingDemo.c	if(TickGet() - Timer > 1ul*TICK_SECOND)
	CALL	_TickGet
	MOVWF	r0x00
	MOVFF	PRODL, r0x01
	MOVFF	PRODH, r0x02
	MOVFF	FSR0L, r0x03
	BANKSEL	_PingDemo_Timer_1_1
	MOVF	_PingDemo_Timer_1_1, W, B
	SUBWF	r0x00, F
	BANKSEL	(_PingDemo_Timer_1_1 + 1)
	MOVF	(_PingDemo_Timer_1_1 + 1), W, B
	SUBWFB	r0x01, F
	BANKSEL	(_PingDemo_Timer_1_1 + 2)
	MOVF	(_PingDemo_Timer_1_1 + 2), W, B
	SUBWFB	r0x02, F
	BANKSEL	(_PingDemo_Timer_1_1 + 3)
	MOVF	(_PingDemo_Timer_1_1 + 3), W, B
	SUBWFB	r0x03, F
	MOVLW	0x00
	SUBWF	r0x03, W
	BNZ	_00137_DS_
	MOVLW	0x00
	SUBWF	r0x02, W
	BNZ	_00137_DS_
	MOVLW	0x9e
	SUBWF	r0x01, W
	BNZ	_00137_DS_
	MOVLW	0xf3
	SUBWF	r0x00, W
_00137_DS_:
	BTFSS	STATUS, 0
	BRA	_00123_DS_
;	.line	117; PingDemo.c	if(!ICMPBeginUsage())
	CALL	_ICMPBeginUsage
	MOVWF	r0x00
	MOVF	r0x00, W
	BTFSC	STATUS, 2
	BRA	_00123_DS_
;	.line	121; PingDemo.c	Timer = TickGet();
	CALL	_TickGet
	BANKSEL	_PingDemo_Timer_1_1
	MOVWF	_PingDemo_Timer_1_1, B
	MOVFF	PRODL, (_PingDemo_Timer_1_1 + 1)
	MOVFF	PRODH, (_PingDemo_Timer_1_1 + 2)
	MOVFF	FSR0L, (_PingDemo_Timer_1_1 + 3)
	BANKSEL	(_AppConfig + 11)
;	.line	127; PingDemo.c	ICMPSendPing(AppConfig.MyGateway.Val);
	MOVF	(_AppConfig + 11), W, B
	MOVWF	POSTDEC1
	BANKSEL	(_AppConfig + 10)
	MOVF	(_AppConfig + 10), W, B
	MOVWF	POSTDEC1
	BANKSEL	(_AppConfig + 9)
	MOVF	(_AppConfig + 9), W, B
	MOVWF	POSTDEC1
	BANKSEL	(_AppConfig + 8)
	MOVF	(_AppConfig + 8), W, B
	MOVWF	POSTDEC1
	CALL	_ICMPSendPing
	MOVLW	0x04
	ADDWF	FSR1L, F
;	.line	129; PingDemo.c	PingState = SM_GET_ICMP_RESPONSE;
	MOVLW	0x01
	BANKSEL	_PingDemo_PingState_1_1
	MOVWF	_PingDemo_PingState_1_1, B
;	.line	132; PingDemo.c	break;
	BRA	_00123_DS_
_00112_DS_:
;	.line	136; PingDemo.c	ret = ICMPGetReply();					
	CALL	_ICMPGetReply
	MOVWF	r0x00
	MOVFF	PRODL, r0x01
	MOVFF	PRODH, r0x02
	MOVFF	FSR0L, r0x03
;	.line	137; PingDemo.c	if(ret == -2)
	MOVF	r0x00, W
	XORLW	0xfe
	BNZ	_00139_DS_
	MOVF	r0x01, W
	XORLW	0xff
	BNZ	_00139_DS_
	MOVF	r0x02, W
	XORLW	0xff
	BNZ	_00139_DS_
	MOVF	r0x03, W
	XORLW	0xff
	BNZ	_00139_DS_
	BRA	_00123_DS_
_00139_DS_:
;	.line	142; PingDemo.c	else if(ret == -1)
	MOVF	r0x00, W
	XORLW	0xff
	BNZ	_00140_DS_
	MOVF	r0x01, W
	XORLW	0xff
	BNZ	_00140_DS_
	MOVF	r0x02, W
	XORLW	0xff
	BNZ	_00140_DS_
	MOVF	r0x03, W
	XORLW	0xff
	BZ	_00141_DS_
_00140_DS_:
	BRA	_00117_DS_
_00141_DS_:
;	.line	147; PingDemo.c	memcpy((void*)&LCDText[16], (void *)"Ping timed out", 15); //ML
	MOVLW	HIGH(_LCDText + 16)
	MOVWF	r0x05
	MOVLW	LOW(_LCDText + 16)
	MOVWF	r0x04
	MOVLW	0x80
	MOVWF	r0x06
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x0f
	MOVWF	POSTDEC1
	MOVLW	UPPER(__str_0)
	MOVWF	POSTDEC1
	MOVLW	HIGH(__str_0)
	MOVWF	POSTDEC1
	MOVLW	LOW(__str_0)
	MOVWF	POSTDEC1
	MOVF	r0x06, W
	MOVWF	POSTDEC1
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	CALL	_memcpy
	MOVLW	0x08
	ADDWF	FSR1L, F
;	.line	148; PingDemo.c	LCDUpdate();
	CALL	_LCDUpdate
	BANKSEL	_PingDemo_PingState_1_1
;	.line	150; PingDemo.c	PingState = SM_HOME;
	CLRF	_PingDemo_PingState_1_1, B
	BRA	_00121_DS_
_00117_DS_:
;	.line	152; PingDemo.c	else if(ret == -3)
	MOVF	r0x00, W
	XORLW	0xfd
	BNZ	_00142_DS_
	MOVF	r0x01, W
	XORLW	0xff
	BNZ	_00142_DS_
	MOVF	r0x02, W
	XORLW	0xff
	BNZ	_00142_DS_
	MOVF	r0x03, W
	XORLW	0xff
	BZ	_00143_DS_
_00142_DS_:
	BRA	_00114_DS_
_00143_DS_:
;	.line	157; PingDemo.c	memcpy((void*)&LCDText[16], ( void *)"Can't resolve IP", 16);
	MOVLW	HIGH(_LCDText + 16)
	MOVWF	r0x05
	MOVLW	LOW(_LCDText + 16)
	MOVWF	r0x04
	MOVLW	0x80
	MOVWF	r0x06
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x10
	MOVWF	POSTDEC1
	MOVLW	UPPER(__str_1)
	MOVWF	POSTDEC1
	MOVLW	HIGH(__str_1)
	MOVWF	POSTDEC1
	MOVLW	LOW(__str_1)
	MOVWF	POSTDEC1
	MOVF	r0x06, W
	MOVWF	POSTDEC1
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	CALL	_memcpy
	MOVLW	0x08
	ADDWF	FSR1L, F
;	.line	158; PingDemo.c	LCDUpdate();
	CALL	_LCDUpdate
	BANKSEL	_PingDemo_PingState_1_1
;	.line	160; PingDemo.c	PingState = SM_HOME;
	CLRF	_PingDemo_PingState_1_1, B
	BRA	_00121_DS_
_00114_DS_:
;	.line	167; PingDemo.c	memcpy((void*)&LCDText[16], ( void *)"Reply: ", 7);
	MOVLW	HIGH(_LCDText + 16)
	MOVWF	r0x05
	MOVLW	LOW(_LCDText + 16)
	MOVWF	r0x04
	MOVLW	0x80
	MOVWF	r0x06
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x07
	MOVWF	POSTDEC1
	MOVLW	UPPER(__str_2)
	MOVWF	POSTDEC1
	MOVLW	HIGH(__str_2)
	MOVWF	POSTDEC1
	MOVLW	LOW(__str_2)
	MOVWF	POSTDEC1
	MOVF	r0x06, W
	MOVWF	POSTDEC1
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	CALL	_memcpy
	MOVLW	0x08
	ADDWF	FSR1L, F
;	.line	169; PingDemo.c	uitoa((WORD)TickConvertToMilliseconds((DWORD)ret), &LCDText[16+7],10);
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_TickConvertToMilliseconds
	MOVWF	r0x00
	MOVFF	PRODL, r0x01
	MOVFF	PRODH, r0x02
	MOVFF	FSR0L, r0x03
	MOVLW	0x04
	ADDWF	FSR1L, F
	MOVLW	0x0a
	MOVWF	POSTDEC1
	MOVLW	HIGH(_LCDText + 23)
	MOVWF	POSTDEC1
	MOVLW	LOW(_LCDText + 23)
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_uitoa
	MOVLW	0x05
	ADDWF	FSR1L, F
;	.line	171; PingDemo.c	strcat((char*)&LCDText[16+7], ( char*)"ms");
	MOVLW	HIGH(_LCDText + 23)
	MOVWF	r0x01
	MOVLW	LOW(_LCDText + 23)
	MOVWF	r0x00
	MOVLW	0x80
	MOVWF	r0x02
	MOVLW	UPPER(__str_3)
	MOVWF	POSTDEC1
	MOVLW	HIGH(__str_3)
	MOVWF	POSTDEC1
	MOVLW	LOW(__str_3)
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_strcat
	MOVLW	0x06
	ADDWF	FSR1L, F
;	.line	172; PingDemo.c	LCDUpdate();
	CALL	_LCDUpdate
	BANKSEL	_PingDemo_PingState_1_1
;	.line	174; PingDemo.c	PingState = SM_HOME;
	CLRF	_PingDemo_PingState_1_1, B
_00121_DS_:
;	.line	178; PingDemo.c	ICMPEndUsage();
	CALL	_ICMPEndUsage
_00123_DS_:
;	.line	180; PingDemo.c	}
	MOVFF	PREINC1, r0x06
	MOVFF	PREINC1, r0x05
	MOVFF	PREINC1, r0x04
	MOVFF	PREINC1, r0x03
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
__str_0:
	DB	0x50, 0x69, 0x6e, 0x67, 0x20, 0x74, 0x69, 0x6d, 0x65, 0x64, 0x20, 0x6f
	DB	0x75, 0x74, 0x00
; ; Starting pCode block
__str_1:
	DB	0x43, 0x61, 0x6e, 0x27, 0x74, 0x20, 0x72, 0x65, 0x73, 0x6f, 0x6c, 0x76
	DB	0x65, 0x20, 0x49, 0x50, 0x00
; ; Starting pCode block
__str_2:
	DB	0x52, 0x65, 0x70, 0x6c, 0x79, 0x3a, 0x20, 0x00
; ; Starting pCode block
__str_3:
	DB	0x6d, 0x73, 0x00


; Statistics:
; code size:	  638 (0x027e) bytes ( 0.49%)
;           	  319 (0x013f) words
; udata size:	    4 (0x0004) bytes ( 0.10%)
; access size:	    7 (0x0007) bytes


	end
