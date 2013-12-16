;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 2.9.4 #5595 (Dec 17 2009) (UNIX)
; This file was generated Mon Mar 15 11:43:28 2010
;--------------------------------------------------------
; PIC16 port for the Microchip 16-bit core micros
;--------------------------------------------------------
	list	p=18f97j60

	radix dec

;--------------------------------------------------------
; public variables in this module
;--------------------------------------------------------
	global _message
	global _AN0String
	global _DisplayWORD
	global _DisplayString
	global _DisplayIPValue
	global _strlcpy
	global _AppConfig
	global _LowISR
	global _HighISR
	global _main

;--------------------------------------------------------
; extern variables in this module
;--------------------------------------------------------
	extern __gptrget1
	extern __gptrput1
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
	extern _uitoa
	extern _ultoa
	extern _strlen
	extern _StackInit
	extern _StackTask
	extern _TickInit
	extern _TickGetDiv256
	extern _TickUpdate
	extern _LCDInit
	extern _LCDUpdate
;--------------------------------------------------------
;	Equates to used internal registers
;--------------------------------------------------------
STATUS	equ	0xfd8
PCLATH	equ	0xffa
PCLATU	equ	0xffb
WREG	equ	0xfe8
BSR	equ	0xfe0
FSR0L	equ	0xfe9
FSR0H	equ	0xfea
FSR1L	equ	0xfe1
FSR2L	equ	0xfd9
INDF0	equ	0xfef
POSTDEC1	equ	0xfe5
PREINC1	equ	0xfe4
PLUSW2	equ	0xfdb
PRODL	equ	0xff3
PRODH	equ	0xff4


	idata
_main_t_1_1	db	0x00, 0x00, 0x00, 0x00
_main_dwLastIP_1_1	db	0x00, 0x00, 0x00, 0x00


; Internal registers
.registers	udata_ovr	0x0000
r0x00	res	1
r0x01	res	1
r0x02	res	1
r0x03	res	1
r0x04	res	1
r0x05	res	1
r0x06	res	1
r0x07	res	1
r0x08	res	1
r0x09	res	1
r0x0a	res	1
r0x0b	res	1
r0x0c	res	1
r0x0d	res	1
r0x0e	res	1
r0x0f	res	1
r0x10	res	1
r0x11	res	1
r0x12	res	1
r0x13	res	1
r0x14	res	1
r0x15	res	1

udata_MainDemo_0	udata
_AN0String	res	8

udata_MainDemo_1	udata
_message	res	3

udata_MainDemo_2	udata
_AppConfig	res	51

udata_MainDemo_3	udata
_DisplayWORD_WDigit_1_1	res	6

udata_MainDemo_4	udata
_DisplayIPValue_IPDigit_1_1	res	4

;--------------------------------------------------------
; interrupt vector 
;--------------------------------------------------------

;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
; ; Starting pCode block for absolute section
; ;-----------------------------------------
S_MainDemo_ivec_0x2_LowISR	code	0X000018
ivec_0x2_LowISR:
	GOTO	_LowISR

; ; Starting pCode block for absolute section
; ;-----------------------------------------
S_MainDemo_ivec_0x1_HighISR	code	0X000008
ivec_0x1_HighISR:
	GOTO	_HighISR

; I code from now on!
; ; Starting pCode block
S_MainDemo__main	code
_main:
;	.line	201; MainDemo.c	InitializeBoard();
	CALL	_InitializeBoard
;	.line	204; MainDemo.c	LCDInit();
	CALL	_LCDInit
;	.line	205; MainDemo.c	DelayMs(100);
	MOVLW	0x10
	MOVWF	r0x00
	MOVLW	0x98
	MOVWF	r0x01
	MOVLW	0x02
	MOVWF	r0x02
	CLRF	r0x03
_00115_DS_:
	MOVFF	r0x00, r0x04
	MOVFF	r0x01, r0x05
	MOVFF	r0x02, r0x06
	MOVFF	r0x03, r0x07
	MOVLW	0xff
	ADDWF	r0x00, F
	MOVLW	0xff
	ADDWFC	r0x01, F
	MOVLW	0xff
	ADDWFC	r0x02, F
	MOVLW	0xff
	ADDWFC	r0x03, F
	MOVF	r0x04, W
	IORWF	r0x05, W
	IORWF	r0x06, W
	IORWF	r0x07, W
	BNZ	_00115_DS_
;	.line	206; MainDemo.c	DisplayString (0,"Olimex"); //first arg is start position on 32 pos LCD
	MOVLW	UPPER(__str_0)
	MOVWF	POSTDEC1
	MOVLW	HIGH(__str_0)
	MOVWF	POSTDEC1
	MOVLW	LOW(__str_0)
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	CALL	_DisplayString
	MOVLW	0x04
	ADDWF	FSR1L, F
;	.line	209; MainDemo.c	TickInit();
	CALL	_TickInit
;	.line	212; MainDemo.c	InitAppConfig();
	CALL	_InitAppConfig
;	.line	216; MainDemo.c	StackInit();
	CALL	_StackInit
_00129_DS_:
;	.line	237; MainDemo.c	nt =  TickGetDiv256();
	CALL	_TickGetDiv256
	MOVWF	r0x00
	MOVFF	PRODL, r0x01
	MOVFF	PRODH, r0x02
	MOVFF	FSR0L, r0x03
	BANKSEL	_main_t_1_1
;	.line	238; MainDemo.c	if((nt - t) >= (DWORD)(TICK_SECOND/1024ul))
	MOVF	_main_t_1_1, W, B
	SUBWF	r0x00, W
	MOVWF	r0x04
	BANKSEL	(_main_t_1_1 + 1)
	MOVF	(_main_t_1_1 + 1), W, B
	SUBWFB	r0x01, W
	MOVWF	r0x05
	BANKSEL	(_main_t_1_1 + 2)
	MOVF	(_main_t_1_1 + 2), W, B
	SUBWFB	r0x02, W
	MOVWF	r0x06
	BANKSEL	(_main_t_1_1 + 3)
	MOVF	(_main_t_1_1 + 3), W, B
	SUBWFB	r0x03, W
	MOVWF	r0x07
	MOVLW	0x00
	SUBWF	r0x07, W
	BNZ	_00139_DS_
	MOVLW	0x00
	SUBWF	r0x06, W
	BNZ	_00139_DS_
	MOVLW	0x00
	SUBWF	r0x05, W
	BNZ	_00139_DS_
	MOVLW	0x27
	SUBWF	r0x04, W
_00139_DS_:
	BNC	_00125_DS_
;	.line	240; MainDemo.c	t = nt;
	MOVFF	r0x00, _main_t_1_1
	MOVFF	r0x01, (_main_t_1_1 + 1)
	MOVFF	r0x02, (_main_t_1_1 + 2)
	MOVFF	r0x03, (_main_t_1_1 + 3)
;	.line	241; MainDemo.c	LED0_IO ^= 1;
	CLRF	r0x00
	BTFSC	_LATJbits, 0
	INCF	r0x00, F
	MOVLW	0x01
	XORWF	r0x00, F
	MOVF	r0x00, W
	ANDLW	0x01
	MOVWF	PRODH
	MOVF	_LATJbits, W
	ANDLW	0xfe
	IORWF	PRODH, W
	MOVWF	_LATJbits
	clrwdt 
_00125_DS_:
;	.line	248; MainDemo.c	StackTask();
	CALL	_StackTask
;	.line	258; MainDemo.c	if(dwLastIP != AppConfig.MyIPAddr.Val)
	MOVFF	_AppConfig, r0x00
	MOVFF	(_AppConfig + 1), r0x01
	MOVFF	(_AppConfig + 2), r0x02
	MOVFF	(_AppConfig + 3), r0x03
	BANKSEL	_main_dwLastIP_1_1
	MOVF	_main_dwLastIP_1_1, W, B
	XORWF	r0x00, W
	BNZ	_00142_DS_
	BANKSEL	(_main_dwLastIP_1_1 + 1)
	MOVF	(_main_dwLastIP_1_1 + 1), W, B
	XORWF	r0x01, W
	BNZ	_00142_DS_
	BANKSEL	(_main_dwLastIP_1_1 + 2)
	MOVF	(_main_dwLastIP_1_1 + 2), W, B
	XORWF	r0x02, W
	BNZ	_00142_DS_
	BANKSEL	(_main_dwLastIP_1_1 + 3)
	MOVF	(_main_dwLastIP_1_1 + 3), W, B
	XORWF	r0x03, W
	BNZ	_00142_DS_
	BRA	_00129_DS_
_00142_DS_:
;	.line	260; MainDemo.c	dwLastIP = AppConfig.MyIPAddr.Val;
	MOVFF	r0x00, _main_dwLastIP_1_1
	MOVFF	r0x01, (_main_dwLastIP_1_1 + 1)
	MOVFF	r0x02, (_main_dwLastIP_1_1 + 2)
	MOVFF	r0x03, (_main_dwLastIP_1_1 + 3)
	BANKSEL	(_main_dwLastIP_1_1 + 3)
;	.line	262; MainDemo.c	DisplayIPValue(dwLastIP); // must be a WORD: sdcc does not
	MOVF	(_main_dwLastIP_1_1 + 3), W, B
	MOVWF	POSTDEC1
	BANKSEL	(_main_dwLastIP_1_1 + 2)
	MOVF	(_main_dwLastIP_1_1 + 2), W, B
	MOVWF	POSTDEC1
	BANKSEL	(_main_dwLastIP_1_1 + 1)
	MOVF	(_main_dwLastIP_1_1 + 1), W, B
	MOVWF	POSTDEC1
	BANKSEL	_main_dwLastIP_1_1
	MOVF	_main_dwLastIP_1_1, W, B
	MOVWF	POSTDEC1
	CALL	_DisplayIPValue
	MOVLW	0x04
	ADDWF	FSR1L, F
	BRA	_00129_DS_
	RETURN	

; ; Starting pCode block
S_MainDemo__strlcpy	code
_strlcpy:
;	.line	504; MainDemo.c	strlcpy(char *dst, const char *src, size_t siz)
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVFF	r0x02, POSTDEC1
	MOVFF	r0x03, POSTDEC1
	MOVFF	r0x04, POSTDEC1
	MOVFF	r0x05, POSTDEC1
	MOVFF	r0x06, POSTDEC1
	MOVFF	r0x07, POSTDEC1
	MOVFF	r0x08, POSTDEC1
	MOVFF	r0x09, POSTDEC1
	MOVFF	r0x0a, POSTDEC1
	MOVFF	r0x0b, POSTDEC1
	MOVFF	r0x0c, POSTDEC1
	MOVFF	r0x0d, POSTDEC1
	MOVFF	r0x0e, POSTDEC1
	MOVFF	r0x0f, POSTDEC1
	MOVFF	r0x10, POSTDEC1
	MOVFF	r0x11, POSTDEC1
	MOVFF	r0x12, POSTDEC1
	MOVFF	r0x13, POSTDEC1
	MOVFF	r0x14, POSTDEC1
	MOVFF	r0x15, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, r0x00
	MOVLW	0x03
	MOVFF	PLUSW2, r0x01
	MOVLW	0x04
	MOVFF	PLUSW2, r0x02
	MOVLW	0x05
	MOVFF	PLUSW2, r0x03
	MOVLW	0x06
	MOVFF	PLUSW2, r0x04
	MOVLW	0x07
	MOVFF	PLUSW2, r0x05
	MOVLW	0x08
	MOVFF	PLUSW2, r0x06
	MOVLW	0x09
	MOVFF	PLUSW2, r0x07
;	.line	506; MainDemo.c	char       *d = dst;
	MOVFF	r0x00, r0x08
	MOVFF	r0x01, r0x09
	MOVFF	r0x02, r0x0a
;	.line	507; MainDemo.c	const char *s = src;
	MOVFF	r0x03, r0x0b
	MOVFF	r0x04, r0x0c
	MOVFF	r0x05, r0x0d
;	.line	508; MainDemo.c	size_t      n = siz;
	MOVFF	r0x06, r0x0e
	MOVFF	r0x07, r0x0f
;	.line	511; MainDemo.c	if (n != 0)
	MOVF	r0x06, W
	IORWF	r0x07, W
	BTFSC	STATUS, 2
	BRA	_00230_DS_
;	.line	513; MainDemo.c	while (--n != 0)
	MOVFF	r0x03, r0x10
	MOVFF	r0x04, r0x11
	MOVFF	r0x05, r0x12
	MOVFF	r0x06, r0x13
	MOVFF	r0x07, r0x14
_00226_DS_:
	MOVLW	0xff
	ADDWF	r0x13, F
	BTFSS	STATUS, 0
	DECF	r0x14, F
	MOVF	r0x13, W
	IORWF	r0x14, W
	BZ	_00245_DS_
;	.line	515; MainDemo.c	if ((*d++ = *s++) == '\0')
	MOVFF	r0x10, FSR0L
	MOVFF	r0x11, PRODL
	MOVF	r0x12, W
	CALL	__gptrget1
	MOVWF	r0x15
	INCF	r0x10, F
	BTFSC	STATUS, 0
	INCF	r0x11, F
	BTFSC	STATUS, 0
	INCF	r0x12, F
	MOVFF	r0x15, POSTDEC1
	MOVFF	r0x00, FSR0L
	MOVFF	r0x01, PRODL
	MOVF	r0x02, W
	CALL	__gptrput1
	INCF	r0x00, F
	BTFSC	STATUS, 0
	INCF	r0x01, F
	BTFSC	STATUS, 0
	INCF	r0x02, F
	MOVF	r0x15, W
	BNZ	_00226_DS_
_00245_DS_:
;	.line	516; MainDemo.c	break;
	MOVFF	r0x10, r0x0b
	MOVFF	r0x11, r0x0c
	MOVFF	r0x12, r0x0d
	MOVFF	r0x00, r0x08
	MOVFF	r0x01, r0x09
	MOVFF	r0x02, r0x0a
	MOVFF	r0x13, r0x0e
	MOVFF	r0x14, r0x0f
_00230_DS_:
;	.line	521; MainDemo.c	if (n == 0)
	MOVF	r0x0e, W
	IORWF	r0x0f, W
	BNZ	_00237_DS_
;	.line	523; MainDemo.c	if (siz != 0)
	MOVF	r0x06, W
	IORWF	r0x07, W
	BZ	_00244_DS_
;	.line	524; MainDemo.c	*d = '\0';          /* NUL-terminate dst */
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVFF	r0x08, FSR0L
	MOVFF	r0x09, PRODL
	MOVF	r0x0a, W
	CALL	__gptrput1
_00244_DS_:
;	.line	525; MainDemo.c	while (*s++)
	MOVFF	r0x0b, r0x00
	MOVFF	r0x0c, r0x01
	MOVFF	r0x0d, r0x02
_00233_DS_:
	MOVFF	r0x00, FSR0L
	MOVFF	r0x01, PRODL
	MOVF	r0x02, W
	CALL	__gptrget1
	MOVWF	r0x06
	INCF	r0x00, F
	BTFSC	STATUS, 0
	INCF	r0x01, F
	BTFSC	STATUS, 0
	INCF	r0x02, F
	MOVF	r0x06, W
	BNZ	_00233_DS_
	MOVFF	r0x00, r0x0b
	MOVFF	r0x01, r0x0c
	MOVFF	r0x02, r0x0d
_00237_DS_:
;	.line	529; MainDemo.c	return (s - src - 1);       /* count does not include NUL */
	MOVF	r0x03, W
	SUBWF	r0x0b, W
	MOVWF	r0x03
	MOVF	r0x04, W
	SUBWFB	r0x0c, W
	MOVWF	r0x04
	MOVLW	0xff
	ADDWF	r0x03, F
	BTFSS	STATUS, 0
	DECF	r0x04, F
	MOVFF	r0x04, PRODL
	MOVF	r0x03, W
	MOVFF	PREINC1, r0x15
	MOVFF	PREINC1, r0x14
	MOVFF	PREINC1, r0x13
	MOVFF	PREINC1, r0x12
	MOVFF	PREINC1, r0x11
	MOVFF	PREINC1, r0x10
	MOVFF	PREINC1, r0x0f
	MOVFF	PREINC1, r0x0e
	MOVFF	PREINC1, r0x0d
	MOVFF	PREINC1, r0x0c
	MOVFF	PREINC1, r0x0b
	MOVFF	PREINC1, r0x0a
	MOVFF	PREINC1, r0x09
	MOVFF	PREINC1, r0x08
	MOVFF	PREINC1, r0x07
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
S_MainDemo__InitAppConfig	code
_InitAppConfig:
;	.line	433; MainDemo.c	static void InitAppConfig(void)
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVFF	r0x02, POSTDEC1
	MOVFF	r0x03, POSTDEC1
	BANKSEL	(_AppConfig + 44)
;	.line	435; MainDemo.c	AppConfig.Flags.bIsDHCPEnabled = TRUE;
	BSF	(_AppConfig + 44), 6, B
	BANKSEL	(_AppConfig + 44)
;	.line	436; MainDemo.c	AppConfig.Flags.bInConfigMode = TRUE;
	BSF	(_AppConfig + 44), 7, B
	BANKSEL	(_AppConfig + 45)
;	.line	440; MainDemo.c	AppConfig.MyMACAddr.v[0] = 0;
	CLRF	(_AppConfig + 45), B
;	.line	441; MainDemo.c	AppConfig.MyMACAddr.v[1] = 0x04;
	MOVLW	0x04
	BANKSEL	(_AppConfig + 46)
	MOVWF	(_AppConfig + 46), B
;	.line	442; MainDemo.c	AppConfig.MyMACAddr.v[2] = 0xA3;
	MOVLW	0xa3
	BANKSEL	(_AppConfig + 47)
	MOVWF	(_AppConfig + 47), B
;	.line	443; MainDemo.c	AppConfig.MyMACAddr.v[3] = 0x01;
	MOVLW	0x01
	BANKSEL	(_AppConfig + 48)
	MOVWF	(_AppConfig + 48), B
;	.line	444; MainDemo.c	AppConfig.MyMACAddr.v[4] = 0x02;
	MOVLW	0x02
	BANKSEL	(_AppConfig + 49)
	MOVWF	(_AppConfig + 49), B
;	.line	445; MainDemo.c	AppConfig.MyMACAddr.v[5] = 0x03;
	MOVLW	0x03
	BANKSEL	(_AppConfig + 50)
	MOVWF	(_AppConfig + 50), B
;	.line	448; MainDemo.c	AppConfig.MyIPAddr.Val = MY_DEFAULT_IP_ADDR_BYTE1 | 
	MOVLW	0xc0
	BANKSEL	_AppConfig
	MOVWF	_AppConfig, B
	MOVLW	0xa8
	BANKSEL	(_AppConfig + 1)
	MOVWF	(_AppConfig + 1), B
	MOVLW	0x61
	BANKSEL	(_AppConfig + 2)
	MOVWF	(_AppConfig + 2), B
	MOVLW	0x3c
	BANKSEL	(_AppConfig + 3)
	MOVWF	(_AppConfig + 3), B
;	.line	451; MainDemo.c	AppConfig.DefaultIPAddr.Val = AppConfig.MyIPAddr.Val;
	MOVFF	_AppConfig, r0x00
	MOVFF	(_AppConfig + 1), r0x01
	MOVFF	(_AppConfig + 2), r0x02
	MOVFF	(_AppConfig + 3), r0x03
	MOVF	r0x00, W
	BANKSEL	(_AppConfig + 20)
	MOVWF	(_AppConfig + 20), B
	MOVF	r0x01, W
	BANKSEL	(_AppConfig + 21)
	MOVWF	(_AppConfig + 21), B
	MOVF	r0x02, W
	BANKSEL	(_AppConfig + 22)
	MOVWF	(_AppConfig + 22), B
	MOVF	r0x03, W
	BANKSEL	(_AppConfig + 23)
	MOVWF	(_AppConfig + 23), B
	BANKSEL	(_AppConfig + 4)
;	.line	452; MainDemo.c	AppConfig.MyMask.Val = MY_DEFAULT_MASK_BYTE1 | 
	SETF	(_AppConfig + 4), B
	BANKSEL	(_AppConfig + 5)
	SETF	(_AppConfig + 5), B
	BANKSEL	(_AppConfig + 6)
	SETF	(_AppConfig + 6), B
	BANKSEL	(_AppConfig + 7)
	CLRF	(_AppConfig + 7), B
;	.line	455; MainDemo.c	AppConfig.DefaultMask.Val = AppConfig.MyMask.Val;
	MOVFF	(_AppConfig + 4), r0x00
	MOVFF	(_AppConfig + 5), r0x01
	MOVFF	(_AppConfig + 6), r0x02
	MOVFF	(_AppConfig + 7), r0x03
	MOVF	r0x00, W
	BANKSEL	(_AppConfig + 24)
	MOVWF	(_AppConfig + 24), B
	MOVF	r0x01, W
	BANKSEL	(_AppConfig + 25)
	MOVWF	(_AppConfig + 25), B
	MOVF	r0x02, W
	BANKSEL	(_AppConfig + 26)
	MOVWF	(_AppConfig + 26), B
	MOVF	r0x03, W
	BANKSEL	(_AppConfig + 27)
	MOVWF	(_AppConfig + 27), B
;	.line	456; MainDemo.c	AppConfig.MyGateway.Val = MY_DEFAULT_GATE_BYTE1 | 
	MOVLW	0xc0
	BANKSEL	(_AppConfig + 8)
	MOVWF	(_AppConfig + 8), B
	MOVLW	0xa8
	BANKSEL	(_AppConfig + 9)
	MOVWF	(_AppConfig + 9), B
	MOVLW	0x61
	BANKSEL	(_AppConfig + 10)
	MOVWF	(_AppConfig + 10), B
	MOVLW	0x01
	BANKSEL	(_AppConfig + 11)
	MOVWF	(_AppConfig + 11), B
;	.line	459; MainDemo.c	AppConfig.PrimaryDNSServer.Val = MY_DEFAULT_PRIMARY_DNS_BYTE1 | 
	MOVLW	0xc0
	BANKSEL	(_AppConfig + 12)
	MOVWF	(_AppConfig + 12), B
	MOVLW	0xa8
	BANKSEL	(_AppConfig + 13)
	MOVWF	(_AppConfig + 13), B
	MOVLW	0x61
	BANKSEL	(_AppConfig + 14)
	MOVWF	(_AppConfig + 14), B
	MOVLW	0x01
	BANKSEL	(_AppConfig + 15)
	MOVWF	(_AppConfig + 15), B
	BANKSEL	(_AppConfig + 16)
;	.line	463; MainDemo.c	AppConfig.SecondaryDNSServer.Val = MY_DEFAULT_SECONDARY_DNS_BYTE1 | 
	CLRF	(_AppConfig + 16), B
	BANKSEL	(_AppConfig + 17)
	CLRF	(_AppConfig + 17), B
	BANKSEL	(_AppConfig + 18)
	CLRF	(_AppConfig + 18), B
	BANKSEL	(_AppConfig + 19)
	CLRF	(_AppConfig + 19), B
	MOVFF	PREINC1, r0x03
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_MainDemo__InitializeBoard	code
_InitializeBoard:
;	.line	377; MainDemo.c	static void InitializeBoard(void)
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
;	.line	380; MainDemo.c	LED0_TRIS = 0;  //LED0
	BCF	_TRISJbits, 0
;	.line	381; MainDemo.c	LED1_TRIS = 0;  //LED1
	BCF	_TRISJbits, 1
;	.line	382; MainDemo.c	LED2_TRIS = 0;  //LED2
	BCF	_TRISJbits, 2
;	.line	383; MainDemo.c	LED3_TRIS = 0;  //LED_LCD1
	BCF	_TRISGbits, 5
;	.line	384; MainDemo.c	LED4_TRIS = 0;  //LED_LCD2
	BCF	_TRISGbits, 5
;	.line	385; MainDemo.c	LED5_TRIS = 0;  //LED5=RELAY1
	BCF	_TRISGbits, 7
;	.line	386; MainDemo.c	LED6_TRIS = 0;  //LED7=RELAY2
	BCF	_TRISGbits, 6
;	.line	391; MainDemo.c	LED_PUT(0x00);  //turn off LED0 - LED2
	MOVLW	0xf8
	ANDWF	_LATJ, F
;	.line	392; MainDemo.c	RELAY_PUT(0x00); //turn relays off to save power
	MOVLW	0x3f
	ANDWF	_LATG, F
;	.line	398; MainDemo.c	OSCTUNE = 0x40;
	MOVLW	0x40
	MOVWF	_OSCTUNE
;	.line	405; MainDemo.c	if(OSCCONbits.IDLEN) //IDLEN = 0x80; 0x02 selects the primary clock
	BTFSS	_OSCCONbits, 7
	BRA	_00212_DS_
;	.line	406; MainDemo.c	OSCCON = 0x82;
	MOVLW	0x82
	MOVWF	_OSCCON
	BRA	_00213_DS_
_00212_DS_:
;	.line	408; MainDemo.c	OSCCON = 0x02;
	MOVLW	0x02
	MOVWF	_OSCCON
_00213_DS_:
;	.line	411; MainDemo.c	RCONbits.IPEN = 1;		// Enable interrupt priorities
	BSF	_RCONbits, 7
;	.line	412; MainDemo.c	INTCONbits.GIEH = 1;
	BSF	_INTCONbits, 7
;	.line	413; MainDemo.c	INTCONbits.GIEL = 1;
	BSF	_INTCONbits, 6
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_MainDemo__DisplayIPValue	code
_DisplayIPValue:
;	.line	319; MainDemo.c	void DisplayIPValue(DWORD IPdw) // 32 bits
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVFF	r0x02, POSTDEC1
	MOVFF	r0x03, POSTDEC1
	MOVFF	r0x04, POSTDEC1
	MOVFF	r0x05, POSTDEC1
	MOVFF	r0x06, POSTDEC1
	MOVFF	r0x07, POSTDEC1
	MOVFF	r0x08, POSTDEC1
	MOVFF	r0x09, POSTDEC1
	MOVFF	r0x0a, POSTDEC1
	MOVFF	r0x0b, POSTDEC1
	MOVFF	r0x0c, POSTDEC1
	MOVFF	r0x0d, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, r0x00
	MOVLW	0x03
	MOVFF	PLUSW2, r0x01
	MOVLW	0x04
	MOVFF	PLUSW2, r0x02
	MOVLW	0x05
	MOVFF	PLUSW2, r0x03
;	.line	327; MainDemo.c	BYTE LCDPos=16;  //write on second line of LCD
	MOVLW	0x10
	MOVWF	r0x04
;	.line	332; MainDemo.c	for(i = 0; i < sizeof(IP_ADDR); i++) //sizeof(IP_ADDR) is 4
	CLRF	r0x05
	CLRF	r0x06
	CLRF	r0x07
_00177_DS_:
	MOVLW	0x04
	SUBWF	r0x05, W
	BTFSC	STATUS, 0
	BRA	_00180_DS_
;	.line	335; MainDemo.c	IP_field =(WORD)(IPdw>>(i*8))&0xff;      //ML
	MOVFF	r0x00, r0x08
	MOVFF	r0x01, r0x09
	MOVFF	r0x02, r0x0a
	MOVFF	r0x03, r0x0b
	MOVF	r0x06, W
	BZ	_00198_DS_
	BN	_00201_DS_
	NEGF	WREG
	BCF	STATUS, 0
_00199_DS_:
	RRCF	r0x0b, F
	RRCF	r0x0a, F
	RRCF	r0x09, F
	RRCF	r0x08, F
	ADDLW	0x01
	BNC	_00199_DS_
	BRA	_00198_DS_
_00201_DS_:
	BCF	STATUS, 0
_00200_DS_:
	RLCF	r0x08, F
	RLCF	r0x09, F
	RLCF	r0x0a, F
	RLCF	r0x0b, F
	ADDLW	0x01
	BNC	_00200_DS_
_00198_DS_:
	CLRF	r0x09
;	.line	336; MainDemo.c	uitoa(IP_field, IPDigit, radix);      //ML
	MOVLW	0x0a
	MOVWF	POSTDEC1
	MOVLW	HIGH(_DisplayIPValue_IPDigit_1_1)
	MOVWF	POSTDEC1
	MOVLW	LOW(_DisplayIPValue_IPDigit_1_1)
	MOVWF	POSTDEC1
	MOVF	r0x09, W
	MOVWF	POSTDEC1
	MOVF	r0x08, W
	MOVWF	POSTDEC1
	CALL	_uitoa
	MOVLW	0x05
	ADDWF	FSR1L, F
;	.line	341; MainDemo.c	for(j = 0; j < strlen((char*)IPDigit); j++)
	MOVFF	r0x04, r0x08
	CLRF	r0x09
_00183_DS_:
	MOVLW	HIGH(_DisplayIPValue_IPDigit_1_1)
	MOVWF	r0x0b
	MOVLW	LOW(_DisplayIPValue_IPDigit_1_1)
	MOVWF	r0x0a
	MOVLW	0x80
	MOVWF	r0x0c
	MOVF	r0x0c, W
	MOVWF	POSTDEC1
	MOVF	r0x0b, W
	MOVWF	POSTDEC1
	MOVF	r0x0a, W
	MOVWF	POSTDEC1
	CALL	_strlen
	MOVWF	r0x0a
	MOVFF	PRODL, r0x0b
	MOVLW	0x03
	ADDWF	FSR1L, F
	MOVFF	r0x09, r0x0c
	CLRF	r0x0d
	MOVF	r0x0d, W
	ADDLW	0x80
	MOVWF	PRODL
	MOVF	r0x0b, W
	ADDLW	0x80
	SUBWF	PRODL, W
	BNZ	_00203_DS_
	MOVF	r0x0a, W
	SUBWF	r0x0c, W
_00203_DS_:
	BC	_00195_DS_
;	.line	343; MainDemo.c	LCDText[LCDPos++] = IPDigit[j];
	MOVFF	r0x08, r0x0a
	INCF	r0x08, F
	CLRF	r0x0b
	MOVLW	LOW(_LCDText)
	ADDWF	r0x0a, F
	MOVLW	HIGH(_LCDText)
	ADDWFC	r0x0b, F
	MOVLW	LOW(_DisplayIPValue_IPDigit_1_1)
	ADDWF	r0x09, W
	MOVWF	r0x0c
	CLRF	r0x0d
	MOVLW	HIGH(_DisplayIPValue_IPDigit_1_1)
	ADDWFC	r0x0d, F
	MOVFF	r0x0c, FSR0L
	MOVFF	r0x0d, FSR0H
	MOVFF	INDF0, r0x0c
	MOVFF	r0x0a, FSR0L
	MOVFF	r0x0b, FSR0H
	MOVFF	r0x0c, INDF0
;	.line	341; MainDemo.c	for(j = 0; j < strlen((char*)IPDigit); j++)
	INCF	r0x09, F
	BRA	_00183_DS_
_00195_DS_:
	MOVFF	r0x08, r0x04
;	.line	345; MainDemo.c	if(i == sizeof(IP_ADDR)-1)
	MOVF	r0x05, W
	XORLW	0x03
	BZ	_00180_DS_
;	.line	347; MainDemo.c	LCDText[LCDPos++] = '.';
	INCF	r0x08, W
	MOVWF	r0x04
	CLRF	r0x09
	MOVLW	LOW(_LCDText)
	ADDWF	r0x08, F
	MOVLW	HIGH(_LCDText)
	ADDWFC	r0x09, F
	MOVFF	r0x08, FSR0L
	MOVFF	r0x09, FSR0H
	MOVLW	0x2e
	MOVWF	INDF0
;	.line	332; MainDemo.c	for(i = 0; i < sizeof(IP_ADDR); i++) //sizeof(IP_ADDR) is 4
	MOVLW	0x08
	ADDWF	r0x06, F
	BTFSC	STATUS, 0
	INCF	r0x07, F
	INCF	r0x05, F
	BRA	_00177_DS_
_00180_DS_:
;	.line	350; MainDemo.c	if(LCDPos < 32u)
	MOVFF	r0x04, r0x00
	CLRF	r0x01
	MOVLW	0x00
	SUBWF	r0x01, W
	BNZ	_00206_DS_
	MOVLW	0x20
	SUBWF	r0x00, W
_00206_DS_:
	BC	_00182_DS_
;	.line	351; MainDemo.c	LCDText[LCDPos] = 0;
	CLRF	r0x00
	MOVLW	LOW(_LCDText)
	ADDWF	r0x04, F
	MOVLW	HIGH(_LCDText)
	ADDWFC	r0x00, F
	MOVFF	r0x04, FSR0L
	MOVFF	r0x00, FSR0H
	MOVLW	0x00
	MOVWF	INDF0
_00182_DS_:
;	.line	352; MainDemo.c	LCDUpdate();
	CALL	_LCDUpdate
	MOVFF	PREINC1, r0x0d
	MOVFF	PREINC1, r0x0c
	MOVFF	PREINC1, r0x0b
	MOVFF	PREINC1, r0x0a
	MOVFF	PREINC1, r0x09
	MOVFF	PREINC1, r0x08
	MOVFF	PREINC1, r0x07
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
S_MainDemo__DisplayString	code
_DisplayString:
;	.line	303; MainDemo.c	void DisplayString(BYTE pos, char* text)
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVFF	r0x02, POSTDEC1
	MOVFF	r0x03, POSTDEC1
	MOVFF	r0x04, POSTDEC1
	MOVFF	r0x05, POSTDEC1
	MOVFF	r0x06, POSTDEC1
	MOVFF	r0x07, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, r0x00
	MOVLW	0x03
	MOVFF	PLUSW2, r0x01
	MOVLW	0x04
	MOVFF	PLUSW2, r0x02
	MOVLW	0x05
	MOVFF	PLUSW2, r0x03
;	.line	305; MainDemo.c	BYTE l= strlen(text)+1;
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	CALL	_strlen
	MOVWF	r0x04
	MOVFF	PRODL, r0x05
	MOVLW	0x03
	ADDWF	FSR1L, F
	INCF	r0x04, F
;	.line	306; MainDemo.c	BYTE max= 32-pos;
	MOVF	r0x00, W
	SUBLW	0x20
	MOVWF	r0x05
;	.line	307; MainDemo.c	strlcpy((char*)&LCDText[pos], text,(l<max)?l:max );
	CLRF	r0x06
	MOVLW	LOW(_LCDText)
	ADDWF	r0x00, F
	MOVLW	HIGH(_LCDText)
	ADDWFC	r0x06, F
	MOVF	r0x06, W
	MOVWF	r0x06
	MOVF	r0x00, W
	MOVWF	r0x00
	MOVLW	0x80
	MOVWF	r0x07
	MOVF	r0x05, W
	SUBWF	r0x04, W
	BNC	_00168_DS_
	MOVFF	r0x05, r0x04
_00168_DS_:
	CLRF	r0x05
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x07, W
	MOVWF	POSTDEC1
	MOVF	r0x06, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_strlcpy
	MOVLW	0x08
	ADDWF	FSR1L, F
;	.line	308; MainDemo.c	LCDUpdate();
	CALL	_LCDUpdate
	MOVFF	PREINC1, r0x07
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
S_MainDemo__DisplayWORD	code
_DisplayWORD:
;	.line	281; MainDemo.c	void DisplayWORD(BYTE pos, WORD w) //WORD is a 16 bits unsigned
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVFF	r0x02, POSTDEC1
	MOVFF	r0x03, POSTDEC1
	MOVFF	r0x04, POSTDEC1
	MOVFF	r0x05, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, r0x00
	MOVLW	0x03
	MOVFF	PLUSW2, r0x01
	MOVLW	0x04
	MOVFF	PLUSW2, r0x02
;	.line	289; MainDemo.c	ultoa(w, WDigit, radix);      
	CLRF	r0x03
	CLRF	r0x04
	MOVLW	0x0a
	MOVWF	POSTDEC1
	MOVLW	HIGH(_DisplayWORD_WDigit_1_1)
	MOVWF	POSTDEC1
	MOVLW	LOW(_DisplayWORD_WDigit_1_1)
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	CALL	_ultoa
	MOVLW	0x07
	ADDWF	FSR1L, F
;	.line	290; MainDemo.c	for(j = 0; j < strlen((char*)WDigit); j++)
	CLRF	r0x01
_00149_DS_:
	MOVLW	HIGH(_DisplayWORD_WDigit_1_1)
	MOVWF	r0x03
	MOVLW	LOW(_DisplayWORD_WDigit_1_1)
	MOVWF	r0x02
	MOVLW	0x80
	MOVWF	r0x04
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	CALL	_strlen
	MOVWF	r0x02
	MOVFF	PRODL, r0x03
	MOVLW	0x03
	ADDWF	FSR1L, F
	MOVFF	r0x01, r0x04
	CLRF	r0x05
	MOVF	r0x05, W
	ADDLW	0x80
	MOVWF	PRODL
	MOVF	r0x03, W
	ADDLW	0x80
	SUBWF	PRODL, W
	BNZ	_00159_DS_
	MOVF	r0x02, W
	SUBWF	r0x04, W
_00159_DS_:
	BC	_00152_DS_
;	.line	292; MainDemo.c	LCDText[LCDPos++] = WDigit[j];
	MOVFF	r0x00, r0x02
	INCF	r0x00, F
	CLRF	r0x03
	MOVLW	LOW(_LCDText)
	ADDWF	r0x02, F
	MOVLW	HIGH(_LCDText)
	ADDWFC	r0x03, F
	MOVLW	LOW(_DisplayWORD_WDigit_1_1)
	ADDWF	r0x01, W
	MOVWF	r0x04
	CLRF	r0x05
	MOVLW	HIGH(_DisplayWORD_WDigit_1_1)
	ADDWFC	r0x05, F
	MOVFF	r0x04, FSR0L
	MOVFF	r0x05, FSR0H
	MOVFF	INDF0, r0x04
	MOVFF	r0x02, FSR0L
	MOVFF	r0x03, FSR0H
	MOVFF	r0x04, INDF0
;	.line	290; MainDemo.c	for(j = 0; j < strlen((char*)WDigit); j++)
	INCF	r0x01, F
	BRA	_00149_DS_
_00152_DS_:
;	.line	294; MainDemo.c	if(LCDPos < 32u)
	MOVFF	r0x00, r0x01
	CLRF	r0x02
	MOVLW	0x00
	SUBWF	r0x02, W
	BNZ	_00160_DS_
	MOVLW	0x20
	SUBWF	r0x01, W
_00160_DS_:
	BC	_00148_DS_
;	.line	295; MainDemo.c	LCDText[LCDPos] = 0;
	CLRF	r0x01
	MOVLW	LOW(_LCDText)
	ADDWF	r0x00, F
	MOVLW	HIGH(_LCDText)
	ADDWFC	r0x01, F
	MOVFF	r0x00, FSR0L
	MOVFF	r0x01, FSR0H
	MOVLW	0x00
	MOVWF	INDF0
_00148_DS_:
;	.line	296; MainDemo.c	LCDUpdate();
	CALL	_LCDUpdate
	MOVFF	PREINC1, r0x05
	MOVFF	PREINC1, r0x04
	MOVFF	PREINC1, r0x03
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_MainDemo__HighISR	code
_HighISR:
;	.line	163; MainDemo.c	void HighISR(void) __interrupt(1) //ML for sdcc        
	MOVFF	WREG, POSTDEC1
	MOVFF	STATUS, POSTDEC1
	MOVFF	BSR, POSTDEC1
	MOVFF	PRODL, POSTDEC1
	MOVFF	PRODH, POSTDEC1
	MOVFF	FSR0L, POSTDEC1
	MOVFF	FSR0H, POSTDEC1
	MOVFF	PCLATH, POSTDEC1
	MOVFF	PCLATU, POSTDEC1
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
;	.line	170; MainDemo.c	}
	MOVFF	PREINC1, FSR2L
	MOVFF	PREINC1, PCLATU
	MOVFF	PREINC1, PCLATH
	MOVFF	PREINC1, FSR0H
	MOVFF	PREINC1, FSR0L
	MOVFF	PREINC1, PRODH
	MOVFF	PREINC1, PRODL
	MOVFF	PREINC1, BSR
	MOVFF	PREINC1, STATUS
	MOVFF	PREINC1, WREG
	RETFIE	

; ; Starting pCode block
S_MainDemo__LowISR	code
_LowISR:
;	.line	143; MainDemo.c	void LowISR(void) __interrupt (2) //ML for sdcc
	MOVFF	WREG, POSTDEC1
	MOVFF	STATUS, POSTDEC1
	MOVFF	BSR, POSTDEC1
	MOVFF	PRODL, POSTDEC1
	MOVFF	PRODH, POSTDEC1
	MOVFF	FSR0L, POSTDEC1
	MOVFF	FSR0H, POSTDEC1
	MOVFF	PCLATH, POSTDEC1
	MOVFF	PCLATU, POSTDEC1
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
;	.line	149; MainDemo.c	TickUpdate();
	CALL	_TickUpdate
	MOVFF	PREINC1, FSR2L
	MOVFF	PREINC1, PCLATU
	MOVFF	PREINC1, PCLATH
	MOVFF	PREINC1, FSR0H
	MOVFF	PREINC1, FSR0L
	MOVFF	PREINC1, PRODH
	MOVFF	PREINC1, PRODL
	MOVFF	PREINC1, BSR
	MOVFF	PREINC1, STATUS
	MOVFF	PREINC1, WREG
	RETFIE	

; ; Starting pCode block
__str_0:
	DB	0x4f, 0x6c, 0x69, 0x6d, 0x65, 0x78, 0x00


; Statistics:
; code size:	 2318 (0x090e) bytes ( 1.77%)
;           	 1159 (0x0487) words
; udata size:	   72 (0x0048) bytes ( 1.88%)
; access size:	   22 (0x0016) bytes


	end
