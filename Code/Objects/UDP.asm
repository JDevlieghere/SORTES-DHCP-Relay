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
	global _UDPInit
	global _UDPTask
	global _UDPOpen
	global _UDPClose
	global _UDPSetTxBuffer
	global _UDPSetRxBuffer
	global _UDPIsPutReady
	global _UDPPut
	global _UDPPutArray
	global _UDPPutString
	global _UDPFlush
	global _UDPIsGetReady
	global _UDPGet
	global _UDPGetArray
	global _UDPDiscard
	global _UDPProcess
	global _UDPSocketInfo
	global _activeUDPSocket
	global _UDPTxCount
	global _UDPRxCount

;--------------------------------------------------------
; extern variables in this module
;--------------------------------------------------------
	extern __gptrget2
	extern __gptrput2
	extern __gptrget4
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
	extern _AN0String
	extern _AppConfig
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
	extern _strlen
	extern _memcpy
	extern _memset
	extern _swaps
	extern _CalcIPChecksum
	extern _CalcIPBufferChecksum
	extern _MACSetWritePtr
	extern _MACSetReadPtr
	extern _MACGet
	extern _MACGetArray
	extern _MACDiscardRx
	extern _MACIsTxReady
	extern _MACPut
	extern _MACPutArray
	extern _MACFlush
	extern _IPPutHeader
	extern _IPSetRxBuffer
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
POSTINC0	equ	0xfee
POSTDEC1	equ	0xfe5
PREINC1	equ	0xfe4
PLUSW2	equ	0xfdb
PRODL	equ	0xff3
PRODH	equ	0xff4


	idata
_LastPutSocket	db	0xff
_SocketWithRxData	db	0xff


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
r0x16	res	1
r0x17	res	1
r0x18	res	1
r0x19	res	1
r0x1a	res	1
r0x1b	res	1

udata_UDP_0	udata
_wPutOffset	res	2

udata_UDP_1	udata
_wGetOffset	res	2

udata_UDP_2	udata
_Flags	res	1

udata_UDP_3	udata
_UDPOpen_NextPort_1_1	res	2

udata_UDP_4	udata
_activeUDPSocket	res	1

udata_UDP_5	udata
_UDPSocketInfo	res	140

udata_UDP_6	udata
_UDPTxCount	res	2

udata_UDP_7	udata
_UDPFlush_wChecksum_1_1	res	2

udata_UDP_8	udata
_UDPFlush_h_1_1	res	8

udata_UDP_9	udata
_UDPFlush_pseudoHeader_2_2	res	12

udata_UDP_10	udata
_UDPRxCount	res	2

udata_UDP_11	udata
_UDPProcess_h_1_1	res	8

udata_UDP_12	udata
_UDPProcess_pseudoHeader_1_1	res	12

udata_UDP_13	udata
_UDPProcess_checksums_1_1	res	4

;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
; I code from now on!
; ; Starting pCode block
S_UDP__FindMatchingSocket	code
_FindMatchingSocket:
;	.line	1017; TCPIP_Stack/UDP.c	static UDP_SOCKET FindMatchingSocket(UDP_HEADER *h,
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
	MOVFF	r0x16, POSTDEC1
	MOVFF	r0x17, POSTDEC1
	MOVFF	r0x18, POSTDEC1
	MOVFF	r0x19, POSTDEC1
	MOVFF	r0x1a, POSTDEC1
	MOVFF	r0x1b, POSTDEC1
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
;	.line	1025; TCPIP_Stack/UDP.c	partialMatch = INVALID_UDP_SOCKET;
	MOVLW	0xff
	MOVWF	r0x09
;	.line	1027; TCPIP_Stack/UDP.c	p = UDPSocketInfo;
	MOVLW	HIGH(_UDPSocketInfo)
	MOVWF	r0x0b
	MOVLW	LOW(_UDPSocketInfo)
	MOVWF	r0x0a
	MOVLW	0x80
	MOVWF	r0x0c
;	.line	1028; TCPIP_Stack/UDP.c	for ( s = 0; s < MAX_UDP_SOCKETS; s++ )
	CLRF	r0x0d
	MOVF	r0x00, W
	ADDLW	0x02
	MOVWF	r0x0e
	MOVLW	0x00
	ADDWFC	r0x01, W
	MOVWF	r0x0f
	MOVLW	0x00
	ADDWFC	r0x02, W
	MOVWF	r0x10
	MOVFF	r0x0e, FSR0L
	MOVFF	r0x0f, PRODL
	MOVF	r0x10, W
	CALL	__gptrget2
	MOVWF	r0x0e
	MOVFF	PRODL, r0x0f
	MOVFF	r0x0a, r0x10
	MOVFF	r0x0b, r0x11
	MOVFF	r0x0c, r0x12
	CLRF	r0x13
_00306_DS_:
	MOVFF	r0x13, r0x14
	CLRF	r0x15
	MOVLW	0x00
	SUBWF	r0x15, W
	BNZ	_00319_DS_
	MOVLW	0x0a
	SUBWF	r0x14, W
_00319_DS_:
	BTFSC	STATUS, 0
	BRA	_00309_DS_
;	.line	1035; TCPIP_Stack/UDP.c	if ( p->localPort == h->DestinationPort )
	MOVF	r0x10, W
	ADDLW	0x0c
	MOVWF	r0x14
	MOVLW	0x00
	ADDWFC	r0x11, W
	MOVWF	r0x15
	MOVLW	0x00
	ADDWFC	r0x12, W
	MOVWF	r0x16
	MOVFF	r0x14, FSR0L
	MOVFF	r0x15, PRODL
	MOVF	r0x16, W
	CALL	__gptrget2
	MOVWF	r0x14
	MOVFF	PRODL, r0x15
	MOVF	r0x14, W
	XORWF	r0x0e, W
	BNZ	_00320_DS_
	MOVF	r0x15, W
	XORWF	r0x0f, W
	BZ	_00321_DS_
_00320_DS_:
	BRA	_00303_DS_
_00321_DS_:
;	.line	1037; TCPIP_Stack/UDP.c	if(p->remotePort == h->SourcePort)
	MOVF	r0x10, W
	ADDLW	0x0a
	MOVWF	r0x14
	MOVLW	0x00
	ADDWFC	r0x11, W
	MOVWF	r0x15
	MOVLW	0x00
	ADDWFC	r0x12, W
	MOVWF	r0x16
	MOVFF	r0x14, FSR0L
	MOVFF	r0x15, PRODL
	MOVF	r0x16, W
	CALL	__gptrget2
	MOVWF	r0x14
	MOVFF	PRODL, r0x15
	MOVFF	r0x00, FSR0L
	MOVFF	r0x01, PRODL
	MOVF	r0x02, W
	CALL	__gptrget2
	MOVWF	r0x16
	MOVFF	PRODL, r0x17
	MOVF	r0x14, W
	XORWF	r0x16, W
	BNZ	_00322_DS_
	MOVF	r0x15, W
	XORWF	r0x17, W
	BZ	_00323_DS_
_00322_DS_:
	BRA	_00301_DS_
_00323_DS_:
;	.line	1039; TCPIP_Stack/UDP.c	if( (p->remoteNode.IPAddr.Val == remoteNode->IPAddr.Val) ||
	MOVFF	r0x10, FSR0L
	MOVFF	r0x11, PRODL
	MOVF	r0x12, W
	CALL	__gptrget4
	MOVWF	r0x14
	MOVFF	PRODL, r0x15
	MOVFF	PRODH, r0x16
	MOVFF	FSR0L, r0x17
	MOVFF	r0x03, FSR0L
	MOVFF	r0x04, PRODL
	MOVF	r0x05, W
	CALL	__gptrget4
	MOVWF	r0x18
	MOVFF	PRODL, r0x19
	MOVFF	PRODH, r0x1a
	MOVFF	FSR0L, r0x1b
	MOVF	r0x14, W
	XORWF	r0x18, W
	BNZ	_00325_DS_
	MOVF	r0x15, W
	XORWF	r0x19, W
	BNZ	_00325_DS_
	MOVF	r0x16, W
	XORWF	r0x1a, W
	BNZ	_00325_DS_
	MOVF	r0x17, W
	XORWF	r0x1b, W
	BNZ	_00325_DS_
	BRA	_00296_DS_
_00325_DS_:
;	.line	1040; TCPIP_Stack/UDP.c	(localIP->Val == 0xFFFFFFFFul) || (localIP->Val == 
	MOVFF	r0x06, FSR0L
	MOVFF	r0x07, PRODL
	MOVF	r0x08, W
	CALL	__gptrget4
	MOVWF	r0x14
	MOVFF	PRODL, r0x15
	MOVFF	PRODH, r0x16
	MOVFF	FSR0L, r0x17
	MOVF	r0x14, W
	XORLW	0xff
	BNZ	_00327_DS_
	MOVF	r0x15, W
	XORLW	0xff
	BNZ	_00327_DS_
	MOVF	r0x16, W
	XORLW	0xff
	BNZ	_00327_DS_
	MOVF	r0x17, W
	XORLW	0xff
	BZ	_00296_DS_
_00327_DS_:
	BANKSEL	(_AppConfig + 4)
;	.line	1041; TCPIP_Stack/UDP.c	(AppConfig.MyIPAddr.Val | (~AppConfig.MyMask.Val))))
	COMF	(_AppConfig + 4), W, B
	MOVWF	r0x18
	BANKSEL	(_AppConfig + 5)
	COMF	(_AppConfig + 5), W, B
	MOVWF	r0x19
	BANKSEL	(_AppConfig + 6)
	COMF	(_AppConfig + 6), W, B
	MOVWF	r0x1a
	BANKSEL	(_AppConfig + 7)
	COMF	(_AppConfig + 7), W, B
	MOVWF	r0x1b
	BANKSEL	_AppConfig
	MOVF	_AppConfig, W, B
	IORWF	r0x18, F
	BANKSEL	(_AppConfig + 1)
	MOVF	(_AppConfig + 1), W, B
	IORWF	r0x19, F
	BANKSEL	(_AppConfig + 2)
	MOVF	(_AppConfig + 2), W, B
	IORWF	r0x1a, F
	BANKSEL	(_AppConfig + 3)
	MOVF	(_AppConfig + 3), W, B
	IORWF	r0x1b, F
	MOVF	r0x14, W
	XORWF	r0x18, W
	BNZ	_00329_DS_
	MOVF	r0x15, W
	XORWF	r0x19, W
	BNZ	_00329_DS_
	MOVF	r0x16, W
	XORWF	r0x1a, W
	BNZ	_00329_DS_
	MOVF	r0x17, W
	XORWF	r0x1b, W
	BZ	_00296_DS_
_00329_DS_:
	BRA	_00301_DS_
_00296_DS_:
;	.line	1043; TCPIP_Stack/UDP.c	return s;
	MOVF	r0x0d, W
	BRA	_00310_DS_
_00301_DS_:
;	.line	1047; TCPIP_Stack/UDP.c	partialMatch = s;
	MOVFF	r0x13, r0x09
_00303_DS_:
;	.line	1049; TCPIP_Stack/UDP.c	p++;
	MOVLW	0x0e
	ADDWF	r0x10, F
	MOVLW	0x00
	ADDWFC	r0x11, F
	MOVLW	0x00
	ADDWFC	r0x12, F
;	.line	1028; TCPIP_Stack/UDP.c	for ( s = 0; s < MAX_UDP_SOCKETS; s++ )
	INCF	r0x13, F
	MOVFF	r0x13, r0x0d
	BRA	_00306_DS_
_00309_DS_:
;	.line	1052; TCPIP_Stack/UDP.c	if ( partialMatch != INVALID_UDP_SOCKET )
	MOVFF	r0x09, r0x06
	CLRF	r0x07
	MOVF	r0x06, W
	XORLW	0xff
	BNZ	_00332_DS_
	MOVF	r0x07, W
	BNZ	_00332_DS_
	BRA	_00305_DS_
; ;multiply lit val:0x0e by variable r0x09 and store in r0x06
; ;Unrolled 8 X 8 multiplication
; ;FIXME: the function does not support result==WREG
_00332_DS_:
;	.line	1054; TCPIP_Stack/UDP.c	p = &UDPSocketInfo[partialMatch];
	MOVF	r0x09, W
	MULLW	0x0e
	MOVFF	PRODL, r0x06
	CLRF	r0x07
	MOVLW	LOW(_UDPSocketInfo)
	ADDWF	r0x06, F
	MOVLW	HIGH(_UDPSocketInfo)
	ADDWFC	r0x07, F
	MOVF	r0x07, W
	MOVWF	r0x0b
	MOVF	r0x06, W
	MOVWF	r0x0a
	MOVLW	0x80
	MOVWF	r0x0c
;	.line	1057; TCPIP_Stack/UDP.c	(void*)remoteNode, sizeof(p->remoteNode) );
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x0a
	MOVWF	POSTDEC1
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVF	r0x0c, W
	MOVWF	POSTDEC1
	MOVF	r0x0b, W
	MOVWF	POSTDEC1
	MOVF	r0x0a, W
	MOVWF	POSTDEC1
	CALL	_memcpy
	MOVLW	0x08
	ADDWF	FSR1L, F
;	.line	1059; TCPIP_Stack/UDP.c	p->remotePort = h->SourcePort;
	MOVLW	0x0a
	ADDWF	r0x0a, F
	MOVLW	0x00
	ADDWFC	r0x0b, F
	MOVLW	0x00
	ADDWFC	r0x0c, F
	MOVFF	r0x00, FSR0L
	MOVFF	r0x01, PRODL
	MOVF	r0x02, W
	CALL	__gptrget2
	MOVWF	r0x00
	MOVFF	PRODL, r0x01
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, PRODH
	MOVFF	r0x0a, FSR0L
	MOVFF	r0x0b, PRODL
	MOVF	r0x0c, W
	CALL	__gptrput2
_00305_DS_:
;	.line	1061; TCPIP_Stack/UDP.c	return partialMatch;
	MOVF	r0x09, W
_00310_DS_:
	MOVFF	PREINC1, r0x1b
	MOVFF	PREINC1, r0x1a
	MOVFF	PREINC1, r0x19
	MOVFF	PREINC1, r0x18
	MOVFF	PREINC1, r0x17
	MOVFF	PREINC1, r0x16
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
S_UDP__UDPProcess	code
_UDPProcess:
;	.line	929; TCPIP_Stack/UDP.c	BOOL UDPProcess(NODE_INFO *remoteNode, IP_ADDR *localIP, WORD len)
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
	BANKSEL	_UDPRxCount
;	.line	936; TCPIP_Stack/UDP.c	UDPRxCount = 0;
	CLRF	_UDPRxCount, B
	BANKSEL	(_UDPRxCount + 1)
	CLRF	(_UDPRxCount + 1), B
;	.line	939; TCPIP_Stack/UDP.c	MACGetArray((BYTE*)&h, sizeof(h));
	MOVLW	HIGH(_UDPProcess_h_1_1)
	MOVWF	r0x09
	MOVLW	LOW(_UDPProcess_h_1_1)
	MOVWF	r0x08
	MOVLW	0x80
	MOVWF	r0x0a
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x08
	MOVWF	POSTDEC1
	MOVF	r0x0a, W
	MOVWF	POSTDEC1
	MOVF	r0x09, W
	MOVWF	POSTDEC1
	MOVF	r0x08, W
	MOVWF	POSTDEC1
	CALL	_MACGetArray
	MOVLW	0x05
	ADDWF	FSR1L, F
	BANKSEL	(_UDPProcess_h_1_1 + 1)
;	.line	941; TCPIP_Stack/UDP.c	h.SourcePort        = swaps(h.SourcePort);
	MOVF	(_UDPProcess_h_1_1 + 1), W, B
	MOVWF	POSTDEC1
	BANKSEL	_UDPProcess_h_1_1
	MOVF	_UDPProcess_h_1_1, W, B
	MOVWF	POSTDEC1
	CALL	_swaps
	MOVWF	r0x08
	MOVFF	PRODL, r0x09
	MOVLW	0x02
	ADDWF	FSR1L, F
	MOVF	r0x08, W
	BANKSEL	_UDPProcess_h_1_1
	MOVWF	_UDPProcess_h_1_1, B
	MOVF	r0x09, W
	BANKSEL	(_UDPProcess_h_1_1 + 1)
	MOVWF	(_UDPProcess_h_1_1 + 1), B
	BANKSEL	(_UDPProcess_h_1_1 + 3)
;	.line	942; TCPIP_Stack/UDP.c	h.DestinationPort   = swaps(h.DestinationPort);
	MOVF	(_UDPProcess_h_1_1 + 3), W, B
	MOVWF	POSTDEC1
	BANKSEL	(_UDPProcess_h_1_1 + 2)
	MOVF	(_UDPProcess_h_1_1 + 2), W, B
	MOVWF	POSTDEC1
	CALL	_swaps
	MOVWF	r0x08
	MOVFF	PRODL, r0x09
	MOVLW	0x02
	ADDWF	FSR1L, F
	MOVF	r0x08, W
	BANKSEL	(_UDPProcess_h_1_1 + 2)
	MOVWF	(_UDPProcess_h_1_1 + 2), B
	MOVF	r0x09, W
	BANKSEL	(_UDPProcess_h_1_1 + 3)
	MOVWF	(_UDPProcess_h_1_1 + 3), B
	BANKSEL	(_UDPProcess_h_1_1 + 5)
;	.line	943; TCPIP_Stack/UDP.c	h.Length            = swaps(h.Length) - sizeof(UDP_HEADER);
	MOVF	(_UDPProcess_h_1_1 + 5), W, B
	MOVWF	POSTDEC1
	BANKSEL	(_UDPProcess_h_1_1 + 4)
	MOVF	(_UDPProcess_h_1_1 + 4), W, B
	MOVWF	POSTDEC1
	CALL	_swaps
	MOVWF	r0x08
	MOVFF	PRODL, r0x09
	MOVLW	0x02
	ADDWF	FSR1L, F
	MOVLW	0xf8
	ADDWF	r0x08, F
	BTFSS	STATUS, 0
	DECF	r0x09, F
	MOVF	r0x08, W
	BANKSEL	(_UDPProcess_h_1_1 + 4)
	MOVWF	(_UDPProcess_h_1_1 + 4), B
	MOVF	r0x09, W
	BANKSEL	(_UDPProcess_h_1_1 + 5)
	MOVWF	(_UDPProcess_h_1_1 + 5), B
	BANKSEL	(_UDPProcess_h_1_1 + 6)
;	.line	946; TCPIP_Stack/UDP.c	if(h.Checksum)
	MOVF	(_UDPProcess_h_1_1 + 6), W, B
	BANKSEL	(_UDPProcess_h_1_1 + 7)
	IORWF	(_UDPProcess_h_1_1 + 7), W, B
	BTFSC	STATUS, 2
	BRA	_00279_DS_
;	.line	949; TCPIP_Stack/UDP.c	pseudoHeader.SourceAddress.Val	= remoteNode->IPAddr.Val;
	MOVFF	r0x00, FSR0L
	MOVFF	r0x01, PRODL
	MOVF	r0x02, W
	CALL	__gptrget4
	MOVWF	r0x08
	MOVFF	PRODL, r0x09
	MOVFF	PRODH, r0x0a
	MOVFF	FSR0L, r0x0b
	MOVF	r0x08, W
	BANKSEL	_UDPProcess_pseudoHeader_1_1
	MOVWF	_UDPProcess_pseudoHeader_1_1, B
	MOVF	r0x09, W
	BANKSEL	(_UDPProcess_pseudoHeader_1_1 + 1)
	MOVWF	(_UDPProcess_pseudoHeader_1_1 + 1), B
	MOVF	r0x0a, W
	BANKSEL	(_UDPProcess_pseudoHeader_1_1 + 2)
	MOVWF	(_UDPProcess_pseudoHeader_1_1 + 2), B
	MOVF	r0x0b, W
	BANKSEL	(_UDPProcess_pseudoHeader_1_1 + 3)
	MOVWF	(_UDPProcess_pseudoHeader_1_1 + 3), B
;	.line	950; TCPIP_Stack/UDP.c	pseudoHeader.DestAddress.Val	= localIP->Val;
	MOVFF	r0x03, FSR0L
	MOVFF	r0x04, PRODL
	MOVF	r0x05, W
	CALL	__gptrget4
	MOVWF	r0x08
	MOVFF	PRODL, r0x09
	MOVFF	PRODH, r0x0a
	MOVFF	FSR0L, r0x0b
	MOVF	r0x08, W
	BANKSEL	(_UDPProcess_pseudoHeader_1_1 + 4)
	MOVWF	(_UDPProcess_pseudoHeader_1_1 + 4), B
	MOVF	r0x09, W
	BANKSEL	(_UDPProcess_pseudoHeader_1_1 + 5)
	MOVWF	(_UDPProcess_pseudoHeader_1_1 + 5), B
	MOVF	r0x0a, W
	BANKSEL	(_UDPProcess_pseudoHeader_1_1 + 6)
	MOVWF	(_UDPProcess_pseudoHeader_1_1 + 6), B
	MOVF	r0x0b, W
	BANKSEL	(_UDPProcess_pseudoHeader_1_1 + 7)
	MOVWF	(_UDPProcess_pseudoHeader_1_1 + 7), B
	BANKSEL	(_UDPProcess_pseudoHeader_1_1 + 8)
;	.line	951; TCPIP_Stack/UDP.c	pseudoHeader.Zero		= 0x0;
	CLRF	(_UDPProcess_pseudoHeader_1_1 + 8), B
;	.line	952; TCPIP_Stack/UDP.c	pseudoHeader.Protocol		= IP_PROT_UDP;
	MOVLW	0x11
	BANKSEL	(_UDPProcess_pseudoHeader_1_1 + 9)
	MOVWF	(_UDPProcess_pseudoHeader_1_1 + 9), B
;	.line	953; TCPIP_Stack/UDP.c	pseudoHeader.Length		= len;
	MOVF	r0x06, W
	BANKSEL	(_UDPProcess_pseudoHeader_1_1 + 10)
	MOVWF	(_UDPProcess_pseudoHeader_1_1 + 10), B
	MOVF	r0x07, W
	BANKSEL	(_UDPProcess_pseudoHeader_1_1 + 11)
	MOVWF	(_UDPProcess_pseudoHeader_1_1 + 11), B
;	.line	955; TCPIP_Stack/UDP.c	SwapPseudoHeader(pseudoHeader);
	MOVF	r0x07, W
	MOVWF	POSTDEC1
	MOVF	r0x06, W
	MOVWF	POSTDEC1
	CALL	_swaps
	MOVWF	r0x08
	MOVFF	PRODL, r0x09
	MOVLW	0x02
	ADDWF	FSR1L, F
	MOVF	r0x08, W
	BANKSEL	(_UDPProcess_pseudoHeader_1_1 + 10)
	MOVWF	(_UDPProcess_pseudoHeader_1_1 + 10), B
	MOVF	r0x09, W
	BANKSEL	(_UDPProcess_pseudoHeader_1_1 + 11)
	MOVWF	(_UDPProcess_pseudoHeader_1_1 + 11), B
;	.line	957; TCPIP_Stack/UDP.c	checksums.w[0] = ~CalcIPChecksum((BYTE*)&pseudoHeader,
	MOVLW	HIGH(_UDPProcess_pseudoHeader_1_1)
	MOVWF	r0x09
	MOVLW	LOW(_UDPProcess_pseudoHeader_1_1)
	MOVWF	r0x08
	MOVLW	0x80
	MOVWF	r0x0a
;	.line	958; TCPIP_Stack/UDP.c	sizeof(pseudoHeader));
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x0c
	MOVWF	POSTDEC1
	MOVF	r0x0a, W
	MOVWF	POSTDEC1
	MOVF	r0x09, W
	MOVWF	POSTDEC1
	MOVF	r0x08, W
	MOVWF	POSTDEC1
	CALL	_CalcIPChecksum
	MOVWF	r0x08
	MOVFF	PRODL, r0x09
	MOVLW	0x05
	ADDWF	FSR1L, F
	COMF	r0x08, F
	COMF	r0x09, F
	MOVF	r0x08, W
	BANKSEL	_UDPProcess_checksums_1_1
	MOVWF	_UDPProcess_checksums_1_1, B
	MOVF	r0x09, W
	BANKSEL	(_UDPProcess_checksums_1_1 + 1)
	MOVWF	(_UDPProcess_checksums_1_1 + 1), B
;	.line	963; TCPIP_Stack/UDP.c	IPSetRxBuffer(0);
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	CALL	_IPSetRxBuffer
	MOVLW	0x02
	ADDWF	FSR1L, F
;	.line	964; TCPIP_Stack/UDP.c	checksums.w[1] = CalcIPBufferChecksum(len);
	MOVF	r0x07, W
	MOVWF	POSTDEC1
	MOVF	r0x06, W
	MOVWF	POSTDEC1
	CALL	_CalcIPBufferChecksum
	MOVWF	r0x06
	MOVFF	PRODL, r0x07
	MOVLW	0x02
	ADDWF	FSR1L, F
	MOVF	r0x06, W
	BANKSEL	(_UDPProcess_checksums_1_1 + 2)
	MOVWF	(_UDPProcess_checksums_1_1 + 2), B
	MOVF	r0x07, W
	BANKSEL	(_UDPProcess_checksums_1_1 + 3)
	MOVWF	(_UDPProcess_checksums_1_1 + 3), B
	BANKSEL	_UDPProcess_checksums_1_1
;	.line	966; TCPIP_Stack/UDP.c	if(checksums.w[0] != checksums.w[1])
	MOVF	_UDPProcess_checksums_1_1, W, B
	BANKSEL	(_UDPProcess_checksums_1_1 + 2)
	XORWF	(_UDPProcess_checksums_1_1 + 2), W, B
	BNZ	_00289_DS_
	BANKSEL	(_UDPProcess_checksums_1_1 + 1)
	MOVF	(_UDPProcess_checksums_1_1 + 1), W, B
	BANKSEL	(_UDPProcess_checksums_1_1 + 3)
	XORWF	(_UDPProcess_checksums_1_1 + 3), W, B
	BZ	_00279_DS_
_00289_DS_:
;	.line	968; TCPIP_Stack/UDP.c	MACDiscardRx();
	CALL	_MACDiscardRx
;	.line	969; TCPIP_Stack/UDP.c	return FALSE;
	CLRF	WREG
	BRA	_00283_DS_
_00279_DS_:
;	.line	973; TCPIP_Stack/UDP.c	s = FindMatchingSocket(&h, remoteNode, localIP);
	MOVLW	HIGH(_UDPProcess_h_1_1)
	MOVWF	r0x07
	MOVLW	LOW(_UDPProcess_h_1_1)
	MOVWF	r0x06
	MOVLW	0x80
	MOVWF	r0x08
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
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	MOVF	r0x08, W
	MOVWF	POSTDEC1
	MOVF	r0x07, W
	MOVWF	POSTDEC1
	MOVF	r0x06, W
	MOVWF	POSTDEC1
	CALL	_FindMatchingSocket
	MOVWF	r0x00
	MOVLW	0x09
	ADDWF	FSR1L, F
;	.line	974; TCPIP_Stack/UDP.c	if(s == INVALID_UDP_SOCKET)
	MOVFF	r0x00, r0x01
	CLRF	r0x02
	MOVF	r0x01, W
	XORLW	0xff
	BNZ	_00290_DS_
	MOVF	r0x02, W
	BZ	_00291_DS_
_00290_DS_:
	BRA	_00281_DS_
_00291_DS_:
;	.line	978; TCPIP_Stack/UDP.c	MACDiscardRx();
	CALL	_MACDiscardRx
;	.line	979; TCPIP_Stack/UDP.c	return FALSE;
	CLRF	WREG
	BRA	_00283_DS_
_00281_DS_:
;	.line	983; TCPIP_Stack/UDP.c	SocketWithRxData = s;
	MOVFF	r0x00, _SocketWithRxData
;	.line	984; TCPIP_Stack/UDP.c	UDPRxCount = h.Length;
	MOVFF	(_UDPProcess_h_1_1 + 4), _UDPRxCount
	MOVFF	(_UDPProcess_h_1_1 + 5), (_UDPRxCount + 1)
	BANKSEL	_Flags
;	.line	985; TCPIP_Stack/UDP.c	Flags.bFirstRead = 1;
	BSF	_Flags, 0, B
	BANKSEL	_Flags
;	.line	986; TCPIP_Stack/UDP.c	Flags.bWasDiscarded = 0;
	BCF	_Flags, 1, B
;	.line	990; TCPIP_Stack/UDP.c	return TRUE;
	MOVLW	0x01
_00283_DS_:
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
S_UDP__UDPDiscard	code
_UDPDiscard:
;	.line	886; TCPIP_Stack/UDP.c	void UDPDiscard(void)
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	BANKSEL	_Flags
;	.line	888; TCPIP_Stack/UDP.c	if(!Flags.bWasDiscarded)
	BTFSC	_Flags, 1, B
	BRA	_00271_DS_
;	.line	890; TCPIP_Stack/UDP.c	MACDiscardRx();
	CALL	_MACDiscardRx
	BANKSEL	_UDPRxCount
;	.line	891; TCPIP_Stack/UDP.c	UDPRxCount = 0;
	CLRF	_UDPRxCount, B
	BANKSEL	(_UDPRxCount + 1)
	CLRF	(_UDPRxCount + 1), B
;	.line	892; TCPIP_Stack/UDP.c	SocketWithRxData = INVALID_UDP_SOCKET;
	MOVLW	0xff
	BANKSEL	_SocketWithRxData
	MOVWF	_SocketWithRxData, B
	BANKSEL	_Flags
;	.line	893; TCPIP_Stack/UDP.c	Flags.bWasDiscarded = 1;
	BSF	_Flags, 1, B
_00271_DS_:
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_UDP__UDPGetArray	code
_UDPGetArray:
;	.line	843; TCPIP_Stack/UDP.c	WORD UDPGetArray(BYTE *cData, WORD wDataLen)
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVFF	r0x02, POSTDEC1
	MOVFF	r0x03, POSTDEC1
	MOVFF	r0x04, POSTDEC1
	MOVFF	r0x05, POSTDEC1
	MOVFF	r0x06, POSTDEC1
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
	BANKSEL	(_UDPRxCount + 1)
;	.line	848; TCPIP_Stack/UDP.c	if((wGetOffset >= UDPRxCount) || (SocketWithRxData != activeUDPSocket))
	MOVF	(_UDPRxCount + 1), W, B
	BANKSEL	(_wGetOffset + 1)
	SUBWF	(_wGetOffset + 1), W, B
	BNZ	_00261_DS_
	BANKSEL	_UDPRxCount
	MOVF	_UDPRxCount, W, B
	BANKSEL	_wGetOffset
	SUBWF	_wGetOffset, W, B
_00261_DS_:
	BC	_00252_DS_
	BANKSEL	_SocketWithRxData
	MOVF	_SocketWithRxData, W, B
	BANKSEL	_activeUDPSocket
	XORWF	_activeUDPSocket, W, B
	BZ	_00253_DS_
_00252_DS_:
;	.line	849; TCPIP_Stack/UDP.c	return 0;
	CLRF	PRODL
	CLRF	WREG
	BRA	_00257_DS_
_00253_DS_:
	BANKSEL	_wGetOffset
;	.line	852; TCPIP_Stack/UDP.c	wBytesAvailable = UDPRxCount - wGetOffset;
	MOVF	_wGetOffset, W, B
	BANKSEL	_UDPRxCount
	SUBWF	_UDPRxCount, W, B
	MOVWF	r0x05
	BANKSEL	(_wGetOffset + 1)
	MOVF	(_wGetOffset + 1), W, B
	BANKSEL	(_UDPRxCount + 1)
	SUBWFB	(_UDPRxCount + 1), W, B
	MOVWF	r0x06
;	.line	853; TCPIP_Stack/UDP.c	if(wBytesAvailable < wDataLen) wDataLen = wBytesAvailable;
	MOVF	r0x04, W
	SUBWF	r0x06, W
	BNZ	_00264_DS_
	MOVF	r0x03, W
	SUBWF	r0x05, W
_00264_DS_:
	BC	_00256_DS_
	MOVFF	r0x05, r0x03
	MOVFF	r0x06, r0x04
_00256_DS_:
;	.line	855; TCPIP_Stack/UDP.c	wDataLen = MACGetArray(cData, wDataLen);
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_MACGetArray
	MOVWF	r0x03
	MOVFF	PRODL, r0x04
	MOVLW	0x05
	ADDWF	FSR1L, F
;	.line	856; TCPIP_Stack/UDP.c	wGetOffset += wDataLen;
	MOVF	r0x03, W
	BANKSEL	_wGetOffset
	ADDWF	_wGetOffset, F, B
	MOVF	r0x04, W
	BANKSEL	(_wGetOffset + 1)
	ADDWFC	(_wGetOffset + 1), F, B
;	.line	858; TCPIP_Stack/UDP.c	return wDataLen;
	MOVFF	r0x04, PRODL
	MOVF	r0x03, W
_00257_DS_:
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
S_UDP__UDPGet	code
_UDPGet:
;	.line	805; TCPIP_Stack/UDP.c	BOOL UDPGet(BYTE *v)
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
	BANKSEL	(_UDPRxCount + 1)
;	.line	808; TCPIP_Stack/UDP.c	if((wGetOffset >= UDPRxCount) || (SocketWithRxData != activeUDPSocket))
	MOVF	(_UDPRxCount + 1), W, B
	BANKSEL	(_wGetOffset + 1)
	SUBWF	(_wGetOffset + 1), W, B
	BNZ	_00245_DS_
	BANKSEL	_UDPRxCount
	MOVF	_UDPRxCount, W, B
	BANKSEL	_wGetOffset
	SUBWF	_wGetOffset, W, B
_00245_DS_:
	BC	_00239_DS_
	BANKSEL	_SocketWithRxData
	MOVF	_SocketWithRxData, W, B
	BANKSEL	_activeUDPSocket
	XORWF	_activeUDPSocket, W, B
	BZ	_00240_DS_
_00239_DS_:
;	.line	809; TCPIP_Stack/UDP.c	return FALSE;
	CLRF	WREG
	BRA	_00242_DS_
_00240_DS_:
;	.line	811; TCPIP_Stack/UDP.c	*v = MACGet();
	CALL	_MACGet
	MOVWF	r0x03
	MOVFF	r0x03, POSTDEC1
	MOVFF	r0x00, FSR0L
	MOVFF	r0x01, PRODL
	MOVF	r0x02, W
	CALL	__gptrput1
	BANKSEL	_wGetOffset
;	.line	812; TCPIP_Stack/UDP.c	wGetOffset++;
	INCF	_wGetOffset, F, B
	BNC	_10296_DS_
	BANKSEL	(_wGetOffset + 1)
	INCF	(_wGetOffset + 1), F, B
_10296_DS_:
;	.line	814; TCPIP_Stack/UDP.c	return TRUE;
	MOVLW	0x01
_00242_DS_:
	MOVFF	PREINC1, r0x03
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_UDP__UDPIsGetReady	code
_UDPIsGetReady:
;	.line	766; TCPIP_Stack/UDP.c	WORD UDPIsGetReady(UDP_SOCKET s)
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, r0x00
;	.line	768; TCPIP_Stack/UDP.c	activeUDPSocket = s;
	MOVFF	r0x00, _activeUDPSocket
	BANKSEL	_SocketWithRxData
;	.line	769; TCPIP_Stack/UDP.c	if(SocketWithRxData != s) return 0;
	MOVF	_SocketWithRxData, W, B
	XORWF	r0x00, W
	BZ	_00226_DS_
	CLRF	PRODL
	CLRF	WREG
	BRA	_00229_DS_
_00226_DS_:
	BANKSEL	_Flags
;	.line	773; TCPIP_Stack/UDP.c	if(Flags.bFirstRead)
	BTFSS	_Flags, 0, B
	BRA	_00228_DS_
	BANKSEL	_Flags
;	.line	775; TCPIP_Stack/UDP.c	Flags.bFirstRead = 0;
	BCF	_Flags, 0, B
;	.line	776; TCPIP_Stack/UDP.c	UDPSetRxBuffer(0);
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	CALL	_UDPSetRxBuffer
	MOVLW	0x02
	ADDWF	FSR1L, F
_00228_DS_:
	BANKSEL	_wGetOffset
;	.line	779; TCPIP_Stack/UDP.c	return UDPRxCount - wGetOffset;
	MOVF	_wGetOffset, W, B
	BANKSEL	_UDPRxCount
	SUBWF	_UDPRxCount, W, B
	MOVWF	r0x00
	BANKSEL	(_wGetOffset + 1)
	MOVF	(_wGetOffset + 1), W, B
	BANKSEL	(_UDPRxCount + 1)
	SUBWFB	(_UDPRxCount + 1), W, B
	MOVWF	r0x01
	MOVFF	r0x01, PRODL
	MOVF	r0x00, W
_00229_DS_:
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_UDP__UDPFlush	code
_UDPFlush:
;	.line	671; TCPIP_Stack/UDP.c	void UDPFlush(void)
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
; ;multiply lit val:0x0e by variable _activeUDPSocket and store in r0x00
; ;Unrolled 8 X 8 multiplication
; ;FIXME: the function does not support result==WREG
	BANKSEL	_activeUDPSocket
;	.line	679; TCPIP_Stack/UDP.c	p = &UDPSocketInfo[activeUDPSocket];
	MOVF	_activeUDPSocket, W, B
	MULLW	0x0e
	MOVFF	PRODL, r0x00
	CLRF	r0x01
	MOVLW	LOW(_UDPSocketInfo)
	ADDWF	r0x00, F
	MOVLW	HIGH(_UDPSocketInfo)
	ADDWFC	r0x01, F
	MOVF	r0x01, W
	MOVWF	r0x01
	MOVF	r0x00, W
	MOVWF	r0x00
	MOVLW	0x80
	MOVWF	r0x02
	BANKSEL	_UDPTxCount
;	.line	681; TCPIP_Stack/UDP.c	wUDPLength = UDPTxCount + sizeof(UDP_HEADER);
	MOVF	_UDPTxCount, W, B
	ADDLW	0x08
	MOVWF	r0x03
	MOVLW	0x00
	BANKSEL	(_UDPTxCount + 1)
	ADDWFC	(_UDPTxCount + 1), W, B
	MOVWF	r0x04
;	.line	684; TCPIP_Stack/UDP.c	h.SourcePort = swaps(p->localPort);
	MOVF	r0x00, W
	ADDLW	0x0c
	MOVWF	r0x05
	MOVLW	0x00
	ADDWFC	r0x01, W
	MOVWF	r0x06
	MOVLW	0x00
	ADDWFC	r0x02, W
	MOVWF	r0x07
	MOVFF	r0x05, FSR0L
	MOVFF	r0x06, PRODL
	MOVF	r0x07, W
	CALL	__gptrget2
	MOVWF	r0x05
	MOVFF	PRODL, r0x06
	MOVF	r0x06, W
	MOVWF	POSTDEC1
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	CALL	_swaps
	MOVWF	r0x05
	MOVFF	PRODL, r0x06
	MOVLW	0x02
	ADDWF	FSR1L, F
	MOVF	r0x05, W
	BANKSEL	_UDPFlush_h_1_1
	MOVWF	_UDPFlush_h_1_1, B
	MOVF	r0x06, W
	BANKSEL	(_UDPFlush_h_1_1 + 1)
	MOVWF	(_UDPFlush_h_1_1 + 1), B
;	.line	685; TCPIP_Stack/UDP.c	h.DestinationPort = swaps(p->remotePort);
	MOVF	r0x00, W
	ADDLW	0x0a
	MOVWF	r0x05
	MOVLW	0x00
	ADDWFC	r0x01, W
	MOVWF	r0x06
	MOVLW	0x00
	ADDWFC	r0x02, W
	MOVWF	r0x07
	MOVFF	r0x05, FSR0L
	MOVFF	r0x06, PRODL
	MOVF	r0x07, W
	CALL	__gptrget2
	MOVWF	r0x05
	MOVFF	PRODL, r0x06
	MOVF	r0x06, W
	MOVWF	POSTDEC1
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	CALL	_swaps
	MOVWF	r0x05
	MOVFF	PRODL, r0x06
	MOVLW	0x02
	ADDWF	FSR1L, F
	MOVF	r0x05, W
	BANKSEL	(_UDPFlush_h_1_1 + 2)
	MOVWF	(_UDPFlush_h_1_1 + 2), B
	MOVF	r0x06, W
	BANKSEL	(_UDPFlush_h_1_1 + 3)
	MOVWF	(_UDPFlush_h_1_1 + 3), B
;	.line	686; TCPIP_Stack/UDP.c	h.Length = swaps(wUDPLength);
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	CALL	_swaps
	MOVWF	r0x05
	MOVFF	PRODL, r0x06
	MOVLW	0x02
	ADDWF	FSR1L, F
	MOVF	r0x05, W
	BANKSEL	(_UDPFlush_h_1_1 + 4)
	MOVWF	(_UDPFlush_h_1_1 + 4), B
	MOVF	r0x06, W
	BANKSEL	(_UDPFlush_h_1_1 + 5)
	MOVWF	(_UDPFlush_h_1_1 + 5), B
	BANKSEL	(_UDPFlush_h_1_1 + 6)
;	.line	687; TCPIP_Stack/UDP.c	h.Checksum = 0x0000;
	CLRF	(_UDPFlush_h_1_1 + 6), B
	BANKSEL	(_UDPFlush_h_1_1 + 7)
	CLRF	(_UDPFlush_h_1_1 + 7), B
	BANKSEL	_AppConfig
;	.line	695; TCPIP_Stack/UDP.c	pseudoHeader.SourceAddress.Val = AppConfig.MyIPAddr.Val;
	MOVF	_AppConfig, W, B
	BANKSEL	_UDPFlush_pseudoHeader_2_2
	MOVWF	_UDPFlush_pseudoHeader_2_2, B
	BANKSEL	(_AppConfig + 1)
	MOVF	(_AppConfig + 1), W, B
	BANKSEL	(_UDPFlush_pseudoHeader_2_2 + 1)
	MOVWF	(_UDPFlush_pseudoHeader_2_2 + 1), B
	BANKSEL	(_AppConfig + 2)
	MOVF	(_AppConfig + 2), W, B
	BANKSEL	(_UDPFlush_pseudoHeader_2_2 + 2)
	MOVWF	(_UDPFlush_pseudoHeader_2_2 + 2), B
	BANKSEL	(_AppConfig + 3)
	MOVF	(_AppConfig + 3), W, B
	BANKSEL	(_UDPFlush_pseudoHeader_2_2 + 3)
	MOVWF	(_UDPFlush_pseudoHeader_2_2 + 3), B
;	.line	696; TCPIP_Stack/UDP.c	pseudoHeader.DestAddress.Val = p->remoteNode.IPAddr.Val;
	MOVFF	r0x00, FSR0L
	MOVFF	r0x01, PRODL
	MOVF	r0x02, W
	CALL	__gptrget4
	MOVWF	r0x05
	MOVFF	PRODL, r0x06
	MOVFF	PRODH, r0x07
	MOVFF	FSR0L, r0x08
	MOVF	r0x05, W
	BANKSEL	(_UDPFlush_pseudoHeader_2_2 + 4)
	MOVWF	(_UDPFlush_pseudoHeader_2_2 + 4), B
	MOVF	r0x06, W
	BANKSEL	(_UDPFlush_pseudoHeader_2_2 + 5)
	MOVWF	(_UDPFlush_pseudoHeader_2_2 + 5), B
	MOVF	r0x07, W
	BANKSEL	(_UDPFlush_pseudoHeader_2_2 + 6)
	MOVWF	(_UDPFlush_pseudoHeader_2_2 + 6), B
	MOVF	r0x08, W
	BANKSEL	(_UDPFlush_pseudoHeader_2_2 + 7)
	MOVWF	(_UDPFlush_pseudoHeader_2_2 + 7), B
	BANKSEL	(_UDPFlush_pseudoHeader_2_2 + 8)
;	.line	697; TCPIP_Stack/UDP.c	pseudoHeader.Zero = 0x0;
	CLRF	(_UDPFlush_pseudoHeader_2_2 + 8), B
;	.line	698; TCPIP_Stack/UDP.c	pseudoHeader.Protocol = IP_PROT_UDP;
	MOVLW	0x11
	BANKSEL	(_UDPFlush_pseudoHeader_2_2 + 9)
	MOVWF	(_UDPFlush_pseudoHeader_2_2 + 9), B
;	.line	699; TCPIP_Stack/UDP.c	pseudoHeader.Length = wUDPLength;
	MOVF	r0x03, W
	BANKSEL	(_UDPFlush_pseudoHeader_2_2 + 10)
	MOVWF	(_UDPFlush_pseudoHeader_2_2 + 10), B
	MOVF	r0x04, W
	BANKSEL	(_UDPFlush_pseudoHeader_2_2 + 11)
	MOVWF	(_UDPFlush_pseudoHeader_2_2 + 11), B
;	.line	700; TCPIP_Stack/UDP.c	SwapPseudoHeader(pseudoHeader);
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	CALL	_swaps
	MOVWF	r0x05
	MOVFF	PRODL, r0x06
	MOVLW	0x02
	ADDWF	FSR1L, F
	MOVF	r0x05, W
	BANKSEL	(_UDPFlush_pseudoHeader_2_2 + 10)
	MOVWF	(_UDPFlush_pseudoHeader_2_2 + 10), B
	MOVF	r0x06, W
	BANKSEL	(_UDPFlush_pseudoHeader_2_2 + 11)
	MOVWF	(_UDPFlush_pseudoHeader_2_2 + 11), B
;	.line	701; TCPIP_Stack/UDP.c	h.Checksum = ~CalcIPChecksum((BYTE*)&pseudoHeader, 
	MOVLW	HIGH(_UDPFlush_pseudoHeader_2_2)
	MOVWF	r0x06
	MOVLW	LOW(_UDPFlush_pseudoHeader_2_2)
	MOVWF	r0x05
	MOVLW	0x80
	MOVWF	r0x07
;	.line	702; TCPIP_Stack/UDP.c	sizeof(pseudoHeader));
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x0c
	MOVWF	POSTDEC1
	MOVF	r0x07, W
	MOVWF	POSTDEC1
	MOVF	r0x06, W
	MOVWF	POSTDEC1
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	CALL	_CalcIPChecksum
	MOVWF	r0x05
	MOVFF	PRODL, r0x06
	MOVLW	0x05
	ADDWF	FSR1L, F
	COMF	r0x05, F
	COMF	r0x06, F
	MOVF	r0x05, W
	BANKSEL	(_UDPFlush_h_1_1 + 6)
	MOVWF	(_UDPFlush_h_1_1 + 6), B
	MOVF	r0x06, W
	BANKSEL	(_UDPFlush_h_1_1 + 7)
	MOVWF	(_UDPFlush_h_1_1 + 7), B
;	.line	708; TCPIP_Stack/UDP.c	MACSetWritePtr(BASE_TX_ADDR + sizeof(ETHER_HEADER));
	MOVLW	0x1a
	MOVWF	POSTDEC1
	MOVLW	0x19
	MOVWF	POSTDEC1
	CALL	_MACSetWritePtr
	MOVLW	0x02
	ADDWF	FSR1L, F
;	.line	711; TCPIP_Stack/UDP.c	IPPutHeader(&p->remoteNode, IP_PROT_UDP, wUDPLength);
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVLW	0x11
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_IPPutHeader
	MOVLW	0x06
	ADDWF	FSR1L, F
;	.line	714; TCPIP_Stack/UDP.c	MACPutArray((BYTE*)&h, sizeof(h));
	MOVLW	HIGH(_UDPFlush_h_1_1)
	MOVWF	r0x01
	MOVLW	LOW(_UDPFlush_h_1_1)
	MOVWF	r0x00
	MOVLW	0x80
	MOVWF	r0x02
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x08
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
;	.line	720; TCPIP_Stack/UDP.c	sizeof(IP_HEADER));
	MOVLW	0x1a
	MOVWF	POSTDEC1
	MOVLW	0x2d
	MOVWF	POSTDEC1
	CALL	_MACSetReadPtr
	MOVWF	r0x00
	MOVFF	PRODL, r0x01
	MOVLW	0x02
	ADDWF	FSR1L, F
;	.line	721; TCPIP_Stack/UDP.c	wChecksum = CalcIPBufferChecksum(wUDPLength);
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	CALL	_CalcIPBufferChecksum
	BANKSEL	_UDPFlush_wChecksum_1_1
	MOVWF	_UDPFlush_wChecksum_1_1, B
	MOVFF	PRODL, (_UDPFlush_wChecksum_1_1 + 1)
	MOVLW	0x02
	ADDWF	FSR1L, F
;	.line	722; TCPIP_Stack/UDP.c	MACSetReadPtr(wReadPtrSave);
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_MACSetReadPtr
	MOVLW	0x02
	ADDWF	FSR1L, F
;	.line	724; TCPIP_Stack/UDP.c	+ 6);    // 6 is the offset to the Checksum field in UDP_HEADER
	MOVLW	0x1a
	MOVWF	POSTDEC1
	MOVLW	0x33
	MOVWF	POSTDEC1
	CALL	_MACSetWritePtr
	MOVLW	0x02
	ADDWF	FSR1L, F
;	.line	725; TCPIP_Stack/UDP.c	MACPutArray((BYTE*)&wChecksum, sizeof(wChecksum));
	MOVLW	HIGH(_UDPFlush_wChecksum_1_1)
	MOVWF	r0x01
	MOVLW	LOW(_UDPFlush_wChecksum_1_1)
	MOVWF	r0x00
	MOVLW	0x80
	MOVWF	r0x02
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x02
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
;	.line	730; TCPIP_Stack/UDP.c	MACFlush();
	CALL	_MACFlush
	BANKSEL	_UDPTxCount
;	.line	733; TCPIP_Stack/UDP.c	UDPTxCount = 0;
	CLRF	_UDPTxCount, B
	BANKSEL	(_UDPTxCount + 1)
	CLRF	(_UDPTxCount + 1), B
;	.line	734; TCPIP_Stack/UDP.c	LastPutSocket = INVALID_UDP_SOCKET;
	MOVLW	0xff
	BANKSEL	_LastPutSocket
	MOVWF	_LastPutSocket, B
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
S_UDP__UDPPutString	code
_UDPPutString:
;	.line	601; TCPIP_Stack/UDP.c	BYTE* UDPPutString(BYTE *strData)
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVFF	r0x02, POSTDEC1
	MOVFF	r0x03, POSTDEC1
	MOVFF	r0x04, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, r0x00
	MOVLW	0x03
	MOVFF	PLUSW2, r0x01
	MOVLW	0x04
	MOVFF	PLUSW2, r0x02
;	.line	603; TCPIP_Stack/UDP.c	return strData + UDPPutArray(strData, strlen((char*)strData));
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_strlen
	MOVWF	r0x03
	MOVFF	PRODL, r0x04
	MOVLW	0x03
	ADDWF	FSR1L, F
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_UDPPutArray
	MOVWF	r0x03
	MOVFF	PRODL, r0x04
	MOVLW	0x05
	ADDWF	FSR1L, F
	MOVF	r0x03, W
	ADDWF	r0x00, F
	MOVF	r0x04, W
	ADDWFC	r0x01, F
	CLRF	WREG
	ADDWFC	r0x02, F
	MOVFF	r0x02, PRODH
	MOVFF	r0x01, PRODL
	MOVF	r0x00, W
	MOVFF	PREINC1, r0x04
	MOVFF	PREINC1, r0x03
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_UDP__UDPPutArray	code
_UDPPutArray:
;	.line	514; TCPIP_Stack/UDP.c	WORD UDPPutArray(BYTE *cData, WORD wDataLen)
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
;	.line	518; TCPIP_Stack/UDP.c	wTemp=(MAC_TX_BUFFER_SIZE-sizeof(IP_HEADER)-sizeof(UDP_HEADER))-wPutOffset;
	MOVFF	_wPutOffset, r0x05
	MOVFF	(_wPutOffset + 1), r0x06
	CLRF	r0x07
	CLRF	r0x08
	MOVF	r0x05, W
	SUBLW	0xc0
	MOVWF	r0x05
	MOVLW	0x05
	SUBFWB	r0x06, F
	MOVLW	0x00
	SUBFWB	r0x07, F
	MOVLW	0x00
	SUBFWB	r0x08, F
;	.line	519; TCPIP_Stack/UDP.c	if(wTemp < wDataLen) wDataLen = wTemp;
	MOVF	r0x04, W
	SUBWF	r0x06, W
	BNZ	_00209_DS_
	MOVF	r0x03, W
	SUBWF	r0x05, W
_00209_DS_:
	BC	_00202_DS_
	MOVFF	r0x05, r0x03
	MOVFF	r0x06, r0x04
_00202_DS_:
;	.line	521; TCPIP_Stack/UDP.c	wPutOffset += wDataLen;
	MOVF	r0x03, W
	BANKSEL	_wPutOffset
	ADDWF	_wPutOffset, F, B
	MOVF	r0x04, W
	BANKSEL	(_wPutOffset + 1)
	ADDWFC	(_wPutOffset + 1), F, B
	BANKSEL	(_wPutOffset + 1)
;	.line	522; TCPIP_Stack/UDP.c	if(wPutOffset > UDPTxCount) UDPTxCount = wPutOffset;
	MOVF	(_wPutOffset + 1), W, B
	BANKSEL	(_UDPTxCount + 1)
	SUBWF	(_UDPTxCount + 1), W, B
	BNZ	_00210_DS_
	BANKSEL	_wPutOffset
	MOVF	_wPutOffset, W, B
	BANKSEL	_UDPTxCount
	SUBWF	_UDPTxCount, W, B
_00210_DS_:
	BC	_00204_DS_
	MOVFF	_wPutOffset, _UDPTxCount
	MOVFF	(_wPutOffset + 1), (_UDPTxCount + 1)
_00204_DS_:
;	.line	525; TCPIP_Stack/UDP.c	MACPutArray(cData, wDataLen);
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	MOVF	r0x03, W
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
;	.line	527; TCPIP_Stack/UDP.c	return wDataLen;
	MOVFF	r0x04, PRODL
	MOVF	r0x03, W
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
S_UDP__UDPPut	code
_UDPPut:
;	.line	472; TCPIP_Stack/UDP.c	BOOL UDPPut(BYTE v)
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVFF	r0x02, POSTDEC1
	MOVFF	r0x03, POSTDEC1
	MOVFF	r0x04, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, r0x00
;	.line	475; TCPIP_Stack/UDP.c	if(wPutOffset >= (MAC_TX_BUFFER_SIZE-sizeof(IP_HEADER)-sizeof(UDP_HEADER)))
	MOVFF	_wPutOffset, r0x01
	MOVFF	(_wPutOffset + 1), r0x02
	CLRF	r0x03
	CLRF	r0x04
	MOVLW	0x00
	SUBWF	r0x04, W
	BNZ	_00195_DS_
	MOVLW	0x00
	SUBWF	r0x03, W
	BNZ	_00195_DS_
	MOVLW	0x05
	SUBWF	r0x02, W
	BNZ	_00195_DS_
	MOVLW	0xc0
	SUBWF	r0x01, W
_00195_DS_:
	BNC	_00188_DS_
;	.line	477; TCPIP_Stack/UDP.c	return FALSE;
	CLRF	WREG
	BRA	_00191_DS_
_00188_DS_:
;	.line	481; TCPIP_Stack/UDP.c	MACPut(v);
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_MACPut
	INCF	FSR1L, F
	BANKSEL	_wPutOffset
;	.line	482; TCPIP_Stack/UDP.c	wPutOffset++;
	INCF	_wPutOffset, F, B
	BNC	_20297_DS_
	BANKSEL	(_wPutOffset + 1)
	INCF	(_wPutOffset + 1), F, B
_20297_DS_:
	BANKSEL	(_wPutOffset + 1)
;	.line	483; TCPIP_Stack/UDP.c	if(wPutOffset > UDPTxCount)
	MOVF	(_wPutOffset + 1), W, B
	BANKSEL	(_UDPTxCount + 1)
	SUBWF	(_UDPTxCount + 1), W, B
	BNZ	_00196_DS_
	BANKSEL	_wPutOffset
	MOVF	_wPutOffset, W, B
	BANKSEL	_UDPTxCount
	SUBWF	_UDPTxCount, W, B
_00196_DS_:
	BC	_00190_DS_
;	.line	484; TCPIP_Stack/UDP.c	UDPTxCount = wPutOffset;
	MOVFF	_wPutOffset, _UDPTxCount
	MOVFF	(_wPutOffset + 1), (_UDPTxCount + 1)
_00190_DS_:
;	.line	486; TCPIP_Stack/UDP.c	return TRUE;
	MOVLW	0x01
_00191_DS_:
	MOVFF	PREINC1, r0x04
	MOVFF	PREINC1, r0x03
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_UDP__UDPIsPutReady	code
_UDPIsPutReady:
;	.line	434; TCPIP_Stack/UDP.c	WORD UDPIsPutReady(UDP_SOCKET s)
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVFF	r0x02, POSTDEC1
	MOVFF	r0x03, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, r0x00
;	.line	436; TCPIP_Stack/UDP.c	if(!MACIsTxReady())
	CALL	_MACIsTxReady
	MOVWF	r0x01
	MOVF	r0x01, W
	BNZ	_00174_DS_
;	.line	437; TCPIP_Stack/UDP.c	return 0;
	CLRF	PRODL
	CLRF	WREG
	BRA	_00177_DS_
_00174_DS_:
	BANKSEL	_LastPutSocket
;	.line	439; TCPIP_Stack/UDP.c	if(LastPutSocket != s)
	MOVF	_LastPutSocket, W, B
	XORWF	r0x00, W
	BZ	_00176_DS_
;	.line	441; TCPIP_Stack/UDP.c	LastPutSocket = s;
	MOVFF	r0x00, _LastPutSocket
	BANKSEL	_UDPTxCount
;	.line	442; TCPIP_Stack/UDP.c	UDPTxCount = 0;
	CLRF	_UDPTxCount, B
	BANKSEL	(_UDPTxCount + 1)
	CLRF	(_UDPTxCount + 1), B
;	.line	443; TCPIP_Stack/UDP.c	UDPSetTxBuffer(0);
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	CALL	_UDPSetTxBuffer
	MOVLW	0x02
	ADDWF	FSR1L, F
_00176_DS_:
;	.line	445; TCPIP_Stack/UDP.c	activeUDPSocket = s;
	MOVFF	r0x00, _activeUDPSocket
;	.line	447; TCPIP_Stack/UDP.c	return MAC_TX_BUFFER_SIZE-sizeof(IP_HEADER)-sizeof(UDP_HEADER)-UDPTxCount;
	MOVFF	_UDPTxCount, r0x00
	MOVFF	(_UDPTxCount + 1), r0x01
	CLRF	r0x02
	CLRF	r0x03
	MOVF	r0x00, W
	SUBLW	0xc0
	MOVWF	r0x00
	MOVLW	0x05
	SUBFWB	r0x01, F
	MOVLW	0x00
	SUBFWB	r0x02, F
	MOVLW	0x00
	SUBFWB	r0x03, F
	MOVFF	r0x01, PRODL
	MOVF	r0x00, W
_00177_DS_:
	MOVFF	PREINC1, r0x03
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_UDP__UDPSetRxBuffer	code
_UDPSetRxBuffer:
;	.line	400; TCPIP_Stack/UDP.c	void UDPSetRxBuffer(WORD wOffset)
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
;	.line	402; TCPIP_Stack/UDP.c	IPSetRxBuffer(wOffset+sizeof(UDP_HEADER));
	MOVF	r0x00, W
	ADDLW	0x08
	MOVWF	r0x02
	MOVLW	0x00
	ADDWFC	r0x01, W
	MOVWF	r0x03
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	CALL	_IPSetRxBuffer
	MOVLW	0x02
	ADDWF	FSR1L, F
;	.line	403; TCPIP_Stack/UDP.c	wGetOffset = wOffset;
	MOVFF	r0x00, _wGetOffset
	MOVFF	r0x01, (_wGetOffset + 1)
	MOVFF	PREINC1, r0x03
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_UDP__UDPSetTxBuffer	code
_UDPSetTxBuffer:
;	.line	370; TCPIP_Stack/UDP.c	void UDPSetTxBuffer(WORD wOffset)
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
;	.line	372; TCPIP_Stack/UDP.c	IPSetTxBuffer(wOffset+sizeof(UDP_HEADER));
	MOVFF	r0x00, r0x02
	MOVFF	r0x01, r0x03
	CLRF	r0x04
	CLRF	r0x05
	MOVLW	0x35
	ADDWF	r0x02, F
	MOVLW	0x1a
	ADDWFC	r0x03, F
	MOVLW	0x00
	ADDWFC	r0x04, F
	MOVLW	0x00
	ADDWFC	r0x05, F
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	CALL	_MACSetWritePtr
	MOVLW	0x02
	ADDWF	FSR1L, F
;	.line	373; TCPIP_Stack/UDP.c	wPutOffset = wOffset;
	MOVFF	r0x00, _wPutOffset
	MOVFF	r0x01, (_wPutOffset + 1)
	MOVFF	PREINC1, r0x05
	MOVFF	PREINC1, r0x04
	MOVFF	PREINC1, r0x03
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_UDP__UDPClose	code
_UDPClose:
;	.line	339; TCPIP_Stack/UDP.c	void UDPClose(UDP_SOCKET s)
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVFF	r0x02, POSTDEC1
	MOVFF	r0x03, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, r0x00
;	.line	341; TCPIP_Stack/UDP.c	if(s >= MAX_UDP_SOCKETS) return;
	MOVFF	r0x00, r0x01
	CLRF	r0x02
	MOVLW	0x00
	SUBWF	r0x02, W
	BNZ	_00158_DS_
	MOVLW	0x0a
	SUBWF	r0x01, W
_00158_DS_:
	BC	_00155_DS_
; ;multiply lit val:0x0e by variable r0x00 and store in r0x00
; ;Unrolled 8 X 8 multiplication
; ;FIXME: the function does not support result==WREG
;	.line	342; TCPIP_Stack/UDP.c	UDPSocketInfo[s].localPort = INVALID_UDP_PORT;
	MOVF	r0x00, W
	MULLW	0x0e
	MOVFF	PRODL, r0x00
	CLRF	r0x01
	MOVLW	LOW(_UDPSocketInfo)
	ADDWF	r0x00, F
	MOVLW	HIGH(_UDPSocketInfo)
	ADDWFC	r0x01, F
	MOVF	r0x00, W
	ADDLW	0x0c
	MOVWF	r0x02
	MOVLW	0x00
	ADDWFC	r0x01, W
	MOVWF	r0x03
	MOVFF	r0x02, FSR0L
	MOVFF	r0x03, FSR0H
	MOVLW	0x00
	MOVWF	POSTINC0
	MOVLW	0x00
	MOVWF	INDF0
;	.line	343; TCPIP_Stack/UDP.c	UDPSocketInfo[s].remoteNode.IPAddr.Val = 0x00000000;
	MOVFF	r0x00, FSR0L
	MOVFF	r0x01, FSR0H
	MOVLW	0x00
	MOVWF	POSTINC0
	MOVLW	0x00
	MOVWF	POSTINC0
	MOVLW	0x00
	MOVWF	POSTINC0
	MOVLW	0x00
	MOVWF	INDF0
_00155_DS_:
	MOVFF	PREINC1, r0x03
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_UDP__UDPOpen	code
_UDPOpen:
;	.line	258; TCPIP_Stack/UDP.c	UDP_SOCKET UDPOpen(UDP_PORT this_localPort,
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
;	.line	269; TCPIP_Stack/UDP.c	p = UDPSocketInfo; //pointer to the table of UDP sockets
	MOVLW	HIGH(_UDPSocketInfo)
	MOVWF	r0x08
	MOVLW	LOW(_UDPSocketInfo)
	MOVWF	r0x07
	MOVLW	0x80
	MOVWF	r0x09
;	.line	270; TCPIP_Stack/UDP.c	for ( s = 0; s < MAX_UDP_SOCKETS; s++ )
	CLRF	r0x0a
	MOVFF	r0x07, r0x0b
	MOVFF	r0x08, r0x0c
	MOVFF	r0x09, r0x0d
	CLRF	r0x0e
_00134_DS_:
	MOVFF	r0x0e, r0x0f
	CLRF	r0x10
	MOVLW	0x00
	SUBWF	r0x10, W
	BNZ	_00146_DS_
	MOVLW	0x0a
	SUBWF	r0x0f, W
_00146_DS_:
	BTFSC	STATUS, 0
	BRA	_00137_DS_
;	.line	272; TCPIP_Stack/UDP.c	if(p->localPort == INVALID_UDP_PORT)
	MOVF	r0x0b, W
	ADDLW	0x0c
	MOVWF	r0x0f
	MOVLW	0x00
	ADDWFC	r0x0c, W
	MOVWF	r0x10
	MOVLW	0x00
	ADDWFC	r0x0d, W
	MOVWF	r0x11
	MOVFF	r0x0f, FSR0L
	MOVFF	r0x10, PRODL
	MOVF	r0x11, W
	CALL	__gptrget2
	MOVWF	r0x12
	MOVFF	PRODL, r0x13
	MOVF	r0x12, W
	IORWF	r0x13, W
	BTFSS	STATUS, 2
	BRA	_00133_DS_
;	.line	274; TCPIP_Stack/UDP.c	p->localPort = this_localPort;	
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, PRODH
	MOVFF	r0x0f, FSR0L
	MOVFF	r0x10, PRODL
	MOVF	r0x11, W
	CALL	__gptrput2
;	.line	276; TCPIP_Stack/UDP.c	if(this_localPort == 0x0000u) //select any free port
	MOVF	r0x00, W
	IORWF	r0x01, W
	BNZ	_00128_DS_
;	.line	278; TCPIP_Stack/UDP.c	if(NextPort > LOCAL_UDP_PORT_END_NUMBER || 
	MOVLW	0x20
	BANKSEL	(_UDPOpen_NextPort_1_1 + 1)
	SUBWF	(_UDPOpen_NextPort_1_1 + 1), W, B
	BNZ	_00147_DS_
	MOVLW	0x01
	BANKSEL	_UDPOpen_NextPort_1_1
	SUBWF	_UDPOpen_NextPort_1_1, W, B
_00147_DS_:
	BC	_00124_DS_
;	.line	279; TCPIP_Stack/UDP.c	NextPort < LOCAL_UDP_PORT_START_NUMBER)
	MOVLW	0x10
	BANKSEL	(_UDPOpen_NextPort_1_1 + 1)
	SUBWF	(_UDPOpen_NextPort_1_1 + 1), W, B
	BNZ	_00148_DS_
	MOVLW	0x00
	BANKSEL	_UDPOpen_NextPort_1_1
	SUBWF	_UDPOpen_NextPort_1_1, W, B
_00148_DS_:
	BC	_00125_DS_
_00124_DS_:
	BANKSEL	_UDPOpen_NextPort_1_1
;	.line	280; TCPIP_Stack/UDP.c	NextPort = LOCAL_UDP_PORT_START_NUMBER;
	CLRF	_UDPOpen_NextPort_1_1, B
	MOVLW	0x10
	BANKSEL	(_UDPOpen_NextPort_1_1 + 1)
	MOVWF	(_UDPOpen_NextPort_1_1 + 1), B
_00125_DS_:
;	.line	282; TCPIP_Stack/UDP.c	p->localPort    = NextPort++;
	MOVF	r0x07, W
	ADDLW	0x0c
	MOVWF	r0x0f
	MOVLW	0x00
	ADDWFC	r0x08, W
	MOVWF	r0x10
	MOVLW	0x00
	ADDWFC	r0x09, W
	MOVWF	r0x11
	MOVFF	_UDPOpen_NextPort_1_1, r0x12
	MOVFF	(_UDPOpen_NextPort_1_1 + 1), r0x13
	BANKSEL	_UDPOpen_NextPort_1_1
	INCF	_UDPOpen_NextPort_1_1, F, B
	BNC	_30298_DS_
	BANKSEL	(_UDPOpen_NextPort_1_1 + 1)
	INCF	(_UDPOpen_NextPort_1_1 + 1), F, B
_30298_DS_:
	MOVFF	r0x12, POSTDEC1
	MOVFF	r0x13, PRODH
	MOVFF	r0x0f, FSR0L
	MOVFF	r0x10, PRODL
	MOVF	r0x11, W
	CALL	__gptrput2
_00128_DS_:
;	.line	286; TCPIP_Stack/UDP.c	if(this_remoteNode)
	MOVF	r0x02, W
	IORWF	r0x03, W
	IORWF	r0x04, W
	BZ	_00130_DS_
;	.line	289; TCPIP_Stack/UDP.c	sizeof(p->remoteNode));
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x0a
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x09, W
	MOVWF	POSTDEC1
	MOVF	r0x08, W
	MOVWF	POSTDEC1
	MOVF	r0x07, W
	MOVWF	POSTDEC1
	CALL	_memcpy
	MOVLW	0x08
	ADDWF	FSR1L, F
	BRA	_00131_DS_
_00130_DS_:
;	.line	294; TCPIP_Stack/UDP.c	memset((void*)&(p->remoteNode), 0xFF, sizeof(p->remoteNode));
	MOVFF	r0x07, r0x0f
	MOVFF	r0x08, r0x10
	MOVFF	r0x09, r0x11
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x0a
	MOVWF	POSTDEC1
	MOVLW	0xff
	MOVWF	POSTDEC1
	MOVF	r0x10, W
	MOVWF	POSTDEC1
	MOVF	r0x0f, W
	MOVWF	POSTDEC1
	CALL	_memset
	MOVLW	0x05
	ADDWF	FSR1L, F
_00131_DS_:
;	.line	297; TCPIP_Stack/UDP.c	p->remotePort = this_remotePort;
	MOVF	r0x07, W
	ADDLW	0x0a
	MOVWF	r0x0f
	MOVLW	0x00
	ADDWFC	r0x08, W
	MOVWF	r0x10
	MOVLW	0x00
	ADDWFC	r0x09, W
	MOVWF	r0x11
	MOVFF	r0x05, POSTDEC1
	MOVFF	r0x06, PRODH
	MOVFF	r0x0f, FSR0L
	MOVFF	r0x10, PRODL
	MOVF	r0x11, W
	CALL	__gptrput2
;	.line	302; TCPIP_Stack/UDP.c	activeUDPSocket = s;
	MOVFF	r0x0a, _activeUDPSocket
;	.line	303; TCPIP_Stack/UDP.c	return s;
	MOVF	r0x0a, W
	BRA	_00138_DS_
_00133_DS_:
;	.line	305; TCPIP_Stack/UDP.c	p++;
	MOVLW	0x0e
	ADDWF	r0x0b, F
	MOVLW	0x00
	ADDWFC	r0x0c, F
	MOVLW	0x00
	ADDWFC	r0x0d, F
	MOVFF	r0x0b, r0x07
	MOVFF	r0x0c, r0x08
	MOVFF	r0x0d, r0x09
;	.line	270; TCPIP_Stack/UDP.c	for ( s = 0; s < MAX_UDP_SOCKETS; s++ )
	INCF	r0x0e, F
	MOVFF	r0x0e, r0x0a
	BRA	_00134_DS_
_00137_DS_:
;	.line	308; TCPIP_Stack/UDP.c	return (UDP_SOCKET)INVALID_UDP_SOCKET;
	SETF	WREG
_00138_DS_:
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
S_UDP__UDPTask	code
_UDPTask:
;	.line	215; TCPIP_Stack/UDP.c	void UDPTask(void)
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
;	.line	217; TCPIP_Stack/UDP.c	LastPutSocket = INVALID_UDP_SOCKET;
	MOVLW	0xff
	BANKSEL	_LastPutSocket
	MOVWF	_LastPutSocket, B
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_UDP__UDPInit	code
_UDPInit:
;	.line	177; TCPIP_Stack/UDP.c	void UDPInit(void)
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVFF	r0x02, POSTDEC1
;	.line	182; TCPIP_Stack/UDP.c	for ( s = 0; s < MAX_UDP_SOCKETS; s++ )
	CLRF	r0x00
_00105_DS_:
	MOVFF	r0x00, r0x01
	CLRF	r0x02
	MOVLW	0x00
	SUBWF	r0x02, W
	BNZ	_00114_DS_
	MOVLW	0x0a
	SUBWF	r0x01, W
_00114_DS_:
	BC	_00108_DS_
;	.line	184; TCPIP_Stack/UDP.c	UDPClose(s);
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_UDPClose
	INCF	FSR1L, F
;	.line	182; TCPIP_Stack/UDP.c	for ( s = 0; s < MAX_UDP_SOCKETS; s++ )
	INCF	r0x00, F
	BRA	_00105_DS_
_00108_DS_:
	BANKSEL	_Flags
;	.line	186; TCPIP_Stack/UDP.c	Flags.bWasDiscarded = 1;
	BSF	_Flags, 1, B
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	



; Statistics:
; code size:	 4642 (0x1222) bytes ( 3.54%)
;           	 2321 (0x0911) words
; udata size:	  198 (0x00c6) bytes ( 5.16%)
; access size:	   28 (0x001c) bytes


	end
