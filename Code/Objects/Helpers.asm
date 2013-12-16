;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 2.9.4 #5595 (Dec 17 2009) (UNIX)
; This file was generated Mon Mar 15 11:43:31 2010
;--------------------------------------------------------
; PIC16 port for the Microchip 16-bit core micros
;--------------------------------------------------------
	list	p=18f97j60

	radix dec

;--------------------------------------------------------
; public variables in this module
;--------------------------------------------------------
	global _GenerateRandomDWORD
	global _StringToIPAddress
	global _btohexa_high
	global _btohexa_low
	global _swaps
	global _swapl
	global _CalcIPChecksum
	global _leftRotateDWORD
	global _strnchr
	global _toRotate
	global _hexatob

;--------------------------------------------------------
; extern variables in this module
;--------------------------------------------------------
	extern __gptrget1
	extern __gptrput1
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
	extern _srand
	extern _rand
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
r0x1c	res	1
r0x1d	res	1

udata_Helpers_0	udata
_GenerateRandomDWORD_wTime_1_1	res	2

udata_Helpers_1	udata
_StringToIPAddress_dwVal_1_1	res	4

udata_Helpers_2	udata
_hexatob_AsciiChars_1_1	res	2

udata_Helpers_3	udata
_swaps_t_1_1	res	2

udata_Helpers_4	udata
_swapl_v_1_1	res	4

udata_Helpers_5	udata
_CalcIPChecksum_count_1_1	res	2

udata_Helpers_6	udata
_CalcIPChecksum_sum_1_1	res	4

udata_Helpers_7	udata
_toRotate	res	4

;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
; I code from now on!
; ; Starting pCode block
S_Helpers__strnchr	code
_strnchr:
;	.line	1359; TCPIP_Stack/Helpers.c	char * strnchr(const char *searchString, size_t count, char c)
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
;	.line	1363; TCPIP_Stack/Helpers.c	while(count--)
	MOVFF	r0x00, r0x06
	MOVFF	r0x01, r0x07
	MOVFF	r0x02, r0x08
_00311_DS_:
	MOVFF	r0x03, r0x09
	MOVFF	r0x04, r0x0a
	MOVLW	0xff
	ADDWF	r0x03, F
	BTFSS	STATUS, 0
	DECF	r0x04, F
	MOVF	r0x09, W
	IORWF	r0x0a, W
	BZ	_00313_DS_
;	.line	1365; TCPIP_Stack/Helpers.c	c2  = *searchString++;
	MOVFF	r0x06, FSR0L
	MOVFF	r0x07, PRODL
	MOVF	r0x08, W
	CALL	__gptrget1
	MOVWF	r0x09
	INCF	r0x06, F
	BTFSC	STATUS, 0
	INCF	r0x07, F
	BTFSC	STATUS, 0
	INCF	r0x08, F
;	.line	1366; TCPIP_Stack/Helpers.c	if(c2 == 0u)
	MOVF	r0x09, W
	BNZ	_00308_DS_
;	.line	1367; TCPIP_Stack/Helpers.c	return NULL;
	CLRF	PRODH
	CLRF	PRODL
	CLRF	WREG
	BRA	_00314_DS_
_00308_DS_:
;	.line	1368; TCPIP_Stack/Helpers.c	if(c2 == c)
	MOVF	r0x09, W
	XORWF	r0x05, W
	BNZ	_00311_DS_
;	.line	1369; TCPIP_Stack/Helpers.c	return (char*)--searchString;
	MOVF	r0x06, W
	ADDLW	0xff
	MOVWF	r0x00
	MOVLW	0xff
	ADDWFC	r0x07, W
	MOVWF	r0x01
	MOVLW	0xff
	ADDWFC	r0x08, W
	MOVWF	r0x02
	MOVFF	r0x02, PRODH
	MOVFF	r0x01, PRODL
	MOVF	r0x00, W
	BRA	_00314_DS_
_00313_DS_:
;	.line	1371; TCPIP_Stack/Helpers.c	return NULL;
	CLRF	PRODH
	CLRF	PRODL
	CLRF	WREG
_00314_DS_:
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
S_Helpers__leftRotateDWORD	code
_leftRotateDWORD:
;	.line	1235; TCPIP_Stack/Helpers.c	DWORD leftRotateDWORD(DWORD val, BYTE bits)
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
	MOVLW	0x05
	MOVFF	PLUSW2, r0x03
	MOVLW	0x06
	MOVFF	PLUSW2, r0x04
;	.line	1239; TCPIP_Stack/Helpers.c	toRotate.Val = val;
	MOVF	r0x00, W
	BANKSEL	_toRotate
	MOVWF	_toRotate, B
	MOVF	r0x01, W
	BANKSEL	(_toRotate + 1)
	MOVWF	(_toRotate + 1), B
	MOVF	r0x02, W
	BANKSEL	(_toRotate + 2)
	MOVWF	(_toRotate + 2), B
	MOVF	r0x03, W
	BANKSEL	(_toRotate + 3)
	MOVWF	(_toRotate + 3), B
;	.line	1241; TCPIP_Stack/Helpers.c	for(i = bits; i >= 8u; i -= 8)
	MOVFF	r0x04, r0x00
_00284_DS_:
	MOVFF	r0x00, r0x01
	CLRF	r0x02
	MOVLW	0x00
	SUBWF	r0x02, W
	BNZ	_00300_DS_
	MOVLW	0x08
	SUBWF	r0x01, W
_00300_DS_:
	BNC	_00288_DS_
;	.line	1243; TCPIP_Stack/Helpers.c	t = toRotate.v[3];
	MOVFF	(_toRotate + 3), r0x01
;	.line	1244; TCPIP_Stack/Helpers.c	toRotate.v[3] = toRotate.v[2];
	MOVFF	(_toRotate + 2), r0x02
	MOVF	r0x02, W
	BANKSEL	(_toRotate + 3)
	MOVWF	(_toRotate + 3), B
;	.line	1245; TCPIP_Stack/Helpers.c	toRotate.v[2] = toRotate.v[1];
	MOVFF	(_toRotate + 1), r0x02
	MOVF	r0x02, W
	BANKSEL	(_toRotate + 2)
	MOVWF	(_toRotate + 2), B
;	.line	1246; TCPIP_Stack/Helpers.c	toRotate.v[1] = toRotate.v[0];
	MOVFF	_toRotate, r0x02
	MOVF	r0x02, W
	BANKSEL	(_toRotate + 1)
	MOVWF	(_toRotate + 1), B
;	.line	1247; TCPIP_Stack/Helpers.c	toRotate.v[0] = t;
	MOVF	r0x01, W
	BANKSEL	_toRotate
	MOVWF	_toRotate, B
;	.line	1241; TCPIP_Stack/Helpers.c	for(i = bits; i >= 8u; i -= 8)
	MOVLW	0xf8
	ADDWF	r0x00, F
	BRA	_00284_DS_
_00288_DS_:
;	.line	1266; TCPIP_Stack/Helpers.c	for(; i != 0u; i--)
	MOVFF	r0x00, r0x01
	CLRF	r0x02
	MOVF	r0x01, W
	BNZ	_00302_DS_
	MOVF	r0x02, W
	BZ	_00291_DS_
_00301_DS_:
_00302_DS_:
	movlb _toRotate
	bcf STATUS,0,0
	btfsc _toRotate+3,7,1
	bsf STATUS,0,0
	rlcf _toRotate+0,1,1
	rlcf _toRotate+1,1,1
	rlcf _toRotate+2,1,1
	rlcf _toRotate+3,1,1
	
;	.line	1266; TCPIP_Stack/Helpers.c	for(; i != 0u; i--)
	DECF	r0x00, F
	BRA	_00288_DS_
_00291_DS_:
;	.line	1281; TCPIP_Stack/Helpers.c	return toRotate.Val;
	MOVFF	(_toRotate + 3), FSR0L
	MOVFF	(_toRotate + 2), PRODH
	MOVFF	(_toRotate + 1), PRODL
	BANKSEL	_toRotate
	MOVF	_toRotate, W, B
	MOVFF	PREINC1, r0x04
	MOVFF	PREINC1, r0x03
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_Helpers__CalcIPChecksum	code
_CalcIPChecksum:
;	.line	1062; TCPIP_Stack/Helpers.c	WORD CalcIPChecksum(BYTE* buffer, WORD count)
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
	MOVFF	PLUSW2, _CalcIPChecksum_count_1_1
	MOVLW	0x06
	MOVFF	PLUSW2, (_CalcIPChecksum_count_1_1 + 1)
	BANKSEL	_CalcIPChecksum_sum_1_1
;	.line	1066; TCPIP_Stack/Helpers.c	DWORD_VAL sum = {0x00000000ul};
	CLRF	_CalcIPChecksum_sum_1_1, B
	BANKSEL	(_CalcIPChecksum_sum_1_1 + 1)
	CLRF	(_CalcIPChecksum_sum_1_1 + 1), B
	BANKSEL	(_CalcIPChecksum_sum_1_1 + 2)
	CLRF	(_CalcIPChecksum_sum_1_1 + 2), B
	BANKSEL	(_CalcIPChecksum_sum_1_1 + 3)
	CLRF	(_CalcIPChecksum_sum_1_1 + 3), B
	BANKSEL	_CalcIPChecksum_sum_1_1
	CLRF	_CalcIPChecksum_sum_1_1, B
	BANKSEL	(_CalcIPChecksum_sum_1_1 + 1)
	CLRF	(_CalcIPChecksum_sum_1_1 + 1), B
	BANKSEL	(_CalcIPChecksum_sum_1_1 + 2)
	CLRF	(_CalcIPChecksum_sum_1_1 + 2), B
	BANKSEL	(_CalcIPChecksum_sum_1_1 + 3)
	CLRF	(_CalcIPChecksum_sum_1_1 + 3), B
	BANKSEL	_CalcIPChecksum_sum_1_1
	CLRF	_CalcIPChecksum_sum_1_1, B
	BANKSEL	(_CalcIPChecksum_sum_1_1 + 1)
	CLRF	(_CalcIPChecksum_sum_1_1 + 1), B
	BANKSEL	(_CalcIPChecksum_sum_1_1 + 2)
	CLRF	(_CalcIPChecksum_sum_1_1 + 2), B
	BANKSEL	(_CalcIPChecksum_sum_1_1 + 3)
	CLRF	(_CalcIPChecksum_sum_1_1 + 3), B
	BANKSEL	_CalcIPChecksum_sum_1_1
	CLRF	_CalcIPChecksum_sum_1_1, B
	BANKSEL	(_CalcIPChecksum_sum_1_1 + 1)
	CLRF	(_CalcIPChecksum_sum_1_1 + 1), B
	BANKSEL	(_CalcIPChecksum_sum_1_1 + 2)
	CLRF	(_CalcIPChecksum_sum_1_1 + 2), B
	BANKSEL	(_CalcIPChecksum_sum_1_1 + 3)
	CLRF	(_CalcIPChecksum_sum_1_1 + 3), B
	BANKSEL	_CalcIPChecksum_sum_1_1
	CLRF	_CalcIPChecksum_sum_1_1, B
	BANKSEL	(_CalcIPChecksum_sum_1_1 + 1)
	CLRF	(_CalcIPChecksum_sum_1_1 + 1), B
	BANKSEL	(_CalcIPChecksum_sum_1_1 + 2)
	CLRF	(_CalcIPChecksum_sum_1_1 + 2), B
	BANKSEL	(_CalcIPChecksum_sum_1_1 + 3)
	CLRF	(_CalcIPChecksum_sum_1_1 + 3), B
	BANKSEL	_CalcIPChecksum_sum_1_1
	CLRF	_CalcIPChecksum_sum_1_1, B
	BANKSEL	(_CalcIPChecksum_sum_1_1 + 1)
	CLRF	(_CalcIPChecksum_sum_1_1 + 1), B
	BANKSEL	_CalcIPChecksum_sum_1_1
	CLRF	_CalcIPChecksum_sum_1_1, B
	BANKSEL	(_CalcIPChecksum_sum_1_1 + 1)
	CLRF	(_CalcIPChecksum_sum_1_1 + 1), B
	BANKSEL	_CalcIPChecksum_sum_1_1
	CLRF	_CalcIPChecksum_sum_1_1, B
	BANKSEL	(_CalcIPChecksum_sum_1_1 + 1)
	CLRF	(_CalcIPChecksum_sum_1_1 + 1), B
	BANKSEL	_CalcIPChecksum_sum_1_1
	BCF	_CalcIPChecksum_sum_1_1, 0, B
	BANKSEL	_CalcIPChecksum_sum_1_1
	BCF	_CalcIPChecksum_sum_1_1, 1, B
	BANKSEL	_CalcIPChecksum_sum_1_1
	BCF	_CalcIPChecksum_sum_1_1, 2, B
	BANKSEL	_CalcIPChecksum_sum_1_1
	BCF	_CalcIPChecksum_sum_1_1, 3, B
	BANKSEL	_CalcIPChecksum_sum_1_1
	BCF	_CalcIPChecksum_sum_1_1, 4, B
	BANKSEL	_CalcIPChecksum_sum_1_1
	BCF	_CalcIPChecksum_sum_1_1, 5, B
	BANKSEL	_CalcIPChecksum_sum_1_1
	BCF	_CalcIPChecksum_sum_1_1, 6, B
	BANKSEL	_CalcIPChecksum_sum_1_1
	BCF	_CalcIPChecksum_sum_1_1, 7, B
	BANKSEL	(_CalcIPChecksum_sum_1_1 + 1)
	BCF	(_CalcIPChecksum_sum_1_1 + 1), 0, B
	BANKSEL	(_CalcIPChecksum_sum_1_1 + 1)
	BCF	(_CalcIPChecksum_sum_1_1 + 1), 1, B
	BANKSEL	(_CalcIPChecksum_sum_1_1 + 1)
	BCF	(_CalcIPChecksum_sum_1_1 + 1), 2, B
	BANKSEL	(_CalcIPChecksum_sum_1_1 + 1)
	BCF	(_CalcIPChecksum_sum_1_1 + 1), 3, B
	BANKSEL	(_CalcIPChecksum_sum_1_1 + 1)
	BCF	(_CalcIPChecksum_sum_1_1 + 1), 4, B
	BANKSEL	(_CalcIPChecksum_sum_1_1 + 1)
	BCF	(_CalcIPChecksum_sum_1_1 + 1), 5, B
	BANKSEL	(_CalcIPChecksum_sum_1_1 + 1)
	BCF	(_CalcIPChecksum_sum_1_1 + 1), 6, B
	BANKSEL	(_CalcIPChecksum_sum_1_1 + 1)
	BCF	(_CalcIPChecksum_sum_1_1 + 1), 7, B
	BANKSEL	(_CalcIPChecksum_sum_1_1 + 2)
	CLRF	(_CalcIPChecksum_sum_1_1 + 2), B
	BANKSEL	(_CalcIPChecksum_sum_1_1 + 3)
	CLRF	(_CalcIPChecksum_sum_1_1 + 3), B
	BANKSEL	(_CalcIPChecksum_sum_1_1 + 2)
	CLRF	(_CalcIPChecksum_sum_1_1 + 2), B
	BANKSEL	(_CalcIPChecksum_sum_1_1 + 3)
	CLRF	(_CalcIPChecksum_sum_1_1 + 3), B
	BANKSEL	(_CalcIPChecksum_sum_1_1 + 2)
	CLRF	(_CalcIPChecksum_sum_1_1 + 2), B
	BANKSEL	(_CalcIPChecksum_sum_1_1 + 3)
	CLRF	(_CalcIPChecksum_sum_1_1 + 3), B
	BANKSEL	(_CalcIPChecksum_sum_1_1 + 2)
	BCF	(_CalcIPChecksum_sum_1_1 + 2), 0, B
	BANKSEL	(_CalcIPChecksum_sum_1_1 + 2)
	BCF	(_CalcIPChecksum_sum_1_1 + 2), 1, B
	BANKSEL	(_CalcIPChecksum_sum_1_1 + 2)
	BCF	(_CalcIPChecksum_sum_1_1 + 2), 2, B
	BANKSEL	(_CalcIPChecksum_sum_1_1 + 2)
	BCF	(_CalcIPChecksum_sum_1_1 + 2), 3, B
	BANKSEL	(_CalcIPChecksum_sum_1_1 + 2)
	BCF	(_CalcIPChecksum_sum_1_1 + 2), 4, B
	BANKSEL	(_CalcIPChecksum_sum_1_1 + 2)
	BCF	(_CalcIPChecksum_sum_1_1 + 2), 5, B
	BANKSEL	(_CalcIPChecksum_sum_1_1 + 2)
	BCF	(_CalcIPChecksum_sum_1_1 + 2), 6, B
	BANKSEL	(_CalcIPChecksum_sum_1_1 + 2)
	BCF	(_CalcIPChecksum_sum_1_1 + 2), 7, B
	BANKSEL	(_CalcIPChecksum_sum_1_1 + 3)
	BCF	(_CalcIPChecksum_sum_1_1 + 3), 0, B
	BANKSEL	(_CalcIPChecksum_sum_1_1 + 3)
	BCF	(_CalcIPChecksum_sum_1_1 + 3), 1, B
	BANKSEL	(_CalcIPChecksum_sum_1_1 + 3)
	BCF	(_CalcIPChecksum_sum_1_1 + 3), 2, B
	BANKSEL	(_CalcIPChecksum_sum_1_1 + 3)
	BCF	(_CalcIPChecksum_sum_1_1 + 3), 3, B
	BANKSEL	(_CalcIPChecksum_sum_1_1 + 3)
	BCF	(_CalcIPChecksum_sum_1_1 + 3), 4, B
	BANKSEL	(_CalcIPChecksum_sum_1_1 + 3)
	BCF	(_CalcIPChecksum_sum_1_1 + 3), 5, B
	BANKSEL	(_CalcIPChecksum_sum_1_1 + 3)
	BCF	(_CalcIPChecksum_sum_1_1 + 3), 6, B
	BANKSEL	(_CalcIPChecksum_sum_1_1 + 3)
	BCF	(_CalcIPChecksum_sum_1_1 + 3), 7, B
	BANKSEL	_CalcIPChecksum_sum_1_1
	BCF	_CalcIPChecksum_sum_1_1, 0, B
	BANKSEL	_CalcIPChecksum_sum_1_1
	BCF	_CalcIPChecksum_sum_1_1, 1, B
	BANKSEL	_CalcIPChecksum_sum_1_1
	BCF	_CalcIPChecksum_sum_1_1, 2, B
	BANKSEL	_CalcIPChecksum_sum_1_1
	BCF	_CalcIPChecksum_sum_1_1, 3, B
	BANKSEL	_CalcIPChecksum_sum_1_1
	BCF	_CalcIPChecksum_sum_1_1, 4, B
	BANKSEL	_CalcIPChecksum_sum_1_1
	BCF	_CalcIPChecksum_sum_1_1, 5, B
	BANKSEL	_CalcIPChecksum_sum_1_1
	BCF	_CalcIPChecksum_sum_1_1, 6, B
	BANKSEL	_CalcIPChecksum_sum_1_1
	BCF	_CalcIPChecksum_sum_1_1, 7, B
	BANKSEL	(_CalcIPChecksum_sum_1_1 + 1)
	BCF	(_CalcIPChecksum_sum_1_1 + 1), 0, B
	BANKSEL	(_CalcIPChecksum_sum_1_1 + 1)
	BCF	(_CalcIPChecksum_sum_1_1 + 1), 1, B
	BANKSEL	(_CalcIPChecksum_sum_1_1 + 1)
	BCF	(_CalcIPChecksum_sum_1_1 + 1), 2, B
	BANKSEL	(_CalcIPChecksum_sum_1_1 + 1)
	BCF	(_CalcIPChecksum_sum_1_1 + 1), 3, B
	BANKSEL	(_CalcIPChecksum_sum_1_1 + 1)
	BCF	(_CalcIPChecksum_sum_1_1 + 1), 4, B
	BANKSEL	(_CalcIPChecksum_sum_1_1 + 1)
	BCF	(_CalcIPChecksum_sum_1_1 + 1), 5, B
	BANKSEL	(_CalcIPChecksum_sum_1_1 + 1)
	BCF	(_CalcIPChecksum_sum_1_1 + 1), 6, B
	BANKSEL	(_CalcIPChecksum_sum_1_1 + 1)
	BCF	(_CalcIPChecksum_sum_1_1 + 1), 7, B
	BANKSEL	(_CalcIPChecksum_sum_1_1 + 2)
	BCF	(_CalcIPChecksum_sum_1_1 + 2), 0, B
	BANKSEL	(_CalcIPChecksum_sum_1_1 + 2)
	BCF	(_CalcIPChecksum_sum_1_1 + 2), 1, B
	BANKSEL	(_CalcIPChecksum_sum_1_1 + 2)
	BCF	(_CalcIPChecksum_sum_1_1 + 2), 2, B
	BANKSEL	(_CalcIPChecksum_sum_1_1 + 2)
	BCF	(_CalcIPChecksum_sum_1_1 + 2), 3, B
	BANKSEL	(_CalcIPChecksum_sum_1_1 + 2)
	BCF	(_CalcIPChecksum_sum_1_1 + 2), 4, B
	BANKSEL	(_CalcIPChecksum_sum_1_1 + 2)
	BCF	(_CalcIPChecksum_sum_1_1 + 2), 5, B
	BANKSEL	(_CalcIPChecksum_sum_1_1 + 2)
	BCF	(_CalcIPChecksum_sum_1_1 + 2), 6, B
	BANKSEL	(_CalcIPChecksum_sum_1_1 + 2)
	BCF	(_CalcIPChecksum_sum_1_1 + 2), 7, B
	BANKSEL	(_CalcIPChecksum_sum_1_1 + 3)
	BCF	(_CalcIPChecksum_sum_1_1 + 3), 0, B
	BANKSEL	(_CalcIPChecksum_sum_1_1 + 3)
	BCF	(_CalcIPChecksum_sum_1_1 + 3), 1, B
	BANKSEL	(_CalcIPChecksum_sum_1_1 + 3)
	BCF	(_CalcIPChecksum_sum_1_1 + 3), 2, B
	BANKSEL	(_CalcIPChecksum_sum_1_1 + 3)
	BCF	(_CalcIPChecksum_sum_1_1 + 3), 3, B
	BANKSEL	(_CalcIPChecksum_sum_1_1 + 3)
	BCF	(_CalcIPChecksum_sum_1_1 + 3), 4, B
	BANKSEL	(_CalcIPChecksum_sum_1_1 + 3)
	BCF	(_CalcIPChecksum_sum_1_1 + 3), 5, B
	BANKSEL	(_CalcIPChecksum_sum_1_1 + 3)
	BCF	(_CalcIPChecksum_sum_1_1 + 3), 6, B
	BANKSEL	(_CalcIPChecksum_sum_1_1 + 3)
	BCF	(_CalcIPChecksum_sum_1_1 + 3), 7, B
;	.line	1068; TCPIP_Stack/Helpers.c	i = count >> 1;
	BCF	STATUS, 0
	BANKSEL	(_CalcIPChecksum_count_1_1 + 1)
	RRCF	(_CalcIPChecksum_count_1_1 + 1), W, B
	MOVWF	r0x04
	BANKSEL	_CalcIPChecksum_count_1_1
	RRCF	_CalcIPChecksum_count_1_1, W, B
	MOVWF	r0x03
_00274_DS_:
;	.line	1072; TCPIP_Stack/Helpers.c	while(i--)
	MOVFF	r0x03, r0x05
	MOVFF	r0x04, r0x06
	MOVLW	0xff
	ADDWF	r0x03, F
	BTFSS	STATUS, 0
	DECF	r0x04, F
	MOVF	r0x05, W
	IORWF	r0x06, W
	BZ	_00276_DS_
;	.line	1073; TCPIP_Stack/Helpers.c	sum.Val += (DWORD)*val++;
	MOVFF	r0x00, FSR0L
	MOVFF	r0x01, PRODL
	MOVF	r0x02, W
	CALL	__gptrget2
	MOVWF	r0x05
	MOVFF	PRODL, r0x06
	MOVLW	0x02
	ADDWF	r0x00, F
	MOVLW	0x00
	ADDWFC	r0x01, F
	MOVLW	0x00
	ADDWFC	r0x02, F
	CLRF	r0x07
	CLRF	r0x08
	BANKSEL	_CalcIPChecksum_sum_1_1
	MOVF	_CalcIPChecksum_sum_1_1, W, B
	ADDWF	r0x05, F
	BANKSEL	(_CalcIPChecksum_sum_1_1 + 1)
	MOVF	(_CalcIPChecksum_sum_1_1 + 1), W, B
	ADDWFC	r0x06, F
	BANKSEL	(_CalcIPChecksum_sum_1_1 + 2)
	MOVF	(_CalcIPChecksum_sum_1_1 + 2), W, B
	ADDWFC	r0x07, F
	BANKSEL	(_CalcIPChecksum_sum_1_1 + 3)
	MOVF	(_CalcIPChecksum_sum_1_1 + 3), W, B
	ADDWFC	r0x08, F
	MOVF	r0x05, W
	BANKSEL	_CalcIPChecksum_sum_1_1
	MOVWF	_CalcIPChecksum_sum_1_1, B
	MOVF	r0x06, W
	BANKSEL	(_CalcIPChecksum_sum_1_1 + 1)
	MOVWF	(_CalcIPChecksum_sum_1_1 + 1), B
	MOVF	r0x07, W
	BANKSEL	(_CalcIPChecksum_sum_1_1 + 2)
	MOVWF	(_CalcIPChecksum_sum_1_1 + 2), B
	MOVF	r0x08, W
	BANKSEL	(_CalcIPChecksum_sum_1_1 + 3)
	MOVWF	(_CalcIPChecksum_sum_1_1 + 3), B
	BRA	_00274_DS_
_00276_DS_:
	BANKSEL	_CalcIPChecksum_count_1_1
;	.line	1076; TCPIP_Stack/Helpers.c	if(((WORD_VAL*)&count)->bits.b0)
	BTFSS	_CalcIPChecksum_count_1_1, 0, B
	BRA	_00278_DS_
;	.line	1077; TCPIP_Stack/Helpers.c	sum.Val += (DWORD)*(BYTE*)val;
	MOVFF	r0x00, FSR0L
	MOVFF	r0x01, PRODL
	MOVF	r0x02, W
	CALL	__gptrget1
	MOVWF	r0x00
	CLRF	r0x01
	CLRF	r0x02
	CLRF	r0x03
	BANKSEL	_CalcIPChecksum_sum_1_1
	MOVF	_CalcIPChecksum_sum_1_1, W, B
	ADDWF	r0x00, F
	BANKSEL	(_CalcIPChecksum_sum_1_1 + 1)
	MOVF	(_CalcIPChecksum_sum_1_1 + 1), W, B
	ADDWFC	r0x01, F
	BANKSEL	(_CalcIPChecksum_sum_1_1 + 2)
	MOVF	(_CalcIPChecksum_sum_1_1 + 2), W, B
	ADDWFC	r0x02, F
	BANKSEL	(_CalcIPChecksum_sum_1_1 + 3)
	MOVF	(_CalcIPChecksum_sum_1_1 + 3), W, B
	ADDWFC	r0x03, F
	MOVF	r0x00, W
	BANKSEL	_CalcIPChecksum_sum_1_1
	MOVWF	_CalcIPChecksum_sum_1_1, B
	MOVF	r0x01, W
	BANKSEL	(_CalcIPChecksum_sum_1_1 + 1)
	MOVWF	(_CalcIPChecksum_sum_1_1 + 1), B
	MOVF	r0x02, W
	BANKSEL	(_CalcIPChecksum_sum_1_1 + 2)
	MOVWF	(_CalcIPChecksum_sum_1_1 + 2), B
	MOVF	r0x03, W
	BANKSEL	(_CalcIPChecksum_sum_1_1 + 3)
	MOVWF	(_CalcIPChecksum_sum_1_1 + 3), B
_00278_DS_:
;	.line	1080; TCPIP_Stack/Helpers.c	sum.Val = (DWORD)sum.w[0] + (DWORD)sum.w[1];
	MOVFF	_CalcIPChecksum_sum_1_1, r0x00
	MOVFF	(_CalcIPChecksum_sum_1_1 + 1), r0x01
	CLRF	r0x02
	CLRF	r0x03
	MOVFF	(_CalcIPChecksum_sum_1_1 + 2), r0x04
	MOVFF	(_CalcIPChecksum_sum_1_1 + 3), r0x05
	CLRF	r0x06
	CLRF	r0x07
	MOVF	r0x04, W
	ADDWF	r0x00, F
	MOVF	r0x05, W
	ADDWFC	r0x01, F
	MOVF	r0x06, W
	ADDWFC	r0x02, F
	MOVF	r0x07, W
	ADDWFC	r0x03, F
	MOVF	r0x00, W
	BANKSEL	_CalcIPChecksum_sum_1_1
	MOVWF	_CalcIPChecksum_sum_1_1, B
	MOVF	r0x01, W
	BANKSEL	(_CalcIPChecksum_sum_1_1 + 1)
	MOVWF	(_CalcIPChecksum_sum_1_1 + 1), B
	MOVF	r0x02, W
	BANKSEL	(_CalcIPChecksum_sum_1_1 + 2)
	MOVWF	(_CalcIPChecksum_sum_1_1 + 2), B
	MOVF	r0x03, W
	BANKSEL	(_CalcIPChecksum_sum_1_1 + 3)
	MOVWF	(_CalcIPChecksum_sum_1_1 + 3), B
	BANKSEL	(_CalcIPChecksum_sum_1_1 + 2)
;	.line	1084; TCPIP_Stack/Helpers.c	sum.w[0] += sum.w[1];
	MOVF	(_CalcIPChecksum_sum_1_1 + 2), W, B
	BANKSEL	_CalcIPChecksum_sum_1_1
	ADDWF	_CalcIPChecksum_sum_1_1, W, B
	MOVWF	r0x00
	BANKSEL	(_CalcIPChecksum_sum_1_1 + 3)
	MOVF	(_CalcIPChecksum_sum_1_1 + 3), W, B
	BANKSEL	(_CalcIPChecksum_sum_1_1 + 1)
	ADDWFC	(_CalcIPChecksum_sum_1_1 + 1), W, B
	MOVWF	r0x01
	MOVF	r0x00, W
	BANKSEL	_CalcIPChecksum_sum_1_1
	MOVWF	_CalcIPChecksum_sum_1_1, B
	MOVF	r0x01, W
	BANKSEL	(_CalcIPChecksum_sum_1_1 + 1)
	MOVWF	(_CalcIPChecksum_sum_1_1 + 1), B
	BANKSEL	_CalcIPChecksum_sum_1_1
;	.line	1087; TCPIP_Stack/Helpers.c	return ~sum.w[0];
	COMF	_CalcIPChecksum_sum_1_1, W, B
	MOVWF	r0x00
	BANKSEL	(_CalcIPChecksum_sum_1_1 + 1)
	COMF	(_CalcIPChecksum_sum_1_1 + 1), W, B
	MOVWF	r0x01
	MOVFF	r0x01, PRODL
	MOVF	r0x00, W
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
S_Helpers__swapl	code
_swapl:
;	.line	1020; TCPIP_Stack/Helpers.c	DWORD swapl(DWORD v)
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, _swapl_v_1_1
	MOVLW	0x03
	MOVFF	PLUSW2, (_swapl_v_1_1 + 1)
	MOVLW	0x04
	MOVFF	PLUSW2, (_swapl_v_1_1 + 2)
	MOVLW	0x05
	MOVFF	PLUSW2, (_swapl_v_1_1 + 3)
;	.line	1023; TCPIP_Stack/Helpers.c	((DWORD_VAL*)&v)->v[0] ^= ((DWORD_VAL*)&v)->v[3];
	MOVFF	(_swapl_v_1_1 + 3), r0x00
	MOVF	r0x00, W
	BANKSEL	_swapl_v_1_1
	XORWF	_swapl_v_1_1, W, B
	MOVWF	r0x01
	MOVF	r0x01, W
	BANKSEL	_swapl_v_1_1
	MOVWF	_swapl_v_1_1, B
	BANKSEL	_swapl_v_1_1
;	.line	1024; TCPIP_Stack/Helpers.c	((DWORD_VAL*)&v)->v[3] ^= ((DWORD_VAL*)&v)->v[0];
	MOVF	_swapl_v_1_1, W, B
	XORWF	r0x00, F
	MOVF	r0x00, W
	BANKSEL	(_swapl_v_1_1 + 3)
	MOVWF	(_swapl_v_1_1 + 3), B
	BANKSEL	(_swapl_v_1_1 + 3)
;	.line	1025; TCPIP_Stack/Helpers.c	((DWORD_VAL*)&v)->v[0] ^= ((DWORD_VAL*)&v)->v[3];
	MOVF	(_swapl_v_1_1 + 3), W, B
	BANKSEL	_swapl_v_1_1
	XORWF	_swapl_v_1_1, W, B
	MOVWF	r0x00
	MOVF	r0x00, W
	BANKSEL	_swapl_v_1_1
	MOVWF	_swapl_v_1_1, B
;	.line	1028; TCPIP_Stack/Helpers.c	((DWORD_VAL*)&v)->v[1] ^= ((DWORD_VAL*)&v)->v[2];
	MOVFF	(_swapl_v_1_1 + 2), r0x00
	MOVF	r0x00, W
	BANKSEL	(_swapl_v_1_1 + 1)
	XORWF	(_swapl_v_1_1 + 1), W, B
	MOVWF	r0x01
	MOVF	r0x01, W
	BANKSEL	(_swapl_v_1_1 + 1)
	MOVWF	(_swapl_v_1_1 + 1), B
	BANKSEL	(_swapl_v_1_1 + 1)
;	.line	1029; TCPIP_Stack/Helpers.c	((DWORD_VAL*)&v)->v[2] ^= ((DWORD_VAL*)&v)->v[1];
	MOVF	(_swapl_v_1_1 + 1), W, B
	XORWF	r0x00, F
	MOVF	r0x00, W
	BANKSEL	(_swapl_v_1_1 + 2)
	MOVWF	(_swapl_v_1_1 + 2), B
	BANKSEL	(_swapl_v_1_1 + 2)
;	.line	1030; TCPIP_Stack/Helpers.c	((DWORD_VAL*)&v)->v[1] ^= ((DWORD_VAL*)&v)->v[2];
	MOVF	(_swapl_v_1_1 + 2), W, B
	BANKSEL	(_swapl_v_1_1 + 1)
	XORWF	(_swapl_v_1_1 + 1), W, B
	MOVWF	r0x00
	MOVF	r0x00, W
	BANKSEL	(_swapl_v_1_1 + 1)
	MOVWF	(_swapl_v_1_1 + 1), B
;	.line	1032; TCPIP_Stack/Helpers.c	return v;
	MOVFF	(_swapl_v_1_1 + 3), FSR0L
	MOVFF	(_swapl_v_1_1 + 2), PRODH
	MOVFF	(_swapl_v_1_1 + 1), PRODL
	BANKSEL	_swapl_v_1_1
	MOVF	_swapl_v_1_1, W, B
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_Helpers__swaps	code
_swaps:
;	.line	991; TCPIP_Stack/Helpers.c	WORD swaps(WORD v)
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, r0x00
	MOVLW	0x03
	MOVFF	PLUSW2, r0x01
;	.line	996; TCPIP_Stack/Helpers.c	t.Val   = v;
	MOVF	r0x00, W
	BANKSEL	_swaps_t_1_1
	MOVWF	_swaps_t_1_1, B
	MOVF	r0x01, W
	BANKSEL	(_swaps_t_1_1 + 1)
	MOVWF	(_swaps_t_1_1 + 1), B
;	.line	997; TCPIP_Stack/Helpers.c	b       = t.v[1];
	MOVFF	(_swaps_t_1_1 + 1), r0x00
;	.line	998; TCPIP_Stack/Helpers.c	t.v[1]  = t.v[0];
	MOVFF	_swaps_t_1_1, r0x01
	MOVF	r0x01, W
	BANKSEL	(_swaps_t_1_1 + 1)
	MOVWF	(_swaps_t_1_1 + 1), B
;	.line	999; TCPIP_Stack/Helpers.c	t.v[0]  = b;
	MOVF	r0x00, W
	BANKSEL	_swaps_t_1_1
	MOVWF	_swaps_t_1_1, B
;	.line	1001; TCPIP_Stack/Helpers.c	return t.Val;
	MOVFF	(_swaps_t_1_1 + 1), PRODL
	BANKSEL	_swaps_t_1_1
	MOVF	_swaps_t_1_1, W, B
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_Helpers__btohexa_low	code
_btohexa_low:
;	.line	904; TCPIP_Stack/Helpers.c	BYTE btohexa_low(BYTE b)
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVFF	r0x02, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, r0x00
;	.line	906; TCPIP_Stack/Helpers.c	b &= 0x0F;
	MOVLW	0x0f
	ANDWF	r0x00, F
;	.line	907; TCPIP_Stack/Helpers.c	return (b>9u) ? b+'A'-10:b+'0';
	MOVFF	r0x00, r0x01
	CLRF	r0x02
	MOVLW	0x00
	SUBWF	r0x02, W
	BNZ	_00259_DS_
	MOVLW	0x0a
	SUBWF	r0x01, W
_00259_DS_:
	BNC	_00255_DS_
	MOVLW	0x37
	ADDWF	r0x00, W
	MOVWF	r0x01
	BRA	_00256_DS_
_00255_DS_:
	MOVLW	0x30
	ADDWF	r0x00, W
	MOVWF	r0x01
_00256_DS_:
	MOVF	r0x01, W
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_Helpers__btohexa_high	code
_btohexa_high:
;	.line	878; TCPIP_Stack/Helpers.c	BYTE btohexa_high(BYTE b)
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVFF	r0x02, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, r0x00
;	.line	880; TCPIP_Stack/Helpers.c	b >>= 4;
	SWAPF	r0x00, W
	ANDLW	0x0f
	MOVWF	r0x00
;	.line	881; TCPIP_Stack/Helpers.c	return (b>0x9u) ? b+'A'-10:b+'0';
	MOVFF	r0x00, r0x01
	CLRF	r0x02
	MOVLW	0x00
	SUBWF	r0x02, W
	BNZ	_00248_DS_
	MOVLW	0x0a
	SUBWF	r0x01, W
_00248_DS_:
	BNC	_00245_DS_
	MOVLW	0x37
	ADDWF	r0x00, W
	MOVWF	r0x01
	BRA	_00246_DS_
_00245_DS_:
	MOVLW	0x30
	ADDWF	r0x00, W
	MOVWF	r0x01
_00246_DS_:
	MOVF	r0x01, W
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_Helpers__hexatob	code
_hexatob:
;	.line	829; TCPIP_Stack/Helpers.c	BYTE hexatob(WORD AsciiCharsarg)
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
;	.line	832; TCPIP_Stack/Helpers.c	AsciiChars.v[0] = (BYTE)AsciiCharsarg&0xFF; //ML
	MOVF	r0x00, W
	MOVWF	r0x02
	MOVF	r0x02, W
	BANKSEL	_hexatob_AsciiChars_1_1
	MOVWF	_hexatob_AsciiChars_1_1, B
;	.line	833; TCPIP_Stack/Helpers.c	AsciiChars.v[1] = (BYTE)(AsciiCharsarg>>8)&0xFF; //ML
	MOVF	r0x01, W
	MOVWF	r0x00
	CLRF	r0x01
	MOVF	r0x00, W
	BANKSEL	(_hexatob_AsciiChars_1_1 + 1)
	MOVWF	(_hexatob_AsciiChars_1_1 + 1), B
;	.line	836; TCPIP_Stack/Helpers.c	if(AsciiChars.v[1] > (int)'F')
	MOVFF	(_hexatob_AsciiChars_1_1 + 1), r0x01
	CLRF	r0x02
	MOVF	r0x02, W
	ADDLW	0x80
	ADDLW	0x80
	BNZ	_00235_DS_
	MOVLW	0x47
	SUBWF	r0x00, W
_00235_DS_:
	BNC	_00220_DS_
;	.line	837; TCPIP_Stack/Helpers.c	AsciiChars.v[1] -= (int)'a'-(int)'A';
	MOVLW	0xe0
	ADDWF	r0x01, F
	MOVF	r0x01, W
	BANKSEL	(_hexatob_AsciiChars_1_1 + 1)
	MOVWF	(_hexatob_AsciiChars_1_1 + 1), B
_00220_DS_:
;	.line	838; TCPIP_Stack/Helpers.c	if(AsciiChars.v[0] > (int)'F')
	MOVFF	_hexatob_AsciiChars_1_1, r0x00
	MOVFF	r0x00, r0x01
	CLRF	r0x02
	MOVF	r0x02, W
	ADDLW	0x80
	ADDLW	0x80
	BNZ	_00236_DS_
	MOVLW	0x47
	SUBWF	r0x01, W
_00236_DS_:
	BNC	_00222_DS_
;	.line	839; TCPIP_Stack/Helpers.c	AsciiChars.v[0] -= (int)'a'-(int)'A';
	MOVLW	0xe0
	ADDWF	r0x00, F
	MOVF	r0x00, W
	BANKSEL	_hexatob_AsciiChars_1_1
	MOVWF	_hexatob_AsciiChars_1_1, B
_00222_DS_:
;	.line	842; TCPIP_Stack/Helpers.c	if(AsciiChars.v[1] > (int)'9')
	MOVFF	(_hexatob_AsciiChars_1_1 + 1), r0x00
	MOVFF	r0x00, r0x01
	CLRF	r0x02
	MOVF	r0x02, W
	ADDLW	0x80
	ADDLW	0x80
	BNZ	_00237_DS_
	MOVLW	0x3a
	SUBWF	r0x01, W
_00237_DS_:
	BNC	_00224_DS_
;	.line	843; TCPIP_Stack/Helpers.c	AsciiChars.v[1] -= (int)'A' - 10;
	MOVLW	0xc9
	ADDWF	r0x00, W
	MOVWF	r0x01
	MOVF	r0x01, W
	BANKSEL	(_hexatob_AsciiChars_1_1 + 1)
	MOVWF	(_hexatob_AsciiChars_1_1 + 1), B
	BRA	_00225_DS_
_00224_DS_:
;	.line	845; TCPIP_Stack/Helpers.c	AsciiChars.v[1] -= '0';
	MOVLW	0xd0
	ADDWF	r0x00, F
	MOVF	r0x00, W
	BANKSEL	(_hexatob_AsciiChars_1_1 + 1)
	MOVWF	(_hexatob_AsciiChars_1_1 + 1), B
_00225_DS_:
;	.line	847; TCPIP_Stack/Helpers.c	if(AsciiChars.v[0] > (int)'9')
	MOVFF	_hexatob_AsciiChars_1_1, r0x00
	MOVFF	r0x00, r0x01
	CLRF	r0x02
	MOVF	r0x02, W
	ADDLW	0x80
	ADDLW	0x80
	BNZ	_00238_DS_
	MOVLW	0x3a
	SUBWF	r0x01, W
_00238_DS_:
	BNC	_00227_DS_
;	.line	848; TCPIP_Stack/Helpers.c	AsciiChars.v[0] -= (int)'A' - 10;
	MOVLW	0xc9
	ADDWF	r0x00, W
	MOVWF	r0x01
	MOVF	r0x01, W
	BANKSEL	_hexatob_AsciiChars_1_1
	MOVWF	_hexatob_AsciiChars_1_1, B
	BRA	_00228_DS_
_00227_DS_:
;	.line	850; TCPIP_Stack/Helpers.c	AsciiChars.v[0] -= (int)'0';
	MOVLW	0xd0
	ADDWF	r0x00, F
	MOVF	r0x00, W
	BANKSEL	_hexatob_AsciiChars_1_1
	MOVWF	_hexatob_AsciiChars_1_1, B
_00228_DS_:
;	.line	854; TCPIP_Stack/Helpers.c	return (WORD)((AsciiChars.v[1]<<4) |  AsciiChars.v[0]);
	MOVFF	(_hexatob_AsciiChars_1_1 + 1), r0x00
	CLRF	r0x01
	SWAPF	r0x01, W
	ANDLW	0xf0
	MOVWF	r0x03
	SWAPF	r0x00, W
	MOVWF	r0x02
	ANDLW	0x0f
	XORWF	r0x02, F
	ADDWF	r0x03, F
	MOVFF	_hexatob_AsciiChars_1_1, r0x00
	CLRF	r0x01
	MOVF	r0x00, W
	IORWF	r0x02, F
	MOVF	r0x01, W
	IORWF	r0x03, F
	MOVF	r0x02, W
	MOVFF	PREINC1, r0x03
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_Helpers__StringToIPAddress	code
_StringToIPAddress:
;	.line	330; TCPIP_Stack/Helpers.c	BOOL StringToIPAddress(BYTE* str, IP_ADDR* IPAddress)
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
	MOVLW	0x06
	MOVFF	PLUSW2, r0x04
	MOVLW	0x07
	MOVFF	PLUSW2, r0x05
;	.line	335; TCPIP_Stack/Helpers.c	charLen = 0;
	CLRF	r0x06
;	.line	336; TCPIP_Stack/Helpers.c	currentOctet = 0;
	CLRF	r0x07
	BANKSEL	_StringToIPAddress_dwVal_1_1
;	.line	337; TCPIP_Stack/Helpers.c	dwVal.Val = 0;
	CLRF	_StringToIPAddress_dwVal_1_1, B
	BANKSEL	(_StringToIPAddress_dwVal_1_1 + 1)
	CLRF	(_StringToIPAddress_dwVal_1_1 + 1), B
	BANKSEL	(_StringToIPAddress_dwVal_1_1 + 2)
	CLRF	(_StringToIPAddress_dwVal_1_1 + 2), B
	BANKSEL	(_StringToIPAddress_dwVal_1_1 + 3)
	CLRF	(_StringToIPAddress_dwVal_1_1 + 3), B
_00161_DS_:
;	.line	338; TCPIP_Stack/Helpers.c	while((i = *str++))
	MOVFF	r0x00, FSR0L
	MOVFF	r0x01, PRODL
	MOVF	r0x02, W
	CALL	__gptrget1
	MOVWF	r0x08
	INCF	r0x00, F
	BTFSC	STATUS, 0
	INCF	r0x01, F
	BTFSC	STATUS, 0
	INCF	r0x02, F
	MOVFF	r0x08, r0x09
	MOVF	r0x08, W
	BTFSC	STATUS, 2
	BRA	_00163_DS_
;	.line	340; TCPIP_Stack/Helpers.c	if(currentOctet > 3u)
	MOVFF	r0x07, r0x08
	CLRF	r0x0a
	MOVLW	0x00
	SUBWF	r0x0a, W
	BNZ	_00193_DS_
	MOVLW	0x04
	SUBWF	r0x08, W
_00193_DS_:
	BTFSC	STATUS, 0
	BRA	_00163_DS_
;	.line	343; TCPIP_Stack/Helpers.c	i -= '0';
	MOVLW	0xd0
	ADDWF	r0x09, F
;	.line	347; TCPIP_Stack/Helpers.c	if(charLen == 0u)
	MOVF	r0x06, W
	BNZ	_00159_DS_
;	.line	349; TCPIP_Stack/Helpers.c	if(i > 9u)
	MOVFF	r0x09, r0x08
	CLRF	r0x0a
	MOVLW	0x00
	SUBWF	r0x0a, W
	BNZ	_00194_DS_
	MOVLW	0x0a
	SUBWF	r0x08, W
_00194_DS_:
	BTFSS	STATUS, 0
	BRA	_00160_DS_
;	.line	350; TCPIP_Stack/Helpers.c	return FALSE;
	CLRF	WREG
	BRA	_00173_DS_
_00159_DS_:
;	.line	352; TCPIP_Stack/Helpers.c	else if(charLen == 3u)
	MOVFF	r0x06, r0x08
	CLRF	r0x0a
	MOVF	r0x08, W
	XORLW	0x03
	BNZ	_00195_DS_
	MOVF	r0x0a, W
	BZ	_00196_DS_
_00195_DS_:
	BRA	_00156_DS_
_00196_DS_:
;	.line	354; TCPIP_Stack/Helpers.c	if(i != (BYTE)('.' - '0'))
	MOVF	r0x09, W
	XORLW	0xfe
	BZ	_00146_DS_
;	.line	355; TCPIP_Stack/Helpers.c	return FALSE;
	CLRF	WREG
	BRA	_00173_DS_
_00146_DS_:
;	.line	357; TCPIP_Stack/Helpers.c	if(dwVal.Val > 0x00020505ul)
	MOVLW	0x00
	BANKSEL	(_StringToIPAddress_dwVal_1_1 + 3)
	SUBWF	(_StringToIPAddress_dwVal_1_1 + 3), W, B
	BNZ	_00199_DS_
	MOVLW	0x02
	BANKSEL	(_StringToIPAddress_dwVal_1_1 + 2)
	SUBWF	(_StringToIPAddress_dwVal_1_1 + 2), W, B
	BNZ	_00199_DS_
	MOVLW	0x05
	BANKSEL	(_StringToIPAddress_dwVal_1_1 + 1)
	SUBWF	(_StringToIPAddress_dwVal_1_1 + 1), W, B
	BNZ	_00199_DS_
	MOVLW	0x06
	BANKSEL	_StringToIPAddress_dwVal_1_1
	SUBWF	_StringToIPAddress_dwVal_1_1, W, B
_00199_DS_:
	BNC	_00148_DS_
;	.line	358; TCPIP_Stack/Helpers.c	return FALSE;
	CLRF	WREG
	BRA	_00173_DS_
_00148_DS_:
;	.line	360; TCPIP_Stack/Helpers.c	IPAddress->v[currentOctet++] = dwVal.v[2]*((BYTE)100) + dwVal.v[1]*((BYTE)10) + dwVal.v[0];
	MOVFF	r0x07, r0x08
	INCF	r0x07, F
	CLRF	r0x0a
	CLRF	r0x0b
	MOVF	r0x03, W
	ADDWF	r0x08, F
	MOVF	r0x04, W
	ADDWFC	r0x0a, F
	MOVF	r0x05, W
	ADDWFC	r0x0b, F
; ;multiply lit val:0x64 by variable (_StringToIPAddress_dwVal_1_1 + 2) and store in r0x0c
; ;Unrolled 8 X 8 multiplication
; ;FIXME: the function does not support result==WREG
	BANKSEL	(_StringToIPAddress_dwVal_1_1 + 2)
	MOVF	(_StringToIPAddress_dwVal_1_1 + 2), W, B
	MULLW	0x64
	MOVFF	PRODL, r0x0c
; ;multiply lit val:0x0a by variable (_StringToIPAddress_dwVal_1_1 + 1) and store in r0x0d
; ;Unrolled 8 X 8 multiplication
; ;FIXME: the function does not support result==WREG
	BANKSEL	(_StringToIPAddress_dwVal_1_1 + 1)
	MOVF	(_StringToIPAddress_dwVal_1_1 + 1), W, B
	MULLW	0x0a
	MOVFF	PRODL, r0x0d
	MOVF	r0x0d, W
	ADDWF	r0x0c, F
	BANKSEL	_StringToIPAddress_dwVal_1_1
	MOVF	_StringToIPAddress_dwVal_1_1, W, B
	ADDWF	r0x0c, F
	MOVFF	r0x0c, POSTDEC1
	MOVFF	r0x08, FSR0L
	MOVFF	r0x0a, PRODL
	MOVF	r0x0b, W
	CALL	__gptrput1
;	.line	361; TCPIP_Stack/Helpers.c	charLen = 0;
	CLRF	r0x06
	BANKSEL	_StringToIPAddress_dwVal_1_1
;	.line	362; TCPIP_Stack/Helpers.c	dwVal.Val = 0;
	CLRF	_StringToIPAddress_dwVal_1_1, B
	BANKSEL	(_StringToIPAddress_dwVal_1_1 + 1)
	CLRF	(_StringToIPAddress_dwVal_1_1 + 1), B
	BANKSEL	(_StringToIPAddress_dwVal_1_1 + 2)
	CLRF	(_StringToIPAddress_dwVal_1_1 + 2), B
	BANKSEL	(_StringToIPAddress_dwVal_1_1 + 3)
	CLRF	(_StringToIPAddress_dwVal_1_1 + 3), B
;	.line	363; TCPIP_Stack/Helpers.c	continue;
	BRA	_00161_DS_
_00156_DS_:
;	.line	367; TCPIP_Stack/Helpers.c	if(i == (BYTE)('.' - '0'))
	MOVF	r0x09, W
	XORLW	0xfe
	BZ	_00201_DS_
	BRA	_00152_DS_
_00201_DS_:
;	.line	369; TCPIP_Stack/Helpers.c	if(dwVal.Val > 0x00020505ul)
	MOVLW	0x00
	BANKSEL	(_StringToIPAddress_dwVal_1_1 + 3)
	SUBWF	(_StringToIPAddress_dwVal_1_1 + 3), W, B
	BNZ	_00202_DS_
	MOVLW	0x02
	BANKSEL	(_StringToIPAddress_dwVal_1_1 + 2)
	SUBWF	(_StringToIPAddress_dwVal_1_1 + 2), W, B
	BNZ	_00202_DS_
	MOVLW	0x05
	BANKSEL	(_StringToIPAddress_dwVal_1_1 + 1)
	SUBWF	(_StringToIPAddress_dwVal_1_1 + 1), W, B
	BNZ	_00202_DS_
	MOVLW	0x06
	BANKSEL	_StringToIPAddress_dwVal_1_1
	SUBWF	_StringToIPAddress_dwVal_1_1, W, B
_00202_DS_:
	BNC	_00150_DS_
;	.line	370; TCPIP_Stack/Helpers.c	return FALSE;
	CLRF	WREG
	BRA	_00173_DS_
_00150_DS_:
;	.line	372; TCPIP_Stack/Helpers.c	IPAddress->v[currentOctet++] = dwVal.v[2]*((BYTE)100) + dwVal.v[1]*((BYTE)10) + dwVal.v[0];
	MOVFF	r0x07, r0x08
	INCF	r0x07, F
	CLRF	r0x0a
	CLRF	r0x0b
	MOVF	r0x03, W
	ADDWF	r0x08, F
	MOVF	r0x04, W
	ADDWFC	r0x0a, F
	MOVF	r0x05, W
	ADDWFC	r0x0b, F
; ;multiply lit val:0x64 by variable (_StringToIPAddress_dwVal_1_1 + 2) and store in r0x0c
; ;Unrolled 8 X 8 multiplication
; ;FIXME: the function does not support result==WREG
	BANKSEL	(_StringToIPAddress_dwVal_1_1 + 2)
	MOVF	(_StringToIPAddress_dwVal_1_1 + 2), W, B
	MULLW	0x64
	MOVFF	PRODL, r0x0c
; ;multiply lit val:0x0a by variable (_StringToIPAddress_dwVal_1_1 + 1) and store in r0x0d
; ;Unrolled 8 X 8 multiplication
; ;FIXME: the function does not support result==WREG
	BANKSEL	(_StringToIPAddress_dwVal_1_1 + 1)
	MOVF	(_StringToIPAddress_dwVal_1_1 + 1), W, B
	MULLW	0x0a
	MOVFF	PRODL, r0x0d
	MOVF	r0x0d, W
	ADDWF	r0x0c, F
	BANKSEL	_StringToIPAddress_dwVal_1_1
	MOVF	_StringToIPAddress_dwVal_1_1, W, B
	ADDWF	r0x0c, F
	MOVFF	r0x0c, POSTDEC1
	MOVFF	r0x08, FSR0L
	MOVFF	r0x0a, PRODL
	MOVF	r0x0b, W
	CALL	__gptrput1
;	.line	373; TCPIP_Stack/Helpers.c	charLen = 0;
	CLRF	r0x06
	BANKSEL	_StringToIPAddress_dwVal_1_1
;	.line	374; TCPIP_Stack/Helpers.c	dwVal.Val = 0;
	CLRF	_StringToIPAddress_dwVal_1_1, B
	BANKSEL	(_StringToIPAddress_dwVal_1_1 + 1)
	CLRF	(_StringToIPAddress_dwVal_1_1 + 1), B
	BANKSEL	(_StringToIPAddress_dwVal_1_1 + 2)
	CLRF	(_StringToIPAddress_dwVal_1_1 + 2), B
	BANKSEL	(_StringToIPAddress_dwVal_1_1 + 3)
	CLRF	(_StringToIPAddress_dwVal_1_1 + 3), B
;	.line	375; TCPIP_Stack/Helpers.c	continue;
	BRA	_00161_DS_
_00152_DS_:
;	.line	377; TCPIP_Stack/Helpers.c	if(i > 9u)
	MOVFF	r0x09, r0x08
	CLRF	r0x0a
	MOVLW	0x00
	SUBWF	r0x0a, W
	BNZ	_00203_DS_
	MOVLW	0x0a
	SUBWF	r0x08, W
_00203_DS_:
	BNC	_00160_DS_
;	.line	378; TCPIP_Stack/Helpers.c	return FALSE;
	CLRF	WREG
	BRA	_00173_DS_
_00160_DS_:
;	.line	381; TCPIP_Stack/Helpers.c	charLen++;
	INCF	r0x06, F
	BANKSEL	(_StringToIPAddress_dwVal_1_1 + 2)
;	.line	382; TCPIP_Stack/Helpers.c	dwVal.Val <<= 8;
	MOVF	(_StringToIPAddress_dwVal_1_1 + 2), W, B
	MOVWF	r0x0c
	BANKSEL	(_StringToIPAddress_dwVal_1_1 + 1)
	MOVF	(_StringToIPAddress_dwVal_1_1 + 1), W, B
	MOVWF	r0x0b
	BANKSEL	_StringToIPAddress_dwVal_1_1
	MOVF	_StringToIPAddress_dwVal_1_1, W, B
	MOVWF	r0x0a
	CLRF	r0x08
	MOVF	r0x08, W
	BANKSEL	_StringToIPAddress_dwVal_1_1
	MOVWF	_StringToIPAddress_dwVal_1_1, B
	MOVF	r0x0a, W
	BANKSEL	(_StringToIPAddress_dwVal_1_1 + 1)
	MOVWF	(_StringToIPAddress_dwVal_1_1 + 1), B
	MOVF	r0x0b, W
	BANKSEL	(_StringToIPAddress_dwVal_1_1 + 2)
	MOVWF	(_StringToIPAddress_dwVal_1_1 + 2), B
	MOVF	r0x0c, W
	BANKSEL	(_StringToIPAddress_dwVal_1_1 + 3)
	MOVWF	(_StringToIPAddress_dwVal_1_1 + 3), B
;	.line	383; TCPIP_Stack/Helpers.c	dwVal.v[0] = i;
	MOVF	r0x09, W
	BANKSEL	_StringToIPAddress_dwVal_1_1
	MOVWF	_StringToIPAddress_dwVal_1_1, B
	BRA	_00161_DS_
_00163_DS_:
;	.line	389; TCPIP_Stack/Helpers.c	if(i != 0u && i != (int)'/' && i != (int)'\r' && i != (int)'\n' && i !=(int) ' ' && i != (int)'\t')
	MOVF	r0x09, W
	BZ	_00165_DS_
	MOVFF	r0x09, r0x00
	CLRF	r0x01
	MOVF	r0x00, W
	XORLW	0x2f
	BNZ	_00205_DS_
	MOVF	r0x01, W
	BZ	_00165_DS_
_00205_DS_:
	MOVF	r0x00, W
	XORLW	0x0d
	BNZ	_00207_DS_
	MOVF	r0x01, W
	BZ	_00165_DS_
_00207_DS_:
	MOVF	r0x00, W
	XORLW	0x0a
	BNZ	_00209_DS_
	MOVF	r0x01, W
	BZ	_00165_DS_
_00209_DS_:
	MOVF	r0x00, W
	XORLW	0x20
	BNZ	_00211_DS_
	MOVF	r0x01, W
	BZ	_00165_DS_
_00211_DS_:
	MOVF	r0x00, W
	XORLW	0x09
	BNZ	_00213_DS_
	MOVF	r0x01, W
	BZ	_00165_DS_
_00213_DS_:
;	.line	390; TCPIP_Stack/Helpers.c	return FALSE;
	CLRF	WREG
	BRA	_00173_DS_
_00165_DS_:
;	.line	393; TCPIP_Stack/Helpers.c	if(dwVal.Val > 0x00020505ul)
	MOVLW	0x00
	BANKSEL	(_StringToIPAddress_dwVal_1_1 + 3)
	SUBWF	(_StringToIPAddress_dwVal_1_1 + 3), W, B
	BNZ	_00214_DS_
	MOVLW	0x02
	BANKSEL	(_StringToIPAddress_dwVal_1_1 + 2)
	SUBWF	(_StringToIPAddress_dwVal_1_1 + 2), W, B
	BNZ	_00214_DS_
	MOVLW	0x05
	BANKSEL	(_StringToIPAddress_dwVal_1_1 + 1)
	SUBWF	(_StringToIPAddress_dwVal_1_1 + 1), W, B
	BNZ	_00214_DS_
	MOVLW	0x06
	BANKSEL	_StringToIPAddress_dwVal_1_1
	SUBWF	_StringToIPAddress_dwVal_1_1, W, B
_00214_DS_:
	BNC	_00172_DS_
;	.line	394; TCPIP_Stack/Helpers.c	return FALSE;
	CLRF	WREG
	BRA	_00173_DS_
_00172_DS_:
;	.line	396; TCPIP_Stack/Helpers.c	IPAddress->v[3] = dwVal.v[2]*((BYTE)100) + dwVal.v[1]*((BYTE)10) + dwVal.v[0];
	MOVLW	0x03
	ADDWF	r0x03, F
	MOVLW	0x00
	ADDWFC	r0x04, F
	MOVLW	0x00
	ADDWFC	r0x05, F
; ;multiply lit val:0x64 by variable (_StringToIPAddress_dwVal_1_1 + 2) and store in r0x00
; ;Unrolled 8 X 8 multiplication
; ;FIXME: the function does not support result==WREG
	BANKSEL	(_StringToIPAddress_dwVal_1_1 + 2)
	MOVF	(_StringToIPAddress_dwVal_1_1 + 2), W, B
	MULLW	0x64
	MOVFF	PRODL, r0x00
; ;multiply lit val:0x0a by variable (_StringToIPAddress_dwVal_1_1 + 1) and store in r0x01
; ;Unrolled 8 X 8 multiplication
; ;FIXME: the function does not support result==WREG
	BANKSEL	(_StringToIPAddress_dwVal_1_1 + 1)
	MOVF	(_StringToIPAddress_dwVal_1_1 + 1), W, B
	MULLW	0x0a
	MOVFF	PRODL, r0x01
	MOVF	r0x01, W
	ADDWF	r0x00, F
	BANKSEL	_StringToIPAddress_dwVal_1_1
	MOVF	_StringToIPAddress_dwVal_1_1, W, B
	ADDWF	r0x00, F
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x03, FSR0L
	MOVFF	r0x04, PRODL
	MOVF	r0x05, W
	CALL	__gptrput1
;	.line	398; TCPIP_Stack/Helpers.c	return TRUE;
	MOVLW	0x01
_00173_DS_:
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
S_Helpers__GenerateRandomDWORD	code
_GenerateRandomDWORD:
;	.line	106; TCPIP_Stack/Helpers.c	DWORD GenerateRandomDWORD(void)
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
	MOVFF	r0x1c, POSTDEC1
	MOVFF	r0x1d, POSTDEC1
;	.line	119; TCPIP_Stack/Helpers.c	ADCON0Save = ADCON0;
	MOVFF	_ADCON0, r0x00
;	.line	120; TCPIP_Stack/Helpers.c	ADCON2Save = ADCON2;
	MOVFF	_ADCON2, r0x01
;	.line	121; TCPIP_Stack/Helpers.c	T0CONSave = T0CON;
	MOVFF	_T0CON, r0x02
;	.line	122; TCPIP_Stack/Helpers.c	TMR0LSave = TMR0L;
	MOVFF	_TMR0L, r0x03
;	.line	123; TCPIP_Stack/Helpers.c	TMR0HSave = TMR0H;
	MOVFF	_TMR0H, r0x04
;	.line	126; TCPIP_Stack/Helpers.c	ADCON0 = 0x01;	// Turn on the A/D module
	MOVLW	0x01
	MOVWF	_ADCON0
;	.line	127; TCPIP_Stack/Helpers.c	ADCON2 = 0x3F;	// 20 Tad acquisition, Frc A/D clock used for conversion
	MOVLW	0x3f
	MOVWF	_ADCON2
;	.line	128; TCPIP_Stack/Helpers.c	T0CON = 0x88;	// TMR0ON = 1, no prescalar
	MOVLW	0x88
	MOVWF	_T0CON
;	.line	130; TCPIP_Stack/Helpers.c	dwTotalTime = 0;
	CLRF	r0x05
	CLRF	r0x06
	CLRF	r0x07
	CLRF	r0x08
;	.line	131; TCPIP_Stack/Helpers.c	wLastValue = 0;
	CLRF	r0x09
	CLRF	r0x0a
;	.line	132; TCPIP_Stack/Helpers.c	dwRandomResult = rand();
	CALL	_rand
	MOVWF	r0x0b
	MOVFF	PRODL, r0x0c
	MOVFF	PRODH, r0x0d
	MOVFF	FSR0L, r0x0e
;	.line	133; TCPIP_Stack/Helpers.c	while(1)
	CLRF	r0x0f
_00120_DS_:
;	.line	136; TCPIP_Stack/Helpers.c	TMR0H = 0x00;
	CLRF	_TMR0H
;	.line	137; TCPIP_Stack/Helpers.c	TMR0L = 0x00;
	CLRF	_TMR0L
;	.line	138; TCPIP_Stack/Helpers.c	ADCON0bits.GO = 1;
	BSF	_ADCON0bits, 1
	clrwdt 
_00108_DS_:
;	.line	140; TCPIP_Stack/Helpers.c	while(ADCON0bits.GO);
	BTFSC	_ADCON0bits, 1
	BRA	_00108_DS_
;	.line	141; TCPIP_Stack/Helpers.c	((BYTE*)&wTime)[0] = TMR0L;
	MOVF	_TMR0L, W
	BANKSEL	_GenerateRandomDWORD_wTime_1_1
	MOVWF	_GenerateRandomDWORD_wTime_1_1, B
;	.line	142; TCPIP_Stack/Helpers.c	((BYTE*)&wTime)[1] = TMR0H;
	MOVF	_TMR0H, W
	BANKSEL	(_GenerateRandomDWORD_wTime_1_1 + 1)
	MOVWF	(_GenerateRandomDWORD_wTime_1_1 + 1), B
;	.line	143; TCPIP_Stack/Helpers.c	w = rand();
	CALL	_rand
	MOVWF	r0x10
	MOVFF	PRODL, r0x11
	MOVFF	PRODH, r0x12
	MOVFF	FSR0L, r0x13
;	.line	146; TCPIP_Stack/Helpers.c	dwTotalTime += wTime;
	MOVFF	_GenerateRandomDWORD_wTime_1_1, r0x12
	MOVFF	(_GenerateRandomDWORD_wTime_1_1 + 1), r0x13
	CLRF	r0x14
	CLRF	r0x15
	MOVF	r0x12, W
	ADDWF	r0x05, F
	MOVF	r0x13, W
	ADDWFC	r0x06, F
	MOVF	r0x14, W
	ADDWFC	r0x07, F
	MOVF	r0x15, W
	ADDWFC	r0x08, F
;	.line	147; TCPIP_Stack/Helpers.c	if(dwTotalTime >= GetInstructionClock())
	MOVLW	0x00
	SUBWF	r0x08, W
	BNZ	_00130_DS_
	MOVLW	0x9e
	SUBWF	r0x07, W
	BNZ	_00130_DS_
	MOVLW	0xf2
	SUBWF	r0x06, W
	BNZ	_00130_DS_
	MOVLW	0x1a
	SUBWF	r0x05, W
_00130_DS_:
	BTFSS	STATUS, 0
	BRA	_00112_DS_
;	.line	149; TCPIP_Stack/Helpers.c	dwRandomResult ^= rand() | (((DWORD)rand())<<15ul) | (((DWORD)rand())<<30ul);
	CALL	_rand
	MOVWF	r0x12
	MOVFF	PRODL, r0x13
	MOVFF	PRODH, r0x14
	MOVFF	FSR0L, r0x15
	CALL	_rand
	MOVWF	r0x16
	MOVFF	PRODL, r0x17
	MOVFF	PRODH, r0x18
	MOVFF	FSR0L, r0x19
	RRCF	r0x18, W
	RRCF	r0x17, W
	MOVWF	r0x1d
	CLRF	r0x1c
	RRCF	r0x1c, F
	RRNCF	r0x16, W
	ANDLW	0x80
	MOVWF	r0x1b
	MOVF	r0x16, W
	RRNCF	WREG, W
	ANDLW	0x7f
	IORWF	r0x1c, F
	CLRF	r0x1a
	MOVF	r0x1a, W
	IORWF	r0x12, F
	MOVF	r0x1b, W
	IORWF	r0x13, F
	MOVF	r0x1c, W
	IORWF	r0x14, F
	MOVF	r0x1d, W
	IORWF	r0x15, F
	CALL	_rand
	MOVWF	r0x16
	MOVFF	PRODL, r0x17
	MOVFF	PRODH, r0x18
	MOVFF	FSR0L, r0x19
	RRNCF	r0x16, W
	RRNCF	WREG, W
	ANDLW	0xc0
	MOVWF	r0x1d
	CLRF	r0x1a
	CLRF	r0x1b
	CLRF	r0x1c
	MOVF	r0x1a, W
	IORWF	r0x12, F
	MOVF	r0x1b, W
	IORWF	r0x13, F
	MOVF	r0x1c, W
	IORWF	r0x14, F
	MOVF	r0x1d, W
	IORWF	r0x15, F
	MOVF	r0x12, W
	XORWF	r0x0b, F
	MOVF	r0x13, W
	XORWF	r0x0c, F
	MOVF	r0x14, W
	XORWF	r0x0d, F
	MOVF	r0x15, W
	XORWF	r0x0e, F
;	.line	150; TCPIP_Stack/Helpers.c	break;
	BRA	_00121_DS_
_00112_DS_:
;	.line	154; TCPIP_Stack/Helpers.c	if(wLastValue == wTime)
	MOVF	r0x09, W
	BANKSEL	_GenerateRandomDWORD_wTime_1_1
	XORWF	_GenerateRandomDWORD_wTime_1_1, W, B
	BNZ	_00135_DS_
	MOVF	r0x0a, W
	BANKSEL	(_GenerateRandomDWORD_wTime_1_1 + 1)
	XORWF	(_GenerateRandomDWORD_wTime_1_1 + 1), W, B
	BNZ	_00135_DS_
	BRA	_00120_DS_
_00135_DS_:
	BANKSEL	_GenerateRandomDWORD_wTime_1_1
;	.line	158; TCPIP_Stack/Helpers.c	srand(w + (wLastValue - wTime));
	MOVF	_GenerateRandomDWORD_wTime_1_1, W, B
	SUBWF	r0x09, W
	MOVWF	r0x12
	BANKSEL	(_GenerateRandomDWORD_wTime_1_1 + 1)
	MOVF	(_GenerateRandomDWORD_wTime_1_1 + 1), W, B
	SUBWFB	r0x0a, W
	MOVWF	r0x13
	MOVF	r0x12, W
	ADDWF	r0x10, F
	MOVF	r0x13, W
	ADDWFC	r0x11, F
	CLRF	r0x12
	CLRF	r0x13
	MOVF	r0x13, W
	MOVWF	POSTDEC1
	MOVF	r0x12, W
	MOVWF	POSTDEC1
	MOVF	r0x11, W
	MOVWF	POSTDEC1
	MOVF	r0x10, W
	MOVWF	POSTDEC1
	CALL	_srand
	MOVLW	0x04
	ADDWF	FSR1L, F
;	.line	159; TCPIP_Stack/Helpers.c	wLastValue = wTime;
	MOVFF	_GenerateRandomDWORD_wTime_1_1, r0x09
	MOVFF	(_GenerateRandomDWORD_wTime_1_1 + 1), r0x0a
;	.line	162; TCPIP_Stack/Helpers.c	dwRandomResult <<= 1;
	MOVF	r0x0b, W
	ADDWF	r0x0b, F
	RLCF	r0x0c, F
	RLCF	r0x0d, F
	RLCF	r0x0e, F
;	.line	163; TCPIP_Stack/Helpers.c	if(rand() >= 16384)
	CALL	_rand
	MOVWF	r0x10
	MOVFF	PRODL, r0x11
	MOVFF	PRODH, r0x12
	MOVFF	FSR0L, r0x13
	MOVF	r0x13, W
	ADDLW	0x80
	ADDLW	0x80
	BNZ	_00136_DS_
	MOVLW	0x00
	SUBWF	r0x12, W
	BNZ	_00136_DS_
	MOVLW	0x40
	SUBWF	r0x11, W
	BNZ	_00136_DS_
	MOVLW	0x00
	SUBWF	r0x10, W
_00136_DS_:
	BNC	_00116_DS_
;	.line	164; TCPIP_Stack/Helpers.c	dwRandomResult |= 0x1;
	BSF	r0x0b, 0
_00116_DS_:
;	.line	167; TCPIP_Stack/Helpers.c	if(++vBitCount == 0u)
	INCF	r0x0f, F
	MOVF	r0x0f, W
	BTFSS	STATUS, 2
	BRA	_00120_DS_
_00121_DS_:
;	.line	172; TCPIP_Stack/Helpers.c	ADCON0 = ADCON0Save;
	MOVFF	r0x00, _ADCON0
;	.line	173; TCPIP_Stack/Helpers.c	ADCON2 = ADCON2Save;
	MOVFF	r0x01, _ADCON2
;	.line	174; TCPIP_Stack/Helpers.c	TMR0H = TMR0HSave;
	MOVFF	r0x04, _TMR0H
;	.line	175; TCPIP_Stack/Helpers.c	TMR0L = TMR0LSave;
	MOVFF	r0x03, _TMR0L
;	.line	176; TCPIP_Stack/Helpers.c	T0CON = T0CONSave;
	MOVFF	r0x02, _T0CON
;	.line	254; TCPIP_Stack/Helpers.c	return dwRandomResult;
	MOVFF	r0x0e, FSR0L
	MOVFF	r0x0d, PRODH
	MOVFF	r0x0c, PRODL
	MOVF	r0x0b, W
	MOVFF	PREINC1, r0x1d
	MOVFF	PREINC1, r0x1c
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



; Statistics:
; code size:	 3510 (0x0db6) bytes ( 2.68%)
;           	 1755 (0x06db) words
; udata size:	   24 (0x0018) bytes ( 0.62%)
; access size:	   30 (0x001e) bytes


	end
