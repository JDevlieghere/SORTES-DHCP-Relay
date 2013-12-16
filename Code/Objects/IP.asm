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
	global _IPGetHeader
	global _IPPutHeader
	global _IPSetRxBuffer

;--------------------------------------------------------
; extern variables in this module
;--------------------------------------------------------
	extern __gptrput4
	extern __gptrput1
	extern __gptrput2
	extern __gptrget4
	extern __gptrget2
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
	extern _swaps
	extern _CalcIPChecksum
	extern _MACCalcRxChecksum
	extern _MACSetReadPtrInRx
	extern _MACGetArray
	extern _MACPutHeader
	extern _MACPutArray
;--------------------------------------------------------
;	Equates to used internal registers
;--------------------------------------------------------
STATUS	equ	0xfd8
WREG	equ	0xfe8
TBLPTRL	equ	0xff6
TBLPTRH	equ	0xff7
FSR0L	equ	0xfe9
FSR1L	equ	0xfe1
FSR2L	equ	0xfd9
POSTDEC1	equ	0xfe5
PREINC1	equ	0xfe4
PLUSW2	equ	0xfdb
PRODL	equ	0xff3
PRODH	equ	0xff4


	idata
__Identifier	db	0x00, 0x00


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

udata_IP_0	udata
_IPHeaderLen	res	1

udata_IP_1	udata
_IPGetHeader_header_1_1	res	20

udata_IP_2	udata
_IPGetHeader_CalcChecksum_1_1	res	2

udata_IP_3	udata
_IPPutHeader_header_1_1	res	20

;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
; I code from now on!
; ; Starting pCode block
S_IP__SwapIPHeader	code
_SwapIPHeader:
;	.line	302; TCPIP_Stack/IP.c	static void SwapIPHeader(IP_HEADER* h)
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
;	.line	304; TCPIP_Stack/IP.c	h->TotalLength      = swaps(h->TotalLength);
	MOVF	r0x00, W
	ADDLW	0x02
	MOVWF	r0x03
	MOVLW	0x00
	ADDWFC	r0x01, W
	MOVWF	r0x04
	MOVLW	0x00
	ADDWFC	r0x02, W
	MOVWF	r0x05
	MOVFF	r0x03, FSR0L
	MOVFF	r0x04, PRODL
	MOVF	r0x05, W
	CALL	__gptrget2
	MOVWF	r0x06
	MOVFF	PRODL, r0x07
	MOVF	r0x07, W
	MOVWF	POSTDEC1
	MOVF	r0x06, W
	MOVWF	POSTDEC1
	CALL	_swaps
	MOVWF	r0x06
	MOVFF	PRODL, r0x07
	MOVLW	0x02
	ADDWF	FSR1L, F
	MOVFF	r0x06, POSTDEC1
	MOVFF	r0x07, PRODH
	MOVFF	r0x03, FSR0L
	MOVFF	r0x04, PRODL
	MOVF	r0x05, W
	CALL	__gptrput2
;	.line	305; TCPIP_Stack/IP.c	h->Identification   = swaps(h->Identification);
	MOVF	r0x00, W
	ADDLW	0x04
	MOVWF	r0x03
	MOVLW	0x00
	ADDWFC	r0x01, W
	MOVWF	r0x04
	MOVLW	0x00
	ADDWFC	r0x02, W
	MOVWF	r0x05
	MOVFF	r0x03, FSR0L
	MOVFF	r0x04, PRODL
	MOVF	r0x05, W
	CALL	__gptrget2
	MOVWF	r0x06
	MOVFF	PRODL, r0x07
	MOVF	r0x07, W
	MOVWF	POSTDEC1
	MOVF	r0x06, W
	MOVWF	POSTDEC1
	CALL	_swaps
	MOVWF	r0x06
	MOVFF	PRODL, r0x07
	MOVLW	0x02
	ADDWF	FSR1L, F
	MOVFF	r0x06, POSTDEC1
	MOVFF	r0x07, PRODH
	MOVFF	r0x03, FSR0L
	MOVFF	r0x04, PRODL
	MOVF	r0x05, W
	CALL	__gptrput2
;	.line	306; TCPIP_Stack/IP.c	h->HeaderChecksum   = swaps(h->HeaderChecksum);
	MOVLW	0x0a
	ADDWF	r0x00, F
	MOVLW	0x00
	ADDWFC	r0x01, F
	MOVLW	0x00
	ADDWFC	r0x02, F
	MOVFF	r0x00, FSR0L
	MOVFF	r0x01, PRODL
	MOVF	r0x02, W
	CALL	__gptrget2
	MOVWF	r0x03
	MOVFF	PRODL, r0x04
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	CALL	_swaps
	MOVWF	r0x03
	MOVFF	PRODL, r0x04
	MOVLW	0x02
	ADDWF	FSR1L, F
	MOVFF	r0x03, POSTDEC1
	MOVFF	r0x04, PRODH
	MOVFF	r0x00, FSR0L
	MOVFF	r0x01, PRODL
	MOVF	r0x02, W
	CALL	__gptrput2
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
S_IP__IPSetRxBuffer	code
_IPSetRxBuffer:
;	.line	295; TCPIP_Stack/IP.c	void IPSetRxBuffer(WORD Offset) 
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
;	.line	297; TCPIP_Stack/IP.c	MACSetReadPtrInRx(Offset+IPHeaderLen);
	MOVFF	_IPHeaderLen, r0x02
	CLRF	r0x03
	MOVF	r0x02, W
	ADDWF	r0x00, F
	MOVF	r0x03, W
	ADDWFC	r0x01, F
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_MACSetReadPtrInRx
	MOVLW	0x02
	ADDWF	FSR1L, F
	MOVFF	PREINC1, r0x03
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_IP__IPPutHeader	code
_IPPutHeader:
;	.line	247; TCPIP_Stack/IP.c	WORD IPPutHeader(NODE_INFO *remote,
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
;	.line	253; TCPIP_Stack/IP.c	IPHeaderLen = sizeof(IP_HEADER);
	MOVLW	0x14
	BANKSEL	_IPHeaderLen
	MOVWF	_IPHeaderLen, B
;	.line	255; TCPIP_Stack/IP.c	header.VersionIHL       = IP_VERSION | IP_IHL;
	MOVLW	0x45
	BANKSEL	_IPPutHeader_header_1_1
	MOVWF	_IPPutHeader_header_1_1, B
	BANKSEL	(_IPPutHeader_header_1_1 + 1)
;	.line	256; TCPIP_Stack/IP.c	header.TypeOfService    = IP_SERVICE;
	CLRF	(_IPPutHeader_header_1_1 + 1), B
;	.line	257; TCPIP_Stack/IP.c	header.TotalLength      = sizeof(header) + len;
	MOVLW	0x14
	ADDWF	r0x04, F
	BTFSC	STATUS, 0
	INCF	r0x05, F
	MOVF	r0x04, W
	BANKSEL	(_IPPutHeader_header_1_1 + 2)
	MOVWF	(_IPPutHeader_header_1_1 + 2), B
	MOVF	r0x05, W
	BANKSEL	(_IPPutHeader_header_1_1 + 3)
	MOVWF	(_IPPutHeader_header_1_1 + 3), B
	BANKSEL	__Identifier
;	.line	258; TCPIP_Stack/IP.c	header.Identification   = ++_Identifier;
	INCF	__Identifier, F, B
	BNC	_10137_DS_
	BANKSEL	(__Identifier + 1)
	INCF	(__Identifier + 1), F, B
_10137_DS_:
	BANKSEL	__Identifier
	MOVF	__Identifier, W, B
	BANKSEL	(_IPPutHeader_header_1_1 + 4)
	MOVWF	(_IPPutHeader_header_1_1 + 4), B
	BANKSEL	(__Identifier + 1)
	MOVF	(__Identifier + 1), W, B
	BANKSEL	(_IPPutHeader_header_1_1 + 5)
	MOVWF	(_IPPutHeader_header_1_1 + 5), B
	BANKSEL	(_IPPutHeader_header_1_1 + 6)
;	.line	259; TCPIP_Stack/IP.c	header.FragmentInfo     = 0;
	CLRF	(_IPPutHeader_header_1_1 + 6), B
	BANKSEL	(_IPPutHeader_header_1_1 + 7)
	CLRF	(_IPPutHeader_header_1_1 + 7), B
;	.line	260; TCPIP_Stack/IP.c	header.TimeToLive       = MY_IP_TTL;
	MOVLW	0x64
	BANKSEL	(_IPPutHeader_header_1_1 + 8)
	MOVWF	(_IPPutHeader_header_1_1 + 8), B
;	.line	261; TCPIP_Stack/IP.c	header.Protocol         = protocol;
	MOVF	r0x03, W
	BANKSEL	(_IPPutHeader_header_1_1 + 9)
	MOVWF	(_IPPutHeader_header_1_1 + 9), B
	BANKSEL	(_IPPutHeader_header_1_1 + 10)
;	.line	262; TCPIP_Stack/IP.c	header.HeaderChecksum   = 0;
	CLRF	(_IPPutHeader_header_1_1 + 10), B
	BANKSEL	(_IPPutHeader_header_1_1 + 11)
	CLRF	(_IPPutHeader_header_1_1 + 11), B
	BANKSEL	_AppConfig
;	.line	264; TCPIP_Stack/IP.c	header.SourceAddress.Val 	= AppConfig.MyIPAddr.Val;
	MOVF	_AppConfig, W, B
	BANKSEL	(_IPPutHeader_header_1_1 + 12)
	MOVWF	(_IPPutHeader_header_1_1 + 12), B
	BANKSEL	(_AppConfig + 1)
	MOVF	(_AppConfig + 1), W, B
	BANKSEL	(_IPPutHeader_header_1_1 + 13)
	MOVWF	(_IPPutHeader_header_1_1 + 13), B
	BANKSEL	(_AppConfig + 2)
	MOVF	(_AppConfig + 2), W, B
	BANKSEL	(_IPPutHeader_header_1_1 + 14)
	MOVWF	(_IPPutHeader_header_1_1 + 14), B
	BANKSEL	(_AppConfig + 3)
	MOVF	(_AppConfig + 3), W, B
	BANKSEL	(_IPPutHeader_header_1_1 + 15)
	MOVWF	(_IPPutHeader_header_1_1 + 15), B
;	.line	266; TCPIP_Stack/IP.c	header.DestAddress.Val = remote->IPAddr.Val;
	MOVFF	r0x00, FSR0L
	MOVFF	r0x01, PRODL
	MOVF	r0x02, W
	CALL	__gptrget4
	MOVWF	r0x03
	MOVFF	PRODL, r0x06
	MOVFF	PRODH, r0x07
	MOVFF	FSR0L, r0x08
	MOVF	r0x03, W
	BANKSEL	(_IPPutHeader_header_1_1 + 16)
	MOVWF	(_IPPutHeader_header_1_1 + 16), B
	MOVF	r0x06, W
	BANKSEL	(_IPPutHeader_header_1_1 + 17)
	MOVWF	(_IPPutHeader_header_1_1 + 17), B
	MOVF	r0x07, W
	BANKSEL	(_IPPutHeader_header_1_1 + 18)
	MOVWF	(_IPPutHeader_header_1_1 + 18), B
	MOVF	r0x08, W
	BANKSEL	(_IPPutHeader_header_1_1 + 19)
	MOVWF	(_IPPutHeader_header_1_1 + 19), B
;	.line	268; TCPIP_Stack/IP.c	SwapIPHeader(&header);
	MOVLW	HIGH(_IPPutHeader_header_1_1)
	MOVWF	r0x06
	MOVLW	LOW(_IPPutHeader_header_1_1)
	MOVWF	r0x03
	MOVLW	0x80
	MOVWF	r0x07
	MOVF	r0x07, W
	MOVWF	POSTDEC1
	MOVF	r0x06, W
	MOVWF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	CALL	_SwapIPHeader
	MOVLW	0x03
	ADDWF	FSR1L, F
;	.line	270; TCPIP_Stack/IP.c	header.HeaderChecksum   = CalcIPChecksum((BYTE*)&header, sizeof(header));
	MOVLW	HIGH(_IPPutHeader_header_1_1)
	MOVWF	r0x06
	MOVLW	LOW(_IPPutHeader_header_1_1)
	MOVWF	r0x03
	MOVLW	0x80
	MOVWF	r0x07
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x14
	MOVWF	POSTDEC1
	MOVF	r0x07, W
	MOVWF	POSTDEC1
	MOVF	r0x06, W
	MOVWF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	CALL	_CalcIPChecksum
	MOVWF	r0x03
	MOVFF	PRODL, r0x06
	MOVLW	0x05
	ADDWF	FSR1L, F
	MOVF	r0x03, W
	BANKSEL	(_IPPutHeader_header_1_1 + 10)
	MOVWF	(_IPPutHeader_header_1_1 + 10), B
	MOVF	r0x06, W
	BANKSEL	(_IPPutHeader_header_1_1 + 11)
	MOVWF	(_IPPutHeader_header_1_1 + 11), B
;	.line	272; TCPIP_Stack/IP.c	MACPutHeader(&remote->MACAddr, MAC_IP, (sizeof(header)+len));
	MOVLW	0x04
	ADDWF	r0x00, F
	MOVLW	0x00
	ADDWFC	r0x01, F
	MOVLW	0x00
	ADDWFC	r0x02, F
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_MACPutHeader
	MOVLW	0x06
	ADDWF	FSR1L, F
;	.line	273; TCPIP_Stack/IP.c	MACPutArray((BYTE*)&header, sizeof(header));
	MOVLW	HIGH(_IPPutHeader_header_1_1)
	MOVWF	r0x01
	MOVLW	LOW(_IPPutHeader_header_1_1)
	MOVWF	r0x00
	MOVLW	0x80
	MOVWF	r0x02
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x14
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_MACPutArray
	MOVLW	0x05
	ADDWF	FSR1L, F
;	.line	275; TCPIP_Stack/IP.c	return 0x0000;
	CLRF	PRODL
	CLRF	WREG
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
S_IP__IPGetHeader	code
_IPGetHeader:
;	.line	136; TCPIP_Stack/IP.c	BOOL IPGetHeader(IP_ADDR *localIP,
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
	MOVLW	0x0a
	MOVFF	PLUSW2, r0x08
	MOVLW	0x0b
	MOVFF	PLUSW2, r0x09
	MOVLW	0x0c
	MOVFF	PLUSW2, r0x0a
	MOVLW	0x0d
	MOVFF	PLUSW2, r0x0b
;	.line	153; TCPIP_Stack/IP.c	MACGetArray((BYTE*)&header, sizeof(header));
	MOVLW	HIGH(_IPGetHeader_header_1_1)
	MOVWF	r0x0d
	MOVLW	LOW(_IPGetHeader_header_1_1)
	MOVWF	r0x0c
	MOVLW	0x80
	MOVWF	r0x0e
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x14
	MOVWF	POSTDEC1
	MOVF	r0x0e, W
	MOVWF	POSTDEC1
	MOVF	r0x0d, W
	MOVWF	POSTDEC1
	MOVF	r0x0c, W
	MOVWF	POSTDEC1
	CALL	_MACGetArray
	MOVLW	0x05
	ADDWF	FSR1L, F
;	.line	156; TCPIP_Stack/IP.c	if((header.VersionIHL & 0xf0) != IP_VERSION) return FALSE;
	MOVLW	0xf0
	BANKSEL	_IPGetHeader_header_1_1
	ANDWF	_IPGetHeader_header_1_1, W, B
	MOVWF	r0x0c
	CLRF	r0x0d
	MOVF	r0x0c, W
	XORLW	0x40
	BNZ	_00121_DS_
	MOVF	r0x0d, W
	BZ	_00106_DS_
_00121_DS_:
	CLRF	WREG
	BRA	_00113_DS_
_00106_DS_:
	BANKSEL	(_IPGetHeader_header_1_1 + 6)
;	.line	160; TCPIP_Stack/IP.c	if(header.FragmentInfo & 0xFF1F) return FALSE;
	MOVF	(_IPGetHeader_header_1_1 + 6), W, B
	ANDLW	0x1f
	BNZ	_00122_DS_
	BANKSEL	(_IPGetHeader_header_1_1 + 7)
	MOVF	(_IPGetHeader_header_1_1 + 7), W, B
	BZ	_00108_DS_
_00122_DS_:
	CLRF	WREG
	BRA	_00113_DS_
_00108_DS_:
;	.line	162; TCPIP_Stack/IP.c	IPHeaderLen = (header.VersionIHL & 0x0f) << 2;
	MOVLW	0x0f
	BANKSEL	_IPGetHeader_header_1_1
	ANDWF	_IPGetHeader_header_1_1, W, B
	MOVWF	r0x0c
	RLNCF	r0x0c, W
	RLNCF	WREG, W
	ANDLW	0xfc
	BANKSEL	_IPHeaderLen
	MOVWF	_IPHeaderLen, B
;	.line	169; TCPIP_Stack/IP.c	CalcChecksum.Val = MACCalcRxChecksum(0, IPHeaderLen);
	MOVFF	_IPHeaderLen, r0x0c
	CLRF	r0x0d
	MOVF	r0x0d, W
	MOVWF	POSTDEC1
	MOVF	r0x0c, W
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	CALL	_MACCalcRxChecksum
	MOVWF	r0x0c
	MOVFF	PRODL, r0x0d
	MOVLW	0x04
	ADDWF	FSR1L, F
	MOVF	r0x0c, W
	BANKSEL	_IPGetHeader_CalcChecksum_1_1
	MOVWF	_IPGetHeader_CalcChecksum_1_1, B
	MOVF	r0x0d, W
	BANKSEL	(_IPGetHeader_CalcChecksum_1_1 + 1)
	MOVWF	(_IPGetHeader_CalcChecksum_1_1 + 1), B
;	.line	172; TCPIP_Stack/IP.c	MACSetReadPtrInRx(IPHeaderLen);
	MOVFF	_IPHeaderLen, r0x0c
	CLRF	r0x0d
	MOVF	r0x0d, W
	MOVWF	POSTDEC1
	MOVF	r0x0c, W
	MOVWF	POSTDEC1
	CALL	_MACSetReadPtrInRx
	MOVLW	0x02
	ADDWF	FSR1L, F
	BANKSEL	_IPGetHeader_CalcChecksum_1_1
;	.line	174; TCPIP_Stack/IP.c	if(CalcChecksum.Val)
	MOVF	_IPGetHeader_CalcChecksum_1_1, W, B
	BANKSEL	(_IPGetHeader_CalcChecksum_1_1 + 1)
	IORWF	(_IPGetHeader_CalcChecksum_1_1 + 1), W, B
	BZ	_00110_DS_
;	.line	209; TCPIP_Stack/IP.c	return FALSE;
	CLRF	WREG
	BRA	_00113_DS_
_00110_DS_:
;	.line	213; TCPIP_Stack/IP.c	SwapIPHeader(&header);
	MOVLW	HIGH(_IPGetHeader_header_1_1)
	MOVWF	r0x0d
	MOVLW	LOW(_IPGetHeader_header_1_1)
	MOVWF	r0x0c
	MOVLW	0x80
	MOVWF	r0x0e
	MOVF	r0x0e, W
	MOVWF	POSTDEC1
	MOVF	r0x0d, W
	MOVWF	POSTDEC1
	MOVF	r0x0c, W
	MOVWF	POSTDEC1
	CALL	_SwapIPHeader
	MOVLW	0x03
	ADDWF	FSR1L, F
;	.line	217; TCPIP_Stack/IP.c	if ( localIP ) localIP->Val = header.DestAddress.Val;
	MOVF	r0x00, W
	IORWF	r0x01, W
	IORWF	r0x02, W
	BZ	_00112_DS_
	MOVFF	(_IPGetHeader_header_1_1 + 16), r0x0c
	MOVFF	(_IPGetHeader_header_1_1 + 17), r0x0d
	MOVFF	(_IPGetHeader_header_1_1 + 18), r0x0e
	MOVFF	(_IPGetHeader_header_1_1 + 19), r0x0f
	MOVFF	r0x0c, POSTDEC1
	MOVFF	r0x0d, PRODH
	MOVFF	r0x0e, TBLPTRL
	MOVFF	r0x0f, TBLPTRH
	MOVFF	r0x00, FSR0L
	MOVFF	r0x01, PRODL
	MOVF	r0x02, W
	CALL	__gptrput4
_00112_DS_:
;	.line	219; TCPIP_Stack/IP.c	remote->IPAddr.Val  = header.SourceAddress.Val;
	MOVFF	(_IPGetHeader_header_1_1 + 12), r0x00
	MOVFF	(_IPGetHeader_header_1_1 + 13), r0x01
	MOVFF	(_IPGetHeader_header_1_1 + 14), r0x02
	MOVFF	(_IPGetHeader_header_1_1 + 15), r0x0c
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, PRODH
	MOVFF	r0x02, TBLPTRL
	MOVFF	r0x0c, TBLPTRH
	MOVFF	r0x03, FSR0L
	MOVFF	r0x04, PRODL
	MOVF	r0x05, W
	CALL	__gptrput4
;	.line	220; TCPIP_Stack/IP.c	*protocol           = header.Protocol;
	MOVFF	(_IPGetHeader_header_1_1 + 9), r0x00
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x06, FSR0L
	MOVFF	r0x07, PRODL
	MOVF	r0x08, W
	CALL	__gptrput1
;	.line	221; TCPIP_Stack/IP.c	*len 		= header.TotalLength - IPHeaderLen;
	MOVFF	_IPHeaderLen, r0x00
	CLRF	r0x01
	MOVF	r0x00, W
	BANKSEL	(_IPGetHeader_header_1_1 + 2)
	SUBWF	(_IPGetHeader_header_1_1 + 2), W, B
	MOVWF	r0x00
	MOVF	r0x01, W
	BANKSEL	(_IPGetHeader_header_1_1 + 3)
	SUBWFB	(_IPGetHeader_header_1_1 + 3), W, B
	MOVWF	r0x01
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, PRODH
	MOVFF	r0x09, FSR0L
	MOVFF	r0x0a, PRODL
	MOVF	r0x0b, W
	CALL	__gptrput2
;	.line	223; TCPIP_Stack/IP.c	return TRUE;
	MOVLW	0x01
_00113_DS_:
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



; Statistics:
; code size:	 1496 (0x05d8) bytes ( 1.14%)
;           	  748 (0x02ec) words
; udata size:	   43 (0x002b) bytes ( 1.12%)
; access size:	   16 (0x0010) bytes


	end
