;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 2.9.4 #5582 (Dec  9 2009) (UNIX)
; This file was generated Wed Dec 16 00:27:12 2009
;--------------------------------------------------------
; PIC16 port for the Microchip 16-bit core micros
;--------------------------------------------------------
	list	p=18f97j60

	radix dec

;--------------------------------------------------------
; public variables in this module
;--------------------------------------------------------
	global _BerkeleyUDPClientDemo
	global _BerkeleySNTPGetUTCSeconds

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
	extern _memset
	extern _swapl
	extern _TickGet
	extern _TickGetDiv64K
	extern _socket
	extern _sendto
	extern _recvfrom
	extern _closesocket
	extern _DNSBeginUsage
	extern _DNSResolve
	extern _DNSIsResolved
	extern _DNSEndUsage
;--------------------------------------------------------
;	Equates to used internal registers
;--------------------------------------------------------
STATUS	equ	0xfd8
PCL	equ	0xff9
PCLATH	equ	0xffa
PCLATU	equ	0xffb
WREG	equ	0xfe8
FSR0L	equ	0xfe9
FSR1L	equ	0xfe1
FSR2L	equ	0xfd9
POSTDEC1	equ	0xfe5
PREINC1	equ	0xfe4
PRODL	equ	0xff3
PRODH	equ	0xff4


	idata
_dwSNTPSeconds	db	0x00, 0x00, 0x00, 0x00
_dwLastUpdateTick	db	0x00, 0x00, 0x00, 0x00
_BerkeleyUDPClientDemo_SNTPState_1_1	db	0x00


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

udata_BerkeleyUDPClientDemo_0	udata
_BerkeleyUDPClientDemo_dwServerIP_1_1	res	4

udata_BerkeleyUDPClientDemo_1	udata
_BerkeleyUDPClientDemo_dwTimer_1_1	res	4

udata_BerkeleyUDPClientDemo_2	udata
_BerkeleyUDPClientDemo_bsdUdpClient_1_1	res	1

udata_BerkeleyUDPClientDemo_3	udata
_BerkeleyUDPClientDemo_udpaddr_1_1	res	16

udata_BerkeleyUDPClientDemo_4	udata
_BerkeleyUDPClientDemo_addrlen_1_1	res	2

udata_BerkeleyUDPClientDemo_5	udata
_BerkeleyUDPClientDemo_pkt_1_1	res	48

;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
; I code from now on!
; ; Starting pCode block
S_BerkeleyUDPClientDemo__BerkeleySNTPGetUTCSeconds	code
_BerkeleySNTPGetUTCSeconds:
;	.line	331; BerkeleyUDPClientDemo.c	DWORD BerkeleySNTPGetUTCSeconds(void)
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
;	.line	338; BerkeleyUDPClientDemo.c	dwTick = TickGet();
	CALL	_TickGet
	MOVWF	r0x00
	MOVFF	PRODL, r0x01
	MOVFF	PRODH, r0x02
	MOVFF	FSR0L, r0x03
	BANKSEL	_dwLastUpdateTick
;	.line	339; BerkeleyUDPClientDemo.c	dwTickDelta = dwTick - dwLastUpdateTick;
	MOVF	_dwLastUpdateTick, W, B
	SUBWF	r0x00, W
	MOVWF	r0x04
	BANKSEL	(_dwLastUpdateTick + 1)
	MOVF	(_dwLastUpdateTick + 1), W, B
	SUBWFB	r0x01, W
	MOVWF	r0x05
	BANKSEL	(_dwLastUpdateTick + 2)
	MOVF	(_dwLastUpdateTick + 2), W, B
	SUBWFB	r0x02, W
	MOVWF	r0x06
	BANKSEL	(_dwLastUpdateTick + 3)
	MOVF	(_dwLastUpdateTick + 3), W, B
	SUBWFB	r0x03, W
	MOVWF	r0x07
_00164_DS_:
;	.line	340; BerkeleyUDPClientDemo.c	while(dwTickDelta > TICK_SECOND)
	MOVLW	0x00
	SUBWF	r0x07, W
	BNZ	_00172_DS_
	MOVLW	0x00
	SUBWF	r0x06, W
	BNZ	_00172_DS_
	MOVLW	0x9e
	SUBWF	r0x05, W
	BNZ	_00172_DS_
	MOVLW	0xf3
	SUBWF	r0x04, W
_00172_DS_:
	BNC	_00166_DS_
	BANKSEL	_dwSNTPSeconds
;	.line	342; BerkeleyUDPClientDemo.c	dwSNTPSeconds++;
	INCF	_dwSNTPSeconds, F, B
	BNC	_10164_DS_
	BANKSEL	(_dwSNTPSeconds + 1)
	INCF	(_dwSNTPSeconds + 1), F, B
_10164_DS_:
	BNC	_20165_DS_
	BANKSEL	(_dwSNTPSeconds + 2)
	INCF	(_dwSNTPSeconds + 2), F, B
_20165_DS_:
	BNC	_30166_DS_
	BANKSEL	(_dwSNTPSeconds + 3)
	INCF	(_dwSNTPSeconds + 3), F, B
_30166_DS_:
;	.line	343; BerkeleyUDPClientDemo.c	dwTickDelta -= TICK_SECOND;
	MOVLW	0x0e
	ADDWF	r0x04, F
	MOVLW	0x61
	ADDWFC	r0x05, F
	MOVLW	0xff
	ADDWFC	r0x06, F
	MOVLW	0xff
	ADDWFC	r0x07, F
	BRA	_00164_DS_
_00166_DS_:
;	.line	347; BerkeleyUDPClientDemo.c	dwLastUpdateTick = dwTick - dwTickDelta;
	MOVF	r0x04, W
	SUBWF	r0x00, W
	BANKSEL	_dwLastUpdateTick
	MOVWF	_dwLastUpdateTick, B
	MOVF	r0x05, W
	SUBWFB	r0x01, W
	BANKSEL	(_dwLastUpdateTick + 1)
	MOVWF	(_dwLastUpdateTick + 1), B
	MOVF	r0x06, W
	SUBWFB	r0x02, W
	BANKSEL	(_dwLastUpdateTick + 2)
	MOVWF	(_dwLastUpdateTick + 2), B
	MOVF	r0x07, W
	SUBWFB	r0x03, W
	BANKSEL	(_dwLastUpdateTick + 3)
	MOVWF	(_dwLastUpdateTick + 3), B
;	.line	349; BerkeleyUDPClientDemo.c	return dwSNTPSeconds;
	MOVFF	(_dwSNTPSeconds + 3), FSR0L
	MOVFF	(_dwSNTPSeconds + 2), PRODH
	MOVFF	(_dwSNTPSeconds + 1), PRODL
	BANKSEL	_dwSNTPSeconds
	MOVF	_dwSNTPSeconds, W, B
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
S_BerkeleyUDPClientDemo__BerkeleyUDPClientDemo	code
_BerkeleyUDPClientDemo:
;	.line	159; BerkeleyUDPClientDemo.c	void BerkeleyUDPClientDemo(void)
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
;	.line	167; BerkeleyUDPClientDemo.c	int 				addrlen = sizeof(struct sockaddr_in);
	MOVLW	0x10
	BANKSEL	_BerkeleyUDPClientDemo_addrlen_1_1
	MOVWF	_BerkeleyUDPClientDemo_addrlen_1_1, B
	BANKSEL	(_BerkeleyUDPClientDemo_addrlen_1_1 + 1)
	CLRF	(_BerkeleyUDPClientDemo_addrlen_1_1 + 1), B
;	.line	181; BerkeleyUDPClientDemo.c	switch(SNTPState)
	MOVLW	0x07
	BANKSEL	_BerkeleyUDPClientDemo_SNTPState_1_1
	SUBWF	_BerkeleyUDPClientDemo_SNTPState_1_1, W, B
	BTFSC	STATUS, 0
	GOTO	_00135_DS_
	MOVFF	r0x09, POSTDEC1
	MOVFF	r0x0a, POSTDEC1
	CLRF	r0x0a
	BANKSEL	_BerkeleyUDPClientDemo_SNTPState_1_1
	RLCF	_BerkeleyUDPClientDemo_SNTPState_1_1, W, B
	RLCF	r0x0a, F
	RLCF	WREG, W
	RLCF	r0x0a, F
	ANDLW	0xfc
	MOVWF	r0x09
	MOVLW	UPPER(_00150_DS_)
	MOVWF	PCLATU
	MOVLW	HIGH(_00150_DS_)
	MOVWF	PCLATH
	MOVLW	LOW(_00150_DS_)
	ADDWF	r0x09, F
	MOVF	r0x0a, W
	ADDWFC	PCLATH, F
	BTFSC	STATUS, 0
	INCF	PCLATU, F
	MOVF	r0x09, W
	MOVFF	PREINC1, r0x0a
	MOVFF	PREINC1, r0x09
	MOVWF	PCL
_00150_DS_:
	GOTO	_00105_DS_
	GOTO	_00108_DS_
	GOTO	_00115_DS_
	GOTO	_00118_DS_
	GOTO	_00121_DS_
	GOTO	_00128_DS_
	GOTO	_00131_DS_
_00105_DS_:
;	.line	185; BerkeleyUDPClientDemo.c	if(!DNSBeginUsage())
	CALL	_DNSBeginUsage
	MOVWF	r0x00
	MOVF	r0x00, W
	BTFSC	STATUS, 2
	GOTO	_00135_DS_
;	.line	190; BerkeleyUDPClientDemo.c	DNSResolve(( BYTE*)NTP_SERVER, DNS_TYPE_A);
	MOVLW	0x01
	MOVWF	POSTDEC1
	MOVLW	UPPER(__str_0)
	MOVWF	POSTDEC1
	MOVLW	HIGH(__str_0)
	MOVWF	POSTDEC1
	MOVLW	LOW(__str_0)
	MOVWF	POSTDEC1
	CALL	_DNSResolve
	MOVLW	0x04
	ADDWF	FSR1L, F
;	.line	191; BerkeleyUDPClientDemo.c	dwTimer = TickGet();
	CALL	_TickGet
	BANKSEL	_BerkeleyUDPClientDemo_dwTimer_1_1
	MOVWF	_BerkeleyUDPClientDemo_dwTimer_1_1, B
	MOVFF	PRODL, (_BerkeleyUDPClientDemo_dwTimer_1_1 + 1)
	MOVFF	PRODH, (_BerkeleyUDPClientDemo_dwTimer_1_1 + 2)
	MOVFF	FSR0L, (_BerkeleyUDPClientDemo_dwTimer_1_1 + 3)
;	.line	192; BerkeleyUDPClientDemo.c	SNTPState = SM_NAME_RESOLVE;
	MOVLW	0x01
	BANKSEL	_BerkeleyUDPClientDemo_SNTPState_1_1
	MOVWF	_BerkeleyUDPClientDemo_SNTPState_1_1, B
;	.line	193; BerkeleyUDPClientDemo.c	break;
	GOTO	_00135_DS_
_00108_DS_:
;	.line	197; BerkeleyUDPClientDemo.c	if(!DNSIsResolved((IP_ADDR*)&dwServerIP)) 
	MOVLW	HIGH(_BerkeleyUDPClientDemo_dwServerIP_1_1)
	MOVWF	r0x01
	MOVLW	LOW(_BerkeleyUDPClientDemo_dwServerIP_1_1)
	MOVWF	r0x00
	MOVLW	0x80
	MOVWF	r0x02
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_DNSIsResolved
	MOVWF	r0x00
	MOVLW	0x03
	ADDWF	FSR1L, F
	MOVF	r0x00, W
	BNZ	_00112_DS_
;	.line	199; BerkeleyUDPClientDemo.c	if((TickGet() - dwTimer) > (5 * TICK_SECOND)) 
	CALL	_TickGet
	MOVWF	r0x00
	MOVFF	PRODL, r0x01
	MOVFF	PRODH, r0x02
	MOVFF	FSR0L, r0x03
	BANKSEL	_BerkeleyUDPClientDemo_dwTimer_1_1
	MOVF	_BerkeleyUDPClientDemo_dwTimer_1_1, W, B
	SUBWF	r0x00, F
	BANKSEL	(_BerkeleyUDPClientDemo_dwTimer_1_1 + 1)
	MOVF	(_BerkeleyUDPClientDemo_dwTimer_1_1 + 1), W, B
	SUBWFB	r0x01, F
	BANKSEL	(_BerkeleyUDPClientDemo_dwTimer_1_1 + 2)
	MOVF	(_BerkeleyUDPClientDemo_dwTimer_1_1 + 2), W, B
	SUBWFB	r0x02, F
	BANKSEL	(_BerkeleyUDPClientDemo_dwTimer_1_1 + 3)
	MOVF	(_BerkeleyUDPClientDemo_dwTimer_1_1 + 3), W, B
	SUBWFB	r0x03, F
	MOVLW	0x00
	SUBWF	r0x03, W
	BNZ	_00151_DS_
	MOVLW	0x03
	SUBWF	r0x02, W
	BNZ	_00151_DS_
	MOVLW	0x1a
	SUBWF	r0x01, W
	BNZ	_00151_DS_
	MOVLW	0xbb
	SUBWF	r0x00, W
_00151_DS_:
	BTFSS	STATUS, 0
	GOTO	_00135_DS_
;	.line	201; BerkeleyUDPClientDemo.c	DNSEndUsage();
	CALL	_DNSEndUsage
;	.line	202; BerkeleyUDPClientDemo.c	dwTimer = TickGetDiv64K();
	CALL	_TickGetDiv64K
	BANKSEL	_BerkeleyUDPClientDemo_dwTimer_1_1
	MOVWF	_BerkeleyUDPClientDemo_dwTimer_1_1, B
	MOVFF	PRODL, (_BerkeleyUDPClientDemo_dwTimer_1_1 + 1)
	MOVFF	PRODH, (_BerkeleyUDPClientDemo_dwTimer_1_1 + 2)
	MOVFF	FSR0L, (_BerkeleyUDPClientDemo_dwTimer_1_1 + 3)
;	.line	203; BerkeleyUDPClientDemo.c	SNTPState = SM_SHORT_WAIT;
	MOVLW	0x05
	BANKSEL	_BerkeleyUDPClientDemo_SNTPState_1_1
	MOVWF	_BerkeleyUDPClientDemo_SNTPState_1_1, B
;	.line	205; BerkeleyUDPClientDemo.c	break;
	GOTO	_00135_DS_
_00112_DS_:
;	.line	209; BerkeleyUDPClientDemo.c	if(!DNSEndUsage())
	CALL	_DNSEndUsage
	MOVWF	r0x00
	MOVF	r0x00, W
	BNZ	_00114_DS_
;	.line	213; BerkeleyUDPClientDemo.c	dwTimer = TickGetDiv64K();
	CALL	_TickGetDiv64K
	BANKSEL	_BerkeleyUDPClientDemo_dwTimer_1_1
	MOVWF	_BerkeleyUDPClientDemo_dwTimer_1_1, B
	MOVFF	PRODL, (_BerkeleyUDPClientDemo_dwTimer_1_1 + 1)
	MOVFF	PRODH, (_BerkeleyUDPClientDemo_dwTimer_1_1 + 2)
	MOVFF	FSR0L, (_BerkeleyUDPClientDemo_dwTimer_1_1 + 3)
;	.line	214; BerkeleyUDPClientDemo.c	SNTPState = SM_SHORT_WAIT;
	MOVLW	0x05
	BANKSEL	_BerkeleyUDPClientDemo_SNTPState_1_1
	MOVWF	_BerkeleyUDPClientDemo_SNTPState_1_1, B
;	.line	215; BerkeleyUDPClientDemo.c	break;
	BRA	_00135_DS_
_00114_DS_:
;	.line	218; BerkeleyUDPClientDemo.c	SNTPState = SM_CREATE_SOCKET;
	MOVLW	0x02
	BANKSEL	_BerkeleyUDPClientDemo_SNTPState_1_1
	MOVWF	_BerkeleyUDPClientDemo_SNTPState_1_1, B
_00115_DS_:
;	.line	222; BerkeleyUDPClientDemo.c	bsdUdpClient = socket(AF_INET, SOCK_DGRAM, IPPROTO_UDP);
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x11
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x6e
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x02
	MOVWF	POSTDEC1
	CALL	_socket
	BANKSEL	_BerkeleyUDPClientDemo_bsdUdpClient_1_1
	MOVWF	_BerkeleyUDPClientDemo_bsdUdpClient_1_1, B
	MOVLW	0x06
	ADDWF	FSR1L, F
	BANKSEL	_BerkeleyUDPClientDemo_bsdUdpClient_1_1
;	.line	223; BerkeleyUDPClientDemo.c	if(bsdUdpClient == INVALID_SOCKET)
	MOVF	_BerkeleyUDPClientDemo_bsdUdpClient_1_1, W, B
	XORLW	0xfe
	BNZ	_00117_DS_
;	.line	224; BerkeleyUDPClientDemo.c	return;
	BRA	_00135_DS_
_00117_DS_:
;	.line	239; BerkeleyUDPClientDemo.c	SNTPState = SM_UDP_SEND;
	MOVLW	0x03
	BANKSEL	_BerkeleyUDPClientDemo_SNTPState_1_1
	MOVWF	_BerkeleyUDPClientDemo_SNTPState_1_1, B
_00118_DS_:
;	.line	244; BerkeleyUDPClientDemo.c	memset(&pkt, 0, sizeof(pkt));
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x30
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	HIGH(_BerkeleyUDPClientDemo_pkt_1_1)
	MOVWF	POSTDEC1
	MOVLW	LOW(_BerkeleyUDPClientDemo_pkt_1_1)
	MOVWF	POSTDEC1
	CALL	_memset
	MOVLW	0x05
	ADDWF	FSR1L, F
	BANKSEL	_BerkeleyUDPClientDemo_pkt_1_1
;	.line	245; BerkeleyUDPClientDemo.c	pkt.flags.versionNumber = 3;	// NTP Version 3
	MOVF	_BerkeleyUDPClientDemo_pkt_1_1, W, B
	ANDLW	0xc7
	IORLW	0x18
	BANKSEL	_BerkeleyUDPClientDemo_pkt_1_1
	MOVWF	_BerkeleyUDPClientDemo_pkt_1_1, B
	BANKSEL	_BerkeleyUDPClientDemo_pkt_1_1
;	.line	246; BerkeleyUDPClientDemo.c	pkt.flags.mode = 3;				// NTP Client
	MOVF	_BerkeleyUDPClientDemo_pkt_1_1, W, B
	ANDLW	0xf8
	IORLW	0x03
	BANKSEL	_BerkeleyUDPClientDemo_pkt_1_1
	MOVWF	_BerkeleyUDPClientDemo_pkt_1_1, B
;	.line	247; BerkeleyUDPClientDemo.c	pkt.orig_ts_secs = swapl(NTP_EPOCH);
	MOVLW	0x83
	MOVWF	POSTDEC1
	MOVLW	0xaa
	MOVWF	POSTDEC1
	MOVLW	0x7e
	MOVWF	POSTDEC1
	MOVLW	0x80
	MOVWF	POSTDEC1
	CALL	_swapl
	MOVWF	r0x00
	MOVFF	PRODL, r0x01
	MOVFF	PRODH, r0x02
	MOVFF	FSR0L, r0x03
	MOVLW	0x04
	ADDWF	FSR1L, F
	MOVF	r0x00, W
	BANKSEL	(_BerkeleyUDPClientDemo_pkt_1_1 + 24)
	MOVWF	(_BerkeleyUDPClientDemo_pkt_1_1 + 24), B
	MOVF	r0x01, W
	BANKSEL	(_BerkeleyUDPClientDemo_pkt_1_1 + 25)
	MOVWF	(_BerkeleyUDPClientDemo_pkt_1_1 + 25), B
	MOVF	r0x02, W
	BANKSEL	(_BerkeleyUDPClientDemo_pkt_1_1 + 26)
	MOVWF	(_BerkeleyUDPClientDemo_pkt_1_1 + 26), B
	MOVF	r0x03, W
	BANKSEL	(_BerkeleyUDPClientDemo_pkt_1_1 + 27)
	MOVWF	(_BerkeleyUDPClientDemo_pkt_1_1 + 27), B
;	.line	248; BerkeleyUDPClientDemo.c	udpaddr.sin_port = NTP_SERVER_PORT;
	MOVLW	0x7b
	BANKSEL	(_BerkeleyUDPClientDemo_udpaddr_1_1 + 2)
	MOVWF	(_BerkeleyUDPClientDemo_udpaddr_1_1 + 2), B
	BANKSEL	(_BerkeleyUDPClientDemo_udpaddr_1_1 + 3)
	CLRF	(_BerkeleyUDPClientDemo_udpaddr_1_1 + 3), B
	BANKSEL	_BerkeleyUDPClientDemo_dwServerIP_1_1
;	.line	249; BerkeleyUDPClientDemo.c	udpaddr.sin_addr.S_un.S_addr = dwServerIP;
	MOVF	_BerkeleyUDPClientDemo_dwServerIP_1_1, W, B
	BANKSEL	(_BerkeleyUDPClientDemo_udpaddr_1_1 + 4)
	MOVWF	(_BerkeleyUDPClientDemo_udpaddr_1_1 + 4), B
	BANKSEL	(_BerkeleyUDPClientDemo_dwServerIP_1_1 + 1)
	MOVF	(_BerkeleyUDPClientDemo_dwServerIP_1_1 + 1), W, B
	BANKSEL	(_BerkeleyUDPClientDemo_udpaddr_1_1 + 5)
	MOVWF	(_BerkeleyUDPClientDemo_udpaddr_1_1 + 5), B
	BANKSEL	(_BerkeleyUDPClientDemo_dwServerIP_1_1 + 2)
	MOVF	(_BerkeleyUDPClientDemo_dwServerIP_1_1 + 2), W, B
	BANKSEL	(_BerkeleyUDPClientDemo_udpaddr_1_1 + 6)
	MOVWF	(_BerkeleyUDPClientDemo_udpaddr_1_1 + 6), B
	BANKSEL	(_BerkeleyUDPClientDemo_dwServerIP_1_1 + 3)
	MOVF	(_BerkeleyUDPClientDemo_dwServerIP_1_1 + 3), W, B
	BANKSEL	(_BerkeleyUDPClientDemo_udpaddr_1_1 + 7)
	MOVWF	(_BerkeleyUDPClientDemo_udpaddr_1_1 + 7), B
;	.line	250; BerkeleyUDPClientDemo.c	if(sendto(bsdUdpClient, (const char*)&pkt, sizeof(pkt), 0, (struct sockaddr*)&udpaddr, addrlen)>0)
	MOVLW	HIGH(_BerkeleyUDPClientDemo_pkt_1_1)
	MOVWF	r0x01
	MOVLW	LOW(_BerkeleyUDPClientDemo_pkt_1_1)
	MOVWF	r0x00
	MOVLW	0x80
	MOVWF	r0x02
	MOVLW	HIGH(_BerkeleyUDPClientDemo_udpaddr_1_1)
	MOVWF	r0x04
	MOVLW	LOW(_BerkeleyUDPClientDemo_udpaddr_1_1)
	MOVWF	r0x03
	MOVLW	0x80
	MOVWF	r0x05
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x10
	MOVWF	POSTDEC1
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x30
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	BANKSEL	_BerkeleyUDPClientDemo_bsdUdpClient_1_1
	MOVF	_BerkeleyUDPClientDemo_bsdUdpClient_1_1, W, B
	MOVWF	POSTDEC1
	CALL	_sendto
	MOVWF	r0x00
	MOVFF	PRODL, r0x01
	MOVLW	0x0d
	ADDWF	FSR1L, F
	MOVF	r0x01, W
	ADDLW	0x80
	ADDLW	0x80
	BNZ	_00154_DS_
	MOVLW	0x01
	SUBWF	r0x00, W
_00154_DS_:
	BTFSS	STATUS, 0
	BRA	_00135_DS_
;	.line	252; BerkeleyUDPClientDemo.c	dwTimer = TickGet();
	CALL	_TickGet
	BANKSEL	_BerkeleyUDPClientDemo_dwTimer_1_1
	MOVWF	_BerkeleyUDPClientDemo_dwTimer_1_1, B
	MOVFF	PRODL, (_BerkeleyUDPClientDemo_dwTimer_1_1 + 1)
	MOVFF	PRODH, (_BerkeleyUDPClientDemo_dwTimer_1_1 + 2)
	MOVFF	FSR0L, (_BerkeleyUDPClientDemo_dwTimer_1_1 + 3)
;	.line	253; BerkeleyUDPClientDemo.c	SNTPState = SM_UDP_RECV;
	MOVLW	0x04
	BANKSEL	_BerkeleyUDPClientDemo_SNTPState_1_1
	MOVWF	_BerkeleyUDPClientDemo_SNTPState_1_1, B
;	.line	255; BerkeleyUDPClientDemo.c	break;
	BRA	_00135_DS_
_00121_DS_:
;	.line	259; BerkeleyUDPClientDemo.c	i = recvfrom(bsdUdpClient, (char*)&pkt, sizeof(pkt), 0, (struct sockaddr*)&udpaddr, &addrlen);
	MOVLW	HIGH(_BerkeleyUDPClientDemo_pkt_1_1)
	MOVWF	r0x01
	MOVLW	LOW(_BerkeleyUDPClientDemo_pkt_1_1)
	MOVWF	r0x00
	MOVLW	0x80
	MOVWF	r0x02
	MOVLW	HIGH(_BerkeleyUDPClientDemo_udpaddr_1_1)
	MOVWF	r0x04
	MOVLW	LOW(_BerkeleyUDPClientDemo_udpaddr_1_1)
	MOVWF	r0x03
	MOVLW	0x80
	MOVWF	r0x05
	MOVLW	HIGH(_BerkeleyUDPClientDemo_addrlen_1_1)
	MOVWF	r0x07
	MOVLW	LOW(_BerkeleyUDPClientDemo_addrlen_1_1)
	MOVWF	r0x06
	MOVLW	0x80
	MOVWF	r0x08
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
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x30
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	BANKSEL	_BerkeleyUDPClientDemo_bsdUdpClient_1_1
	MOVF	_BerkeleyUDPClientDemo_bsdUdpClient_1_1, W, B
	MOVWF	POSTDEC1
	CALL	_recvfrom
	MOVWF	r0x00
	MOVFF	PRODL, r0x01
	MOVLW	0x0e
	ADDWF	FSR1L, F
;	.line	260; BerkeleyUDPClientDemo.c	if(i < (int)sizeof(pkt))
	MOVF	r0x01, W
	ADDLW	0x80
	ADDLW	0x80
	BNZ	_00155_DS_
	MOVLW	0x30
	SUBWF	r0x00, W
_00155_DS_:
	BTFSC	STATUS, 0
	BRA	_00125_DS_
;	.line	262; BerkeleyUDPClientDemo.c	if((TickGet()) - dwTimer > NTP_REPLY_TIMEOUT)
	CALL	_TickGet
	MOVWF	r0x00
	MOVFF	PRODL, r0x01
	MOVFF	PRODH, r0x02
	MOVFF	FSR0L, r0x03
	BANKSEL	_BerkeleyUDPClientDemo_dwTimer_1_1
	MOVF	_BerkeleyUDPClientDemo_dwTimer_1_1, W, B
	SUBWF	r0x00, F
	BANKSEL	(_BerkeleyUDPClientDemo_dwTimer_1_1 + 1)
	MOVF	(_BerkeleyUDPClientDemo_dwTimer_1_1 + 1), W, B
	SUBWFB	r0x01, F
	BANKSEL	(_BerkeleyUDPClientDemo_dwTimer_1_1 + 2)
	MOVF	(_BerkeleyUDPClientDemo_dwTimer_1_1 + 2), W, B
	SUBWFB	r0x02, F
	BANKSEL	(_BerkeleyUDPClientDemo_dwTimer_1_1 + 3)
	MOVF	(_BerkeleyUDPClientDemo_dwTimer_1_1 + 3), W, B
	SUBWFB	r0x03, F
	MOVLW	0x00
	SUBWF	r0x03, W
	BNZ	_00156_DS_
	MOVLW	0x03
	SUBWF	r0x02, W
	BNZ	_00156_DS_
	MOVLW	0xb9
	SUBWF	r0x01, W
	BNZ	_00156_DS_
	MOVLW	0xad
	SUBWF	r0x00, W
_00156_DS_:
	BTFSS	STATUS, 0
	BRA	_00135_DS_
	BANKSEL	_BerkeleyUDPClientDemo_bsdUdpClient_1_1
;	.line	265; BerkeleyUDPClientDemo.c	closesocket(bsdUdpClient);
	MOVF	_BerkeleyUDPClientDemo_bsdUdpClient_1_1, W, B
	MOVWF	POSTDEC1
	CALL	_closesocket
	INCF	FSR1L, F
;	.line	266; BerkeleyUDPClientDemo.c	dwTimer = TickGetDiv64K();
	CALL	_TickGetDiv64K
	BANKSEL	_BerkeleyUDPClientDemo_dwTimer_1_1
	MOVWF	_BerkeleyUDPClientDemo_dwTimer_1_1, B
	MOVFF	PRODL, (_BerkeleyUDPClientDemo_dwTimer_1_1 + 1)
	MOVFF	PRODH, (_BerkeleyUDPClientDemo_dwTimer_1_1 + 2)
	MOVFF	FSR0L, (_BerkeleyUDPClientDemo_dwTimer_1_1 + 3)
;	.line	267; BerkeleyUDPClientDemo.c	SNTPState = SM_SHORT_WAIT;
	MOVLW	0x05
	BANKSEL	_BerkeleyUDPClientDemo_SNTPState_1_1
	MOVWF	_BerkeleyUDPClientDemo_SNTPState_1_1, B
;	.line	268; BerkeleyUDPClientDemo.c	break;
	BRA	_00135_DS_
_00125_DS_:
	BANKSEL	_BerkeleyUDPClientDemo_bsdUdpClient_1_1
;	.line	272; BerkeleyUDPClientDemo.c	closesocket(bsdUdpClient);
	MOVF	_BerkeleyUDPClientDemo_bsdUdpClient_1_1, W, B
	MOVWF	POSTDEC1
	CALL	_closesocket
	INCF	FSR1L, F
;	.line	273; BerkeleyUDPClientDemo.c	dwTimer = TickGetDiv64K();
	CALL	_TickGetDiv64K
	BANKSEL	_BerkeleyUDPClientDemo_dwTimer_1_1
	MOVWF	_BerkeleyUDPClientDemo_dwTimer_1_1, B
	MOVFF	PRODL, (_BerkeleyUDPClientDemo_dwTimer_1_1 + 1)
	MOVFF	PRODH, (_BerkeleyUDPClientDemo_dwTimer_1_1 + 2)
	MOVFF	FSR0L, (_BerkeleyUDPClientDemo_dwTimer_1_1 + 3)
;	.line	274; BerkeleyUDPClientDemo.c	SNTPState = SM_WAIT;
	MOVLW	0x06
	BANKSEL	_BerkeleyUDPClientDemo_SNTPState_1_1
	MOVWF	_BerkeleyUDPClientDemo_SNTPState_1_1, B
;	.line	277; BerkeleyUDPClientDemo.c	dwLastUpdateTick = TickGet();
	CALL	_TickGet
	BANKSEL	_dwLastUpdateTick
	MOVWF	_dwLastUpdateTick, B
	MOVFF	PRODL, (_dwLastUpdateTick + 1)
	MOVFF	PRODH, (_dwLastUpdateTick + 2)
	MOVFF	FSR0L, (_dwLastUpdateTick + 3)
	BANKSEL	(_BerkeleyUDPClientDemo_pkt_1_1 + 43)
;	.line	278; BerkeleyUDPClientDemo.c	dwSNTPSeconds = swapl(pkt.tx_ts_secs) - NTP_EPOCH;
	MOVF	(_BerkeleyUDPClientDemo_pkt_1_1 + 43), W, B
	MOVWF	POSTDEC1
	BANKSEL	(_BerkeleyUDPClientDemo_pkt_1_1 + 42)
	MOVF	(_BerkeleyUDPClientDemo_pkt_1_1 + 42), W, B
	MOVWF	POSTDEC1
	BANKSEL	(_BerkeleyUDPClientDemo_pkt_1_1 + 41)
	MOVF	(_BerkeleyUDPClientDemo_pkt_1_1 + 41), W, B
	MOVWF	POSTDEC1
	BANKSEL	(_BerkeleyUDPClientDemo_pkt_1_1 + 40)
	MOVF	(_BerkeleyUDPClientDemo_pkt_1_1 + 40), W, B
	MOVWF	POSTDEC1
	CALL	_swapl
	MOVWF	r0x00
	MOVFF	PRODL, r0x01
	MOVFF	PRODH, r0x02
	MOVFF	FSR0L, r0x03
	MOVLW	0x04
	ADDWF	FSR1L, F
	MOVF	r0x00, W
	ADDLW	0x80
	BANKSEL	_dwSNTPSeconds
	MOVWF	_dwSNTPSeconds, B
	MOVLW	0x81
	ADDWFC	r0x01, W
	BANKSEL	(_dwSNTPSeconds + 1)
	MOVWF	(_dwSNTPSeconds + 1), B
	MOVLW	0x55
	ADDWFC	r0x02, W
	BANKSEL	(_dwSNTPSeconds + 2)
	MOVWF	(_dwSNTPSeconds + 2), B
	MOVLW	0x7c
	ADDWFC	r0x03, W
	BANKSEL	(_dwSNTPSeconds + 3)
	MOVWF	(_dwSNTPSeconds + 3), B
	BANKSEL	(_BerkeleyUDPClientDemo_pkt_1_1 + 44)
;	.line	280; BerkeleyUDPClientDemo.c	if(((BYTE*)&pkt.tx_ts_fraq)[0] & 0x80)
	BTFSS	(_BerkeleyUDPClientDemo_pkt_1_1 + 44), 7
	BRA	_00135_DS_
	BANKSEL	_dwSNTPSeconds
;	.line	281; BerkeleyUDPClientDemo.c	dwSNTPSeconds++;
	INCF	_dwSNTPSeconds, F, B
	BNC	_40167_DS_
	BANKSEL	(_dwSNTPSeconds + 1)
	INCF	(_dwSNTPSeconds + 1), F, B
_40167_DS_:
	BNC	_50168_DS_
	BANKSEL	(_dwSNTPSeconds + 2)
	INCF	(_dwSNTPSeconds + 2), F, B
_50168_DS_:
	BNC	_60169_DS_
	BANKSEL	(_dwSNTPSeconds + 3)
	INCF	(_dwSNTPSeconds + 3), F, B
_60169_DS_:
;	.line	283; BerkeleyUDPClientDemo.c	break;
	BRA	_00135_DS_
_00128_DS_:
;	.line	287; BerkeleyUDPClientDemo.c	if(TickGetDiv64K() - dwTimer > (NTP_FAST_QUERY_INTERVAL/65536ull))
	CALL	_TickGetDiv64K
	MOVWF	r0x00
	MOVFF	PRODL, r0x01
	MOVFF	PRODH, r0x02
	MOVFF	FSR0L, r0x03
	BANKSEL	_BerkeleyUDPClientDemo_dwTimer_1_1
	MOVF	_BerkeleyUDPClientDemo_dwTimer_1_1, W, B
	SUBWF	r0x00, F
	BANKSEL	(_BerkeleyUDPClientDemo_dwTimer_1_1 + 1)
	MOVF	(_BerkeleyUDPClientDemo_dwTimer_1_1 + 1), W, B
	SUBWFB	r0x01, F
	BANKSEL	(_BerkeleyUDPClientDemo_dwTimer_1_1 + 2)
	MOVF	(_BerkeleyUDPClientDemo_dwTimer_1_1 + 2), W, B
	SUBWFB	r0x02, F
	BANKSEL	(_BerkeleyUDPClientDemo_dwTimer_1_1 + 3)
	MOVF	(_BerkeleyUDPClientDemo_dwTimer_1_1 + 3), W, B
	SUBWFB	r0x03, F
	MOVLW	0x00
	SUBWF	r0x03, W
	BNZ	_00158_DS_
	MOVLW	0x00
	SUBWF	r0x02, W
	BNZ	_00158_DS_
	MOVLW	0x00
	SUBWF	r0x01, W
	BNZ	_00158_DS_
	MOVLW	0x09
	SUBWF	r0x00, W
_00158_DS_:
	BNC	_00135_DS_
	BANKSEL	_BerkeleyUDPClientDemo_SNTPState_1_1
;	.line	288; BerkeleyUDPClientDemo.c	SNTPState = SM_HOME;	
	CLRF	_BerkeleyUDPClientDemo_SNTPState_1_1, B
;	.line	289; BerkeleyUDPClientDemo.c	break;
	BRA	_00135_DS_
_00131_DS_:
;	.line	293; BerkeleyUDPClientDemo.c	if(TickGetDiv64K() - dwTimer > (NTP_QUERY_INTERVAL/65536ull))
	CALL	_TickGetDiv64K
	MOVWF	r0x00
	MOVFF	PRODL, r0x01
	MOVFF	PRODH, r0x02
	MOVFF	FSR0L, r0x03
	BANKSEL	_BerkeleyUDPClientDemo_dwTimer_1_1
	MOVF	_BerkeleyUDPClientDemo_dwTimer_1_1, W, B
	SUBWF	r0x00, F
	BANKSEL	(_BerkeleyUDPClientDemo_dwTimer_1_1 + 1)
	MOVF	(_BerkeleyUDPClientDemo_dwTimer_1_1 + 1), W, B
	SUBWFB	r0x01, F
	BANKSEL	(_BerkeleyUDPClientDemo_dwTimer_1_1 + 2)
	MOVF	(_BerkeleyUDPClientDemo_dwTimer_1_1 + 2), W, B
	SUBWFB	r0x02, F
	BANKSEL	(_BerkeleyUDPClientDemo_dwTimer_1_1 + 3)
	MOVF	(_BerkeleyUDPClientDemo_dwTimer_1_1 + 3), W, B
	SUBWFB	r0x03, F
	MOVLW	0x00
	SUBWF	r0x03, W
	BNZ	_00159_DS_
	MOVLW	0x00
	SUBWF	r0x02, W
	BNZ	_00159_DS_
	MOVLW	0x01
	SUBWF	r0x01, W
	BNZ	_00159_DS_
	MOVLW	0x75
	SUBWF	r0x00, W
_00159_DS_:
	BNC	_00135_DS_
	BANKSEL	_BerkeleyUDPClientDemo_SNTPState_1_1
;	.line	294; BerkeleyUDPClientDemo.c	SNTPState = SM_HOME;	
	CLRF	_BerkeleyUDPClientDemo_SNTPState_1_1, B
_00135_DS_:
;	.line	297; BerkeleyUDPClientDemo.c	}
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
__str_0:
	DB	0x70, 0x6f, 0x6f, 0x6c, 0x2e, 0x6e, 0x74, 0x70, 0x2e, 0x6f, 0x72, 0x67
	DB	0x00


; Statistics:
; code size:	 1574 (0x0626) bytes ( 1.20%)
;           	  787 (0x0313) words
; udata size:	   75 (0x004b) bytes ( 1.95%)
; access size:	   11 (0x000b) bytes


	end
