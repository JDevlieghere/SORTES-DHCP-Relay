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
	global _ARPInit
	global _ARPProcess
	global _ARPResolve
	global _ARPIsResolved
	global _SwapARPPacket

;--------------------------------------------------------
; extern variables in this module
;--------------------------------------------------------
	extern __gptrput2
	extern __gptrput1
	extern __gptrput4
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
	extern _memcpy
	extern _swaps
	extern _MACSetWritePtr
	extern _MACGetArray
	extern _MACDiscardRx
	extern _MACPutHeader
	extern _MACIsTxReady
	extern _MACPutArray
	extern _MACFlush
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
_ARPProcess_smARP_1_1	db	0x00


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

udata_ARP_0	udata
_Cache	res	10

udata_ARP_1	udata
_ARPProcess_Target_1_1	res	10

udata_ARP_2	udata
_ARPProcess_packet_1_1	res	28

udata_ARP_3	udata
_ARPResolve_packet_1_1	res	28

;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
; I code from now on!
; ; Starting pCode block
S_ARP__SwapARPPacket	code
_SwapARPPacket:
;	.line	412; TCPIP_Stack/ARP.c	void SwapARPPacket(ARP_PACKET* p)
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
;	.line	414; TCPIP_Stack/ARP.c	p->HardwareType     = swaps(p->HardwareType);
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
;	.line	415; TCPIP_Stack/ARP.c	p->Protocol         = swaps(p->Protocol);
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
;	.line	416; TCPIP_Stack/ARP.c	p->Operation        = swaps(p->Operation);
	MOVLW	0x06
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
S_ARP__ARPIsResolved	code
_ARPIsResolved:
;	.line	377; TCPIP_Stack/ARP.c	BOOL ARPIsResolved(IP_ADDR* IPAddr, MAC_ADDR* MACAddr)
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
;	.line	379; TCPIP_Stack/ARP.c	if((Cache.IPAddr.Val == IPAddr->Val) || 
	MOVFF	_Cache, r0x06
	MOVFF	(_Cache + 1), r0x07
	MOVFF	(_Cache + 2), r0x08
	MOVFF	(_Cache + 3), r0x09
	MOVFF	r0x00, FSR0L
	MOVFF	r0x01, PRODL
	MOVF	r0x02, W
	CALL	__gptrget4
	MOVWF	r0x00
	MOVFF	PRODL, r0x01
	MOVFF	PRODH, r0x02
	MOVFF	FSR0L, r0x0a
	MOVF	r0x06, W
	XORWF	r0x00, W
	BNZ	_00180_DS_
	MOVF	r0x07, W
	XORWF	r0x01, W
	BNZ	_00180_DS_
	MOVF	r0x08, W
	XORWF	r0x02, W
	BNZ	_00180_DS_
	MOVF	r0x09, W
	XORWF	r0x0a, W
	BZ	_00171_DS_
_00180_DS_:
;	.line	380; TCPIP_Stack/ARP.c	((Cache.IPAddr.Val == AppConfig.MyGateway.Val) && 
	MOVF	r0x06, W
	BANKSEL	(_AppConfig + 8)
	XORWF	(_AppConfig + 8), W, B
	BNZ	_00181_DS_
	MOVF	r0x07, W
	BANKSEL	(_AppConfig + 9)
	XORWF	(_AppConfig + 9), W, B
	BNZ	_00181_DS_
	MOVF	r0x08, W
	BANKSEL	(_AppConfig + 10)
	XORWF	(_AppConfig + 10), W, B
	BNZ	_00181_DS_
	MOVF	r0x09, W
	BANKSEL	(_AppConfig + 11)
	XORWF	(_AppConfig + 11), W, B
	BZ	_00182_DS_
_00181_DS_:
	BRA	_00172_DS_
_00182_DS_:
	BANKSEL	_AppConfig
;	.line	381; TCPIP_Stack/ARP.c	((AppConfig.MyIPAddr.Val ^ IPAddr->Val) & AppConfig.MyMask.Val)))
	MOVF	_AppConfig, W, B
	XORWF	r0x00, F
	BANKSEL	(_AppConfig + 1)
	MOVF	(_AppConfig + 1), W, B
	XORWF	r0x01, F
	BANKSEL	(_AppConfig + 2)
	MOVF	(_AppConfig + 2), W, B
	XORWF	r0x02, F
	BANKSEL	(_AppConfig + 3)
	MOVF	(_AppConfig + 3), W, B
	XORWF	r0x0a, F
	BANKSEL	(_AppConfig + 4)
	MOVF	(_AppConfig + 4), W, B
	ANDWF	r0x00, F
	BANKSEL	(_AppConfig + 5)
	MOVF	(_AppConfig + 5), W, B
	ANDWF	r0x01, F
	BANKSEL	(_AppConfig + 6)
	MOVF	(_AppConfig + 6), W, B
	ANDWF	r0x02, F
	BANKSEL	(_AppConfig + 7)
	MOVF	(_AppConfig + 7), W, B
	ANDWF	r0x0a, F
	MOVF	r0x00, W
	IORWF	r0x01, W
	IORWF	r0x02, W
	IORWF	r0x0a, W
	BZ	_00172_DS_
_00171_DS_:
;	.line	384; TCPIP_Stack/ARP.c	memcpy((void*)MACAddr, (void*)&Cache.MACAddr, sizeof(Cache.MACAddr));
	MOVLW	HIGH(_Cache + 4)
	MOVWF	r0x01
	MOVLW	LOW(_Cache + 4)
	MOVWF	r0x00
	MOVLW	0x80
	MOVWF	r0x02
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x06
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	CALL	_memcpy
	MOVLW	0x08
	ADDWF	FSR1L, F
;	.line	388; TCPIP_Stack/ARP.c	return TRUE;
	MOVLW	0x01
	BRA	_00175_DS_
_00172_DS_:
;	.line	390; TCPIP_Stack/ARP.c	return FALSE;
	CLRF	WREG
_00175_DS_:
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
S_ARP__ARPResolve	code
_ARPResolve:
;	.line	324; TCPIP_Stack/ARP.c	void ARPResolve(IP_ADDR* IPAddr)
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
;	.line	328; TCPIP_Stack/ARP.c	packet.Operation            = ARP_OPERATION_REQ;
	MOVLW	0x01
	BANKSEL	(_ARPResolve_packet_1_1 + 6)
	MOVWF	(_ARPResolve_packet_1_1 + 6), B
	BANKSEL	(_ARPResolve_packet_1_1 + 7)
	CLRF	(_ARPResolve_packet_1_1 + 7), B
	BANKSEL	(_ARPResolve_packet_1_1 + 18)
;	.line	329; TCPIP_Stack/ARP.c	packet.TargetMACAddr.v[0]   = 0xff;
	SETF	(_ARPResolve_packet_1_1 + 18), B
	BANKSEL	(_ARPResolve_packet_1_1 + 19)
;	.line	330; TCPIP_Stack/ARP.c	packet.TargetMACAddr.v[1]   = 0xff;
	SETF	(_ARPResolve_packet_1_1 + 19), B
	BANKSEL	(_ARPResolve_packet_1_1 + 20)
;	.line	331; TCPIP_Stack/ARP.c	packet.TargetMACAddr.v[2]   = 0xff;
	SETF	(_ARPResolve_packet_1_1 + 20), B
	BANKSEL	(_ARPResolve_packet_1_1 + 21)
;	.line	332; TCPIP_Stack/ARP.c	packet.TargetMACAddr.v[3]   = 0xff;
	SETF	(_ARPResolve_packet_1_1 + 21), B
	BANKSEL	(_ARPResolve_packet_1_1 + 22)
;	.line	333; TCPIP_Stack/ARP.c	packet.TargetMACAddr.v[4]   = 0xff;
	SETF	(_ARPResolve_packet_1_1 + 22), B
	BANKSEL	(_ARPResolve_packet_1_1 + 23)
;	.line	334; TCPIP_Stack/ARP.c	packet.TargetMACAddr.v[5]   = 0xff;
	SETF	(_ARPResolve_packet_1_1 + 23), B
;	.line	340; TCPIP_Stack/ARP.c	((AppConfig.MyIPAddr.Val ^ IPAddr->Val) & AppConfig.MyMask.Val) 
	MOVFF	r0x00, FSR0L
	MOVFF	r0x01, PRODL
	MOVF	r0x02, W
	CALL	__gptrget4
	MOVWF	r0x00
	MOVFF	PRODL, r0x01
	MOVFF	PRODH, r0x02
	MOVFF	FSR0L, r0x03
	MOVF	r0x00, W
	BANKSEL	_AppConfig
	XORWF	_AppConfig, W, B
	MOVWF	r0x04
	MOVF	r0x01, W
	BANKSEL	(_AppConfig + 1)
	XORWF	(_AppConfig + 1), W, B
	MOVWF	r0x05
	MOVF	r0x02, W
	BANKSEL	(_AppConfig + 2)
	XORWF	(_AppConfig + 2), W, B
	MOVWF	r0x06
	MOVF	r0x03, W
	BANKSEL	(_AppConfig + 3)
	XORWF	(_AppConfig + 3), W, B
	MOVWF	r0x07
	BANKSEL	(_AppConfig + 4)
	MOVF	(_AppConfig + 4), W, B
	ANDWF	r0x04, F
	BANKSEL	(_AppConfig + 5)
	MOVF	(_AppConfig + 5), W, B
	ANDWF	r0x05, F
	BANKSEL	(_AppConfig + 6)
	MOVF	(_AppConfig + 6), W, B
	ANDWF	r0x06, F
	BANKSEL	(_AppConfig + 7)
	MOVF	(_AppConfig + 7), W, B
	ANDWF	r0x07, F
	MOVF	r0x04, W
	IORWF	r0x05, W
	IORWF	r0x06, W
	IORWF	r0x07, W
	BZ	_00165_DS_
;	.line	341; TCPIP_Stack/ARP.c	? AppConfig.MyGateway.Val 
	MOVFF	(_AppConfig + 8), r0x04
	MOVFF	(_AppConfig + 9), r0x05
	MOVFF	(_AppConfig + 10), r0x06
	MOVFF	(_AppConfig + 11), r0x07
	BRA	_00166_DS_
_00165_DS_:
;	.line	342; TCPIP_Stack/ARP.c	: (*IPAddr).Val;
	MOVFF	r0x00, r0x04
	MOVFF	r0x01, r0x05
	MOVFF	r0x02, r0x06
	MOVFF	r0x03, r0x07
_00166_DS_:
	MOVF	r0x04, W
	BANKSEL	(_ARPResolve_packet_1_1 + 24)
	MOVWF	(_ARPResolve_packet_1_1 + 24), B
	MOVF	r0x05, W
	BANKSEL	(_ARPResolve_packet_1_1 + 25)
	MOVWF	(_ARPResolve_packet_1_1 + 25), B
	MOVF	r0x06, W
	BANKSEL	(_ARPResolve_packet_1_1 + 26)
	MOVWF	(_ARPResolve_packet_1_1 + 26), B
	MOVF	r0x07, W
	BANKSEL	(_ARPResolve_packet_1_1 + 27)
	MOVWF	(_ARPResolve_packet_1_1 + 27), B
;	.line	343; TCPIP_Stack/ARP.c	ARPPut(&packet);
	MOVLW	HIGH(_ARPResolve_packet_1_1)
	MOVWF	r0x01
	MOVLW	LOW(_ARPResolve_packet_1_1)
	MOVWF	r0x00
	MOVLW	0x80
	MOVWF	r0x02
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_ARPPut
	MOVLW	0x03
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
S_ARP__ARPProcess	code
_ARPProcess:
;	.line	204; TCPIP_Stack/ARP.c	BOOL ARPProcess(void)
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
	BANKSEL	_ARPProcess_smARP_1_1
;	.line	214; TCPIP_Stack/ARP.c	switch(smARP)
	MOVF	_ARPProcess_smARP_1_1, W, B
	BZ	_00118_DS_
_00144_DS_:
	BANKSEL	_ARPProcess_smARP_1_1
	MOVF	_ARPProcess_smARP_1_1, W, B
	XORLW	0x01
	BNZ	_00146_DS_
	BRA	_00129_DS_
_00146_DS_:
	BRA	_00132_DS_
_00118_DS_:
;	.line	218; TCPIP_Stack/ARP.c	MACGetArray((BYTE*)&packet, sizeof(packet));
	MOVLW	HIGH(_ARPProcess_packet_1_1)
	MOVWF	r0x01
	MOVLW	LOW(_ARPProcess_packet_1_1)
	MOVWF	r0x00
	MOVLW	0x80
	MOVWF	r0x02
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x1c
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_MACGetArray
	MOVLW	0x05
	ADDWF	FSR1L, F
;	.line	219; TCPIP_Stack/ARP.c	MACDiscardRx();
	CALL	_MACDiscardRx
;	.line	220; TCPIP_Stack/ARP.c	SwapARPPacket(&packet);
	MOVLW	HIGH(_ARPProcess_packet_1_1)
	MOVWF	r0x01
	MOVLW	LOW(_ARPProcess_packet_1_1)
	MOVWF	r0x00
	MOVLW	0x80
	MOVWF	r0x02
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_SwapARPPacket
	MOVLW	0x03
	ADDWF	FSR1L, F
	BANKSEL	_ARPProcess_packet_1_1
;	.line	223; TCPIP_Stack/ARP.c	if ( packet.HardwareType != HW_ETHERNET     ||
	MOVF	_ARPProcess_packet_1_1, W, B
	XORLW	0x01
	BNZ	_00147_DS_
	BANKSEL	(_ARPProcess_packet_1_1 + 1)
	MOVF	(_ARPProcess_packet_1_1 + 1), W, B
	BZ	_00148_DS_
_00147_DS_:
	BRA	_00119_DS_
_00148_DS_:
	BANKSEL	(_ARPProcess_packet_1_1 + 4)
;	.line	224; TCPIP_Stack/ARP.c	packet.MACAddrLen != sizeof(MAC_ADDR)  ||
	MOVF	(_ARPProcess_packet_1_1 + 4), W, B
	XORLW	0x06
	BNZ	_00119_DS_
_00150_DS_:
	BANKSEL	(_ARPProcess_packet_1_1 + 5)
;	.line	225; TCPIP_Stack/ARP.c	packet.ProtocolLen != sizeof(IP_ADDR) )
	MOVF	(_ARPProcess_packet_1_1 + 5), W, B
	XORLW	0x04
	BZ	_00120_DS_
_00119_DS_:
;	.line	227; TCPIP_Stack/ARP.c	return TRUE;
	MOVLW	0x01
	BRA	_00133_DS_
_00120_DS_:
;	.line	232; TCPIP_Stack/ARP.c	if(packet.Operation == ARP_OPERATION_RESP)
	MOVFF	(_ARPProcess_packet_1_1 + 6), r0x00
	MOVFF	(_ARPProcess_packet_1_1 + 7), r0x01
	MOVF	r0x00, W
	XORLW	0x02
	BNZ	_00153_DS_
	MOVF	r0x01, W
	BZ	_00154_DS_
_00153_DS_:
	BRA	_00124_DS_
_00154_DS_:
;	.line	238; TCPIP_Stack/ARP.c	memcpy((void*)&Cache.MACAddr, (void*)&packet.SenderMACAddr, 
	MOVLW	HIGH(_Cache + 4)
	MOVWF	r0x03
	MOVLW	LOW(_Cache + 4)
	MOVWF	r0x02
	MOVLW	0x80
	MOVWF	r0x04
	MOVLW	HIGH(_ARPProcess_packet_1_1 + 8)
	MOVWF	r0x06
	MOVLW	LOW(_ARPProcess_packet_1_1 + 8)
	MOVWF	r0x05
	MOVLW	0x80
	MOVWF	r0x07
;	.line	239; TCPIP_Stack/ARP.c	sizeof(packet.SenderMACAddr));  
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x06
	MOVWF	POSTDEC1
	MOVF	r0x07, W
	MOVWF	POSTDEC1
	MOVF	r0x06, W
	MOVWF	POSTDEC1
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	CALL	_memcpy
	MOVLW	0x08
	ADDWF	FSR1L, F
	BANKSEL	(_ARPProcess_packet_1_1 + 14)
;	.line	243; TCPIP_Stack/ARP.c	Cache.IPAddr.Val = packet.SenderIPAddr.Val;
	MOVF	(_ARPProcess_packet_1_1 + 14), W, B
	BANKSEL	_Cache
	MOVWF	_Cache, B
	BANKSEL	(_ARPProcess_packet_1_1 + 15)
	MOVF	(_ARPProcess_packet_1_1 + 15), W, B
	BANKSEL	(_Cache + 1)
	MOVWF	(_Cache + 1), B
	BANKSEL	(_ARPProcess_packet_1_1 + 16)
	MOVF	(_ARPProcess_packet_1_1 + 16), W, B
	BANKSEL	(_Cache + 2)
	MOVWF	(_Cache + 2), B
	BANKSEL	(_ARPProcess_packet_1_1 + 17)
	MOVF	(_ARPProcess_packet_1_1 + 17), W, B
	BANKSEL	(_Cache + 3)
	MOVWF	(_Cache + 3), B
;	.line	244; TCPIP_Stack/ARP.c	return TRUE;
	MOVLW	0x01
	BRA	_00133_DS_
_00124_DS_:
;	.line	249; TCPIP_Stack/ARP.c	if(packet.Operation == ARP_OPERATION_REQ)
	MOVF	r0x00, W
	XORLW	0x01
	BNZ	_00155_DS_
	MOVF	r0x01, W
	BZ	_00156_DS_
_00155_DS_:
	BRA	_00129_DS_
_00156_DS_:
	BANKSEL	(_ARPProcess_packet_1_1 + 24)
;	.line	251; TCPIP_Stack/ARP.c	if(packet.TargetIPAddr.Val != AppConfig.MyIPAddr.Val)
	MOVF	(_ARPProcess_packet_1_1 + 24), W, B
	BANKSEL	_AppConfig
	XORWF	_AppConfig, W, B
	BNZ	_00158_DS_
	BANKSEL	(_ARPProcess_packet_1_1 + 25)
	MOVF	(_ARPProcess_packet_1_1 + 25), W, B
	BANKSEL	(_AppConfig + 1)
	XORWF	(_AppConfig + 1), W, B
	BNZ	_00158_DS_
	BANKSEL	(_ARPProcess_packet_1_1 + 26)
	MOVF	(_ARPProcess_packet_1_1 + 26), W, B
	BANKSEL	(_AppConfig + 2)
	XORWF	(_AppConfig + 2), W, B
	BNZ	_00158_DS_
	BANKSEL	(_ARPProcess_packet_1_1 + 27)
	MOVF	(_ARPProcess_packet_1_1 + 27), W, B
	BANKSEL	(_AppConfig + 3)
	XORWF	(_AppConfig + 3), W, B
	BZ	_00126_DS_
_00158_DS_:
;	.line	253; TCPIP_Stack/ARP.c	return TRUE;
	MOVLW	0x01
	BRA	_00133_DS_
_00126_DS_:
	BANKSEL	(_ARPProcess_packet_1_1 + 14)
;	.line	262; TCPIP_Stack/ARP.c	Target.IPAddr.Val = packet.SenderIPAddr.Val;
	MOVF	(_ARPProcess_packet_1_1 + 14), W, B
	BANKSEL	_ARPProcess_Target_1_1
	MOVWF	_ARPProcess_Target_1_1, B
	BANKSEL	(_ARPProcess_packet_1_1 + 15)
	MOVF	(_ARPProcess_packet_1_1 + 15), W, B
	BANKSEL	(_ARPProcess_Target_1_1 + 1)
	MOVWF	(_ARPProcess_Target_1_1 + 1), B
	BANKSEL	(_ARPProcess_packet_1_1 + 16)
	MOVF	(_ARPProcess_packet_1_1 + 16), W, B
	BANKSEL	(_ARPProcess_Target_1_1 + 2)
	MOVWF	(_ARPProcess_Target_1_1 + 2), B
	BANKSEL	(_ARPProcess_packet_1_1 + 17)
	MOVF	(_ARPProcess_packet_1_1 + 17), W, B
	BANKSEL	(_ARPProcess_Target_1_1 + 3)
	MOVWF	(_ARPProcess_Target_1_1 + 3), B
;	.line	264; TCPIP_Stack/ARP.c	memcpy((void*)&Target.MACAddr, 
	MOVLW	HIGH(_ARPProcess_Target_1_1 + 4)
	MOVWF	r0x01
	MOVLW	LOW(_ARPProcess_Target_1_1 + 4)
	MOVWF	r0x00
	MOVLW	0x80
	MOVWF	r0x02
;	.line	265; TCPIP_Stack/ARP.c	(void*)&packet.SenderMACAddr, sizeof(packet.SenderMACAddr));
	MOVLW	HIGH(_ARPProcess_packet_1_1 + 8)
	MOVWF	r0x04
	MOVLW	LOW(_ARPProcess_packet_1_1 + 8)
	MOVWF	r0x03
	MOVLW	0x80
	MOVWF	r0x05
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x06
	MOVWF	POSTDEC1
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
	CALL	_memcpy
	MOVLW	0x08
	ADDWF	FSR1L, F
;	.line	269; TCPIP_Stack/ARP.c	smARP = SM_ARP_REPLY;
	MOVLW	0x01
	BANKSEL	_ARPProcess_smARP_1_1
	MOVWF	_ARPProcess_smARP_1_1, B
_00129_DS_:
;	.line	274; TCPIP_Stack/ARP.c	packet.Operation  = ARP_OPERATION_RESP;
	MOVLW	0x02
	BANKSEL	(_ARPProcess_packet_1_1 + 6)
	MOVWF	(_ARPProcess_packet_1_1 + 6), B
	BANKSEL	(_ARPProcess_packet_1_1 + 7)
	CLRF	(_ARPProcess_packet_1_1 + 7), B
;	.line	276; TCPIP_Stack/ARP.c	memcpy(&packet.TargetMACAddr, (void*)&Target.MACAddr, 
	MOVLW	HIGH(_ARPProcess_packet_1_1 + 18)
	MOVWF	r0x01
	MOVLW	LOW(_ARPProcess_packet_1_1 + 18)
	MOVWF	r0x00
	MOVLW	0x80
	MOVWF	r0x02
	MOVLW	HIGH(_ARPProcess_Target_1_1 + 4)
	MOVWF	r0x04
	MOVLW	LOW(_ARPProcess_Target_1_1 + 4)
	MOVWF	r0x03
	MOVLW	0x80
	MOVWF	r0x05
;	.line	277; TCPIP_Stack/ARP.c	sizeof(Target.MACAddr));
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x06
	MOVWF	POSTDEC1
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
	CALL	_memcpy
	MOVLW	0x08
	ADDWF	FSR1L, F
	BANKSEL	_ARPProcess_Target_1_1
;	.line	281; TCPIP_Stack/ARP.c	packet.TargetIPAddr.Val	= Target.IPAddr.Val;
	MOVF	_ARPProcess_Target_1_1, W, B
	BANKSEL	(_ARPProcess_packet_1_1 + 24)
	MOVWF	(_ARPProcess_packet_1_1 + 24), B
	BANKSEL	(_ARPProcess_Target_1_1 + 1)
	MOVF	(_ARPProcess_Target_1_1 + 1), W, B
	BANKSEL	(_ARPProcess_packet_1_1 + 25)
	MOVWF	(_ARPProcess_packet_1_1 + 25), B
	BANKSEL	(_ARPProcess_Target_1_1 + 2)
	MOVF	(_ARPProcess_Target_1_1 + 2), W, B
	BANKSEL	(_ARPProcess_packet_1_1 + 26)
	MOVWF	(_ARPProcess_packet_1_1 + 26), B
	BANKSEL	(_ARPProcess_Target_1_1 + 3)
	MOVF	(_ARPProcess_Target_1_1 + 3), W, B
	BANKSEL	(_ARPProcess_packet_1_1 + 27)
	MOVWF	(_ARPProcess_packet_1_1 + 27), B
;	.line	284; TCPIP_Stack/ARP.c	if(!ARPPut(&packet))
	MOVLW	HIGH(_ARPProcess_packet_1_1)
	MOVWF	r0x01
	MOVLW	LOW(_ARPProcess_packet_1_1)
	MOVWF	r0x00
	MOVLW	0x80
	MOVWF	r0x02
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_ARPPut
	MOVWF	r0x00
	MOVLW	0x03
	ADDWF	FSR1L, F
	MOVF	r0x00, W
	BNZ	_00131_DS_
;	.line	286; TCPIP_Stack/ARP.c	return FALSE;
	CLRF	WREG
	BRA	_00133_DS_
_00131_DS_:
	BANKSEL	_ARPProcess_smARP_1_1
;	.line	290; TCPIP_Stack/ARP.c	smARP = SM_ARP_IDLE;
	CLRF	_ARPProcess_smARP_1_1, B
_00132_DS_:
;	.line	294; TCPIP_Stack/ARP.c	return TRUE;
	MOVLW	0x01
_00133_DS_:
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
S_ARP__ARPInit	code
_ARPInit:
;	.line	165; TCPIP_Stack/ARP.c	void ARPInit(void)
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	BANKSEL	(_Cache + 4)
;	.line	167; TCPIP_Stack/ARP.c	Cache.MACAddr.v[0] = 0xff;
	SETF	(_Cache + 4), B
	BANKSEL	(_Cache + 5)
;	.line	168; TCPIP_Stack/ARP.c	Cache.MACAddr.v[1] = 0xff;
	SETF	(_Cache + 5), B
	BANKSEL	(_Cache + 6)
;	.line	169; TCPIP_Stack/ARP.c	Cache.MACAddr.v[2] = 0xff;
	SETF	(_Cache + 6), B
	BANKSEL	(_Cache + 7)
;	.line	170; TCPIP_Stack/ARP.c	Cache.MACAddr.v[3] = 0xff;
	SETF	(_Cache + 7), B
	BANKSEL	(_Cache + 8)
;	.line	171; TCPIP_Stack/ARP.c	Cache.MACAddr.v[4] = 0xff;
	SETF	(_Cache + 8), B
	BANKSEL	(_Cache + 9)
;	.line	172; TCPIP_Stack/ARP.c	Cache.MACAddr.v[5] = 0xff;
	SETF	(_Cache + 9), B
	BANKSEL	_Cache
;	.line	174; TCPIP_Stack/ARP.c	Cache.IPAddr.Val = 0x0;
	CLRF	_Cache, B
	BANKSEL	(_Cache + 1)
	CLRF	(_Cache + 1), B
	BANKSEL	(_Cache + 2)
	CLRF	(_Cache + 2), B
	BANKSEL	(_Cache + 3)
	CLRF	(_Cache + 3), B
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_ARP__ARPPut	code
_ARPPut:
;	.line	111; TCPIP_Stack/ARP.c	static BOOL ARPPut(ARP_PACKET* packet)
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
	MOVLW	0x02
	MOVFF	PLUSW2, r0x00
	MOVLW	0x03
	MOVFF	PLUSW2, r0x01
	MOVLW	0x04
	MOVFF	PLUSW2, r0x02
_00105_DS_:
;	.line	113; TCPIP_Stack/ARP.c	while(!MACIsTxReady());
	CALL	_MACIsTxReady
	MOVWF	r0x03
	MOVF	r0x03, W
	BZ	_00105_DS_
;	.line	114; TCPIP_Stack/ARP.c	MACSetWritePtr(BASE_TX_ADDR);
	MOVLW	0x1a
	MOVWF	POSTDEC1
	MOVLW	0x0b
	MOVWF	POSTDEC1
	CALL	_MACSetWritePtr
	MOVLW	0x02
	ADDWF	FSR1L, F
;	.line	117; TCPIP_Stack/ARP.c	packet->HardwareType  = HW_ETHERNET;
	MOVLW	0x01
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	PRODH
	MOVFF	r0x00, FSR0L
	MOVFF	r0x01, PRODL
	MOVF	r0x02, W
	CALL	__gptrput2
;	.line	118; TCPIP_Stack/ARP.c	packet->Protocol      = ARP_IP;
	MOVF	r0x00, W
	ADDLW	0x02
	MOVWF	r0x03
	MOVLW	0x00
	ADDWFC	r0x01, W
	MOVWF	r0x04
	MOVLW	0x00
	ADDWFC	r0x02, W
	MOVWF	r0x05
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x08
	MOVWF	PRODH
	MOVFF	r0x03, FSR0L
	MOVFF	r0x04, PRODL
	MOVF	r0x05, W
	CALL	__gptrput2
;	.line	119; TCPIP_Stack/ARP.c	packet->MACAddrLen    = sizeof(MAC_ADDR);
	MOVF	r0x00, W
	ADDLW	0x04
	MOVWF	r0x03
	MOVLW	0x00
	ADDWFC	r0x01, W
	MOVWF	r0x04
	MOVLW	0x00
	ADDWFC	r0x02, W
	MOVWF	r0x05
	MOVLW	0x06
	MOVWF	POSTDEC1
	MOVFF	r0x03, FSR0L
	MOVFF	r0x04, PRODL
	MOVF	r0x05, W
	CALL	__gptrput1
;	.line	120; TCPIP_Stack/ARP.c	packet->ProtocolLen   = sizeof(IP_ADDR);
	MOVF	r0x00, W
	ADDLW	0x05
	MOVWF	r0x03
	MOVLW	0x00
	ADDWFC	r0x01, W
	MOVWF	r0x04
	MOVLW	0x00
	ADDWFC	r0x02, W
	MOVWF	r0x05
	MOVLW	0x04
	MOVWF	POSTDEC1
	MOVFF	r0x03, FSR0L
	MOVFF	r0x04, PRODL
	MOVF	r0x05, W
	CALL	__gptrput1
;	.line	122; TCPIP_Stack/ARP.c	memcpy(&packet->SenderMACAddr, (void*)&AppConfig.MyMACAddr, 
	MOVF	r0x00, W
	ADDLW	0x08
	MOVWF	r0x03
	MOVLW	0x00
	ADDWFC	r0x01, W
	MOVWF	r0x04
	MOVLW	0x00
	ADDWFC	r0x02, W
	MOVWF	r0x05
	MOVLW	HIGH(_AppConfig + 45)
	MOVWF	r0x07
	MOVLW	LOW(_AppConfig + 45)
	MOVWF	r0x06
	MOVLW	0x80
	MOVWF	r0x08
;	.line	123; TCPIP_Stack/ARP.c	sizeof(packet->SenderMACAddr));
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x06
	MOVWF	POSTDEC1
	MOVF	r0x08, W
	MOVWF	POSTDEC1
	MOVF	r0x07, W
	MOVWF	POSTDEC1
	MOVF	r0x06, W
	MOVWF	POSTDEC1
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	CALL	_memcpy
	MOVLW	0x08
	ADDWF	FSR1L, F
;	.line	127; TCPIP_Stack/ARP.c	packet->SenderIPAddr.Val  = AppConfig.MyIPAddr.Val;
	MOVF	r0x00, W
	ADDLW	0x0e
	MOVWF	r0x03
	MOVLW	0x00
	ADDWFC	r0x01, W
	MOVWF	r0x04
	MOVLW	0x00
	ADDWFC	r0x02, W
	MOVWF	r0x05
	MOVFF	_AppConfig, r0x06
	MOVFF	(_AppConfig + 1), r0x07
	MOVFF	(_AppConfig + 2), r0x08
	MOVFF	(_AppConfig + 3), r0x09
	MOVFF	r0x06, POSTDEC1
	MOVFF	r0x07, PRODH
	MOVFF	r0x08, TBLPTRL
	MOVFF	r0x09, TBLPTRH
	MOVFF	r0x03, FSR0L
	MOVFF	r0x04, PRODL
	MOVF	r0x05, W
	CALL	__gptrput4
;	.line	129; TCPIP_Stack/ARP.c	SwapARPPacket(packet);
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_SwapARPPacket
	MOVLW	0x03
	ADDWF	FSR1L, F
;	.line	131; TCPIP_Stack/ARP.c	MACPutHeader(&packet->TargetMACAddr, MAC_ARP, sizeof(*packet));
	MOVF	r0x00, W
	ADDLW	0x12
	MOVWF	r0x03
	MOVLW	0x00
	ADDWFC	r0x01, W
	MOVWF	r0x04
	MOVLW	0x00
	ADDWFC	r0x02, W
	MOVWF	r0x05
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x1c
	MOVWF	POSTDEC1
	MOVLW	0x06
	MOVWF	POSTDEC1
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	CALL	_MACPutHeader
	MOVLW	0x06
	ADDWF	FSR1L, F
;	.line	132; TCPIP_Stack/ARP.c	MACPutArray((BYTE*)packet, sizeof(*packet));
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x1c
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
;	.line	133; TCPIP_Stack/ARP.c	MACFlush();
	CALL	_MACFlush
;	.line	135; TCPIP_Stack/ARP.c	return TRUE;
	MOVLW	0x01
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
; code size:	 2192 (0x0890) bytes ( 1.67%)
;           	 1096 (0x0448) words
; udata size:	   76 (0x004c) bytes ( 1.98%)
; access size:	   11 (0x000b) bytes


	end
