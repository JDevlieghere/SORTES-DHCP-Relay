;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 2.9.4 #5595 (Dec 17 2009) (UNIX)
; This file was generated Mon Mar 15 11:43:29 2010
;--------------------------------------------------------
; PIC16 port for the Microchip 16-bit core micros
;--------------------------------------------------------
	list	p=18f97j60

	radix dec

;--------------------------------------------------------
; public variables in this module
;--------------------------------------------------------
	global _DHCPInit
	global _DHCPDisable
	global _DHCPEnable
	global _DHCPIsEnabled
	global _DHCPIsBound
	global _DHCPStateChanged
	global _DHCPIsServerDetected
	global _DHCPTask
	global _DHCPClientInitializedOnce

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
	extern _memset
	extern _TickGet
	extern _MACIsLinked
	extern _UDPOpen
	extern _UDPClose
	extern _UDPIsPutReady
	extern _UDPPut
	extern _UDPPutArray
	extern _UDPFlush
	extern _UDPIsGetReady
	extern _UDPGet
	extern _UDPGetArray
	extern _UDPDiscard
;--------------------------------------------------------
;	Equates to used internal registers
;--------------------------------------------------------
STATUS	equ	0xfd8
PCL	equ	0xff9
PCLATH	equ	0xffa
PCLATU	equ	0xffb
WREG	equ	0xfe8
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
_DHCPClientInitializedOnce	db	0x00


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

udata_DHCP_0	udata
_DHCPClient	res	28

udata_DHCP_1	udata
__DHCPReceive_type_1_1	res	1

udata_DHCP_2	udata
__DHCPReceive_j_1_1	res	1

udata_DHCP_3	udata
__DHCPReceive_v_1_1	res	1

udata_DHCP_4	udata
__DHCPReceive_tempServerID_1_1	res	4

udata_DHCP_5	udata
__DHCPSend_MyIP_1_1	res	4

;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
; I code from now on!
; ; Starting pCode block
S_DHCP___DHCPSend	code
__DHCPSend:
;	.line	1039; TCPIP_Stack/DHCP.c	static void _DHCPSend(BYTE messageType, BOOL bRenewing)
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
;	.line	1045; TCPIP_Stack/DHCP.c	UDPPut(BOOT_REQUEST);                       // op
	MOVLW	0x01
	MOVWF	POSTDEC1
	CALL	_UDPPut
	INCF	FSR1L, F
;	.line	1046; TCPIP_Stack/DHCP.c	UDPPut(BOOT_HW_TYPE);                       // htype
	MOVLW	0x01
	MOVWF	POSTDEC1
	CALL	_UDPPut
	INCF	FSR1L, F
;	.line	1047; TCPIP_Stack/DHCP.c	UDPPut(BOOT_LEN_OF_HW_TYPE);                // hlen
	MOVLW	0x06
	MOVWF	POSTDEC1
	CALL	_UDPPut
	INCF	FSR1L, F
;	.line	1048; TCPIP_Stack/DHCP.c	UDPPut(0);                                  // hops
	MOVLW	0x00
	MOVWF	POSTDEC1
	CALL	_UDPPut
	INCF	FSR1L, F
;	.line	1049; TCPIP_Stack/DHCP.c	UDPPut(0x12);                               // xid[0]
	MOVLW	0x12
	MOVWF	POSTDEC1
	CALL	_UDPPut
	INCF	FSR1L, F
;	.line	1050; TCPIP_Stack/DHCP.c	UDPPut(0x23);                               // xid[1]
	MOVLW	0x23
	MOVWF	POSTDEC1
	CALL	_UDPPut
	INCF	FSR1L, F
;	.line	1051; TCPIP_Stack/DHCP.c	UDPPut(0x34);                               // xid[2]
	MOVLW	0x34
	MOVWF	POSTDEC1
	CALL	_UDPPut
	INCF	FSR1L, F
;	.line	1052; TCPIP_Stack/DHCP.c	UDPPut(0x56);                               // xid[3]
	MOVLW	0x56
	MOVWF	POSTDEC1
	CALL	_UDPPut
	INCF	FSR1L, F
;	.line	1053; TCPIP_Stack/DHCP.c	UDPPut(0);                                  // secs[0]
	MOVLW	0x00
	MOVWF	POSTDEC1
	CALL	_UDPPut
	INCF	FSR1L, F
;	.line	1054; TCPIP_Stack/DHCP.c	UDPPut(0);                                  // secs[1]
	MOVLW	0x00
	MOVWF	POSTDEC1
	CALL	_UDPPut
	INCF	FSR1L, F
	BANKSEL	(_DHCPClient + 2)
;	.line	1055; TCPIP_Stack/DHCP.c	UDPPut(DHCPClient.flags.bits.bUseUnicastMode ? 0x00: 0x80);
	BTFSS	(_DHCPClient + 2), 4, B
	BRA	_00489_DS_
	CLRF	r0x02
	BRA	_00490_DS_
_00489_DS_:
	MOVLW	0x80
	MOVWF	r0x02
_00490_DS_:
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	CALL	_UDPPut
	INCF	FSR1L, F
;	.line	1057; TCPIP_Stack/DHCP.c	UDPPut(0);                                  // flags[1]
	MOVLW	0x00
	MOVWF	POSTDEC1
	CALL	_UDPPut
	INCF	FSR1L, F
;	.line	1060; TCPIP_Stack/DHCP.c	if((messageType == DHCP_REQUEST_MESSAGE) && bRenewing)
	MOVFF	r0x00, r0x02
	CLRF	r0x03
	CLRF	r0x04
	MOVF	r0x02, W
	XORLW	0x03
	BNZ	_00507_DS_
	MOVF	r0x03, W
	BNZ	_00507_DS_
	INCF	r0x04, F
_00507_DS_:
	MOVF	r0x04, W
	BZ	_00463_DS_
	MOVF	r0x01, W
	BZ	_00463_DS_
;	.line	1062; TCPIP_Stack/DHCP.c	UDPPutArray((BYTE*)&DHCPClient.tempIPAddress, 
	MOVLW	HIGH(_DHCPClient + 15)
	MOVWF	r0x06
	MOVLW	LOW(_DHCPClient + 15)
	MOVWF	r0x05
	MOVLW	0x80
	MOVWF	r0x07
;	.line	1063; TCPIP_Stack/DHCP.c	sizeof(DHCPClient.tempIPAddress));
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x04
	MOVWF	POSTDEC1
	MOVF	r0x07, W
	MOVWF	POSTDEC1
	MOVF	r0x06, W
	MOVWF	POSTDEC1
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	CALL	_UDPPutArray
	MOVLW	0x05
	ADDWF	FSR1L, F
	BRA	_00464_DS_
_00463_DS_:
;	.line	1067; TCPIP_Stack/DHCP.c	UDPPut(0x00);
	MOVLW	0x00
	MOVWF	POSTDEC1
	CALL	_UDPPut
	INCF	FSR1L, F
;	.line	1068; TCPIP_Stack/DHCP.c	UDPPut(0x00);
	MOVLW	0x00
	MOVWF	POSTDEC1
	CALL	_UDPPut
	INCF	FSR1L, F
;	.line	1069; TCPIP_Stack/DHCP.c	UDPPut(0x00);
	MOVLW	0x00
	MOVWF	POSTDEC1
	CALL	_UDPPut
	INCF	FSR1L, F
;	.line	1070; TCPIP_Stack/DHCP.c	UDPPut(0x00);
	MOVLW	0x00
	MOVWF	POSTDEC1
	CALL	_UDPPut
	INCF	FSR1L, F
_00464_DS_:
;	.line	1074; TCPIP_Stack/DHCP.c	for ( i = 0; i < 12u; i++ )	UDPPut(0x00);
	MOVLW	0x0c
	MOVWF	r0x05
_00483_DS_:
	MOVLW	0x00
	MOVWF	POSTDEC1
	CALL	_UDPPut
	INCF	FSR1L, F
	DECF	r0x05, F
	MOVF	r0x05, W
	BNZ	_00483_DS_
;	.line	1077; TCPIP_Stack/DHCP.c	UDPPutArray((BYTE*)&AppConfig.MyMACAddr, sizeof(AppConfig.MyMACAddr));
	MOVLW	HIGH(_AppConfig + 45)
	MOVWF	r0x07
	MOVLW	LOW(_AppConfig + 45)
	MOVWF	r0x06
	MOVLW	0x80
	MOVWF	r0x08
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
	CALL	_UDPPutArray
	MOVLW	0x05
	ADDWF	FSR1L, F
;	.line	1080; TCPIP_Stack/DHCP.c	for ( i = 0; i < 202u; i++ ) UDPPut(0);
	MOVLW	0xca
	MOVWF	r0x05
_00486_DS_:
	MOVLW	0x00
	MOVWF	POSTDEC1
	CALL	_UDPPut
	INCF	FSR1L, F
	DECFSZ	r0x05, F
	BRA	_00486_DS_
;	.line	1083; TCPIP_Stack/DHCP.c	UDPPut(99);
	MOVLW	0x63
	MOVWF	POSTDEC1
	CALL	_UDPPut
	INCF	FSR1L, F
;	.line	1084; TCPIP_Stack/DHCP.c	UDPPut(130);
	MOVLW	0x82
	MOVWF	POSTDEC1
	CALL	_UDPPut
	INCF	FSR1L, F
;	.line	1085; TCPIP_Stack/DHCP.c	UDPPut(83);
	MOVLW	0x53
	MOVWF	POSTDEC1
	CALL	_UDPPut
	INCF	FSR1L, F
;	.line	1086; TCPIP_Stack/DHCP.c	UDPPut(99);
	MOVLW	0x63
	MOVWF	POSTDEC1
	CALL	_UDPPut
	INCF	FSR1L, F
;	.line	1089; TCPIP_Stack/DHCP.c	UDPPut(DHCP_MESSAGE_TYPE);
	MOVLW	0x35
	MOVWF	POSTDEC1
	CALL	_UDPPut
	INCF	FSR1L, F
;	.line	1090; TCPIP_Stack/DHCP.c	UDPPut(DHCP_MESSAGE_TYPE_LEN);
	MOVLW	0x01
	MOVWF	POSTDEC1
	CALL	_UDPPut
	INCF	FSR1L, F
;	.line	1091; TCPIP_Stack/DHCP.c	UDPPut(messageType);
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_UDPPut
	INCF	FSR1L, F
;	.line	1093; TCPIP_Stack/DHCP.c	if(messageType == DHCP_DISCOVER_MESSAGE)
	CLRF	r0x00
	MOVF	r0x02, W
	XORLW	0x01
	BNZ	_00511_DS_
	MOVF	r0x03, W
	BNZ	_00511_DS_
	INCF	r0x00, F
_00511_DS_:
	MOVF	r0x00, W
	BZ	_00467_DS_
	BANKSEL	(_DHCPClient + 2)
;	.line	1096; TCPIP_Stack/DHCP.c	DHCPClient.flags.bits.bOfferReceived = FALSE;
	BCF	(_DHCPClient + 2), 2, B
_00467_DS_:
;	.line	1100; TCPIP_Stack/DHCP.c	if((messageType == DHCP_REQUEST_MESSAGE) && !bRenewing)
	MOVF	r0x04, W
	BZ	_00469_DS_
	MOVF	r0x01, W
	BNZ	_00469_DS_
;	.line	1108; TCPIP_Stack/DHCP.c	UDPPut(DHCP_SERVER_IDENTIFIER);
	MOVLW	0x36
	MOVWF	POSTDEC1
	CALL	_UDPPut
	INCF	FSR1L, F
;	.line	1109; TCPIP_Stack/DHCP.c	UDPPut(DHCP_SERVER_IDENTIFIER_LEN);
	MOVLW	0x04
	MOVWF	POSTDEC1
	CALL	_UDPPut
	INCF	FSR1L, F
	BANKSEL	(_DHCPClient + 14)
;	.line	1110; TCPIP_Stack/DHCP.c	UDPPut(((BYTE*)(&DHCPClient.dwServerID))[3]);
	MOVF	(_DHCPClient + 14), W, B
	MOVWF	POSTDEC1
	CALL	_UDPPut
	INCF	FSR1L, F
	BANKSEL	(_DHCPClient + 13)
;	.line	1111; TCPIP_Stack/DHCP.c	UDPPut(((BYTE*)(&DHCPClient.dwServerID))[2]);
	MOVF	(_DHCPClient + 13), W, B
	MOVWF	POSTDEC1
	CALL	_UDPPut
	INCF	FSR1L, F
	BANKSEL	(_DHCPClient + 12)
;	.line	1112; TCPIP_Stack/DHCP.c	UDPPut(((BYTE*)(&DHCPClient.dwServerID))[1]);
	MOVF	(_DHCPClient + 12), W, B
	MOVWF	POSTDEC1
	CALL	_UDPPut
	INCF	FSR1L, F
	BANKSEL	(_DHCPClient + 11)
;	.line	1113; TCPIP_Stack/DHCP.c	UDPPut(((BYTE*)(&DHCPClient.dwServerID))[0]);
	MOVF	(_DHCPClient + 11), W, B
	MOVWF	POSTDEC1
	CALL	_UDPPut
	INCF	FSR1L, F
_00469_DS_:
;	.line	1119; TCPIP_Stack/DHCP.c	UDPPut(DHCP_PARAM_REQUEST_LIST);
	MOVLW	0x37
	MOVWF	POSTDEC1
	CALL	_UDPPut
	INCF	FSR1L, F
;	.line	1120; TCPIP_Stack/DHCP.c	UDPPut(DHCP_PARAM_REQUEST_LIST_LEN);
	MOVLW	0x04
	MOVWF	POSTDEC1
	CALL	_UDPPut
	INCF	FSR1L, F
;	.line	1121; TCPIP_Stack/DHCP.c	UDPPut(DHCP_SUBNET_MASK);
	MOVLW	0x01
	MOVWF	POSTDEC1
	CALL	_UDPPut
	INCF	FSR1L, F
;	.line	1122; TCPIP_Stack/DHCP.c	UDPPut(DHCP_ROUTER);
	MOVLW	0x03
	MOVWF	POSTDEC1
	CALL	_UDPPut
	INCF	FSR1L, F
;	.line	1123; TCPIP_Stack/DHCP.c	UDPPut(DHCP_DNS);
	MOVLW	0x06
	MOVWF	POSTDEC1
	CALL	_UDPPut
	INCF	FSR1L, F
;	.line	1124; TCPIP_Stack/DHCP.c	UDPPut(DHCP_HOST_NAME);
	MOVLW	0x0c
	MOVWF	POSTDEC1
	CALL	_UDPPut
	INCF	FSR1L, F
;	.line	1127; TCPIP_Stack/DHCP.c	if( ((messageType == DHCP_REQUEST_MESSAGE) && !bRenewing) || 
	MOVF	r0x04, W
	BZ	_00475_DS_
	MOVF	r0x01, W
	BZ	_00471_DS_
_00475_DS_:
;	.line	1128; TCPIP_Stack/DHCP.c	((messageType == DHCP_DISCOVER_MESSAGE) && 
	MOVF	r0x00, W
	BZ	_00472_DS_
	BANKSEL	(_DHCPClient + 15)
;	.line	1129; TCPIP_Stack/DHCP.c	DHCPClient.tempIPAddress.Val))
	MOVF	(_DHCPClient + 15), W, B
	BANKSEL	(_DHCPClient + 16)
	IORWF	(_DHCPClient + 16), W, B
	BANKSEL	(_DHCPClient + 17)
	IORWF	(_DHCPClient + 17), W, B
	BANKSEL	(_DHCPClient + 18)
	IORWF	(_DHCPClient + 18), W, B
	BZ	_00472_DS_
_00471_DS_:
;	.line	1131; TCPIP_Stack/DHCP.c	UDPPut(DHCP_PARAM_REQUEST_IP_ADDRESS);
	MOVLW	0x32
	MOVWF	POSTDEC1
	CALL	_UDPPut
	INCF	FSR1L, F
;	.line	1132; TCPIP_Stack/DHCP.c	UDPPut(DHCP_PARAM_REQUEST_IP_ADDRESS_LEN);
	MOVLW	0x04
	MOVWF	POSTDEC1
	CALL	_UDPPut
	INCF	FSR1L, F
;	.line	1133; TCPIP_Stack/DHCP.c	UDPPutArray((BYTE*)&DHCPClient.tempIPAddress, 
	MOVLW	HIGH(_DHCPClient + 15)
	MOVWF	r0x02
	MOVLW	LOW(_DHCPClient + 15)
	MOVWF	r0x00
	MOVLW	0x80
	MOVWF	r0x03
;	.line	1134; TCPIP_Stack/DHCP.c	DHCP_PARAM_REQUEST_IP_ADDRESS_LEN);
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x04
	MOVWF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_UDPPutArray
	MOVLW	0x05
	ADDWF	FSR1L, F
_00472_DS_:
;	.line	1140; TCPIP_Stack/DHCP.c	UDPPut(DHCP_END_OPTION);
	MOVLW	0xff
	MOVWF	POSTDEC1
	CALL	_UDPPut
	INCF	FSR1L, F
_00476_DS_:
;	.line	1144; TCPIP_Stack/DHCP.c	while(UDPTxCount < 300u) UDPPut(0); 
	MOVLW	0x01
	BANKSEL	(_UDPTxCount + 1)
	SUBWF	(_UDPTxCount + 1), W, B
	BNZ	_00512_DS_
	MOVLW	0x2c
	BANKSEL	_UDPTxCount
	SUBWF	_UDPTxCount, W, B
_00512_DS_:
	BC	_00478_DS_
	MOVLW	0x00
	MOVWF	POSTDEC1
	CALL	_UDPPut
	INCF	FSR1L, F
	BRA	_00476_DS_
_00478_DS_:
	BANKSEL	_AppConfig
;	.line	1149; TCPIP_Stack/DHCP.c	MyIP.Val = AppConfig.MyIPAddr.Val;
	MOVF	_AppConfig, W, B
	BANKSEL	__DHCPSend_MyIP_1_1
	MOVWF	__DHCPSend_MyIP_1_1, B
	BANKSEL	(_AppConfig + 1)
	MOVF	(_AppConfig + 1), W, B
	BANKSEL	(__DHCPSend_MyIP_1_1 + 1)
	MOVWF	(__DHCPSend_MyIP_1_1 + 1), B
	BANKSEL	(_AppConfig + 2)
	MOVF	(_AppConfig + 2), W, B
	BANKSEL	(__DHCPSend_MyIP_1_1 + 2)
	MOVWF	(__DHCPSend_MyIP_1_1 + 2), B
	BANKSEL	(_AppConfig + 3)
	MOVF	(_AppConfig + 3), W, B
	BANKSEL	(__DHCPSend_MyIP_1_1 + 3)
	MOVWF	(__DHCPSend_MyIP_1_1 + 3), B
;	.line	1150; TCPIP_Stack/DHCP.c	if(!bRenewing) AppConfig.MyIPAddr.Val = 0x00000000;
	MOVF	r0x01, W
	BNZ	_00480_DS_
	BANKSEL	_AppConfig
	CLRF	_AppConfig, B
	BANKSEL	(_AppConfig + 1)
	CLRF	(_AppConfig + 1), B
	BANKSEL	(_AppConfig + 2)
	CLRF	(_AppConfig + 2), B
	BANKSEL	(_AppConfig + 3)
	CLRF	(_AppConfig + 3), B
_00480_DS_:
;	.line	1151; TCPIP_Stack/DHCP.c	UDPFlush();
	CALL	_UDPFlush
	BANKSEL	__DHCPSend_MyIP_1_1
;	.line	1152; TCPIP_Stack/DHCP.c	AppConfig.MyIPAddr.Val = MyIP.Val;
	MOVF	__DHCPSend_MyIP_1_1, W, B
	BANKSEL	_AppConfig
	MOVWF	_AppConfig, B
	BANKSEL	(__DHCPSend_MyIP_1_1 + 1)
	MOVF	(__DHCPSend_MyIP_1_1 + 1), W, B
	BANKSEL	(_AppConfig + 1)
	MOVWF	(_AppConfig + 1), B
	BANKSEL	(__DHCPSend_MyIP_1_1 + 2)
	MOVF	(__DHCPSend_MyIP_1_1 + 2), W, B
	BANKSEL	(_AppConfig + 2)
	MOVWF	(_AppConfig + 2), B
	BANKSEL	(__DHCPSend_MyIP_1_1 + 3)
	MOVF	(__DHCPSend_MyIP_1_1 + 3), W, B
	BANKSEL	(_AppConfig + 3)
	MOVWF	(_AppConfig + 3), B
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
S_DHCP___DHCPReceive	code
__DHCPReceive:
;	.line	720; TCPIP_Stack/DHCP.c	static BYTE _DHCPReceive(void)
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVFF	r0x02, POSTDEC1
	MOVFF	r0x03, POSTDEC1
	MOVFF	r0x04, POSTDEC1
	MOVFF	r0x05, POSTDEC1
	BANKSEL	__DHCPReceive_type_1_1
;	.line	766; TCPIP_Stack/DHCP.c	type = DHCP_UNKNOWN_MESSAGE;
	CLRF	__DHCPReceive_type_1_1, B
;	.line	768; TCPIP_Stack/DHCP.c	UDPGet(&v);                             // op
	MOVLW	HIGH(__DHCPReceive_v_1_1)
	MOVWF	r0x01
	MOVLW	LOW(__DHCPReceive_v_1_1)
	MOVWF	r0x00
	MOVLW	0x80
	MOVWF	r0x02
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_UDPGet
	MOVLW	0x03
	ADDWF	FSR1L, F
;	.line	771; TCPIP_Stack/DHCP.c	if ( v == BOOT_REPLY )
	MOVFF	__DHCPReceive_v_1_1, r0x00
	CLRF	r0x01
	MOVF	r0x00, W
	XORLW	0x02
	BNZ	_00424_DS_
	MOVF	r0x01, W
	BZ	_00425_DS_
_00424_DS_:
	GOTO	_00345_DS_
_00425_DS_:
;	.line	774; TCPIP_Stack/DHCP.c	for ( i = 0; i < 15u; i++ ) UDPGet(&v);
	MOVLW	0x0f
	MOVWF	r0x00
_00354_DS_:
	MOVLW	HIGH(__DHCPReceive_v_1_1)
	MOVWF	r0x02
	MOVLW	LOW(__DHCPReceive_v_1_1)
	MOVWF	r0x01
	MOVLW	0x80
	MOVWF	r0x03
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	CALL	_UDPGet
	MOVLW	0x03
	ADDWF	FSR1L, F
	DECF	r0x00, F
	MOVF	r0x00, W
	BNZ	_00354_DS_
	BANKSEL	(_DHCPClient + 2)
;	.line	777; TCPIP_Stack/DHCP.c	if(DHCPClient.flags.bits.bOfferReceived)
	BTFSS	(_DHCPClient + 2), 2, B
	BRA	_00294_DS_
;	.line	780; TCPIP_Stack/DHCP.c	for ( i = 0; i < 4u; i++ ) UDPGet(&v);
	MOVLW	0x04
	MOVWF	r0x00
_00357_DS_:
	MOVLW	HIGH(__DHCPReceive_v_1_1)
	MOVWF	r0x02
	MOVLW	LOW(__DHCPReceive_v_1_1)
	MOVWF	r0x01
	MOVLW	0x80
	MOVWF	r0x03
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	CALL	_UDPGet
	MOVLW	0x03
	ADDWF	FSR1L, F
	DECF	r0x00, F
	MOVF	r0x00, W
	BNZ	_00357_DS_
	BRA	_00295_DS_
_00294_DS_:
;	.line	785; TCPIP_Stack/DHCP.c	UDPGetArray((BYTE*)&DHCPClient.tempIPAddress, 
	MOVLW	HIGH(_DHCPClient + 15)
	MOVWF	r0x02
	MOVLW	LOW(_DHCPClient + 15)
	MOVWF	r0x01
	MOVLW	0x80
	MOVWF	r0x03
;	.line	786; TCPIP_Stack/DHCP.c	sizeof(DHCPClient.tempIPAddress));
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x04
	MOVWF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	CALL	_UDPGetArray
	MOVLW	0x05
	ADDWF	FSR1L, F
	BANKSEL	(_DHCPClient + 27)
;	.line	787; TCPIP_Stack/DHCP.c	DHCPClient.validValues.bits.IPAddress = 1;
	BSF	(_DHCPClient + 27), 0, B
_00295_DS_:
;	.line	791; TCPIP_Stack/DHCP.c	for ( i = 0; i < 8u; i++ ) UDPGet(&v);
	MOVLW	0x08
	MOVWF	r0x00
_00360_DS_:
	MOVLW	HIGH(__DHCPReceive_v_1_1)
	MOVWF	r0x02
	MOVLW	LOW(__DHCPReceive_v_1_1)
	MOVWF	r0x01
	MOVLW	0x80
	MOVWF	r0x03
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	CALL	_UDPGet
	MOVLW	0x03
	ADDWF	FSR1L, F
	DECF	r0x00, F
	MOVF	r0x00, W
	BNZ	_00360_DS_
;	.line	794; TCPIP_Stack/DHCP.c	for ( i = 0; i < 6u; i++ )
	CLRF	r0x01
_00361_DS_:
	MOVFF	r0x01, r0x02
	CLRF	r0x03
	MOVLW	0x00
	SUBWF	r0x03, W
	BNZ	_00426_DS_
	MOVLW	0x06
	SUBWF	r0x02, W
_00426_DS_:
	BC	_00364_DS_
;	.line	796; TCPIP_Stack/DHCP.c	UDPGet(&v);
	MOVLW	HIGH(__DHCPReceive_v_1_1)
	MOVWF	r0x03
	MOVLW	LOW(__DHCPReceive_v_1_1)
	MOVWF	r0x02
	MOVLW	0x80
	MOVWF	r0x04
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	CALL	_UDPGet
	MOVLW	0x03
	ADDWF	FSR1L, F
;	.line	797; TCPIP_Stack/DHCP.c	if ( v != AppConfig.MyMACAddr.v[i])	goto UDPInvalid;
	MOVLW	LOW(_AppConfig + 45)
	ADDWF	r0x01, W
	MOVWF	r0x02
	CLRF	r0x03
	MOVLW	HIGH(_AppConfig + 45)
	ADDWFC	r0x03, F
	MOVFF	r0x02, FSR0L
	MOVFF	r0x03, FSR0H
	MOVFF	INDF0, r0x02
	BANKSEL	__DHCPReceive_v_1_1
	MOVF	__DHCPReceive_v_1_1, W, B
	XORWF	r0x02, W
	BZ	_00428_DS_
	GOTO	_00351_DS_
_00428_DS_:
;	.line	794; TCPIP_Stack/DHCP.c	for ( i = 0; i < 6u; i++ )
	INCF	r0x01, F
	BRA	_00361_DS_
_00364_DS_:
;	.line	802; TCPIP_Stack/DHCP.c	for ( i = 0; i < 206u; i++ ) UDPGet(&v);
	MOVLW	0xce
	MOVWF	r0x00
_00367_DS_:
	MOVLW	HIGH(__DHCPReceive_v_1_1)
	MOVWF	r0x02
	MOVLW	LOW(__DHCPReceive_v_1_1)
	MOVWF	r0x01
	MOVLW	0x80
	MOVWF	r0x03
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	CALL	_UDPGet
	MOVLW	0x03
	ADDWF	FSR1L, F
	DECF	r0x00, F
	MOVF	r0x00, W
	BNZ	_00367_DS_
;	.line	804; TCPIP_Stack/DHCP.c	lbDone = FALSE;
	CLRF	r0x01
_00341_DS_:
;	.line	810; TCPIP_Stack/DHCP.c	if(!UDPGet(&v))
	MOVLW	HIGH(__DHCPReceive_v_1_1)
	MOVWF	r0x03
	MOVLW	LOW(__DHCPReceive_v_1_1)
	MOVWF	r0x02
	MOVLW	0x80
	MOVWF	r0x04
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	CALL	_UDPGet
	MOVWF	r0x02
	MOVLW	0x03
	ADDWF	FSR1L, F
	MOVF	r0x02, W
	BTFSC	STATUS, 2
	GOTO	_00345_DS_
;	.line	816; TCPIP_Stack/DHCP.c	switch(v)
	MOVFF	__DHCPReceive_v_1_1, r0x02
	CLRF	r0x03
	MOVF	r0x02, W
	XORLW	0x01
	BNZ	_00430_DS_
	MOVF	r0x03, W
	BNZ	_00430_DS_
	BRA	_00307_DS_
_00430_DS_:
	MOVF	r0x02, W
	XORLW	0x03
	BNZ	_00432_DS_
	MOVF	r0x03, W
	BNZ	_00432_DS_
	BRA	_00314_DS_
_00432_DS_:
	MOVF	r0x02, W
	XORLW	0x33
	BNZ	_00434_DS_
	MOVF	r0x03, W
	BNZ	_00434_DS_
	BRA	_00329_DS_
_00434_DS_:
	MOVF	r0x02, W
	XORLW	0x35
	BNZ	_00436_DS_
	MOVF	r0x03, W
	BZ	_00300_DS_
_00436_DS_:
	MOVF	r0x02, W
	XORLW	0x36
	BNZ	_00438_DS_
	MOVF	r0x03, W
	BNZ	_00438_DS_
	BRA	_00324_DS_
_00438_DS_:
	MOVF	r0x02, W
	XORLW	0xff
	BNZ	_00440_DS_
	MOVF	r0x03, W
	BNZ	_00440_DS_
	BRA	_00328_DS_
_00440_DS_:
	GOTO	_00336_DS_
_00300_DS_:
;	.line	819; TCPIP_Stack/DHCP.c	UDPGet(&v);     // Skip len
	MOVLW	HIGH(__DHCPReceive_v_1_1)
	MOVWF	r0x03
	MOVLW	LOW(__DHCPReceive_v_1_1)
	MOVWF	r0x02
	MOVLW	0x80
	MOVWF	r0x04
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	CALL	_UDPGet
	MOVLW	0x03
	ADDWF	FSR1L, F
;	.line	821; TCPIP_Stack/DHCP.c	if ( v == 1u )
	MOVFF	__DHCPReceive_v_1_1, r0x02
	CLRF	r0x03
	MOVF	r0x02, W
	XORLW	0x01
	BNZ	_00441_DS_
	MOVF	r0x03, W
	BZ	_00442_DS_
_00441_DS_:
	GOTO	_00351_DS_
_00442_DS_:
;	.line	823; TCPIP_Stack/DHCP.c	UDPGet(&type);                  // Get type
	MOVLW	HIGH(__DHCPReceive_type_1_1)
	MOVWF	r0x03
	MOVLW	LOW(__DHCPReceive_type_1_1)
	MOVWF	r0x02
	MOVLW	0x80
	MOVWF	r0x04
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	CALL	_UDPGet
	MOVLW	0x03
	ADDWF	FSR1L, F
	BANKSEL	(_DHCPClient + 2)
;	.line	827; TCPIP_Stack/DHCP.c	if(DHCPClient.flags.bits.bOfferReceived && 
	BTFSS	(_DHCPClient + 2), 2, B
	GOTO	_00342_DS_
;	.line	828; TCPIP_Stack/DHCP.c	(type == DHCP_OFFER_MESSAGE))
	MOVFF	__DHCPReceive_type_1_1, r0x02
	CLRF	r0x03
	MOVF	r0x02, W
	XORLW	0x02
	BNZ	_00444_DS_
	MOVF	r0x03, W
	BNZ	_00444_DS_
	GOTO	_00351_DS_
_00444_DS_:
;	.line	835; TCPIP_Stack/DHCP.c	break;
	BRA	_00342_DS_
_00307_DS_:
;	.line	838; TCPIP_Stack/DHCP.c	UDPGet(&v);     // Skip len
	MOVLW	HIGH(__DHCPReceive_v_1_1)
	MOVWF	r0x03
	MOVLW	LOW(__DHCPReceive_v_1_1)
	MOVWF	r0x02
	MOVLW	0x80
	MOVWF	r0x04
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	CALL	_UDPGet
	MOVLW	0x03
	ADDWF	FSR1L, F
;	.line	840; TCPIP_Stack/DHCP.c	if ( v == 4u )
	MOVFF	__DHCPReceive_v_1_1, r0x02
	CLRF	r0x03
	MOVF	r0x02, W
	XORLW	0x04
	BNZ	_00445_DS_
	MOVF	r0x03, W
	BZ	_00446_DS_
_00445_DS_:
	GOTO	_00351_DS_
_00446_DS_:
	BANKSEL	(_DHCPClient + 2)
;	.line	843; TCPIP_Stack/DHCP.c	if(DHCPClient.flags.bits.bOfferReceived)
	BTFSS	(_DHCPClient + 2), 2, B
	BRA	_00309_DS_
;	.line	847; TCPIP_Stack/DHCP.c	for ( i = 0; i < 4u; i++ ) UDPGet(&v);
	MOVLW	0x04
	MOVWF	r0x00
_00370_DS_:
	MOVLW	HIGH(__DHCPReceive_v_1_1)
	MOVWF	r0x03
	MOVLW	LOW(__DHCPReceive_v_1_1)
	MOVWF	r0x02
	MOVLW	0x80
	MOVWF	r0x04
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	CALL	_UDPGet
	MOVLW	0x03
	ADDWF	FSR1L, F
	DECF	r0x00, F
	MOVF	r0x00, W
	BNZ	_00370_DS_
	BRA	_00342_DS_
_00309_DS_:
;	.line	851; TCPIP_Stack/DHCP.c	UDPGetArray((BYTE*)&DHCPClient.tempMask, 
	MOVLW	HIGH(_DHCPClient + 23)
	MOVWF	r0x03
	MOVLW	LOW(_DHCPClient + 23)
	MOVWF	r0x02
	MOVLW	0x80
	MOVWF	r0x04
;	.line	852; TCPIP_Stack/DHCP.c	sizeof(DHCPClient.tempMask));
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x04
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	CALL	_UDPGetArray
	MOVLW	0x05
	ADDWF	FSR1L, F
	BANKSEL	(_DHCPClient + 27)
;	.line	853; TCPIP_Stack/DHCP.c	DHCPClient.validValues.bits.Mask = 1;
	BSF	(_DHCPClient + 27), 2, B
	BRA	_00342_DS_
_00314_DS_:
;	.line	861; TCPIP_Stack/DHCP.c	UDPGet(&j);
	MOVLW	HIGH(__DHCPReceive_j_1_1)
	MOVWF	r0x03
	MOVLW	LOW(__DHCPReceive_j_1_1)
	MOVWF	r0x02
	MOVLW	0x80
	MOVWF	r0x04
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	CALL	_UDPGet
	MOVLW	0x03
	ADDWF	FSR1L, F
;	.line	863; TCPIP_Stack/DHCP.c	if ( j >= 4u )
	MOVFF	__DHCPReceive_j_1_1, r0x02
	CLRF	r0x03
	MOVLW	0x00
	SUBWF	r0x03, W
	BNZ	_00447_DS_
	MOVLW	0x04
	SUBWF	r0x02, W
_00447_DS_:
	BTFSS	STATUS, 0
	BRA	_00351_DS_
	BANKSEL	(_DHCPClient + 2)
;	.line	866; TCPIP_Stack/DHCP.c	if(DHCPClient.flags.bits.bOfferReceived)
	BTFSS	(_DHCPClient + 2), 2, B
	BRA	_00316_DS_
;	.line	870; TCPIP_Stack/DHCP.c	for ( i = 0; i < 4u; i++ ) UDPGet(&v);
	MOVLW	0x04
	MOVWF	r0x00
_00373_DS_:
	MOVLW	HIGH(__DHCPReceive_v_1_1)
	MOVWF	r0x03
	MOVLW	LOW(__DHCPReceive_v_1_1)
	MOVWF	r0x02
	MOVLW	0x80
	MOVWF	r0x04
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	CALL	_UDPGet
	MOVLW	0x03
	ADDWF	FSR1L, F
	DECF	r0x00, F
	MOVF	r0x00, W
	BNZ	_00373_DS_
	BRA	_00320_DS_
_00316_DS_:
;	.line	874; TCPIP_Stack/DHCP.c	UDPGetArray((BYTE*)&DHCPClient.tempGateway, 
	MOVLW	HIGH(_DHCPClient + 19)
	MOVWF	r0x03
	MOVLW	LOW(_DHCPClient + 19)
	MOVWF	r0x02
	MOVLW	0x80
	MOVWF	r0x04
;	.line	875; TCPIP_Stack/DHCP.c	sizeof(DHCPClient.tempGateway));
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x04
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	CALL	_UDPGetArray
	MOVLW	0x05
	ADDWF	FSR1L, F
	BANKSEL	(_DHCPClient + 27)
;	.line	876; TCPIP_Stack/DHCP.c	DHCPClient.validValues.bits.Gateway = 1;
	BSF	(_DHCPClient + 27), 1, B
_00320_DS_:
;	.line	882; TCPIP_Stack/DHCP.c	j -= 4;
	MOVLW	0xfc
	BANKSEL	__DHCPReceive_j_1_1
	ADDWF	__DHCPReceive_j_1_1, F, B
;	.line	883; TCPIP_Stack/DHCP.c	while(j--) UDPGet(&v);
	MOVFF	__DHCPReceive_j_1_1, r0x02
_00321_DS_:
	MOVFF	r0x02, r0x03
	DECF	r0x02, F
	MOVFF	r0x02, __DHCPReceive_j_1_1
	MOVF	r0x03, W
	BTFSC	STATUS, 2
	BRA	_00422_DS_
	MOVLW	HIGH(__DHCPReceive_v_1_1)
	MOVWF	r0x04
	MOVLW	LOW(__DHCPReceive_v_1_1)
	MOVWF	r0x03
	MOVLW	0x80
	MOVWF	r0x05
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	CALL	_UDPGet
	MOVLW	0x03
	ADDWF	FSR1L, F
	BRA	_00321_DS_
_00324_DS_:
;	.line	945; TCPIP_Stack/DHCP.c	UDPGet(&v);    // Get len
	MOVLW	HIGH(__DHCPReceive_v_1_1)
	MOVWF	r0x04
	MOVLW	LOW(__DHCPReceive_v_1_1)
	MOVWF	r0x03
	MOVLW	0x80
	MOVWF	r0x05
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	CALL	_UDPGet
	MOVLW	0x03
	ADDWF	FSR1L, F
;	.line	947; TCPIP_Stack/DHCP.c	if ( v == 4u )
	MOVFF	__DHCPReceive_v_1_1, r0x03
	CLRF	r0x04
	MOVF	r0x03, W
	XORLW	0x04
	BNZ	_00448_DS_
	MOVF	r0x04, W
	BZ	_00449_DS_
_00448_DS_:
	BRA	_00351_DS_
_00449_DS_:
;	.line	949; TCPIP_Stack/DHCP.c	UDPGet(&tempServerID.v[3]);   // Get the id
	MOVLW	HIGH(__DHCPReceive_tempServerID_1_1 + 3)
	MOVWF	r0x04
	MOVLW	LOW(__DHCPReceive_tempServerID_1_1 + 3)
	MOVWF	r0x03
	MOVLW	0x80
	MOVWF	r0x05
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	CALL	_UDPGet
	MOVLW	0x03
	ADDWF	FSR1L, F
;	.line	950; TCPIP_Stack/DHCP.c	UDPGet(&tempServerID.v[2]);
	MOVLW	HIGH(__DHCPReceive_tempServerID_1_1 + 2)
	MOVWF	r0x04
	MOVLW	LOW(__DHCPReceive_tempServerID_1_1 + 2)
	MOVWF	r0x03
	MOVLW	0x80
	MOVWF	r0x05
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	CALL	_UDPGet
	MOVLW	0x03
	ADDWF	FSR1L, F
;	.line	951; TCPIP_Stack/DHCP.c	UDPGet(&tempServerID.v[1]);
	MOVLW	HIGH(__DHCPReceive_tempServerID_1_1 + 1)
	MOVWF	r0x04
	MOVLW	LOW(__DHCPReceive_tempServerID_1_1 + 1)
	MOVWF	r0x03
	MOVLW	0x80
	MOVWF	r0x05
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	CALL	_UDPGet
	MOVLW	0x03
	ADDWF	FSR1L, F
;	.line	952; TCPIP_Stack/DHCP.c	UDPGet(&tempServerID.v[0]);
	MOVLW	HIGH(__DHCPReceive_tempServerID_1_1)
	MOVWF	r0x04
	MOVLW	LOW(__DHCPReceive_tempServerID_1_1)
	MOVWF	r0x03
	MOVLW	0x80
	MOVWF	r0x05
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	CALL	_UDPGet
	MOVLW	0x03
	ADDWF	FSR1L, F
	BRA	_00342_DS_
_00328_DS_:
;	.line	958; TCPIP_Stack/DHCP.c	lbDone = TRUE;
	MOVLW	0x01
	MOVWF	r0x01
;	.line	959; TCPIP_Stack/DHCP.c	break;
	BRA	_00342_DS_
_00329_DS_:
;	.line	962; TCPIP_Stack/DHCP.c	UDPGet(&v);            // Get len
	MOVLW	HIGH(__DHCPReceive_v_1_1)
	MOVWF	r0x04
	MOVLW	LOW(__DHCPReceive_v_1_1)
	MOVWF	r0x03
	MOVLW	0x80
	MOVWF	r0x05
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	CALL	_UDPGet
	MOVLW	0x03
	ADDWF	FSR1L, F
;	.line	964; TCPIP_Stack/DHCP.c	if ( v == 4u )
	MOVFF	__DHCPReceive_v_1_1, r0x03
	CLRF	r0x04
	MOVF	r0x03, W
	XORLW	0x04
	BNZ	_00450_DS_
	MOVF	r0x04, W
	BZ	_00451_DS_
_00450_DS_:
	BRA	_00351_DS_
_00451_DS_:
	BANKSEL	(_DHCPClient + 2)
;	.line	967; TCPIP_Stack/DHCP.c	if(DHCPClient.flags.bits.bOfferReceived)
	BTFSS	(_DHCPClient + 2), 2, B
	BRA	_00331_DS_
;	.line	970; TCPIP_Stack/DHCP.c	for ( i = 0; i < 4u; i++ ) UDPGet(&v);
	MOVLW	0x04
	MOVWF	r0x00
_00376_DS_:
	MOVLW	HIGH(__DHCPReceive_v_1_1)
	MOVWF	r0x04
	MOVLW	LOW(__DHCPReceive_v_1_1)
	MOVWF	r0x03
	MOVLW	0x80
	MOVWF	r0x05
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	CALL	_UDPGet
	MOVLW	0x03
	ADDWF	FSR1L, F
	DECFSZ	r0x00, F
	BRA	_00376_DS_
	BRA	_00342_DS_
_00331_DS_:
;	.line	974; TCPIP_Stack/DHCP.c	UDPGet(&(((BYTE*)(&DHCPClient.dwLeaseTime))[3]));
	MOVLW	HIGH(_DHCPClient + 10)
	MOVWF	r0x03
	MOVLW	LOW(_DHCPClient + 10)
	MOVWF	r0x00
	MOVLW	0x80
	MOVWF	r0x04
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_UDPGet
	MOVLW	0x03
	ADDWF	FSR1L, F
;	.line	975; TCPIP_Stack/DHCP.c	UDPGet(&(((BYTE*)(&DHCPClient.dwLeaseTime))[2]));
	MOVLW	HIGH(_DHCPClient + 9)
	MOVWF	r0x03
	MOVLW	LOW(_DHCPClient + 9)
	MOVWF	r0x00
	MOVLW	0x80
	MOVWF	r0x04
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_UDPGet
	MOVLW	0x03
	ADDWF	FSR1L, F
;	.line	976; TCPIP_Stack/DHCP.c	UDPGet(&(((BYTE*)(&DHCPClient.dwLeaseTime))[1]));
	MOVLW	HIGH(_DHCPClient + 8)
	MOVWF	r0x03
	MOVLW	LOW(_DHCPClient + 8)
	MOVWF	r0x00
	MOVLW	0x80
	MOVWF	r0x04
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_UDPGet
	MOVLW	0x03
	ADDWF	FSR1L, F
;	.line	977; TCPIP_Stack/DHCP.c	UDPGet(&(((BYTE*)(&DHCPClient.dwLeaseTime))[0]));
	MOVLW	HIGH(_DHCPClient + 7)
	MOVWF	r0x03
	MOVLW	LOW(_DHCPClient + 7)
	MOVWF	r0x00
	MOVLW	0x80
	MOVWF	r0x04
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_UDPGet
	MOVLW	0x03
	ADDWF	FSR1L, F
	BANKSEL	(_DHCPClient + 7)
;	.line	981; TCPIP_Stack/DHCP.c	DHCPClient.dwLeaseTime -= DHCPClient.dwLeaseTime>>5;
	SWAPF	(_DHCPClient + 7), W, B
	ANDLW	0x0f
	MOVWF	r0x00
	BANKSEL	(_DHCPClient + 8)
	SWAPF	(_DHCPClient + 8), W, B
	MOVWF	r0x03
	ANDLW	0xf0
	XORWF	r0x03, F
	ADDWF	r0x00, F
	RRCF	r0x03, F
	RRCF	r0x00, F
	BANKSEL	(_DHCPClient + 9)
	MOVF	(_DHCPClient + 9), W, B
	SWAPF	WREG, W
	RRNCF	WREG, W
	ANDLW	0xf8
	IORWF	r0x03, F
	BANKSEL	(_DHCPClient + 9)
	SWAPF	(_DHCPClient + 9), W, B
	ANDLW	0x0f
	MOVWF	r0x04
	BANKSEL	(_DHCPClient + 10)
	SWAPF	(_DHCPClient + 10), W, B
	MOVWF	r0x05
	ANDLW	0xf0
	XORWF	r0x05, F
	ADDWF	r0x04, F
	RRCF	r0x05, F
	RRCF	r0x04, F
	MOVF	r0x00, W
	BANKSEL	(_DHCPClient + 7)
	SUBWF	(_DHCPClient + 7), W, B
	MOVWF	r0x00
	MOVF	r0x03, W
	BANKSEL	(_DHCPClient + 8)
	SUBWFB	(_DHCPClient + 8), W, B
	MOVWF	r0x03
	MOVF	r0x04, W
	BANKSEL	(_DHCPClient + 9)
	SUBWFB	(_DHCPClient + 9), W, B
	MOVWF	r0x04
	MOVF	r0x05, W
	BANKSEL	(_DHCPClient + 10)
	SUBWFB	(_DHCPClient + 10), W, B
	MOVWF	r0x05
	MOVF	r0x00, W
	BANKSEL	(_DHCPClient + 7)
	MOVWF	(_DHCPClient + 7), B
	MOVF	r0x03, W
	BANKSEL	(_DHCPClient + 8)
	MOVWF	(_DHCPClient + 8), B
	MOVF	r0x04, W
	BANKSEL	(_DHCPClient + 9)
	MOVWF	(_DHCPClient + 9), B
	MOVF	r0x05, W
	BANKSEL	(_DHCPClient + 10)
	MOVWF	(_DHCPClient + 10), B
	BRA	_00342_DS_
_00336_DS_:
;	.line	989; TCPIP_Stack/DHCP.c	UDPGet(&j);       // Get option len
	MOVLW	HIGH(__DHCPReceive_j_1_1)
	MOVWF	r0x03
	MOVLW	LOW(__DHCPReceive_j_1_1)
	MOVWF	r0x00
	MOVLW	0x80
	MOVWF	r0x04
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_UDPGet
	MOVLW	0x03
	ADDWF	FSR1L, F
;	.line	990; TCPIP_Stack/DHCP.c	while( j-- )      // Ignore option values
	MOVFF	__DHCPReceive_j_1_1, r0x00
_00337_DS_:
	MOVFF	r0x00, r0x03
	DECF	r0x00, F
	MOVFF	r0x00, __DHCPReceive_j_1_1
	MOVF	r0x03, W
	BZ	_00423_DS_
;	.line	991; TCPIP_Stack/DHCP.c	UDPGet(&v);
	MOVLW	HIGH(__DHCPReceive_v_1_1)
	MOVWF	r0x04
	MOVLW	LOW(__DHCPReceive_v_1_1)
	MOVWF	r0x03
	MOVLW	0x80
	MOVWF	r0x05
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	CALL	_UDPGet
	MOVLW	0x03
	ADDWF	FSR1L, F
	BRA	_00337_DS_
_00422_DS_:
;	.line	992; TCPIP_Stack/DHCP.c	}
	MOVFF	r0x02, __DHCPReceive_j_1_1
;	.line	1015; TCPIP_Stack/DHCP.c	return DHCP_UNKNOWN_MESSAGE;
	BRA	_00342_DS_
_00423_DS_:
;	.line	992; TCPIP_Stack/DHCP.c	}
	MOVFF	r0x00, __DHCPReceive_j_1_1
_00342_DS_:
;	.line	993; TCPIP_Stack/DHCP.c	} while( !lbDone );
	MOVF	r0x01, W
	BTFSC	STATUS, 2
	GOTO	_00341_DS_
_00345_DS_:
;	.line	997; TCPIP_Stack/DHCP.c	if ( type == DHCP_OFFER_MESSAGE )
	MOVFF	__DHCPReceive_type_1_1, r0x00
	CLRF	r0x01
	MOVF	r0x00, W
	XORLW	0x02
	BNZ	_00349_DS_
	MOVF	r0x01, W
	BZ	_00455_DS_
_00454_DS_:
	BRA	_00349_DS_
_00455_DS_:
	BANKSEL	__DHCPReceive_tempServerID_1_1
;	.line	999; TCPIP_Stack/DHCP.c	DHCPClient.dwServerID = tempServerID.Val;
	MOVF	__DHCPReceive_tempServerID_1_1, W, B
	BANKSEL	(_DHCPClient + 11)
	MOVWF	(_DHCPClient + 11), B
	BANKSEL	(__DHCPReceive_tempServerID_1_1 + 1)
	MOVF	(__DHCPReceive_tempServerID_1_1 + 1), W, B
	BANKSEL	(_DHCPClient + 12)
	MOVWF	(_DHCPClient + 12), B
	BANKSEL	(__DHCPReceive_tempServerID_1_1 + 2)
	MOVF	(__DHCPReceive_tempServerID_1_1 + 2), W, B
	BANKSEL	(_DHCPClient + 13)
	MOVWF	(_DHCPClient + 13), B
	BANKSEL	(__DHCPReceive_tempServerID_1_1 + 3)
	MOVF	(__DHCPReceive_tempServerID_1_1 + 3), W, B
	BANKSEL	(_DHCPClient + 14)
	MOVWF	(_DHCPClient + 14), B
	BANKSEL	(_DHCPClient + 2)
;	.line	1000; TCPIP_Stack/DHCP.c	DHCPClient.flags.bits.bOfferReceived = TRUE;
	BSF	(_DHCPClient + 2), 2, B
	BRA	_00350_DS_
_00349_DS_:
	BANKSEL	(_DHCPClient + 11)
;	.line	1006; TCPIP_Stack/DHCP.c	if ( DHCPClient.dwServerID != tempServerID.Val )
	MOVF	(_DHCPClient + 11), W, B
	BANKSEL	__DHCPReceive_tempServerID_1_1
	XORWF	__DHCPReceive_tempServerID_1_1, W, B
	BNZ	_00457_DS_
	BANKSEL	(_DHCPClient + 12)
	MOVF	(_DHCPClient + 12), W, B
	BANKSEL	(__DHCPReceive_tempServerID_1_1 + 1)
	XORWF	(__DHCPReceive_tempServerID_1_1 + 1), W, B
	BNZ	_00457_DS_
	BANKSEL	(_DHCPClient + 13)
	MOVF	(_DHCPClient + 13), W, B
	BANKSEL	(__DHCPReceive_tempServerID_1_1 + 2)
	XORWF	(__DHCPReceive_tempServerID_1_1 + 2), W, B
	BNZ	_00457_DS_
	BANKSEL	(_DHCPClient + 14)
	MOVF	(_DHCPClient + 14), W, B
	BANKSEL	(__DHCPReceive_tempServerID_1_1 + 3)
	XORWF	(__DHCPReceive_tempServerID_1_1 + 3), W, B
	BZ	_00350_DS_
_00457_DS_:
	BANKSEL	__DHCPReceive_type_1_1
;	.line	1007; TCPIP_Stack/DHCP.c	type = DHCP_UNKNOWN_MESSAGE;
	CLRF	__DHCPReceive_type_1_1, B
_00350_DS_:
;	.line	1010; TCPIP_Stack/DHCP.c	UDPDiscard();  // We are done with this packet
	CALL	_UDPDiscard
	BANKSEL	__DHCPReceive_type_1_1
;	.line	1011; TCPIP_Stack/DHCP.c	return type;
	MOVF	__DHCPReceive_type_1_1, W, B
	BRA	_00377_DS_
_00351_DS_:
;	.line	1014; TCPIP_Stack/DHCP.c	UDPDiscard();
	CALL	_UDPDiscard
;	.line	1015; TCPIP_Stack/DHCP.c	return DHCP_UNKNOWN_MESSAGE;
	CLRF	WREG
_00377_DS_:
	MOVFF	PREINC1, r0x05
	MOVFF	PREINC1, r0x04
	MOVFF	PREINC1, r0x03
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_DHCP__DHCPTask	code
_DHCPTask:
;	.line	485; TCPIP_Stack/DHCP.c	void DHCPTask(void)
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
;	.line	489; TCPIP_Stack/DHCP.c	for(i = 0; i < NETWORK_INTERFACES; i++)
	CLRF	r0x00
_00227_DS_:
	MOVFF	r0x00, r0x01
	CLRF	r0x02
	MOVLW	0x00
	SUBWF	r0x02, W
	BNZ	_00259_DS_
	MOVLW	0x01
	SUBWF	r0x01, W
_00259_DS_:
	BTFSC	STATUS, 0
	GOTO	_00231_DS_
;	.line	491; TCPIP_Stack/DHCP.c	LoadState(i);
	CLRF	r0x00
;	.line	492; TCPIP_Stack/DHCP.c	switch(DHCPClient.smState)
	MOVFF	(_DHCPClient + 1), r0x01
	MOVLW	0x0d
	SUBWF	r0x01, W
	BTFSC	STATUS, 0
	GOTO	_00229_DS_
	MOVFF	r0x09, POSTDEC1
	MOVFF	r0x0a, POSTDEC1
	CLRF	r0x0a
	RLCF	r0x01, W
	RLCF	r0x0a, F
	RLCF	WREG, W
	RLCF	r0x0a, F
	ANDLW	0xfc
	MOVWF	r0x09
	MOVLW	UPPER(_00261_DS_)
	MOVWF	PCLATU
	MOVLW	HIGH(_00261_DS_)
	MOVWF	PCLATH
	MOVLW	LOW(_00261_DS_)
	ADDWF	r0x09, F
	MOVF	r0x0a, W
	ADDWFC	PCLATH, F
	BTFSC	STATUS, 0
	INCF	PCLATU, F
	MOVF	r0x09, W
	MOVFF	PREINC1, r0x0a
	MOVFF	PREINC1, r0x09
	MOVWF	PCL
_00261_DS_:
	GOTO	_00169_DS_
	GOTO	_00170_DS_
	GOTO	_00173_DS_
	GOTO	_00178_DS_
	GOTO	_00185_DS_
	GOTO	_00188_DS_
	GOTO	_00202_DS_
	GOTO	_00211_DS_
	GOTO	_00216_DS_
	GOTO	_00211_DS_
	GOTO	_00216_DS_
	GOTO	_00211_DS_
	GOTO	_00216_DS_
_00169_DS_:
;	.line	496; TCPIP_Stack/DHCP.c	break;
	GOTO	_00229_DS_
_00170_DS_:
;	.line	501; TCPIP_Stack/DHCP.c	UDPOpen(DHCP_CLIENT_PORT, NULL, DHCP_SERVER_PORT);
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x43
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x44
	MOVWF	POSTDEC1
	CALL	_UDPOpen
	MOVWF	r0x01
	MOVLW	0x07
	ADDWF	FSR1L, F
	MOVF	r0x01, W
	BANKSEL	_DHCPClient
	MOVWF	_DHCPClient, B
;	.line	502; TCPIP_Stack/DHCP.c	if(DHCPClient.hDHCPSocket == INVALID_UDP_SOCKET) break;
	MOVFF	_DHCPClient, r0x01
	CLRF	r0x02
	MOVF	r0x01, W
	XORLW	0xff
	BNZ	_00263_DS_
	MOVF	r0x02, W
	BNZ	_00263_DS_
	GOTO	_00229_DS_
_00263_DS_:
;	.line	504; TCPIP_Stack/DHCP.c	DHCPClient.smState = SM_DHCP_SEND_DISCOVERY;
	MOVLW	0x02
	BANKSEL	(_DHCPClient + 1)
	MOVWF	(_DHCPClient + 1), B
_00173_DS_:
;	.line	512; TCPIP_Stack/DHCP.c	DHCPClient.dwLeaseTime = 60;
	MOVLW	0x3c
	BANKSEL	(_DHCPClient + 7)
	MOVWF	(_DHCPClient + 7), B
	BANKSEL	(_DHCPClient + 8)
	CLRF	(_DHCPClient + 8), B
	BANKSEL	(_DHCPClient + 9)
	CLRF	(_DHCPClient + 9), B
	BANKSEL	(_DHCPClient + 10)
	CLRF	(_DHCPClient + 10), B
	BANKSEL	(_DHCPClient + 27)
;	.line	513; TCPIP_Stack/DHCP.c	DHCPClient.validValues.val = 0x00;
	CLRF	(_DHCPClient + 27), B
	BANKSEL	(_DHCPClient + 2)
;	.line	514; TCPIP_Stack/DHCP.c	DHCPClient.flags.bits.bIsBound = FALSE;	
	BCF	(_DHCPClient + 2), 0, B
	BANKSEL	(_DHCPClient + 2)
;	.line	515; TCPIP_Stack/DHCP.c	DHCPClient.flags.bits.bOfferReceived = FALSE;
	BCF	(_DHCPClient + 2), 2, B
;	.line	519; TCPIP_Stack/DHCP.c	if(!MACIsLinked()) break;
	CALL	_MACIsLinked
	MOVWF	r0x01
	MOVF	r0x01, W
	BTFSC	STATUS, 2
	GOTO	_00229_DS_
	BANKSEL	_DHCPClient
;	.line	522; TCPIP_Stack/DHCP.c	if(UDPIsPutReady(DHCPClient.hDHCPSocket) < 300u) break;
	MOVF	_DHCPClient, W, B
	MOVWF	POSTDEC1
	CALL	_UDPIsPutReady
	MOVWF	r0x01
	MOVFF	PRODL, r0x02
	INCF	FSR1L, F
	MOVLW	0x01
	SUBWF	r0x02, W
	BNZ	_00264_DS_
	MOVLW	0x2c
	SUBWF	r0x01, W
_00264_DS_:
	BTFSS	STATUS, 0
	GOTO	_00229_DS_
;	.line	528; TCPIP_Stack/DHCP.c	DHCPClient.flags.bits.bUseUnicastMode ^= 1;
	CLRF	r0x01
	BANKSEL	(_DHCPClient + 2)
	BTFSC	(_DHCPClient + 2), 4, B
	INCF	r0x01, F
	MOVLW	0x01
	XORWF	r0x01, F
	MOVF	r0x01, W
	ANDLW	0x01
	SWAPF	WREG, W
	MOVWF	PRODH
	BANKSEL	(_DHCPClient + 2)
	MOVF	(_DHCPClient + 2), W, B
	ANDLW	0xef
	IORWF	PRODH, W
	BANKSEL	(_DHCPClient + 2)
	MOVWF	(_DHCPClient + 2), B
; ;multiply lit val:0x0e by variable _DHCPClient and store in r0x01
; ;Unrolled 8 X 8 multiplication
; ;FIXME: the function does not support result==WREG
	BANKSEL	_DHCPClient
;	.line	533; TCPIP_Stack/DHCP.c	memset((void*)&UDPSocketInfo[DHCPClient.hDHCPSocket].remoteNode,
	MOVF	_DHCPClient, W, B
	MULLW	0x0e
	MOVFF	PRODL, r0x01
	CLRF	r0x02
	MOVLW	LOW(_UDPSocketInfo)
	ADDWF	r0x01, F
	MOVLW	HIGH(_UDPSocketInfo)
	ADDWFC	r0x02, F
;	.line	534; TCPIP_Stack/DHCP.c	0xFF, sizeof(UDPSocketInfo[0].remoteNode));
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x0a
	MOVWF	POSTDEC1
	MOVLW	0xff
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	CALL	_memset
	MOVLW	0x05
	ADDWF	FSR1L, F
;	.line	537; TCPIP_Stack/DHCP.c	_DHCPSend(DHCP_DISCOVER_MESSAGE, FALSE);
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x01
	MOVWF	POSTDEC1
	CALL	__DHCPSend
	MOVLW	0x02
	ADDWF	FSR1L, F
;	.line	540; TCPIP_Stack/DHCP.c	DHCPClient.dwTimer = TickGet();
	CALL	_TickGet
	MOVWF	r0x01
	MOVFF	PRODL, r0x02
	MOVFF	PRODH, r0x03
	MOVFF	FSR0L, r0x04
	MOVF	r0x01, W
	BANKSEL	(_DHCPClient + 3)
	MOVWF	(_DHCPClient + 3), B
	MOVF	r0x02, W
	BANKSEL	(_DHCPClient + 4)
	MOVWF	(_DHCPClient + 4), B
	MOVF	r0x03, W
	BANKSEL	(_DHCPClient + 5)
	MOVWF	(_DHCPClient + 5), B
	MOVF	r0x04, W
	BANKSEL	(_DHCPClient + 6)
	MOVWF	(_DHCPClient + 6), B
;	.line	541; TCPIP_Stack/DHCP.c	DHCPClient.smState = SM_DHCP_GET_OFFER;
	MOVLW	0x03
	BANKSEL	(_DHCPClient + 1)
	MOVWF	(_DHCPClient + 1), B
;	.line	542; TCPIP_Stack/DHCP.c	break;
	GOTO	_00229_DS_
_00178_DS_:
	BANKSEL	_DHCPClient
;	.line	546; TCPIP_Stack/DHCP.c	if(UDPIsGetReady(DHCPClient.hDHCPSocket) < 250u)
	MOVF	_DHCPClient, W, B
	MOVWF	POSTDEC1
	CALL	_UDPIsGetReady
	MOVWF	r0x01
	MOVFF	PRODL, r0x02
	INCF	FSR1L, F
	MOVLW	0x00
	SUBWF	r0x02, W
	BNZ	_00266_DS_
	MOVLW	0xfa
	SUBWF	r0x01, W
_00266_DS_:
	BC	_00182_DS_
;	.line	550; TCPIP_Stack/DHCP.c	if(TickGet() - DHCPClient.dwTimer >= DHCP_TIMEOUT)
	CALL	_TickGet
	MOVWF	r0x01
	MOVFF	PRODL, r0x02
	MOVFF	PRODH, r0x03
	MOVFF	FSR0L, r0x04
	BANKSEL	(_DHCPClient + 3)
	MOVF	(_DHCPClient + 3), W, B
	SUBWF	r0x01, F
	BANKSEL	(_DHCPClient + 4)
	MOVF	(_DHCPClient + 4), W, B
	SUBWFB	r0x02, F
	BANKSEL	(_DHCPClient + 5)
	MOVF	(_DHCPClient + 5), W, B
	SUBWFB	r0x03, F
	BANKSEL	(_DHCPClient + 6)
	MOVF	(_DHCPClient + 6), W, B
	SUBWFB	r0x04, F
	MOVLW	0x00
	SUBWF	r0x04, W
	BNZ	_00267_DS_
	MOVLW	0x01
	SUBWF	r0x03, W
	BNZ	_00267_DS_
	MOVLW	0x3d
	SUBWF	r0x02, W
	BNZ	_00267_DS_
	MOVLW	0xe4
	SUBWF	r0x01, W
_00267_DS_:
	BTFSS	STATUS, 0
	GOTO	_00229_DS_
;	.line	551; TCPIP_Stack/DHCP.c	DHCPClient.smState = SM_DHCP_SEND_DISCOVERY;
	MOVLW	0x02
	BANKSEL	(_DHCPClient + 1)
	MOVWF	(_DHCPClient + 1), B
;	.line	552; TCPIP_Stack/DHCP.c	break;
	GOTO	_00229_DS_
_00182_DS_:
	BANKSEL	(_DHCPClient + 2)
;	.line	557; TCPIP_Stack/DHCP.c	DHCPClient.flags.bits.bDHCPServerDetected = TRUE;
	BSF	(_DHCPClient + 2), 3, B
;	.line	560; TCPIP_Stack/DHCP.c	if(_DHCPReceive() != DHCP_OFFER_MESSAGE) break;
	CALL	__DHCPReceive
	MOVWF	r0x01
	CLRF	r0x02
	MOVF	r0x01, W
	XORLW	0x02
	BNZ	_00268_DS_
	MOVF	r0x02, W
	BZ	_00269_DS_
_00268_DS_:
	GOTO	_00229_DS_
_00269_DS_:
;	.line	561; TCPIP_Stack/DHCP.c	DHCPClient.smState = SM_DHCP_SEND_REQUEST;
	MOVLW	0x04
	BANKSEL	(_DHCPClient + 1)
	MOVWF	(_DHCPClient + 1), B
_00185_DS_:
	BANKSEL	_DHCPClient
;	.line	565; TCPIP_Stack/DHCP.c	if(UDPIsPutReady(DHCPClient.hDHCPSocket) < 258u) break;
	MOVF	_DHCPClient, W, B
	MOVWF	POSTDEC1
	CALL	_UDPIsPutReady
	MOVWF	r0x01
	MOVFF	PRODL, r0x02
	INCF	FSR1L, F
	MOVLW	0x01
	SUBWF	r0x02, W
	BNZ	_00270_DS_
	MOVLW	0x02
	SUBWF	r0x01, W
_00270_DS_:
	BTFSS	STATUS, 0
	GOTO	_00229_DS_
; ;multiply lit val:0x0e by variable _DHCPClient and store in r0x01
; ;Unrolled 8 X 8 multiplication
; ;FIXME: the function does not support result==WREG
	BANKSEL	_DHCPClient
;	.line	572; TCPIP_Stack/DHCP.c	memset((void*)&UDPSocketInfo[DHCPClient.hDHCPSocket].remoteNode,
	MOVF	_DHCPClient, W, B
	MULLW	0x0e
	MOVFF	PRODL, r0x01
	CLRF	r0x02
	MOVLW	LOW(_UDPSocketInfo)
	ADDWF	r0x01, F
	MOVLW	HIGH(_UDPSocketInfo)
	ADDWFC	r0x02, F
;	.line	573; TCPIP_Stack/DHCP.c	0xFF, sizeof(UDPSocketInfo[0].remoteNode));
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x0a
	MOVWF	POSTDEC1
	MOVLW	0xff
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	CALL	_memset
	MOVLW	0x05
	ADDWF	FSR1L, F
;	.line	576; TCPIP_Stack/DHCP.c	_DHCPSend(DHCP_REQUEST_MESSAGE, FALSE);	
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x03
	MOVWF	POSTDEC1
	CALL	__DHCPSend
	MOVLW	0x02
	ADDWF	FSR1L, F
;	.line	579; TCPIP_Stack/DHCP.c	DHCPClient.dwTimer = TickGet();
	CALL	_TickGet
	MOVWF	r0x01
	MOVFF	PRODL, r0x02
	MOVFF	PRODH, r0x03
	MOVFF	FSR0L, r0x04
	MOVF	r0x01, W
	BANKSEL	(_DHCPClient + 3)
	MOVWF	(_DHCPClient + 3), B
	MOVF	r0x02, W
	BANKSEL	(_DHCPClient + 4)
	MOVWF	(_DHCPClient + 4), B
	MOVF	r0x03, W
	BANKSEL	(_DHCPClient + 5)
	MOVWF	(_DHCPClient + 5), B
	MOVF	r0x04, W
	BANKSEL	(_DHCPClient + 6)
	MOVWF	(_DHCPClient + 6), B
;	.line	580; TCPIP_Stack/DHCP.c	DHCPClient.smState = SM_DHCP_GET_REQUEST_ACK;
	MOVLW	0x05
	BANKSEL	(_DHCPClient + 1)
	MOVWF	(_DHCPClient + 1), B
;	.line	581; TCPIP_Stack/DHCP.c	break;
	GOTO	_00229_DS_
_00188_DS_:
	BANKSEL	_DHCPClient
;	.line	585; TCPIP_Stack/DHCP.c	if(UDPIsGetReady(DHCPClient.hDHCPSocket) < 250u)
	MOVF	_DHCPClient, W, B
	MOVWF	POSTDEC1
	CALL	_UDPIsGetReady
	MOVWF	r0x01
	MOVFF	PRODL, r0x02
	INCF	FSR1L, F
	MOVLW	0x00
	SUBWF	r0x02, W
	BNZ	_00271_DS_
	MOVLW	0xfa
	SUBWF	r0x01, W
_00271_DS_:
	BC	_00192_DS_
;	.line	589; TCPIP_Stack/DHCP.c	if(TickGet() - DHCPClient.dwTimer >= DHCP_TIMEOUT)
	CALL	_TickGet
	MOVWF	r0x01
	MOVFF	PRODL, r0x02
	MOVFF	PRODH, r0x03
	MOVFF	FSR0L, r0x04
	BANKSEL	(_DHCPClient + 3)
	MOVF	(_DHCPClient + 3), W, B
	SUBWF	r0x01, F
	BANKSEL	(_DHCPClient + 4)
	MOVF	(_DHCPClient + 4), W, B
	SUBWFB	r0x02, F
	BANKSEL	(_DHCPClient + 5)
	MOVF	(_DHCPClient + 5), W, B
	SUBWFB	r0x03, F
	BANKSEL	(_DHCPClient + 6)
	MOVF	(_DHCPClient + 6), W, B
	SUBWFB	r0x04, F
	MOVLW	0x00
	SUBWF	r0x04, W
	BNZ	_00272_DS_
	MOVLW	0x01
	SUBWF	r0x03, W
	BNZ	_00272_DS_
	MOVLW	0x3d
	SUBWF	r0x02, W
	BNZ	_00272_DS_
	MOVLW	0xe4
	SUBWF	r0x01, W
_00272_DS_:
	BTFSS	STATUS, 0
	BRA	_00229_DS_
;	.line	590; TCPIP_Stack/DHCP.c	DHCPClient.smState = SM_DHCP_SEND_DISCOVERY;
	MOVLW	0x02
	BANKSEL	(_DHCPClient + 1)
	MOVWF	(_DHCPClient + 1), B
;	.line	591; TCPIP_Stack/DHCP.c	break;
	BRA	_00229_DS_
_00192_DS_:
;	.line	595; TCPIP_Stack/DHCP.c	switch(_DHCPReceive())
	CALL	__DHCPReceive
	MOVWF	r0x01
	CLRF	r0x02
	MOVF	r0x01, W
	XORLW	0x05
	BNZ	_00274_DS_
	MOVF	r0x02, W
	BZ	_00193_DS_
_00274_DS_:
	MOVF	r0x01, W
	XORLW	0x06
	BNZ	_00276_DS_
	MOVF	r0x02, W
	BNZ	_00276_DS_
	BRA	_00200_DS_
_00276_DS_:
	BRA	_00229_DS_
_00193_DS_:
	BANKSEL	_DHCPClient
;	.line	598; TCPIP_Stack/DHCP.c	UDPClose(DHCPClient.hDHCPSocket);
	MOVF	_DHCPClient, W, B
	MOVWF	POSTDEC1
	CALL	_UDPClose
	INCF	FSR1L, F
	BANKSEL	_DHCPClient
;	.line	599; TCPIP_Stack/DHCP.c	DHCPClient.hDHCPSocket = INVALID_UDP_SOCKET;
	SETF	_DHCPClient, B
;	.line	600; TCPIP_Stack/DHCP.c	DHCPClient.dwTimer = TickGet();
	CALL	_TickGet
	MOVWF	r0x01
	MOVFF	PRODL, r0x02
	MOVFF	PRODH, r0x03
	MOVFF	FSR0L, r0x04
	MOVF	r0x01, W
	BANKSEL	(_DHCPClient + 3)
	MOVWF	(_DHCPClient + 3), B
	MOVF	r0x02, W
	BANKSEL	(_DHCPClient + 4)
	MOVWF	(_DHCPClient + 4), B
	MOVF	r0x03, W
	BANKSEL	(_DHCPClient + 5)
	MOVWF	(_DHCPClient + 5), B
	MOVF	r0x04, W
	BANKSEL	(_DHCPClient + 6)
	MOVWF	(_DHCPClient + 6), B
;	.line	601; TCPIP_Stack/DHCP.c	DHCPClient.smState = SM_DHCP_BOUND;
	MOVLW	0x06
	BANKSEL	(_DHCPClient + 1)
	MOVWF	(_DHCPClient + 1), B
	BANKSEL	(_DHCPClient + 2)
;	.line	602; TCPIP_Stack/DHCP.c	DHCPClient.flags.bits.bEvent = 1;
	BSF	(_DHCPClient + 2), 1, B
	BANKSEL	(_DHCPClient + 2)
;	.line	603; TCPIP_Stack/DHCP.c	DHCPClient.flags.bits.bIsBound = TRUE;	
	BSF	(_DHCPClient + 2), 0, B
	BANKSEL	(_DHCPClient + 27)
;	.line	605; TCPIP_Stack/DHCP.c	if(DHCPClient.validValues.bits.IPAddress)
	BTFSS	(_DHCPClient + 27), 0, B
	BRA	_00195_DS_
	BANKSEL	(_DHCPClient + 15)
;	.line	606; TCPIP_Stack/DHCP.c	AppConfig.MyIPAddr.Val = DHCPClient.tempIPAddress.Val;
	MOVF	(_DHCPClient + 15), W, B
	BANKSEL	_AppConfig
	MOVWF	_AppConfig, B
	BANKSEL	(_DHCPClient + 16)
	MOVF	(_DHCPClient + 16), W, B
	BANKSEL	(_AppConfig + 1)
	MOVWF	(_AppConfig + 1), B
	BANKSEL	(_DHCPClient + 17)
	MOVF	(_DHCPClient + 17), W, B
	BANKSEL	(_AppConfig + 2)
	MOVWF	(_AppConfig + 2), B
	BANKSEL	(_DHCPClient + 18)
	MOVF	(_DHCPClient + 18), W, B
	BANKSEL	(_AppConfig + 3)
	MOVWF	(_AppConfig + 3), B
_00195_DS_:
	BANKSEL	(_DHCPClient + 27)
;	.line	607; TCPIP_Stack/DHCP.c	if(DHCPClient.validValues.bits.Mask)
	BTFSS	(_DHCPClient + 27), 2, B
	BRA	_00197_DS_
	BANKSEL	(_DHCPClient + 23)
;	.line	608; TCPIP_Stack/DHCP.c	AppConfig.MyMask.Val = DHCPClient.tempMask.Val;
	MOVF	(_DHCPClient + 23), W, B
	BANKSEL	(_AppConfig + 4)
	MOVWF	(_AppConfig + 4), B
	BANKSEL	(_DHCPClient + 24)
	MOVF	(_DHCPClient + 24), W, B
	BANKSEL	(_AppConfig + 5)
	MOVWF	(_AppConfig + 5), B
	BANKSEL	(_DHCPClient + 25)
	MOVF	(_DHCPClient + 25), W, B
	BANKSEL	(_AppConfig + 6)
	MOVWF	(_AppConfig + 6), B
	BANKSEL	(_DHCPClient + 26)
	MOVF	(_DHCPClient + 26), W, B
	BANKSEL	(_AppConfig + 7)
	MOVWF	(_AppConfig + 7), B
_00197_DS_:
	BANKSEL	(_DHCPClient + 27)
;	.line	609; TCPIP_Stack/DHCP.c	if(DHCPClient.validValues.bits.Gateway)
	BTFSS	(_DHCPClient + 27), 1, B
	BRA	_00229_DS_
	BANKSEL	(_DHCPClient + 19)
;	.line	610; TCPIP_Stack/DHCP.c	AppConfig.MyGateway.Val = DHCPClient.tempGateway.Val;
	MOVF	(_DHCPClient + 19), W, B
	BANKSEL	(_AppConfig + 8)
	MOVWF	(_AppConfig + 8), B
	BANKSEL	(_DHCPClient + 20)
	MOVF	(_DHCPClient + 20), W, B
	BANKSEL	(_AppConfig + 9)
	MOVWF	(_AppConfig + 9), B
	BANKSEL	(_DHCPClient + 21)
	MOVF	(_DHCPClient + 21), W, B
	BANKSEL	(_AppConfig + 10)
	MOVWF	(_AppConfig + 10), B
	BANKSEL	(_DHCPClient + 22)
	MOVF	(_DHCPClient + 22), W, B
	BANKSEL	(_AppConfig + 11)
	MOVWF	(_AppConfig + 11), B
;	.line	624; TCPIP_Stack/DHCP.c	break;
	BRA	_00229_DS_
_00200_DS_:
;	.line	627; TCPIP_Stack/DHCP.c	DHCPClient.smState = SM_DHCP_SEND_DISCOVERY;
	MOVLW	0x02
	BANKSEL	(_DHCPClient + 1)
	MOVWF	(_DHCPClient + 1), B
;	.line	630; TCPIP_Stack/DHCP.c	break;
	BRA	_00229_DS_
_00202_DS_:
;	.line	633; TCPIP_Stack/DHCP.c	if(TickGet() - DHCPClient.dwTimer < TICK_SECOND) break;
	CALL	_TickGet
	MOVWF	r0x01
	MOVFF	PRODL, r0x02
	MOVFF	PRODH, r0x03
	MOVFF	FSR0L, r0x04
	MOVFF	(_DHCPClient + 3), r0x05
	MOVFF	(_DHCPClient + 4), r0x06
	MOVFF	(_DHCPClient + 5), r0x07
	MOVFF	(_DHCPClient + 6), r0x08
	MOVF	r0x05, W
	SUBWF	r0x01, F
	MOVF	r0x06, W
	SUBWFB	r0x02, F
	MOVF	r0x07, W
	SUBWFB	r0x03, F
	MOVF	r0x08, W
	SUBWFB	r0x04, F
	MOVLW	0x00
	SUBWF	r0x04, W
	BNZ	_00277_DS_
	MOVLW	0x00
	SUBWF	r0x03, W
	BNZ	_00277_DS_
	MOVLW	0x9e
	SUBWF	r0x02, W
	BNZ	_00277_DS_
	MOVLW	0xf2
	SUBWF	r0x01, W
_00277_DS_:
	BTFSS	STATUS, 0
	BRA	_00229_DS_
;	.line	637; TCPIP_Stack/DHCP.c	if(DHCPClient.dwLeaseTime >= 2ul)
	MOVFF	(_DHCPClient + 7), r0x01
	MOVFF	(_DHCPClient + 8), r0x02
	MOVFF	(_DHCPClient + 9), r0x03
	MOVFF	(_DHCPClient + 10), r0x04
	MOVLW	0x00
	SUBWF	r0x04, W
	BNZ	_00278_DS_
	MOVLW	0x00
	SUBWF	r0x03, W
	BNZ	_00278_DS_
	MOVLW	0x00
	SUBWF	r0x02, W
	BNZ	_00278_DS_
	MOVLW	0x02
	SUBWF	r0x01, W
_00278_DS_:
	BNC	_00206_DS_
;	.line	639; TCPIP_Stack/DHCP.c	DHCPClient.dwTimer += TICK_SECOND;
	MOVLW	0xf2
	ADDWF	r0x05, F
	MOVLW	0x9e
	ADDWFC	r0x06, F
	MOVLW	0x00
	ADDWFC	r0x07, F
	MOVLW	0x00
	ADDWFC	r0x08, F
	MOVF	r0x05, W
	BANKSEL	(_DHCPClient + 3)
	MOVWF	(_DHCPClient + 3), B
	MOVF	r0x06, W
	BANKSEL	(_DHCPClient + 4)
	MOVWF	(_DHCPClient + 4), B
	MOVF	r0x07, W
	BANKSEL	(_DHCPClient + 5)
	MOVWF	(_DHCPClient + 5), B
	MOVF	r0x08, W
	BANKSEL	(_DHCPClient + 6)
	MOVWF	(_DHCPClient + 6), B
;	.line	640; TCPIP_Stack/DHCP.c	DHCPClient.dwLeaseTime--;
	MOVLW	0xff
	ADDWF	r0x01, F
	MOVLW	0xff
	ADDWFC	r0x02, F
	MOVLW	0xff
	ADDWFC	r0x03, F
	MOVLW	0xff
	ADDWFC	r0x04, F
	MOVF	r0x01, W
	BANKSEL	(_DHCPClient + 7)
	MOVWF	(_DHCPClient + 7), B
	MOVF	r0x02, W
	BANKSEL	(_DHCPClient + 8)
	MOVWF	(_DHCPClient + 8), B
	MOVF	r0x03, W
	BANKSEL	(_DHCPClient + 9)
	MOVWF	(_DHCPClient + 9), B
	MOVF	r0x04, W
	BANKSEL	(_DHCPClient + 10)
	MOVWF	(_DHCPClient + 10), B
;	.line	641; TCPIP_Stack/DHCP.c	break;
	BRA	_00229_DS_
_00206_DS_:
;	.line	646; TCPIP_Stack/DHCP.c	NULL, DHCP_SERVER_PORT);
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x43
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x44
	MOVWF	POSTDEC1
	CALL	_UDPOpen
	MOVWF	r0x01
	MOVLW	0x07
	ADDWF	FSR1L, F
	MOVF	r0x01, W
	BANKSEL	_DHCPClient
	MOVWF	_DHCPClient, B
;	.line	647; TCPIP_Stack/DHCP.c	if(DHCPClient.hDHCPSocket == INVALID_UDP_SOCKET) break;
	MOVFF	_DHCPClient, r0x01
	CLRF	r0x02
	MOVF	r0x01, W
	XORLW	0xff
	BNZ	_00280_DS_
	MOVF	r0x02, W
	BNZ	_00280_DS_
	BRA	_00229_DS_
_00280_DS_:
;	.line	649; TCPIP_Stack/DHCP.c	DHCPClient.smState = SM_DHCP_SEND_RENEW;
	MOVLW	0x07
	BANKSEL	(_DHCPClient + 1)
	MOVWF	(_DHCPClient + 1), B
_00211_DS_:
	BANKSEL	_DHCPClient
;	.line	655; TCPIP_Stack/DHCP.c	if(UDPIsPutReady(DHCPClient.hDHCPSocket) < 258u) break;
	MOVF	_DHCPClient, W, B
	MOVWF	POSTDEC1
	CALL	_UDPIsPutReady
	MOVWF	r0x01
	MOVFF	PRODL, r0x02
	INCF	FSR1L, F
	MOVLW	0x01
	SUBWF	r0x02, W
	BNZ	_00281_DS_
	MOVLW	0x02
	SUBWF	r0x01, W
_00281_DS_:
	BTFSS	STATUS, 0
	BRA	_00229_DS_
;	.line	658; TCPIP_Stack/DHCP.c	_DHCPSend(DHCP_REQUEST_MESSAGE, TRUE);
	MOVLW	0x01
	MOVWF	POSTDEC1
	MOVLW	0x03
	MOVWF	POSTDEC1
	CALL	__DHCPSend
	MOVLW	0x02
	ADDWF	FSR1L, F
	BANKSEL	(_DHCPClient + 2)
;	.line	659; TCPIP_Stack/DHCP.c	DHCPClient.flags.bits.bOfferReceived = FALSE;
	BCF	(_DHCPClient + 2), 2, B
;	.line	662; TCPIP_Stack/DHCP.c	DHCPClient.dwTimer = TickGet();
	CALL	_TickGet
	MOVWF	r0x01
	MOVFF	PRODL, r0x02
	MOVFF	PRODH, r0x03
	MOVFF	FSR0L, r0x04
	MOVF	r0x01, W
	BANKSEL	(_DHCPClient + 3)
	MOVWF	(_DHCPClient + 3), B
	MOVF	r0x02, W
	BANKSEL	(_DHCPClient + 4)
	MOVWF	(_DHCPClient + 4), B
	MOVF	r0x03, W
	BANKSEL	(_DHCPClient + 5)
	MOVWF	(_DHCPClient + 5), B
	MOVF	r0x04, W
	BANKSEL	(_DHCPClient + 6)
	MOVWF	(_DHCPClient + 6), B
;	.line	663; TCPIP_Stack/DHCP.c	DHCPClient.smState++;
	MOVFF	(_DHCPClient + 1), r0x01
	INCF	r0x01, F
	MOVF	r0x01, W
	BANKSEL	(_DHCPClient + 1)
	MOVWF	(_DHCPClient + 1), B
;	.line	664; TCPIP_Stack/DHCP.c	break;
	BRA	_00229_DS_
_00216_DS_:
	BANKSEL	_DHCPClient
;	.line	670; TCPIP_Stack/DHCP.c	if(UDPIsGetReady(DHCPClient.hDHCPSocket) < 250u)
	MOVF	_DHCPClient, W, B
	MOVWF	POSTDEC1
	CALL	_UDPIsGetReady
	MOVWF	r0x01
	MOVFF	PRODL, r0x02
	INCF	FSR1L, F
	MOVLW	0x00
	SUBWF	r0x02, W
	BNZ	_00282_DS_
	MOVLW	0xfa
	SUBWF	r0x01, W
_00282_DS_:
	BC	_00222_DS_
;	.line	674; TCPIP_Stack/DHCP.c	if(TickGet() - DHCPClient.dwTimer >=  DHCP_TIMEOUT)
	CALL	_TickGet
	MOVWF	r0x01
	MOVFF	PRODL, r0x02
	MOVFF	PRODH, r0x03
	MOVFF	FSR0L, r0x04
	BANKSEL	(_DHCPClient + 3)
	MOVF	(_DHCPClient + 3), W, B
	SUBWF	r0x01, F
	BANKSEL	(_DHCPClient + 4)
	MOVF	(_DHCPClient + 4), W, B
	SUBWFB	r0x02, F
	BANKSEL	(_DHCPClient + 5)
	MOVF	(_DHCPClient + 5), W, B
	SUBWFB	r0x03, F
	BANKSEL	(_DHCPClient + 6)
	MOVF	(_DHCPClient + 6), W, B
	SUBWFB	r0x04, F
	MOVLW	0x00
	SUBWF	r0x04, W
	BNZ	_00283_DS_
	MOVLW	0x01
	SUBWF	r0x03, W
	BNZ	_00283_DS_
	MOVLW	0x3d
	SUBWF	r0x02, W
	BNZ	_00283_DS_
	MOVLW	0xe4
	SUBWF	r0x01, W
_00283_DS_:
	BTFSS	STATUS, 0
	BRA	_00229_DS_
	BANKSEL	(_DHCPClient + 1)
;	.line	676; TCPIP_Stack/DHCP.c	if(++DHCPClient.smState > SM_DHCP_GET_RENEW_ACK3)
	INCF	(_DHCPClient + 1), W, B
	MOVWF	r0x01
	MOVF	r0x01, W
	BANKSEL	(_DHCPClient + 1)
	MOVWF	(_DHCPClient + 1), B
	MOVLW	0x0d
	SUBWF	r0x01, W
	BTFSS	STATUS, 0
	BRA	_00229_DS_
;	.line	677; TCPIP_Stack/DHCP.c	DHCPClient.smState = SM_DHCP_SEND_DISCOVERY;
	MOVLW	0x02
	BANKSEL	(_DHCPClient + 1)
	MOVWF	(_DHCPClient + 1), B
;	.line	679; TCPIP_Stack/DHCP.c	break;
	BRA	_00229_DS_
_00222_DS_:
;	.line	683; TCPIP_Stack/DHCP.c	switch(_DHCPReceive())
	CALL	__DHCPReceive
	MOVWF	r0x01
	CLRF	r0x02
	MOVF	r0x01, W
	XORLW	0x05
	BNZ	_00286_DS_
	MOVF	r0x02, W
	BZ	_00223_DS_
_00286_DS_:
	MOVF	r0x01, W
	XORLW	0x06
	BNZ	_00229_DS_
	MOVF	r0x02, W
	BZ	_00224_DS_
_00288_DS_:
	BRA	_00229_DS_
_00223_DS_:
	BANKSEL	_DHCPClient
;	.line	686; TCPIP_Stack/DHCP.c	UDPClose(DHCPClient.hDHCPSocket);
	MOVF	_DHCPClient, W, B
	MOVWF	POSTDEC1
	CALL	_UDPClose
	INCF	FSR1L, F
	BANKSEL	_DHCPClient
;	.line	687; TCPIP_Stack/DHCP.c	DHCPClient.hDHCPSocket = INVALID_UDP_SOCKET;
	SETF	_DHCPClient, B
;	.line	688; TCPIP_Stack/DHCP.c	DHCPClient.dwTimer = TickGet();
	CALL	_TickGet
	MOVWF	r0x01
	MOVFF	PRODL, r0x02
	MOVFF	PRODH, r0x03
	MOVFF	FSR0L, r0x04
	MOVF	r0x01, W
	BANKSEL	(_DHCPClient + 3)
	MOVWF	(_DHCPClient + 3), B
	MOVF	r0x02, W
	BANKSEL	(_DHCPClient + 4)
	MOVWF	(_DHCPClient + 4), B
	MOVF	r0x03, W
	BANKSEL	(_DHCPClient + 5)
	MOVWF	(_DHCPClient + 5), B
	MOVF	r0x04, W
	BANKSEL	(_DHCPClient + 6)
	MOVWF	(_DHCPClient + 6), B
;	.line	689; TCPIP_Stack/DHCP.c	DHCPClient.smState = SM_DHCP_BOUND;
	MOVLW	0x06
	BANKSEL	(_DHCPClient + 1)
	MOVWF	(_DHCPClient + 1), B
	BANKSEL	(_DHCPClient + 2)
;	.line	690; TCPIP_Stack/DHCP.c	DHCPClient.flags.bits.bEvent = 1;
	BSF	(_DHCPClient + 2), 1, B
;	.line	691; TCPIP_Stack/DHCP.c	break;
	BRA	_00229_DS_
_00224_DS_:
;	.line	694; TCPIP_Stack/DHCP.c	DHCPClient.smState = SM_DHCP_SEND_DISCOVERY;
	MOVLW	0x02
	BANKSEL	(_DHCPClient + 1)
	MOVWF	(_DHCPClient + 1), B
_00229_DS_:
;	.line	489; TCPIP_Stack/DHCP.c	for(i = 0; i < NETWORK_INTERFACES; i++)
	INCF	r0x00, F
	GOTO	_00227_DS_
_00231_DS_:
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
S_DHCP__DHCPIsServerDetected	code
_DHCPIsServerDetected:
;	.line	457; TCPIP_Stack/DHCP.c	BOOL DHCPIsServerDetected(BYTE vInterface)
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
;	.line	460; TCPIP_Stack/DHCP.c	return DHCPClient.flags.bits.bDHCPServerDetected;
	CLRF	r0x00
	BANKSEL	(_DHCPClient + 2)
	BTFSC	(_DHCPClient + 2), 3, B
	INCF	r0x00, F
	MOVF	r0x00, W
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_DHCP__DHCPStateChanged	code
_DHCPStateChanged:
;	.line	420; TCPIP_Stack/DHCP.c	BOOL DHCPStateChanged(BYTE vInterface)
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	BANKSEL	(_DHCPClient + 2)
;	.line	423; TCPIP_Stack/DHCP.c	if(DHCPClient.flags.bits.bEvent)
	BTFSS	(_DHCPClient + 2), 1, B
	BRA	_00158_DS_
	BANKSEL	(_DHCPClient + 2)
;	.line	425; TCPIP_Stack/DHCP.c	DHCPClient.flags.bits.bEvent = 0;
	BCF	(_DHCPClient + 2), 1, B
;	.line	426; TCPIP_Stack/DHCP.c	return TRUE;
	MOVLW	0x01
	BRA	_00159_DS_
_00158_DS_:
;	.line	428; TCPIP_Stack/DHCP.c	return FALSE;
	CLRF	WREG
_00159_DS_:
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_DHCP__DHCPIsBound	code
_DHCPIsBound:
;	.line	386; TCPIP_Stack/DHCP.c	BOOL DHCPIsBound(BYTE vInterface)
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
;	.line	389; TCPIP_Stack/DHCP.c	return DHCPClient.flags.bits.bIsBound;
	CLRF	r0x00
	BANKSEL	(_DHCPClient + 2)
	BTFSC	(_DHCPClient + 2), 0, B
	INCF	r0x00, F
	MOVF	r0x00, W
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_DHCP__DHCPIsEnabled	code
_DHCPIsEnabled:
;	.line	355; TCPIP_Stack/DHCP.c	BOOL DHCPIsEnabled(BYTE vInterface)
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
;	.line	358; TCPIP_Stack/DHCP.c	return DHCPClient.smState != SM_DHCP_DISABLED;
	CLRF	r0x00
	BANKSEL	(_DHCPClient + 1)
	MOVF	(_DHCPClient + 1), W, B
	BNZ	_00147_DS_
	INCF	r0x00, F
_00147_DS_:
	MOVF	r0x00, W
	BSF	STATUS, 0
	TSTFSZ	WREG
	BCF	STATUS, 0
	CLRF	r0x00
	RLCF	r0x00, F
	MOVF	r0x00, W
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_DHCP__DHCPEnable	code
_DHCPEnable:
;	.line	324; TCPIP_Stack/DHCP.c	void DHCPEnable(BYTE vInterface)
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	BANKSEL	(_DHCPClient + 1)
;	.line	328; TCPIP_Stack/DHCP.c	if(DHCPClient.smState == SM_DHCP_DISABLED)
	MOVF	(_DHCPClient + 1), W, B
	BNZ	_00139_DS_
;	.line	330; TCPIP_Stack/DHCP.c	DHCPClient.smState = SM_DHCP_GET_SOCKET;
	MOVLW	0x01
	BANKSEL	(_DHCPClient + 1)
	MOVWF	(_DHCPClient + 1), B
	BANKSEL	(_DHCPClient + 2)
;	.line	331; TCPIP_Stack/DHCP.c	DHCPClient.flags.bits.bIsBound = FALSE;
	BCF	(_DHCPClient + 2), 0, B
_00139_DS_:
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_DHCP__DHCPDisable	code
_DHCPDisable:
;	.line	289; TCPIP_Stack/DHCP.c	void DHCPDisable(BYTE vInterface)
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVFF	r0x02, POSTDEC1
;	.line	293; TCPIP_Stack/DHCP.c	if(DHCPClient.hDHCPSocket != INVALID_UDP_SOCKET)
	MOVFF	_DHCPClient, r0x00
	MOVFF	r0x00, r0x01
	CLRF	r0x02
	MOVF	r0x01, W
	XORLW	0xff
	BNZ	_00132_DS_
	MOVF	r0x02, W
	BZ	_00127_DS_
_00132_DS_:
;	.line	295; TCPIP_Stack/DHCP.c	UDPClose(DHCPClient.hDHCPSocket);
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_UDPClose
	INCF	FSR1L, F
	BANKSEL	_DHCPClient
;	.line	296; TCPIP_Stack/DHCP.c	DHCPClient.hDHCPSocket = INVALID_UDP_SOCKET;
	SETF	_DHCPClient, B
_00127_DS_:
	BANKSEL	(_DHCPClient + 1)
;	.line	299; TCPIP_Stack/DHCP.c	DHCPClient.smState = SM_DHCP_DISABLED;
	CLRF	(_DHCPClient + 1), B
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_DHCP__DHCPInit	code
_DHCPInit:
;	.line	223; TCPIP_Stack/DHCP.c	void DHCPInit(BYTE vInterface)
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVFF	r0x02, POSTDEC1
	BANKSEL	_DHCPClientInitializedOnce
;	.line	229; TCPIP_Stack/DHCP.c	if(!DHCPClientInitializedOnce)
	MOVF	_DHCPClientInitializedOnce, W, B
	BNZ	_00106_DS_
;	.line	231; TCPIP_Stack/DHCP.c	DHCPClientInitializedOnce = TRUE;
	MOVLW	0x01
	BANKSEL	_DHCPClientInitializedOnce
	MOVWF	_DHCPClientInitializedOnce, B
;	.line	232; TCPIP_Stack/DHCP.c	for(i = 0; i < NETWORK_INTERFACES; i++)
	CLRF	r0x00
_00109_DS_:
	MOVFF	r0x00, r0x01
	CLRF	r0x02
	MOVLW	0x00
	SUBWF	r0x02, W
	BNZ	_00119_DS_
	MOVLW	0x01
	SUBWF	r0x01, W
_00119_DS_:
	BC	_00106_DS_
	BANKSEL	_DHCPClient
;	.line	235; TCPIP_Stack/DHCP.c	DHCPClient.hDHCPSocket = INVALID_UDP_SOCKET;
	SETF	_DHCPClient, B
;	.line	232; TCPIP_Stack/DHCP.c	for(i = 0; i < NETWORK_INTERFACES; i++)
	MOVLW	0x01
	MOVWF	r0x00
	BRA	_00109_DS_
_00106_DS_:
;	.line	242; TCPIP_Stack/DHCP.c	if(DHCPClient.hDHCPSocket != INVALID_UDP_SOCKET)
	MOVFF	_DHCPClient, r0x00
	MOVFF	r0x00, r0x01
	CLRF	r0x02
	MOVF	r0x01, W
	XORLW	0xff
	BNZ	_00121_DS_
	MOVF	r0x02, W
	BZ	_00108_DS_
_00121_DS_:
;	.line	244; TCPIP_Stack/DHCP.c	UDPClose(DHCPClient.hDHCPSocket);
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_UDPClose
	INCF	FSR1L, F
	BANKSEL	_DHCPClient
;	.line	245; TCPIP_Stack/DHCP.c	DHCPClient.hDHCPSocket = INVALID_UDP_SOCKET;
	SETF	_DHCPClient, B
_00108_DS_:
;	.line	249; TCPIP_Stack/DHCP.c	DHCPClient.smState = SM_DHCP_GET_SOCKET;
	MOVLW	0x01
	BANKSEL	(_DHCPClient + 1)
	MOVWF	(_DHCPClient + 1), B
	BANKSEL	(_DHCPClient + 2)
;	.line	250; TCPIP_Stack/DHCP.c	DHCPClient.flags.val = 0;
	CLRF	(_DHCPClient + 2), B
	BANKSEL	(_DHCPClient + 2)
;	.line	251; TCPIP_Stack/DHCP.c	DHCPClient.flags.bits.bUseUnicastMode = TRUE; // This flag toggles before 
	BSF	(_DHCPClient + 2), 4, B
	BANKSEL	(_DHCPClient + 2)
;	.line	255; TCPIP_Stack/DHCP.c	DHCPClient.flags.bits.bEvent = TRUE;
	BSF	(_DHCPClient + 2), 1, B
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	



; Statistics:
; code size:	 4782 (0x12ae) bytes ( 3.65%)
;           	 2391 (0x0957) words
; udata size:	   39 (0x0027) bytes ( 1.02%)
; access size:	   11 (0x000b) bytes


	end
