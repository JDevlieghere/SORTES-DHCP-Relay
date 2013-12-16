;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 2.9.4 #5595 (Dec 17 2009) (UNIX)
; This file was generated Mon Mar 15 11:43:32 2010
;--------------------------------------------------------
; PIC16 port for the Microchip 16-bit core micros
;--------------------------------------------------------
	list	p=18f97j60

	radix dec

;--------------------------------------------------------
; public variables in this module
;--------------------------------------------------------
	global _LCDInit
	global _LCDUpdate
	global _LCDErase
	global _LCDText

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
	extern _memset
;--------------------------------------------------------
;	Equates to used internal registers
;--------------------------------------------------------
STATUS	equ	0xfd8
WREG	equ	0xfe8
FSR0L	equ	0xfe9
FSR0H	equ	0xfea
FSR1L	equ	0xfe1
FSR2L	equ	0xfd9
INDF0	equ	0xfef
POSTDEC1	equ	0xfe5
PREINC1	equ	0xfe4
PLUSW2	equ	0xfdb
PRODH	equ	0xff4


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

udata_LCDBlocking_0	udata
_LCDText	res	33

;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
; I code from now on!
; ; Starting pCode block
S_LCDBlocking__LCDErase	code
_LCDErase:
;	.line	392; TCPIP_Stack/LCDBlocking.c	void LCDErase(void)
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
;	.line	395; TCPIP_Stack/LCDBlocking.c	LCDWrite(0, 0x01);
	MOVLW	0x01
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	CALL	_LCDWrite
	MOVLW	0x02
	ADDWF	FSR1L, F
;	.line	396; TCPIP_Stack/LCDBlocking.c	DelayMs(2);
	MOVLW	0x48
	MOVWF	r0x00
	MOVLW	0x0d
	MOVWF	r0x01
	CLRF	r0x02
	CLRF	r0x03
_00305_DS_:
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
	BNZ	_00305_DS_
;	.line	399; TCPIP_Stack/LCDBlocking.c	memset(LCDText, ' ', 32);
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x20
	MOVWF	POSTDEC1
	MOVLW	0x20
	MOVWF	POSTDEC1
	MOVLW	HIGH(_LCDText)
	MOVWF	POSTDEC1
	MOVLW	LOW(_LCDText)
	MOVWF	POSTDEC1
	CALL	_memset
	MOVLW	0x05
	ADDWF	FSR1L, F
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
S_LCDBlocking__LCDUpdate	code
_LCDUpdate:
;	.line	332; TCPIP_Stack/LCDBlocking.c	void LCDUpdate(void)
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
;	.line	337; TCPIP_Stack/LCDBlocking.c	LCDWrite(0, 0x02);
	MOVLW	0x02
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	CALL	_LCDWrite
	MOVLW	0x02
	ADDWF	FSR1L, F
;	.line	338; TCPIP_Stack/LCDBlocking.c	DelayMs(2);
	MOVLW	0x48
	MOVWF	r0x00
	MOVLW	0x0d
	MOVWF	r0x01
	CLRF	r0x02
	CLRF	r0x03
_00225_DS_:
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
	BNZ	_00225_DS_
;	.line	341; TCPIP_Stack/LCDBlocking.c	for(i = 0; i < 16u; i++)
	CLRF	r0x00
_00257_DS_:
	MOVFF	r0x00, r0x01
	CLRF	r0x02
	MOVLW	0x00
	SUBWF	r0x02, W
	BNZ	_00297_DS_
	MOVLW	0x10
	SUBWF	r0x01, W
_00297_DS_:
	BTFSC	STATUS, 0
	BRA	_00260_DS_
;	.line	345; TCPIP_Stack/LCDBlocking.c	if(LCDText[i] == 0u)
	MOVLW	LOW(_LCDText)
	ADDWF	r0x00, W
	MOVWF	r0x01
	CLRF	r0x02
	MOVLW	HIGH(_LCDText)
	ADDWFC	r0x02, F
	MOVFF	r0x01, FSR0L
	MOVFF	r0x02, FSR0H
	MOVFF	INDF0, r0x01
	MOVF	r0x01, W
	BNZ	_00232_DS_
;	.line	347; TCPIP_Stack/LCDBlocking.c	for(j=i; j < 16u; j++)
	MOVFF	r0x00, r0x01
_00253_DS_:
	MOVFF	r0x01, r0x02
	CLRF	r0x03
	MOVLW	0x00
	SUBWF	r0x03, W
	BNZ	_00298_DS_
	MOVLW	0x10
	SUBWF	r0x02, W
_00298_DS_:
	BC	_00232_DS_
;	.line	349; TCPIP_Stack/LCDBlocking.c	LCDText[j] = ' ';
	MOVLW	LOW(_LCDText)
	ADDWF	r0x01, W
	MOVWF	r0x02
	CLRF	r0x03
	MOVLW	HIGH(_LCDText)
	ADDWFC	r0x03, F
	MOVFF	r0x02, FSR0L
	MOVFF	r0x03, FSR0H
	MOVLW	0x20
	MOVWF	INDF0
;	.line	347; TCPIP_Stack/LCDBlocking.c	for(j=i; j < 16u; j++)
	INCF	r0x01, F
	BRA	_00253_DS_
_00232_DS_:
;	.line	352; TCPIP_Stack/LCDBlocking.c	LCDWrite(1, LCDText[i]);
	MOVLW	LOW(_LCDText)
	ADDWF	r0x00, W
	MOVWF	r0x01
	CLRF	r0x02
	MOVLW	HIGH(_LCDText)
	ADDWFC	r0x02, F
	MOVFF	r0x01, FSR0L
	MOVFF	r0x02, FSR0H
	MOVFF	INDF0, r0x01
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVLW	0x01
	MOVWF	POSTDEC1
	CALL	_LCDWrite
	MOVLW	0x02
	ADDWF	FSR1L, F
;	.line	353; TCPIP_Stack/LCDBlocking.c	Delay10us(5);
	MOVLW	0x55
	MOVWF	r0x01
	CLRF	r0x02
	CLRF	r0x03
	CLRF	r0x04
_00233_DS_:
	MOVFF	r0x01, r0x05
	MOVFF	r0x02, r0x06
	MOVFF	r0x03, r0x07
	MOVFF	r0x04, r0x08
	MOVLW	0xff
	ADDWF	r0x01, F
	MOVLW	0xff
	ADDWFC	r0x02, F
	MOVLW	0xff
	ADDWFC	r0x03, F
	MOVLW	0xff
	ADDWFC	r0x04, F
	MOVF	r0x05, W
	IORWF	r0x06, W
	IORWF	r0x07, W
	IORWF	r0x08, W
	BNZ	_00233_DS_
;	.line	341; TCPIP_Stack/LCDBlocking.c	for(i = 0; i < 16u; i++)
	INCF	r0x00, F
	BRA	_00257_DS_
_00260_DS_:
;	.line	357; TCPIP_Stack/LCDBlocking.c	LCDWrite(0, 0xC0);
	MOVLW	0xc0
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	CALL	_LCDWrite
	MOVLW	0x02
	ADDWF	FSR1L, F
;	.line	358; TCPIP_Stack/LCDBlocking.c	Delay10us(5);
	MOVLW	0x55
	MOVWF	r0x00
	CLRF	r0x01
	CLRF	r0x02
	CLRF	r0x03
_00239_DS_:
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
	BNZ	_00239_DS_
;	.line	361; TCPIP_Stack/LCDBlocking.c	for(i = 16; i < 32u; i++)
	MOVLW	0x10
	MOVWF	r0x00
_00265_DS_:
	MOVFF	r0x00, r0x01
	CLRF	r0x02
	MOVLW	0x00
	SUBWF	r0x02, W
	BNZ	_00299_DS_
	MOVLW	0x20
	SUBWF	r0x01, W
_00299_DS_:
	BTFSC	STATUS, 0
	BRA	_00269_DS_
;	.line	365; TCPIP_Stack/LCDBlocking.c	if(LCDText[i] == 0u)
	MOVLW	LOW(_LCDText)
	ADDWF	r0x00, W
	MOVWF	r0x01
	CLRF	r0x02
	MOVLW	HIGH(_LCDText)
	ADDWFC	r0x02, F
	MOVFF	r0x01, FSR0L
	MOVFF	r0x02, FSR0H
	MOVFF	INDF0, r0x01
	MOVF	r0x01, W
	BNZ	_00246_DS_
;	.line	367; TCPIP_Stack/LCDBlocking.c	for(j=i; j < 32u; j++)
	MOVFF	r0x00, r0x01
_00261_DS_:
	MOVFF	r0x01, r0x02
	CLRF	r0x03
	MOVLW	0x00
	SUBWF	r0x03, W
	BNZ	_00300_DS_
	MOVLW	0x20
	SUBWF	r0x02, W
_00300_DS_:
	BC	_00246_DS_
;	.line	369; TCPIP_Stack/LCDBlocking.c	LCDText[j] = ' ';
	MOVLW	LOW(_LCDText)
	ADDWF	r0x01, W
	MOVWF	r0x02
	CLRF	r0x03
	MOVLW	HIGH(_LCDText)
	ADDWFC	r0x03, F
	MOVFF	r0x02, FSR0L
	MOVFF	r0x03, FSR0H
	MOVLW	0x20
	MOVWF	INDF0
;	.line	367; TCPIP_Stack/LCDBlocking.c	for(j=i; j < 32u; j++)
	INCF	r0x01, F
	BRA	_00261_DS_
_00246_DS_:
;	.line	372; TCPIP_Stack/LCDBlocking.c	LCDWrite(1, LCDText[i]);
	MOVLW	LOW(_LCDText)
	ADDWF	r0x00, W
	MOVWF	r0x01
	CLRF	r0x02
	MOVLW	HIGH(_LCDText)
	ADDWFC	r0x02, F
	MOVFF	r0x01, FSR0L
	MOVFF	r0x02, FSR0H
	MOVFF	INDF0, r0x01
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVLW	0x01
	MOVWF	POSTDEC1
	CALL	_LCDWrite
	MOVLW	0x02
	ADDWF	FSR1L, F
;	.line	373; TCPIP_Stack/LCDBlocking.c	Delay10us(5);
	MOVLW	0x55
	MOVWF	r0x01
	CLRF	r0x02
	CLRF	r0x03
	CLRF	r0x04
_00247_DS_:
	MOVFF	r0x01, r0x05
	MOVFF	r0x02, r0x06
	MOVFF	r0x03, r0x07
	MOVFF	r0x04, r0x08
	MOVLW	0xff
	ADDWF	r0x01, F
	MOVLW	0xff
	ADDWFC	r0x02, F
	MOVLW	0xff
	ADDWFC	r0x03, F
	MOVLW	0xff
	ADDWFC	r0x04, F
	MOVF	r0x05, W
	IORWF	r0x06, W
	IORWF	r0x07, W
	IORWF	r0x08, W
	BNZ	_00247_DS_
;	.line	361; TCPIP_Stack/LCDBlocking.c	for(i = 16; i < 32u; i++)
	INCF	r0x00, F
	BRA	_00265_DS_
_00269_DS_:
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
S_LCDBlocking__LCDInit	code
_LCDInit:
;	.line	207; TCPIP_Stack/LCDBlocking.c	void LCDInit(void)
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
;	.line	211; TCPIP_Stack/LCDBlocking.c	memset(LCDText, ' ', sizeof(LCDText)-1);
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x20
	MOVWF	POSTDEC1
	MOVLW	0x20
	MOVWF	POSTDEC1
	MOVLW	HIGH(_LCDText)
	MOVWF	POSTDEC1
	MOVLW	LOW(_LCDText)
	MOVWF	POSTDEC1
	CALL	_memset
	MOVLW	0x05
	ADDWF	FSR1L, F
	BANKSEL	(_LCDText + 32)
;	.line	212; TCPIP_Stack/LCDBlocking.c	LCDText[sizeof(LCDText)-1] = 0;
	CLRF	(_LCDText + 32), B
;	.line	215; TCPIP_Stack/LCDBlocking.c	LCD_E_IO = 0;
	BCF	_LATHbits, 0
;	.line	216; TCPIP_Stack/LCDBlocking.c	LCD_RD_WR_IO = 0;
	BCF	_LATHbits, 1
;	.line	220; TCPIP_Stack/LCDBlocking.c	LCD_DATA_TRIS = 0x00;
	CLRF	_TRISE
;	.line	233; TCPIP_Stack/LCDBlocking.c	LCD_RD_WR_TRIS = 0;
	BCF	_TRISHbits, 1
;	.line	234; TCPIP_Stack/LCDBlocking.c	LCD_RS_TRIS = 0;
	BCF	_TRISHbits, 2
;	.line	235; TCPIP_Stack/LCDBlocking.c	LCD_E_TRIS = 0;
	BCF	_TRISHbits, 0
;	.line	239; TCPIP_Stack/LCDBlocking.c	DelayMs(40);
	MOVLW	0xa0
	MOVWF	r0x00
	MOVLW	0x09
	MOVWF	r0x01
	MOVLW	0x01
	MOVWF	r0x02
	CLRF	r0x03
_00143_DS_:
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
	BNZ	_00143_DS_
;	.line	247; TCPIP_Stack/LCDBlocking.c	LCD_RS_IO = 0;
	BCF	_LATHbits, 2
;	.line	249; TCPIP_Stack/LCDBlocking.c	LCD_DATA_IO = 0x03;
	MOVLW	0x03
	MOVWF	_LATE
	nop 
	nop 
;	.line	264; TCPIP_Stack/LCDBlocking.c	for(i = 0; i < 3u; i++)
	CLRF	r0x00
_00191_DS_:
	MOVFF	r0x00, r0x01
	CLRF	r0x02
	MOVLW	0x00
	SUBWF	r0x02, W
	BNZ	_00220_DS_
	MOVLW	0x03
	SUBWF	r0x01, W
_00220_DS_:
	BC	_00194_DS_
;	.line	266; TCPIP_Stack/LCDBlocking.c	LCD_E_IO = 1;
	BSF	_LATHbits, 0
;	.line	267; TCPIP_Stack/LCDBlocking.c	Delay10us(1);	       	// Wait E Pulse width time (min 230ns)
	MOVLW	0x11
	MOVWF	r0x01
	CLRF	r0x02
	CLRF	r0x03
	CLRF	r0x04
_00155_DS_:
	MOVFF	r0x01, r0x05
	MOVFF	r0x02, r0x06
	MOVFF	r0x03, r0x07
	MOVFF	r0x04, r0x08
	MOVLW	0xff
	ADDWF	r0x01, F
	MOVLW	0xff
	ADDWFC	r0x02, F
	MOVLW	0xff
	ADDWFC	r0x03, F
	MOVLW	0xff
	ADDWFC	r0x04, F
	MOVF	r0x05, W
	IORWF	r0x06, W
	IORWF	r0x07, W
	IORWF	r0x08, W
	BNZ	_00155_DS_
;	.line	268; TCPIP_Stack/LCDBlocking.c	LCD_E_IO = 0;
	BCF	_LATHbits, 0
;	.line	269; TCPIP_Stack/LCDBlocking.c	DelayMs(2);
	MOVLW	0x48
	MOVWF	r0x01
	MOVLW	0x0d
	MOVWF	r0x02
	CLRF	r0x03
	CLRF	r0x04
_00161_DS_:
	MOVFF	r0x01, r0x05
	MOVFF	r0x02, r0x06
	MOVFF	r0x03, r0x07
	MOVFF	r0x04, r0x08
	MOVLW	0xff
	ADDWF	r0x01, F
	MOVLW	0xff
	ADDWFC	r0x02, F
	MOVLW	0xff
	ADDWFC	r0x03, F
	MOVLW	0xff
	ADDWFC	r0x04, F
	MOVF	r0x05, W
	IORWF	r0x06, W
	IORWF	r0x07, W
	IORWF	r0x08, W
	BNZ	_00161_DS_
;	.line	264; TCPIP_Stack/LCDBlocking.c	for(i = 0; i < 3u; i++)
	INCF	r0x00, F
	BRA	_00191_DS_
_00194_DS_:
;	.line	295; TCPIP_Stack/LCDBlocking.c	LCDWrite(0, 0x38);
	MOVLW	0x38
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	CALL	_LCDWrite
	MOVLW	0x02
	ADDWF	FSR1L, F
;	.line	297; TCPIP_Stack/LCDBlocking.c	Delay10us(5);
	MOVLW	0x55
	MOVWF	r0x00
	CLRF	r0x01
	CLRF	r0x02
	CLRF	r0x03
_00167_DS_:
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
	BNZ	_00167_DS_
;	.line	300; TCPIP_Stack/LCDBlocking.c	LCDWrite(0, 0x06);	// Increment after each write, do not shift
	MOVLW	0x06
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	CALL	_LCDWrite
	MOVLW	0x02
	ADDWF	FSR1L, F
;	.line	301; TCPIP_Stack/LCDBlocking.c	Delay10us(5);
	MOVLW	0x55
	MOVWF	r0x00
	CLRF	r0x01
	CLRF	r0x02
	CLRF	r0x03
_00173_DS_:
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
	BNZ	_00173_DS_
;	.line	304; TCPIP_Stack/LCDBlocking.c	LCDWrite(0, 0x0C);	// Turn display on, no cusor, no cursor blink
	MOVLW	0x0c
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	CALL	_LCDWrite
	MOVLW	0x02
	ADDWF	FSR1L, F
;	.line	305; TCPIP_Stack/LCDBlocking.c	Delay10us(5);
	MOVLW	0x55
	MOVWF	r0x00
	CLRF	r0x01
	CLRF	r0x02
	CLRF	r0x03
_00179_DS_:
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
	BNZ	_00179_DS_
;	.line	308; TCPIP_Stack/LCDBlocking.c	LCDWrite(0, 0x01);	
	MOVLW	0x01
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	CALL	_LCDWrite
	MOVLW	0x02
	ADDWF	FSR1L, F
;	.line	309; TCPIP_Stack/LCDBlocking.c	DelayMs(2);
	MOVLW	0x48
	MOVWF	r0x00
	MOVLW	0x0d
	MOVWF	r0x01
	CLRF	r0x02
	CLRF	r0x03
_00185_DS_:
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
	BNZ	_00185_DS_
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
S_LCDBlocking__LCDWrite	code
_LCDWrite:
;	.line	94; TCPIP_Stack/LCDBlocking.c	static void LCDWrite(BYTE RS, BYTE Data)
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, r0x00
	MOVLW	0x03
	MOVFF	PLUSW2, r0x01
;	.line	97; TCPIP_Stack/LCDBlocking.c	LCD_DATA_TRIS = 0x00;
	CLRF	_TRISE
;	.line	110; TCPIP_Stack/LCDBlocking.c	LCD_RS_TRIS = 0;
	BCF	_TRISHbits, 2
;	.line	111; TCPIP_Stack/LCDBlocking.c	LCD_RD_WR_TRIS = 0;
	BCF	_TRISHbits, 1
;	.line	112; TCPIP_Stack/LCDBlocking.c	LCD_RD_WR_IO = 0;
	BCF	_LATHbits, 1
;	.line	113; TCPIP_Stack/LCDBlocking.c	LCD_RS_IO = RS;
	MOVF	r0x00, W
	ANDLW	0x01
	RLNCF	WREG, W
	RLNCF	WREG, W
	MOVWF	PRODH
	MOVF	_LATHbits, W
	ANDLW	0xfb
	IORWF	PRODH, W
	MOVWF	_LATHbits
;	.line	140; TCPIP_Stack/LCDBlocking.c	LCD_DATA_IO = Data;
	MOVFF	r0x01, _LATE
	nop 
	nop 
;	.line	155; TCPIP_Stack/LCDBlocking.c	LCD_E_IO = 1;
	BSF	_LATHbits, 0
	nop 
	nop 
	nop 
	nop 
	nop 
	nop 
	nop 
	nop 
	nop 
;	.line	165; TCPIP_Stack/LCDBlocking.c	LCD_E_IO = 0;
	BCF	_LATHbits, 0
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	



; Statistics:
; code size:	 1496 (0x05d8) bytes ( 1.14%)
;           	  748 (0x02ec) words
; udata size:	   33 (0x0021) bytes ( 0.86%)
; access size:	    9 (0x0009) bytes


	end
