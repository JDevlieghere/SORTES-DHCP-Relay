;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 2.9.4 #5582 (Dec  9 2009) (UNIX)
; This file was generated Wed Dec 16 00:32:12 2009
;--------------------------------------------------------
; PIC16 port for the Microchip 16-bit core micros
;--------------------------------------------------------
	list	p=18f97j60

	radix dec

;--------------------------------------------------------
; public variables in this module
;--------------------------------------------------------
	global _BerkeleyTCPServerDemo

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
	extern _socket
	extern _bind
	extern _listen
	extern _accept
	extern _send
	extern _recv
	extern _closesocket
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
PRODL	equ	0xff3


	idata
_BerkeleyTCPServerDemo_BSDServerState_1_1	db	0x00


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

udata_BerkeleyTCPServerDemo_0	udata
_BerkeleyTCPServerDemo_bsdServerSocket_1_1	res	1

udata_BerkeleyTCPServerDemo_1	udata
_BerkeleyTCPServerDemo_addrlen_1_1	res	2

udata_BerkeleyTCPServerDemo_2	udata
_BerkeleyTCPServerDemo_ClientSock_1_1	res	3

udata_BerkeleyTCPServerDemo_3	udata
_BerkeleyTCPServerDemo_addr_1_1	res	16

udata_BerkeleyTCPServerDemo_4	udata
_BerkeleyTCPServerDemo_bfr_1_1	res	15

udata_BerkeleyTCPServerDemo_5	udata
_BerkeleyTCPServerDemo_addRemote_1_1	res	16

;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
; I code from now on!
; ; Starting pCode block
S_BerkeleyTCPServerDemo__BerkeleyTCPServerDemo	code
_BerkeleyTCPServerDemo:
;	.line	86; BerkeleyTCPServerDemo.c	void BerkeleyTCPServerDemo(void)
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
;	.line	92; BerkeleyTCPServerDemo.c	int addrlen = sizeof(struct sockaddr_in);
	MOVLW	0x10
	BANKSEL	_BerkeleyTCPServerDemo_addrlen_1_1
	MOVWF	_BerkeleyTCPServerDemo_addrlen_1_1, B
	BANKSEL	(_BerkeleyTCPServerDemo_addrlen_1_1 + 1)
	CLRF	(_BerkeleyTCPServerDemo_addrlen_1_1 + 1), B
;	.line	105; BerkeleyTCPServerDemo.c	switch(BSDServerState)
	MOVLW	0x05
	BANKSEL	_BerkeleyTCPServerDemo_BSDServerState_1_1
	SUBWF	_BerkeleyTCPServerDemo_BSDServerState_1_1, W, B
	BTFSC	STATUS, 0
	BRA	_00135_DS_
	MOVFF	r0x0b, POSTDEC1
	MOVFF	r0x0c, POSTDEC1
	CLRF	r0x0c
	BANKSEL	_BerkeleyTCPServerDemo_BSDServerState_1_1
	RLCF	_BerkeleyTCPServerDemo_BSDServerState_1_1, W, B
	RLCF	r0x0c, F
	RLCF	WREG, W
	RLCF	r0x0c, F
	ANDLW	0xfc
	MOVWF	r0x0b
	MOVLW	UPPER(_00152_DS_)
	MOVWF	PCLATU
	MOVLW	HIGH(_00152_DS_)
	MOVWF	PCLATH
	MOVLW	LOW(_00152_DS_)
	ADDWF	r0x0b, F
	MOVF	r0x0c, W
	ADDWFC	PCLATH, F
	BTFSC	STATUS, 0
	INCF	PCLATU, F
	MOVF	r0x0b, W
	MOVFF	PREINC1, r0x0c
	MOVFF	PREINC1, r0x0b
	MOVWF	PCL
_00152_DS_:
	GOTO	_00105_DS_
	GOTO	_00106_DS_
	GOTO	_00109_DS_
	GOTO	_00112_DS_
	GOTO	_00148_DS_
_00105_DS_:
;	.line	110; BerkeleyTCPServerDemo.c	for(i = 0; i < MAX_CLIENT; i++)
	CLRF	r0x00
	CLRF	r0x01
_00131_DS_:
	MOVF	r0x01, W
	ADDLW	0x80
	ADDLW	0x80
	BNZ	_00153_DS_
	MOVLW	0x03
	SUBWF	r0x00, W
_00153_DS_:
	BC	_00134_DS_
;	.line	111; BerkeleyTCPServerDemo.c	ClientSock[i] = INVALID_SOCKET;
	MOVLW	LOW(_BerkeleyTCPServerDemo_ClientSock_1_1)
	ADDWF	r0x00, W
	MOVWF	r0x02
	MOVLW	HIGH(_BerkeleyTCPServerDemo_ClientSock_1_1)
	ADDWFC	r0x01, W
	MOVWF	r0x03
	MOVFF	r0x02, FSR0L
	MOVFF	r0x03, FSR0H
	MOVLW	0xfe
	MOVWF	INDF0
;	.line	110; BerkeleyTCPServerDemo.c	for(i = 0; i < MAX_CLIENT; i++)
	INCF	r0x00, F
	BTFSC	STATUS, 0
	INCF	r0x01, F
	BRA	_00131_DS_
_00134_DS_:
;	.line	113; BerkeleyTCPServerDemo.c	BSDServerState = BSD_CREATE_SOCKET;
	MOVLW	0x01
	BANKSEL	_BerkeleyTCPServerDemo_BSDServerState_1_1
	MOVWF	_BerkeleyTCPServerDemo_BSDServerState_1_1, B
_00106_DS_:
;	.line	118; BerkeleyTCPServerDemo.c	bsdServerSocket = socket(AF_INET, SOCK_STREAM, IPPROTO_TCP);
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x06
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x64
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x02
	MOVWF	POSTDEC1
	CALL	_socket
	BANKSEL	_BerkeleyTCPServerDemo_bsdServerSocket_1_1
	MOVWF	_BerkeleyTCPServerDemo_bsdServerSocket_1_1, B
	MOVLW	0x06
	ADDWF	FSR1L, F
	BANKSEL	_BerkeleyTCPServerDemo_bsdServerSocket_1_1
;	.line	119; BerkeleyTCPServerDemo.c	if(bsdServerSocket == INVALID_SOCKET)
	MOVF	_BerkeleyTCPServerDemo_bsdServerSocket_1_1, W, B
	XORLW	0xfe
	BNZ	_00108_DS_
;	.line	120; BerkeleyTCPServerDemo.c	return;
	BRA	_00135_DS_
_00108_DS_:
;	.line	122; BerkeleyTCPServerDemo.c	BSDServerState = BSD_BIND;
	MOVLW	0x02
	BANKSEL	_BerkeleyTCPServerDemo_BSDServerState_1_1
	MOVWF	_BerkeleyTCPServerDemo_BSDServerState_1_1, B
_00109_DS_:
;	.line	127; BerkeleyTCPServerDemo.c	addr.sin_port = PORTNUM;
	MOVLW	0x24
	BANKSEL	(_BerkeleyTCPServerDemo_addr_1_1 + 2)
	MOVWF	(_BerkeleyTCPServerDemo_addr_1_1 + 2), B
	MOVLW	0x26
	BANKSEL	(_BerkeleyTCPServerDemo_addr_1_1 + 3)
	MOVWF	(_BerkeleyTCPServerDemo_addr_1_1 + 3), B
	BANKSEL	(_BerkeleyTCPServerDemo_addr_1_1 + 4)
;	.line	128; BerkeleyTCPServerDemo.c	addr.sin_addr.S_un.S_addr = IP_ADDR_ANY;
	CLRF	(_BerkeleyTCPServerDemo_addr_1_1 + 4), B
	BANKSEL	(_BerkeleyTCPServerDemo_addr_1_1 + 5)
	CLRF	(_BerkeleyTCPServerDemo_addr_1_1 + 5), B
	BANKSEL	(_BerkeleyTCPServerDemo_addr_1_1 + 6)
	CLRF	(_BerkeleyTCPServerDemo_addr_1_1 + 6), B
	BANKSEL	(_BerkeleyTCPServerDemo_addr_1_1 + 7)
	CLRF	(_BerkeleyTCPServerDemo_addr_1_1 + 7), B
;	.line	129; BerkeleyTCPServerDemo.c	if( bind( bsdServerSocket, (struct sockaddr*)&addr, addrlen ) == SOCKET_ERROR )
	MOVLW	HIGH(_BerkeleyTCPServerDemo_addr_1_1)
	MOVWF	r0x01
	MOVLW	LOW(_BerkeleyTCPServerDemo_addr_1_1)
	MOVWF	r0x00
	MOVLW	0x80
	MOVWF	r0x02
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x10
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	BANKSEL	_BerkeleyTCPServerDemo_bsdServerSocket_1_1
	MOVF	_BerkeleyTCPServerDemo_bsdServerSocket_1_1, W, B
	MOVWF	POSTDEC1
	CALL	_bind
	MOVWF	r0x00
	MOVFF	PRODL, r0x01
	MOVLW	0x06
	ADDWF	FSR1L, F
	MOVF	r0x00, W
	XORLW	0xff
	BNZ	_00156_DS_
	MOVF	r0x01, W
	XORLW	0xff
	BZ	_00157_DS_
_00156_DS_:
	BRA	_00111_DS_
_00157_DS_:
;	.line	130; BerkeleyTCPServerDemo.c	return;
	BRA	_00135_DS_
_00111_DS_:
;	.line	132; BerkeleyTCPServerDemo.c	BSDServerState = BSD_LISTEN;
	MOVLW	0x03
	BANKSEL	_BerkeleyTCPServerDemo_BSDServerState_1_1
	MOVWF	_BerkeleyTCPServerDemo_BSDServerState_1_1, B
_00112_DS_:
;	.line	136; BerkeleyTCPServerDemo.c	if(listen(bsdServerSocket, MAX_CLIENT) == 0)
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x03
	MOVWF	POSTDEC1
	BANKSEL	_BerkeleyTCPServerDemo_bsdServerSocket_1_1
	MOVF	_BerkeleyTCPServerDemo_bsdServerSocket_1_1, W, B
	MOVWF	POSTDEC1
	CALL	_listen
	MOVWF	r0x00
	MOVFF	PRODL, r0x01
	MOVLW	0x03
	ADDWF	FSR1L, F
	MOVF	r0x00, W
	IORWF	r0x01, W
	BNZ	_00148_DS_
;	.line	137; BerkeleyTCPServerDemo.c	BSDServerState = BSD_OPERATION;
	MOVLW	0x04
	BANKSEL	_BerkeleyTCPServerDemo_BSDServerState_1_1
	MOVWF	_BerkeleyTCPServerDemo_BSDServerState_1_1, B
_00148_DS_:
;	.line	148; BerkeleyTCPServerDemo.c	for(i=0; i<MAX_CLIENT; i++)
	CLRF	r0x00
	CLRF	r0x01
_00125_DS_:
	MOVF	r0x01, W
	ADDLW	0x80
	ADDLW	0x80
	BNZ	_00158_DS_
	MOVLW	0x03
	SUBWF	r0x00, W
_00158_DS_:
	BTFSC	STATUS, 0
	BRA	_00135_DS_
;	.line	151; BerkeleyTCPServerDemo.c	if(ClientSock[i] == INVALID_SOCKET)
	MOVLW	LOW(_BerkeleyTCPServerDemo_ClientSock_1_1)
	ADDWF	r0x00, W
	MOVWF	r0x02
	MOVLW	HIGH(_BerkeleyTCPServerDemo_ClientSock_1_1)
	ADDWFC	r0x01, W
	MOVWF	r0x03
	MOVFF	r0x02, FSR0L
	MOVFF	r0x03, FSR0H
	MOVFF	INDF0, r0x04
	MOVF	r0x04, W
	XORLW	0xfe
	BNZ	_00117_DS_
;	.line	152; BerkeleyTCPServerDemo.c	ClientSock[i] = accept(bsdServerSocket, (struct sockaddr*)&addRemote, &addrlen);
	MOVLW	HIGH(_BerkeleyTCPServerDemo_addRemote_1_1)
	MOVWF	r0x05
	MOVLW	LOW(_BerkeleyTCPServerDemo_addRemote_1_1)
	MOVWF	r0x04
	MOVLW	0x80
	MOVWF	r0x06
	MOVLW	HIGH(_BerkeleyTCPServerDemo_addrlen_1_1)
	MOVWF	r0x08
	MOVLW	LOW(_BerkeleyTCPServerDemo_addrlen_1_1)
	MOVWF	r0x07
	MOVLW	0x80
	MOVWF	r0x09
	MOVF	r0x09, W
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
	BANKSEL	_BerkeleyTCPServerDemo_bsdServerSocket_1_1
	MOVF	_BerkeleyTCPServerDemo_bsdServerSocket_1_1, W, B
	MOVWF	POSTDEC1
	CALL	_accept
	MOVWF	r0x04
	MOVLW	0x07
	ADDWF	FSR1L, F
	MOVFF	r0x02, FSR0L
	MOVFF	r0x03, FSR0H
	MOVFF	r0x04, INDF0
_00117_DS_:
;	.line	155; BerkeleyTCPServerDemo.c	if(ClientSock[i] == INVALID_SOCKET)
	MOVLW	LOW(_BerkeleyTCPServerDemo_ClientSock_1_1)
	ADDWF	r0x00, W
	MOVWF	r0x02
	MOVLW	HIGH(_BerkeleyTCPServerDemo_ClientSock_1_1)
	ADDWFC	r0x01, W
	MOVWF	r0x03
	MOVFF	r0x02, FSR0L
	MOVFF	r0x03, FSR0H
	MOVFF	INDF0, r0x02
	MOVF	r0x02, W
	XORLW	0xfe
	BNZ	_00162_DS_
	BRA	_00127_DS_
_00162_DS_:
;	.line	159; BerkeleyTCPServerDemo.c	length = recv( ClientSock[i], bfr, sizeof(bfr), 0);
	MOVLW	HIGH(_BerkeleyTCPServerDemo_bfr_1_1)
	MOVWF	r0x04
	MOVLW	LOW(_BerkeleyTCPServerDemo_bfr_1_1)
	MOVWF	r0x03
	MOVLW	0x80
	MOVWF	r0x05
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x0f
	MOVWF	POSTDEC1
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	CALL	_recv
	MOVWF	r0x02
	MOVFF	PRODL, r0x03
	MOVLW	0x08
	ADDWF	FSR1L, F
;	.line	161; BerkeleyTCPServerDemo.c	if( length > 0 )
	MOVF	r0x03, W
	ADDLW	0x80
	ADDLW	0x80
	BNZ	_00163_DS_
	MOVLW	0x01
	SUBWF	r0x02, W
_00163_DS_:
	BTFSS	STATUS, 0
	BRA	_00123_DS_
;	.line	163; BerkeleyTCPServerDemo.c	bfr[length] = '\0';
	MOVLW	LOW(_BerkeleyTCPServerDemo_bfr_1_1)
	ADDWF	r0x02, W
	MOVWF	r0x04
	MOVLW	HIGH(_BerkeleyTCPServerDemo_bfr_1_1)
	ADDWFC	r0x03, W
	MOVWF	r0x05
	MOVFF	r0x04, FSR0L
	MOVFF	r0x05, FSR0H
	MOVLW	0x00
	MOVWF	INDF0
;	.line	164; BerkeleyTCPServerDemo.c	send(ClientSock[i], bfr, strlen(bfr), 0);
	MOVLW	LOW(_BerkeleyTCPServerDemo_ClientSock_1_1)
	ADDWF	r0x00, W
	MOVWF	r0x04
	MOVLW	HIGH(_BerkeleyTCPServerDemo_ClientSock_1_1)
	ADDWFC	r0x01, W
	MOVWF	r0x05
	MOVFF	r0x04, FSR0L
	MOVFF	r0x05, FSR0H
	MOVFF	INDF0, r0x04
	MOVLW	HIGH(_BerkeleyTCPServerDemo_bfr_1_1)
	MOVWF	r0x06
	MOVLW	LOW(_BerkeleyTCPServerDemo_bfr_1_1)
	MOVWF	r0x05
	MOVLW	0x80
	MOVWF	r0x07
	MOVLW	HIGH(_BerkeleyTCPServerDemo_bfr_1_1)
	MOVWF	r0x09
	MOVLW	LOW(_BerkeleyTCPServerDemo_bfr_1_1)
	MOVWF	r0x08
	MOVLW	0x80
	MOVWF	r0x0a
	MOVF	r0x0a, W
	MOVWF	POSTDEC1
	MOVF	r0x09, W
	MOVWF	POSTDEC1
	MOVF	r0x08, W
	MOVWF	POSTDEC1
	CALL	_strlen
	MOVWF	r0x08
	MOVFF	PRODL, r0x09
	MOVLW	0x03
	ADDWF	FSR1L, F
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVF	r0x09, W
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
	CALL	_send
	MOVLW	0x08
	ADDWF	FSR1L, F
	BRA	_00127_DS_
_00123_DS_:
;	.line	166; BerkeleyTCPServerDemo.c	else if( length < 0 )
	BSF	STATUS, 0
	BTFSS	r0x03, 7
	BCF	STATUS, 0
	BNC	_00127_DS_
;	.line	168; BerkeleyTCPServerDemo.c	closesocket( ClientSock[i] );
	MOVLW	LOW(_BerkeleyTCPServerDemo_ClientSock_1_1)
	ADDWF	r0x00, W
	MOVWF	r0x02
	MOVLW	HIGH(_BerkeleyTCPServerDemo_ClientSock_1_1)
	ADDWFC	r0x01, W
	MOVWF	r0x03
	MOVFF	r0x02, FSR0L
	MOVFF	r0x03, FSR0H
	MOVFF	INDF0, r0x02
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	CALL	_closesocket
	INCF	FSR1L, F
;	.line	169; BerkeleyTCPServerDemo.c	ClientSock[i] = INVALID_SOCKET;
	MOVLW	LOW(_BerkeleyTCPServerDemo_ClientSock_1_1)
	ADDWF	r0x00, W
	MOVWF	r0x02
	MOVLW	HIGH(_BerkeleyTCPServerDemo_ClientSock_1_1)
	ADDWFC	r0x01, W
	MOVWF	r0x03
	MOVFF	r0x02, FSR0L
	MOVFF	r0x03, FSR0H
	MOVLW	0xfe
	MOVWF	INDF0
_00127_DS_:
;	.line	148; BerkeleyTCPServerDemo.c	for(i=0; i<MAX_CLIENT; i++)
	INCF	r0x00, F
	BTFSC	STATUS, 0
	INCF	r0x01, F
;	.line	175; BerkeleyTCPServerDemo.c	return;
	BRA	_00125_DS_
_00135_DS_:
;	.line	177; BerkeleyTCPServerDemo.c	return;
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
; code size:	  894 (0x037e) bytes ( 0.68%)
;           	  447 (0x01bf) words
; udata size:	   53 (0x0035) bytes ( 1.38%)
; access size:	   13 (0x000d) bytes


	end
