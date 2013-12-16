;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 2.9.4 #5595 (Dec 17 2009) (UNIX)
; This file was generated Mon Mar 15 11:43:30 2010
;--------------------------------------------------------
; PIC16 port for the Microchip 16-bit core micros
;--------------------------------------------------------
	list	p=18f97j60

	radix dec

;--------------------------------------------------------
; public variables in this module
;--------------------------------------------------------
	global _MACInit
	global _MACIsLinked
	global _MACIsTxReady
	global _MACDiscardRx
	global _MACGetFreeRxSize
	global _MACGetHeader
	global _MACPutHeader
	global _MACFlush
	global _MACSetReadPtrInRx
	global _MACSetWritePtr
	global _MACSetReadPtr
	global _MACCalcRxChecksum
	global _CalcIPBufferChecksum
	global _MACMemCopyAsync
	global _MACIsMemCopyDone
	global _MACGet
	global _MACGetArray
	global _MACPut
	global _MACPutArray
	global _ReadPHYReg
	global _WritePHYReg
	global _MACPowerDown
	global _MACPowerUp
	global _MACPrintHeader

;--------------------------------------------------------
; extern variables in this module
;--------------------------------------------------------
	extern __gptrput1
	extern __gptrget2
	extern __gptrget1
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
	extern _DisplayString
	extern _swaps
	extern _TickGet
	extern _LCDUpdate
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

udata_ETH97J60_0	udata
_NextPacketLocation	res	2

udata_ETH97J60_1	udata
_CurrentPacketLocation	res	2

udata_ETH97J60_2	udata
_WasDiscarded	res	1

udata_ETH97J60_3	udata
_wTXWatchdog	res	2

udata_ETH97J60_4	udata
_MACIsLinked_pr_1_1	res	2

udata_ETH97J60_5	udata
_MACDiscardRx_NewRXRDLocation_1_1	res	2

udata_ETH97J60_6	udata
_MACGetFreeRxSize_ReadPT_1_1	res	2

udata_ETH97J60_7	udata
_MACGetFreeRxSize_WritePT_1_1	res	2

udata_ETH97J60_8	udata
_MACGetHeader_header_1_1	res	20

udata_ETH97J60_9	udata
_MACFlush_i_2_2	res	1

udata_ETH97J60_10	udata
_MACSetReadPtrInRx_ReadPT_1_1	res	2

udata_ETH97J60_11	udata
_CalcIPBufferChecksum_ChunkLen_1_1	res	2

udata_ETH97J60_12	udata
_CalcIPBufferChecksum_Checksum_1_1	res	4

udata_ETH97J60_13	udata
_CalcIPBufferChecksum_DataBuffer_1_1	res	20

udata_ETH97J60_14	udata
_MACMemCopyAsync_destAddr_1_1	res	2

udata_ETH97J60_15	udata
_MACMemCopyAsync_sourceAddr_1_1	res	2

udata_ETH97J60_16	udata
_MACMemCopyAsync_ReadSave_1_1	res	2

udata_ETH97J60_17	udata
_MACMemCopyAsync_WriteSave_1_1	res	2

udata_ETH97J60_18	udata
_MACGetArray_i_1_1	res	1

udata_ETH97J60_19	udata
_ReadPHYReg_Result_1_1	res	2

udata_ETH97J60_20	udata
_WritePHYReg_Data_1_1	res	2

udata_ETH97J60_21	udata
_MACPrintHeader_header_1_1	res	64

;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
; I code from now on!
; ; Starting pCode block
S_ETH97J60__MACPrintHeader	code
_MACPrintHeader:
;	.line	1452; TCPIP_Stack/ETH97J60.c	void MACPrintHeader(BYTE woffset)
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
;	.line	1458; TCPIP_Stack/ETH97J60.c	ERDPTL = LOW(TXSTART + 1) ;
	MOVLW	0x0b
	MOVWF	_ERDPTL
;	.line	1459; TCPIP_Stack/ETH97J60.c	ERDPTH = HIGH(TXSTART + 1) ;
	MOVLW	0x1a
	MOVWF	_ERDPTH
;	.line	1462; TCPIP_Stack/ETH97J60.c	MACGetArray((BYTE*)&header[0], sizeof(header));
	MOVLW	HIGH(_MACPrintHeader_header_1_1)
	MOVWF	r0x02
	MOVLW	LOW(_MACPrintHeader_header_1_1)
	MOVWF	r0x01
	MOVLW	0x80
	MOVWF	r0x03
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x40
	MOVWF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	CALL	_MACGetArray
	MOVLW	0x05
	ADDWF	FSR1L, F
; ;multiply lit val:0x02 by variable r0x00 and store in r0x00
; ;Unrolled 8 X 8 multiplication
; ;FIXME: the function does not support result==WREG
;	.line	1464; TCPIP_Stack/ETH97J60.c	for(i=0; i<16; i++)
	BCF	STATUS, 0
	RLCF	r0x00, F
	CLRF	r0x01
	CLRF	r0x02
	CLRF	r0x03
_00492_DS_:
	MOVLW	0x10
	SUBWF	r0x01, W
	BTFSC	STATUS, 0
	BRA	_00495_DS_
;	.line	1466; TCPIP_Stack/ETH97J60.c	c = (header[i+2*woffset]>>4)&0x0F;
	MOVF	r0x00, W
	ADDWF	r0x01, W
	MOVWF	r0x04
	CLRF	r0x05
	MOVLW	LOW(_MACPrintHeader_header_1_1)
	ADDWF	r0x04, F
	MOVLW	HIGH(_MACPrintHeader_header_1_1)
	ADDWFC	r0x05, F
	MOVFF	r0x04, FSR0L
	MOVFF	r0x05, FSR0H
	MOVFF	INDF0, r0x04
	SWAPF	r0x04, W
	ANDLW	0x0f
	MOVWF	r0x04
	MOVLW	0x0f
	ANDWF	r0x04, F
;	.line	1467; TCPIP_Stack/ETH97J60.c	LCDText[2*i] = c + (c < 0x0A ? '0' : 'A');
	MOVLW	LOW(_LCDText)
	ADDWF	r0x02, W
	MOVWF	r0x05
	CLRF	r0x06
	MOVLW	HIGH(_LCDText)
	ADDWFC	r0x06, F
	MOVLW	0x0a
	SUBWF	r0x04, W
	BC	_00498_DS_
	MOVLW	0x30
	MOVWF	r0x07
	BRA	_00499_DS_
_00498_DS_:
	MOVLW	0x41
	MOVWF	r0x07
_00499_DS_:
	MOVF	r0x04, W
	ADDWF	r0x07, F
	MOVFF	r0x05, FSR0L
	MOVFF	r0x06, FSR0H
	MOVFF	r0x07, INDF0
;	.line	1468; TCPIP_Stack/ETH97J60.c	c = header[i+2*woffset]&0x0F;
	MOVF	r0x00, W
	ADDWF	r0x01, W
	MOVWF	r0x05
	CLRF	r0x06
	MOVLW	LOW(_MACPrintHeader_header_1_1)
	ADDWF	r0x05, F
	MOVLW	HIGH(_MACPrintHeader_header_1_1)
	ADDWFC	r0x06, F
	MOVFF	r0x05, FSR0L
	MOVFF	r0x06, FSR0H
	MOVFF	INDF0, r0x05
	MOVLW	0x0f
	ANDWF	r0x05, W
	MOVWF	r0x04
;	.line	1469; TCPIP_Stack/ETH97J60.c	LCDText[2*i+1] = c + (c < 0x0A ? '0' : 'A');
	INCF	r0x03, W
	MOVWF	r0x05
	CLRF	r0x06
	MOVLW	LOW(_LCDText)
	ADDWF	r0x05, F
	MOVLW	HIGH(_LCDText)
	ADDWFC	r0x06, F
	MOVLW	0x0a
	SUBWF	r0x04, W
	BC	_00500_DS_
	MOVLW	0x30
	MOVWF	r0x07
	BRA	_00501_DS_
_00500_DS_:
	MOVLW	0x41
	MOVWF	r0x07
_00501_DS_:
	MOVF	r0x07, W
	ADDWF	r0x04, F
	MOVFF	r0x05, FSR0L
	MOVFF	r0x06, FSR0H
	MOVFF	r0x04, INDF0
;	.line	1464; TCPIP_Stack/ETH97J60.c	for(i=0; i<16; i++)
	INCF	r0x02, F
	INCF	r0x02, F
	INCF	r0x03, F
	INCF	r0x03, F
	INCF	r0x01, F
	BRA	_00492_DS_
_00495_DS_:
	BANKSEL	(_LCDText + 32)
;	.line	1471; TCPIP_Stack/ETH97J60.c	LCDText[32]=0;
	CLRF	(_LCDText + 32), B
;	.line	1473; TCPIP_Stack/ETH97J60.c	LCDUpdate();
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
S_ETH97J60__MACPowerUp	code
_MACPowerUp:
;	.line	1357; TCPIP_Stack/ETH97J60.c	void MACPowerUp(void)
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	BANKSEL	_ECON2bits
;	.line	1360; TCPIP_Stack/ETH97J60.c	ECON2bits.ETHEN = 1;
	BSF	_ECON2bits, 5, B
_00484_DS_:
	BANKSEL	_ESTATbits
;	.line	1363; TCPIP_Stack/ETH97J60.c	while(!ESTATbits.PHYRDY)
	BTFSC	_ESTATbits, 0, B
	BRA	_00487_DS_
;	.line	1366; TCPIP_Stack/ETH97J60.c	ECON1bits.RXEN = 1;
	BSF	_ECON1bits, 2
	BRA	_00484_DS_
_00487_DS_:
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_ETH97J60__MACPowerDown	code
_MACPowerDown:
;	.line	1320; TCPIP_Stack/ETH97J60.c	void MACPowerDown(void)
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
;	.line	1323; TCPIP_Stack/ETH97J60.c	ECON1bits.RXEN = 0;
	BCF	_ECON1bits, 2
_00473_DS_:
	BANKSEL	_ESTATbits
;	.line	1327; TCPIP_Stack/ETH97J60.c	while(ESTATbits.RXBUSY);
	BTFSC	_ESTATbits, 2, B
	BRA	_00473_DS_
_00476_DS_:
;	.line	1330; TCPIP_Stack/ETH97J60.c	while(ECON1bits.TXRTS);
	BTFSC	_ECON1bits, 3
	BRA	_00476_DS_
	BANKSEL	_ECON2bits
;	.line	1333; TCPIP_Stack/ETH97J60.c	ECON2bits.ETHEN = 0;
	BCF	_ECON2bits, 5, B
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_ETH97J60__WritePHYReg	code
_WritePHYReg:
;	.line	1251; TCPIP_Stack/ETH97J60.c	void WritePHYReg(BYTE Register, WORD Data)
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, _MIREGADR
	MOVLW	0x03
	MOVFF	PLUSW2, _WritePHYReg_Data_1_1
	MOVLW	0x04
	MOVFF	PLUSW2, (_WritePHYReg_Data_1_1 + 1)
;	.line	1268; TCPIP_Stack/ETH97J60.c	PRODL = ((WORD_VAL*)&Data)->v[0];
	MOVFF	_WritePHYReg_Data_1_1, _PRODL
;	.line	1269; TCPIP_Stack/ETH97J60.c	PRODH = ((WORD_VAL*)&Data)->v[1];
	MOVFF	(_WritePHYReg_Data_1_1 + 1), _PRODH
;	.line	1270; TCPIP_Stack/ETH97J60.c	GIESave = INTCON & 0xC0;	 // Save GIEH and GIEL bits
	MOVLW	0xc0
	ANDWF	_INTCON, W
	MOVWF	r0x00
;	.line	1271; TCPIP_Stack/ETH97J60.c	INTCON &= 0x3F;		 // Clear INTCONbits.GIEH and INTCONbits.GIEL
	MOVLW	0x3f
	ANDWF	_INTCON, F
	movff _PRODL, _MIWRL
	nop
	movff _PRODH, _MIWRH
	
;	.line	1289; TCPIP_Stack/ETH97J60.c	INTCON |= GIESave;		       // Restore GIEH and GIEL value
	MOVF	r0x00, W
	IORWF	_INTCON, F
_00465_DS_:
	BANKSEL	_MISTATbits
;	.line	1293; TCPIP_Stack/ETH97J60.c	while(MISTATbits.BUSY);
	BTFSC	_MISTATbits, 0, B
	BRA	_00465_DS_
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_ETH97J60__ReadPHYReg	code
_ReadPHYReg:
;	.line	1208; TCPIP_Stack/ETH97J60.c	WORD ReadPHYReg(BYTE Register)
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVLW	0x02
	MOVFF	PLUSW2, _MIREGADR
	nop 
;	.line	1215; TCPIP_Stack/ETH97J60.c	MICMD = MICMD_MIIRD; Nop();
	MOVLW	0x01
	BANKSEL	_MICMD
	MOVWF	_MICMD, B
	nop 
_00451_DS_:
	BANKSEL	_MISTATbits
;	.line	1219; TCPIP_Stack/ETH97J60.c	while(MISTATbits.BUSY);
	BTFSC	_MISTATbits, 0, B
	BRA	_00451_DS_
	BANKSEL	_MICMD
;	.line	1222; TCPIP_Stack/ETH97J60.c	MICMD = 0x00; Nop();
	CLRF	_MICMD, B
	nop 
	BANKSEL	_MIRDL
;	.line	1225; TCPIP_Stack/ETH97J60.c	Result.VAL.v[0] = MIRDL;
	MOVF	_MIRDL, W, B
	BANKSEL	_ReadPHYReg_Result_1_1
	MOVWF	_ReadPHYReg_Result_1_1, B
	nop 
	BANKSEL	_MIRDH
;	.line	1227; TCPIP_Stack/ETH97J60.c	Result.VAL.v[1] = MIRDH;
	MOVF	_MIRDH, W, B
	BANKSEL	(_ReadPHYReg_Result_1_1 + 1)
	MOVWF	(_ReadPHYReg_Result_1_1 + 1), B
;	.line	1229; TCPIP_Stack/ETH97J60.c	return Result2;
	MOVFF	(_ReadPHYReg_Result_1_1 + 1), PRODL
	BANKSEL	_ReadPHYReg_Result_1_1
	MOVF	_ReadPHYReg_Result_1_1, W, B
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_ETH97J60__MACPutArray	code
_MACPutArray:
;	.line	1149; TCPIP_Stack/ETH97J60.c	void MACPutArray(BYTE *val, WORD len)
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
_00437_DS_:
;	.line	1151; TCPIP_Stack/ETH97J60.c	while(len--)
	MOVFF	r0x03, r0x05
	MOVFF	r0x04, r0x06
	MOVLW	0xff
	ADDWF	r0x03, F
	BTFSS	STATUS, 0
	DECF	r0x04, F
	MOVF	r0x05, W
	IORWF	r0x06, W
	BZ	_00440_DS_
;	.line	1167; TCPIP_Stack/ETH97J60.c	EDATA = *val++; 
	MOVFF	r0x00, FSR0L
	MOVFF	r0x01, PRODL
	MOVF	r0x02, W
	CALL	__gptrget1
	MOVWF	_EDATA
	INCF	r0x00, F
	BTFSC	STATUS, 0
	INCF	r0x01, F
	BTFSC	STATUS, 0
	INCF	r0x02, F
	BRA	_00437_DS_
_00440_DS_:
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
S_ETH97J60__MACPut	code
_MACPut:
;	.line	1104; TCPIP_Stack/ETH97J60.c	void MACPut(BYTE val)
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVLW	0x02
	MOVFF	PLUSW2, _EDATA
;	.line	1121; TCPIP_Stack/ETH97J60.c	EDATA = val;
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_ETH97J60__MACGetArray	code
_MACGetArray:
;	.line	1062; TCPIP_Stack/ETH97J60.c	WORD MACGetArray(BYTE *val, WORD len)
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
;	.line	1068; TCPIP_Stack/ETH97J60.c	if(val)
	MOVF	r0x00, W
	IORWF	r0x01, W
	IORWF	r0x02, W
	BZ	_00427_DS_
;	.line	1070; TCPIP_Stack/ETH97J60.c	while(w--)
	MOVFF	r0x03, r0x05
	MOVFF	r0x04, r0x06
_00413_DS_:
	MOVFF	r0x05, r0x07
	MOVFF	r0x06, r0x08
	MOVLW	0xff
	ADDWF	r0x05, F
	BTFSS	STATUS, 0
	DECF	r0x06, F
	MOVF	r0x07, W
	IORWF	r0x08, W
	BZ	_00421_DS_
;	.line	1072; TCPIP_Stack/ETH97J60.c	*val++ = EDATA;
	MOVFF	_EDATA, POSTDEC1
	MOVFF	r0x00, FSR0L
	MOVFF	r0x01, PRODL
	MOVF	r0x02, W
	CALL	__gptrput1
	INCF	r0x00, F
	BTFSC	STATUS, 0
	INCF	r0x01, F
	BTFSC	STATUS, 0
	INCF	r0x02, F
	BRA	_00413_DS_
_00427_DS_:
;	.line	1077; TCPIP_Stack/ETH97J60.c	while(w--)
	MOVFF	r0x03, r0x00
	MOVFF	r0x04, r0x01
_00416_DS_:
	MOVFF	r0x00, r0x02
	MOVFF	r0x01, r0x05
	MOVLW	0xff
	ADDWF	r0x00, F
	BTFSS	STATUS, 0
	DECF	r0x01, F
	MOVF	r0x02, W
	IORWF	r0x05, W
	BZ	_00421_DS_
;	.line	1079; TCPIP_Stack/ETH97J60.c	i = EDATA;
	MOVFF	_EDATA, _MACGetArray_i_1_1
	BRA	_00416_DS_
_00421_DS_:
;	.line	1083; TCPIP_Stack/ETH97J60.c	return len;
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
S_ETH97J60__MACGet	code
_MACGet:
;	.line	1037; TCPIP_Stack/ETH97J60.c	BYTE MACGet()
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
;	.line	1039; TCPIP_Stack/ETH97J60.c	return EDATA;
	MOVF	_EDATA, W
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_ETH97J60__MACIsMemCopyDone	code
_MACIsMemCopyDone:
;	.line	1014; TCPIP_Stack/ETH97J60.c	BOOL MACIsMemCopyDone(void)
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
;	.line	1016; TCPIP_Stack/ETH97J60.c	return !ECON1bits.DMAST;
	CLRF	r0x00
	BTFSC	_ECON1bits, 5
	INCF	r0x00, F
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
S_ETH97J60__MACMemCopyAsync	code
_MACMemCopyAsync:
;	.line	899; TCPIP_Stack/ETH97J60.c	void MACMemCopyAsync(WORD destAddr, WORD sourceAddr, WORD len)
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
	MOVFF	PLUSW2, _MACMemCopyAsync_destAddr_1_1
	MOVLW	0x03
	MOVFF	PLUSW2, (_MACMemCopyAsync_destAddr_1_1 + 1)
	MOVLW	0x04
	MOVFF	PLUSW2, _MACMemCopyAsync_sourceAddr_1_1
	MOVLW	0x05
	MOVFF	PLUSW2, (_MACMemCopyAsync_sourceAddr_1_1 + 1)
	MOVLW	0x06
	MOVFF	PLUSW2, r0x00
	MOVLW	0x07
	MOVFF	PLUSW2, r0x01
;	.line	902; TCPIP_Stack/ETH97J60.c	BOOL UpdateWritePointer = FALSE;
	CLRF	r0x02
;	.line	903; TCPIP_Stack/ETH97J60.c	BOOL UpdateReadPointer = FALSE;
	CLRF	r0x03
	BANKSEL	(_MACMemCopyAsync_destAddr_1_1 + 1)
;	.line	905; TCPIP_Stack/ETH97J60.c	if(((WORD_VAL*)&destAddr)->bits.b15)
	BTFSS	(_MACMemCopyAsync_destAddr_1_1 + 1), 7, B
	BRA	_00325_DS_
;	.line	907; TCPIP_Stack/ETH97J60.c	UpdateWritePointer = TRUE;
	MOVLW	0x01
	MOVWF	r0x02
;	.line	908; TCPIP_Stack/ETH97J60.c	destAddr = ((WORD)EWRPTH)<<8|EWRPTL;
	MOVFF	_EWRPTH, r0x04
	CLRF	r0x05
	MOVF	r0x04, W
	MOVWF	r0x07
	CLRF	r0x06
	MOVFF	_EWRPTL, r0x04
	CLRF	r0x05
	MOVF	r0x04, W
	IORWF	r0x06, W
	BANKSEL	_MACMemCopyAsync_destAddr_1_1
	MOVWF	_MACMemCopyAsync_destAddr_1_1, B
	MOVF	r0x05, W
	IORWF	r0x07, W
	BANKSEL	(_MACMemCopyAsync_destAddr_1_1 + 1)
	MOVWF	(_MACMemCopyAsync_destAddr_1_1 + 1), B
_00325_DS_:
	BANKSEL	(_MACMemCopyAsync_sourceAddr_1_1 + 1)
;	.line	910; TCPIP_Stack/ETH97J60.c	if(((WORD_VAL*)&sourceAddr)->bits.b15)
	BTFSS	(_MACMemCopyAsync_sourceAddr_1_1 + 1), 7, B
	BRA	_00327_DS_
;	.line	912; TCPIP_Stack/ETH97J60.c	UpdateReadPointer = TRUE;
	MOVLW	0x01
	MOVWF	r0x03
;	.line	913; TCPIP_Stack/ETH97J60.c	sourceAddr = ((WORD)ERDPTH)<<8|ERDPTL;
	MOVFF	_ERDPTH, r0x04
	CLRF	r0x05
	MOVF	r0x04, W
	MOVWF	r0x07
	CLRF	r0x06
	MOVFF	_ERDPTL, r0x04
	CLRF	r0x05
	MOVF	r0x04, W
	IORWF	r0x06, W
	BANKSEL	_MACMemCopyAsync_sourceAddr_1_1
	MOVWF	_MACMemCopyAsync_sourceAddr_1_1, B
	MOVF	r0x05, W
	IORWF	r0x07, W
	BANKSEL	(_MACMemCopyAsync_sourceAddr_1_1 + 1)
	MOVWF	(_MACMemCopyAsync_sourceAddr_1_1 + 1), B
_00327_DS_:
;	.line	918; TCPIP_Stack/ETH97J60.c	if(len <= 1u)
	MOVLW	0x00
	SUBWF	r0x01, W
	BNZ	_00376_DS_
	MOVLW	0x02
	SUBWF	r0x00, W
_00376_DS_:
	BTFSC	STATUS, 0
	BRA	_00352_DS_
;	.line	920; TCPIP_Stack/ETH97J60.c	ReadSave.Val = ((WORD)ERDPTH)<<8|ERDPTL;
	MOVFF	_ERDPTH, r0x04
	CLRF	r0x05
	MOVF	r0x04, W
	MOVWF	r0x07
	CLRF	r0x06
	MOVFF	_ERDPTL, r0x04
	CLRF	r0x05
	MOVF	r0x04, W
	IORWF	r0x06, F
	MOVF	r0x05, W
	IORWF	r0x07, F
	MOVF	r0x06, W
	BANKSEL	_MACMemCopyAsync_ReadSave_1_1
	MOVWF	_MACMemCopyAsync_ReadSave_1_1, B
	MOVF	r0x07, W
	BANKSEL	(_MACMemCopyAsync_ReadSave_1_1 + 1)
	MOVWF	(_MACMemCopyAsync_ReadSave_1_1 + 1), B
;	.line	921; TCPIP_Stack/ETH97J60.c	WriteSave.Val =  ((WORD)EWRPTH)<<8|EWRPTL;
	MOVFF	_EWRPTH, r0x04
	CLRF	r0x05
	MOVF	r0x04, W
	MOVWF	r0x07
	CLRF	r0x06
	MOVFF	_EWRPTL, r0x04
	CLRF	r0x05
	MOVF	r0x04, W
	IORWF	r0x06, F
	MOVF	r0x05, W
	IORWF	r0x07, F
	MOVF	r0x06, W
	BANKSEL	_MACMemCopyAsync_WriteSave_1_1
	MOVWF	_MACMemCopyAsync_WriteSave_1_1, B
	MOVF	r0x07, W
	BANKSEL	(_MACMemCopyAsync_WriteSave_1_1 + 1)
	MOVWF	(_MACMemCopyAsync_WriteSave_1_1 + 1), B
	BANKSEL	_MACMemCopyAsync_sourceAddr_1_1
;	.line	922; TCPIP_Stack/ETH97J60.c	ERDPTL = LOW(sourceAddr);
	MOVF	_MACMemCopyAsync_sourceAddr_1_1, W, B
	MOVWF	r0x04
	CLRF	r0x05
	MOVF	r0x04, W
	MOVWF	_ERDPTL
	BANKSEL	(_MACMemCopyAsync_sourceAddr_1_1 + 1)
;	.line	923; TCPIP_Stack/ETH97J60.c	ERDPTH = HIGH(sourceAddr);
	MOVF	(_MACMemCopyAsync_sourceAddr_1_1 + 1), W, B
	MOVWF	r0x04
	CLRF	r0x05
	CLRF	r0x05
	MOVF	r0x04, W
	MOVWF	_ERDPTH
	BANKSEL	_MACMemCopyAsync_destAddr_1_1
;	.line	924; TCPIP_Stack/ETH97J60.c	EWRPTL = LOW(destAddr);
	MOVF	_MACMemCopyAsync_destAddr_1_1, W, B
	MOVWF	r0x04
	CLRF	r0x05
	MOVF	r0x04, W
	BANKSEL	_EWRPTL
	MOVWF	_EWRPTL, B
	BANKSEL	(_MACMemCopyAsync_destAddr_1_1 + 1)
;	.line	925; TCPIP_Stack/ETH97J60.c	EWRPTH = HIGH(destAddr);
	MOVF	(_MACMemCopyAsync_destAddr_1_1 + 1), W, B
	MOVWF	r0x04
	CLRF	r0x05
	CLRF	r0x05
	MOVF	r0x04, W
	BANKSEL	_EWRPTH
	MOVWF	_EWRPTH, B
;	.line	926; TCPIP_Stack/ETH97J60.c	while(len--) MACPut(MACGet());
	MOVFF	r0x00, r0x04
	MOVFF	r0x01, r0x05
_00328_DS_:
	MOVFF	r0x04, r0x06
	MOVFF	r0x05, r0x07
	MOVLW	0xff
	ADDWF	r0x04, F
	BTFSS	STATUS, 0
	DECF	r0x05, F
	MOVF	r0x06, W
	IORWF	r0x07, W
	BZ	_00330_DS_
	CALL	_MACGet
	MOVWF	r0x06
	MOVF	r0x06, W
	MOVWF	POSTDEC1
	CALL	_MACPut
	INCF	FSR1L, F
	BRA	_00328_DS_
_00330_DS_:
;	.line	927; TCPIP_Stack/ETH97J60.c	if(!UpdateReadPointer)
	MOVF	r0x03, W
	BNZ	_00332_DS_
	BANKSEL	_MACMemCopyAsync_ReadSave_1_1
;	.line	929; TCPIP_Stack/ETH97J60.c	ERDPTL = LOW(ReadSave.Val);
	MOVF	_MACMemCopyAsync_ReadSave_1_1, W, B
	MOVWF	r0x04
	CLRF	r0x05
	MOVF	r0x04, W
	MOVWF	_ERDPTL
	BANKSEL	(_MACMemCopyAsync_ReadSave_1_1 + 1)
;	.line	930; TCPIP_Stack/ETH97J60.c	ERDPTH = HIGH(ReadSave.Val);
	MOVF	(_MACMemCopyAsync_ReadSave_1_1 + 1), W, B
	MOVWF	r0x04
	CLRF	r0x05
	CLRF	r0x05
	MOVF	r0x04, W
	MOVWF	_ERDPTH
_00332_DS_:
;	.line	932; TCPIP_Stack/ETH97J60.c	if(!UpdateWritePointer)
	MOVF	r0x02, W
	BTFSS	STATUS, 2
	BRA	_00354_DS_
	BANKSEL	_MACMemCopyAsync_WriteSave_1_1
;	.line	934; TCPIP_Stack/ETH97J60.c	EWRPTL = LOW(WriteSave.Val);
	MOVF	_MACMemCopyAsync_WriteSave_1_1, W, B
	MOVWF	r0x04
	CLRF	r0x05
	MOVF	r0x04, W
	BANKSEL	_EWRPTL
	MOVWF	_EWRPTL, B
	BANKSEL	(_MACMemCopyAsync_WriteSave_1_1 + 1)
;	.line	935; TCPIP_Stack/ETH97J60.c	EWRPTH = HIGH(WriteSave.Val);
	MOVF	(_MACMemCopyAsync_WriteSave_1_1 + 1), W, B
	MOVWF	r0x04
	CLRF	r0x05
	CLRF	r0x05
	MOVF	r0x04, W
	BANKSEL	_EWRPTH
	MOVWF	_EWRPTH, B
	BRA	_00354_DS_
_00352_DS_:
;	.line	940; TCPIP_Stack/ETH97J60.c	if(UpdateWritePointer)
	MOVF	r0x02, W
	BZ	_00336_DS_
;	.line	942; TCPIP_Stack/ETH97J60.c	WriteSave.Val = destAddr + len;
	MOVF	r0x00, W
	BANKSEL	_MACMemCopyAsync_destAddr_1_1
	ADDWF	_MACMemCopyAsync_destAddr_1_1, W, B
	MOVWF	r0x02
	MOVF	r0x01, W
	BANKSEL	(_MACMemCopyAsync_destAddr_1_1 + 1)
	ADDWFC	(_MACMemCopyAsync_destAddr_1_1 + 1), W, B
	MOVWF	r0x04
	MOVF	r0x02, W
	BANKSEL	_MACMemCopyAsync_WriteSave_1_1
	MOVWF	_MACMemCopyAsync_WriteSave_1_1, B
	MOVF	r0x04, W
	BANKSEL	(_MACMemCopyAsync_WriteSave_1_1 + 1)
	MOVWF	(_MACMemCopyAsync_WriteSave_1_1 + 1), B
;	.line	943; TCPIP_Stack/ETH97J60.c	EWRPTL = LOW(WriteSave.Val);
	MOVFF	_MACMemCopyAsync_WriteSave_1_1, WREG
	MOVFF	(_MACMemCopyAsync_WriteSave_1_1 + 1), WREG
	MOVF	r0x02, W
	MOVWF	r0x05
	CLRF	r0x06
	MOVF	r0x05, W
	BANKSEL	_EWRPTL
	MOVWF	_EWRPTL, B
;	.line	944; TCPIP_Stack/ETH97J60.c	EWRPTH = HIGH(WriteSave.Val);
	MOVFF	_MACMemCopyAsync_WriteSave_1_1, WREG
	MOVFF	(_MACMemCopyAsync_WriteSave_1_1 + 1), WREG
	MOVF	r0x04, W
	MOVWF	r0x02
	CLRF	r0x04
	CLRF	r0x04
	MOVF	r0x02, W
	BANKSEL	_EWRPTH
	MOVWF	_EWRPTH, B
_00336_DS_:
	BANKSEL	_MACMemCopyAsync_sourceAddr_1_1
;	.line	946; TCPIP_Stack/ETH97J60.c	len += sourceAddr - 1;
	MOVF	_MACMemCopyAsync_sourceAddr_1_1, W, B
	ADDLW	0xff
	MOVWF	r0x02
	MOVLW	0xff
	BANKSEL	(_MACMemCopyAsync_sourceAddr_1_1 + 1)
	ADDWFC	(_MACMemCopyAsync_sourceAddr_1_1 + 1), W, B
	MOVWF	r0x04
	MOVF	r0x02, W
	ADDWF	r0x00, F
	MOVF	r0x04, W
	ADDWFC	r0x01, F
_00337_DS_:
;	.line	947; TCPIP_Stack/ETH97J60.c	while(ECON1bits.DMAST);
	BTFSC	_ECON1bits, 5
	BRA	_00337_DS_
	BANKSEL	_MACMemCopyAsync_sourceAddr_1_1
;	.line	948; TCPIP_Stack/ETH97J60.c	EDMASTL = LOW(sourceAddr);
	MOVF	_MACMemCopyAsync_sourceAddr_1_1, W, B
	MOVWF	r0x02
	CLRF	r0x04
	MOVF	r0x02, W
	BANKSEL	_EDMASTL
	MOVWF	_EDMASTL, B
	BANKSEL	(_MACMemCopyAsync_sourceAddr_1_1 + 1)
;	.line	949; TCPIP_Stack/ETH97J60.c	EDMASTH = HIGH(sourceAddr);
	MOVF	(_MACMemCopyAsync_sourceAddr_1_1 + 1), W, B
	MOVWF	r0x02
	CLRF	r0x04
	CLRF	r0x04
	MOVF	r0x02, W
	BANKSEL	_EDMASTH
	MOVWF	_EDMASTH, B
	BANKSEL	_MACMemCopyAsync_destAddr_1_1
;	.line	950; TCPIP_Stack/ETH97J60.c	EDMADSTL = LOW(destAddr);
	MOVF	_MACMemCopyAsync_destAddr_1_1, W, B
	MOVWF	r0x02
	CLRF	r0x04
	MOVF	r0x02, W
	BANKSEL	_EDMADSTL
	MOVWF	_EDMADSTL, B
	BANKSEL	(_MACMemCopyAsync_destAddr_1_1 + 1)
;	.line	951; TCPIP_Stack/ETH97J60.c	EDMADSTH = HIGH(destAddr);
	MOVF	(_MACMemCopyAsync_destAddr_1_1 + 1), W, B
	MOVWF	r0x02
	CLRF	r0x04
	CLRF	r0x04
	MOVF	r0x02, W
	BANKSEL	_EDMADSTH
	MOVWF	_EDMADSTH, B
;	.line	952; TCPIP_Stack/ETH97J60.c	if((sourceAddr <= RXSTOP) && (len > RXSTOP))
	MOVFF	_MACMemCopyAsync_sourceAddr_1_1, r0x02
	MOVFF	(_MACMemCopyAsync_sourceAddr_1_1 + 1), r0x04
	CLRF	r0x05
	CLRF	r0x06
	MOVLW	0x00
	SUBWF	r0x06, W
	BNZ	_00394_DS_
	MOVLW	0x00
	SUBWF	r0x05, W
	BNZ	_00394_DS_
	MOVLW	0x1a
	SUBWF	r0x04, W
	BNZ	_00394_DS_
	MOVLW	0x0a
	SUBWF	r0x02, W
_00394_DS_:
	CLRF	r0x02
	RLCF	r0x02, F
	MOVF	r0x02, W
	BNZ	_00341_DS_
	MOVFF	r0x00, r0x04
	MOVFF	r0x01, r0x05
	CLRF	r0x06
	CLRF	r0x07
	MOVLW	0x00
	SUBWF	r0x07, W
	BNZ	_00395_DS_
	MOVLW	0x00
	SUBWF	r0x06, W
	BNZ	_00395_DS_
	MOVLW	0x1a
	SUBWF	r0x05, W
	BNZ	_00395_DS_
	MOVLW	0x0a
	SUBWF	r0x04, W
_00395_DS_:
	BNC	_00341_DS_
;	.line	953; TCPIP_Stack/ETH97J60.c	len -= RXSIZE; //it is a circular buffer
	MOVLW	0xf6
	ADDWF	r0x04, F
	MOVLW	0xe5
	ADDWFC	r0x05, F
	MOVLW	0xff
	ADDWFC	r0x06, F
	MOVLW	0xff
	ADDWFC	r0x07, F
	MOVF	r0x04, W
	MOVWF	r0x00
	MOVF	r0x05, W
	MOVWF	r0x01
_00341_DS_:
;	.line	954; TCPIP_Stack/ETH97J60.c	EDMANDL = LOW(len);
	MOVF	r0x00, W
	MOVWF	r0x04
	CLRF	r0x05
	MOVF	r0x04, W
	BANKSEL	_EDMANDL
	MOVWF	_EDMANDL, B
;	.line	955; TCPIP_Stack/ETH97J60.c	EDMANDH = HIGH(len);
	MOVF	r0x01, W
	MOVWF	r0x04
	CLRF	r0x05
	CLRF	r0x05
	MOVF	r0x04, W
	BANKSEL	_EDMANDH
	MOVWF	_EDMANDH, B
;	.line	956; TCPIP_Stack/ETH97J60.c	ECON1bits.CSUMEN = 0;
	BCF	_ECON1bits, 4
;	.line	957; TCPIP_Stack/ETH97J60.c	ECON1bits.DMAST = 1;
	BSF	_ECON1bits, 5
_00343_DS_:
;	.line	958; TCPIP_Stack/ETH97J60.c	while(ECON1bits.DMAST);	// DMA requires that you must not 
	BTFSC	_ECON1bits, 5
	BRA	_00343_DS_
;	.line	961; TCPIP_Stack/ETH97J60.c	if(UpdateReadPointer)
	MOVF	r0x03, W
	BZ	_00354_DS_
;	.line	963; TCPIP_Stack/ETH97J60.c	len++;
	INCF	r0x00, F
	BTFSC	STATUS, 0
	INCF	r0x01, F
;	.line	964; TCPIP_Stack/ETH97J60.c	if((sourceAddr <= RXSTOP) && (len > RXSTOP))
	MOVF	r0x02, W
	BNZ	_00347_DS_
	MOVFF	r0x00, r0x02
	MOVFF	r0x01, r0x03
	CLRF	r0x04
	CLRF	r0x05
	MOVLW	0x00
	SUBWF	r0x05, W
	BNZ	_00398_DS_
	MOVLW	0x00
	SUBWF	r0x04, W
	BNZ	_00398_DS_
	MOVLW	0x1a
	SUBWF	r0x03, W
	BNZ	_00398_DS_
	MOVLW	0x0a
	SUBWF	r0x02, W
_00398_DS_:
	BNC	_00347_DS_
;	.line	965; TCPIP_Stack/ETH97J60.c	len -= RXSIZE;
	MOVLW	0xf6
	ADDWF	r0x02, F
	MOVLW	0xe5
	ADDWFC	r0x03, F
	MOVLW	0xff
	ADDWFC	r0x04, F
	MOVLW	0xff
	ADDWFC	r0x05, F
	MOVF	r0x02, W
	MOVWF	r0x00
	MOVF	r0x03, W
	MOVWF	r0x01
_00347_DS_:
;	.line	966; TCPIP_Stack/ETH97J60.c	ERDPTL = LOW(len);
	MOVF	r0x00, W
	MOVWF	r0x02
	CLRF	r0x03
	MOVF	r0x02, W
	MOVWF	_ERDPTL
;	.line	967; TCPIP_Stack/ETH97J60.c	ERDPTH = HIGH(len);
	MOVF	r0x01, W
	MOVWF	r0x00
	CLRF	r0x01
	CLRF	r0x01
	MOVF	r0x00, W
	MOVWF	_ERDPTH
_00354_DS_:
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
S_ETH97J60__CalcIPBufferChecksum	code
_CalcIPBufferChecksum:
;	.line	824; TCPIP_Stack/ETH97J60.c	WORD CalcIPBufferChecksum(WORD len)
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
	MOVLW	0x02
	MOVFF	PLUSW2, r0x00
	MOVLW	0x03
	MOVFF	PLUSW2, r0x01
	BANKSEL	_CalcIPBufferChecksum_Checksum_1_1
;	.line	827; TCPIP_Stack/ETH97J60.c	DWORD_VAL Checksum = {0x00000000ul};
	CLRF	_CalcIPBufferChecksum_Checksum_1_1, B
	BANKSEL	(_CalcIPBufferChecksum_Checksum_1_1 + 1)
	CLRF	(_CalcIPBufferChecksum_Checksum_1_1 + 1), B
	BANKSEL	(_CalcIPBufferChecksum_Checksum_1_1 + 2)
	CLRF	(_CalcIPBufferChecksum_Checksum_1_1 + 2), B
	BANKSEL	(_CalcIPBufferChecksum_Checksum_1_1 + 3)
	CLRF	(_CalcIPBufferChecksum_Checksum_1_1 + 3), B
	BANKSEL	_CalcIPBufferChecksum_Checksum_1_1
	CLRF	_CalcIPBufferChecksum_Checksum_1_1, B
	BANKSEL	(_CalcIPBufferChecksum_Checksum_1_1 + 1)
	CLRF	(_CalcIPBufferChecksum_Checksum_1_1 + 1), B
	BANKSEL	(_CalcIPBufferChecksum_Checksum_1_1 + 2)
	CLRF	(_CalcIPBufferChecksum_Checksum_1_1 + 2), B
	BANKSEL	(_CalcIPBufferChecksum_Checksum_1_1 + 3)
	CLRF	(_CalcIPBufferChecksum_Checksum_1_1 + 3), B
	BANKSEL	_CalcIPBufferChecksum_Checksum_1_1
	CLRF	_CalcIPBufferChecksum_Checksum_1_1, B
	BANKSEL	(_CalcIPBufferChecksum_Checksum_1_1 + 1)
	CLRF	(_CalcIPBufferChecksum_Checksum_1_1 + 1), B
	BANKSEL	(_CalcIPBufferChecksum_Checksum_1_1 + 2)
	CLRF	(_CalcIPBufferChecksum_Checksum_1_1 + 2), B
	BANKSEL	(_CalcIPBufferChecksum_Checksum_1_1 + 3)
	CLRF	(_CalcIPBufferChecksum_Checksum_1_1 + 3), B
	BANKSEL	_CalcIPBufferChecksum_Checksum_1_1
	CLRF	_CalcIPBufferChecksum_Checksum_1_1, B
	BANKSEL	(_CalcIPBufferChecksum_Checksum_1_1 + 1)
	CLRF	(_CalcIPBufferChecksum_Checksum_1_1 + 1), B
	BANKSEL	(_CalcIPBufferChecksum_Checksum_1_1 + 2)
	CLRF	(_CalcIPBufferChecksum_Checksum_1_1 + 2), B
	BANKSEL	(_CalcIPBufferChecksum_Checksum_1_1 + 3)
	CLRF	(_CalcIPBufferChecksum_Checksum_1_1 + 3), B
	BANKSEL	_CalcIPBufferChecksum_Checksum_1_1
	CLRF	_CalcIPBufferChecksum_Checksum_1_1, B
	BANKSEL	(_CalcIPBufferChecksum_Checksum_1_1 + 1)
	CLRF	(_CalcIPBufferChecksum_Checksum_1_1 + 1), B
	BANKSEL	(_CalcIPBufferChecksum_Checksum_1_1 + 2)
	CLRF	(_CalcIPBufferChecksum_Checksum_1_1 + 2), B
	BANKSEL	(_CalcIPBufferChecksum_Checksum_1_1 + 3)
	CLRF	(_CalcIPBufferChecksum_Checksum_1_1 + 3), B
	BANKSEL	_CalcIPBufferChecksum_Checksum_1_1
	CLRF	_CalcIPBufferChecksum_Checksum_1_1, B
	BANKSEL	(_CalcIPBufferChecksum_Checksum_1_1 + 1)
	CLRF	(_CalcIPBufferChecksum_Checksum_1_1 + 1), B
	BANKSEL	_CalcIPBufferChecksum_Checksum_1_1
	CLRF	_CalcIPBufferChecksum_Checksum_1_1, B
	BANKSEL	(_CalcIPBufferChecksum_Checksum_1_1 + 1)
	CLRF	(_CalcIPBufferChecksum_Checksum_1_1 + 1), B
	BANKSEL	_CalcIPBufferChecksum_Checksum_1_1
	CLRF	_CalcIPBufferChecksum_Checksum_1_1, B
	BANKSEL	(_CalcIPBufferChecksum_Checksum_1_1 + 1)
	CLRF	(_CalcIPBufferChecksum_Checksum_1_1 + 1), B
	BANKSEL	_CalcIPBufferChecksum_Checksum_1_1
	BCF	_CalcIPBufferChecksum_Checksum_1_1, 0, B
	BANKSEL	_CalcIPBufferChecksum_Checksum_1_1
	BCF	_CalcIPBufferChecksum_Checksum_1_1, 1, B
	BANKSEL	_CalcIPBufferChecksum_Checksum_1_1
	BCF	_CalcIPBufferChecksum_Checksum_1_1, 2, B
	BANKSEL	_CalcIPBufferChecksum_Checksum_1_1
	BCF	_CalcIPBufferChecksum_Checksum_1_1, 3, B
	BANKSEL	_CalcIPBufferChecksum_Checksum_1_1
	BCF	_CalcIPBufferChecksum_Checksum_1_1, 4, B
	BANKSEL	_CalcIPBufferChecksum_Checksum_1_1
	BCF	_CalcIPBufferChecksum_Checksum_1_1, 5, B
	BANKSEL	_CalcIPBufferChecksum_Checksum_1_1
	BCF	_CalcIPBufferChecksum_Checksum_1_1, 6, B
	BANKSEL	_CalcIPBufferChecksum_Checksum_1_1
	BCF	_CalcIPBufferChecksum_Checksum_1_1, 7, B
	BANKSEL	(_CalcIPBufferChecksum_Checksum_1_1 + 1)
	BCF	(_CalcIPBufferChecksum_Checksum_1_1 + 1), 0, B
	BANKSEL	(_CalcIPBufferChecksum_Checksum_1_1 + 1)
	BCF	(_CalcIPBufferChecksum_Checksum_1_1 + 1), 1, B
	BANKSEL	(_CalcIPBufferChecksum_Checksum_1_1 + 1)
	BCF	(_CalcIPBufferChecksum_Checksum_1_1 + 1), 2, B
	BANKSEL	(_CalcIPBufferChecksum_Checksum_1_1 + 1)
	BCF	(_CalcIPBufferChecksum_Checksum_1_1 + 1), 3, B
	BANKSEL	(_CalcIPBufferChecksum_Checksum_1_1 + 1)
	BCF	(_CalcIPBufferChecksum_Checksum_1_1 + 1), 4, B
	BANKSEL	(_CalcIPBufferChecksum_Checksum_1_1 + 1)
	BCF	(_CalcIPBufferChecksum_Checksum_1_1 + 1), 5, B
	BANKSEL	(_CalcIPBufferChecksum_Checksum_1_1 + 1)
	BCF	(_CalcIPBufferChecksum_Checksum_1_1 + 1), 6, B
	BANKSEL	(_CalcIPBufferChecksum_Checksum_1_1 + 1)
	BCF	(_CalcIPBufferChecksum_Checksum_1_1 + 1), 7, B
	BANKSEL	(_CalcIPBufferChecksum_Checksum_1_1 + 2)
	CLRF	(_CalcIPBufferChecksum_Checksum_1_1 + 2), B
	BANKSEL	(_CalcIPBufferChecksum_Checksum_1_1 + 3)
	CLRF	(_CalcIPBufferChecksum_Checksum_1_1 + 3), B
	BANKSEL	(_CalcIPBufferChecksum_Checksum_1_1 + 2)
	CLRF	(_CalcIPBufferChecksum_Checksum_1_1 + 2), B
	BANKSEL	(_CalcIPBufferChecksum_Checksum_1_1 + 3)
	CLRF	(_CalcIPBufferChecksum_Checksum_1_1 + 3), B
	BANKSEL	(_CalcIPBufferChecksum_Checksum_1_1 + 2)
	CLRF	(_CalcIPBufferChecksum_Checksum_1_1 + 2), B
	BANKSEL	(_CalcIPBufferChecksum_Checksum_1_1 + 3)
	CLRF	(_CalcIPBufferChecksum_Checksum_1_1 + 3), B
	BANKSEL	(_CalcIPBufferChecksum_Checksum_1_1 + 2)
	BCF	(_CalcIPBufferChecksum_Checksum_1_1 + 2), 0, B
	BANKSEL	(_CalcIPBufferChecksum_Checksum_1_1 + 2)
	BCF	(_CalcIPBufferChecksum_Checksum_1_1 + 2), 1, B
	BANKSEL	(_CalcIPBufferChecksum_Checksum_1_1 + 2)
	BCF	(_CalcIPBufferChecksum_Checksum_1_1 + 2), 2, B
	BANKSEL	(_CalcIPBufferChecksum_Checksum_1_1 + 2)
	BCF	(_CalcIPBufferChecksum_Checksum_1_1 + 2), 3, B
	BANKSEL	(_CalcIPBufferChecksum_Checksum_1_1 + 2)
	BCF	(_CalcIPBufferChecksum_Checksum_1_1 + 2), 4, B
	BANKSEL	(_CalcIPBufferChecksum_Checksum_1_1 + 2)
	BCF	(_CalcIPBufferChecksum_Checksum_1_1 + 2), 5, B
	BANKSEL	(_CalcIPBufferChecksum_Checksum_1_1 + 2)
	BCF	(_CalcIPBufferChecksum_Checksum_1_1 + 2), 6, B
	BANKSEL	(_CalcIPBufferChecksum_Checksum_1_1 + 2)
	BCF	(_CalcIPBufferChecksum_Checksum_1_1 + 2), 7, B
	BANKSEL	(_CalcIPBufferChecksum_Checksum_1_1 + 3)
	BCF	(_CalcIPBufferChecksum_Checksum_1_1 + 3), 0, B
	BANKSEL	(_CalcIPBufferChecksum_Checksum_1_1 + 3)
	BCF	(_CalcIPBufferChecksum_Checksum_1_1 + 3), 1, B
	BANKSEL	(_CalcIPBufferChecksum_Checksum_1_1 + 3)
	BCF	(_CalcIPBufferChecksum_Checksum_1_1 + 3), 2, B
	BANKSEL	(_CalcIPBufferChecksum_Checksum_1_1 + 3)
	BCF	(_CalcIPBufferChecksum_Checksum_1_1 + 3), 3, B
	BANKSEL	(_CalcIPBufferChecksum_Checksum_1_1 + 3)
	BCF	(_CalcIPBufferChecksum_Checksum_1_1 + 3), 4, B
	BANKSEL	(_CalcIPBufferChecksum_Checksum_1_1 + 3)
	BCF	(_CalcIPBufferChecksum_Checksum_1_1 + 3), 5, B
	BANKSEL	(_CalcIPBufferChecksum_Checksum_1_1 + 3)
	BCF	(_CalcIPBufferChecksum_Checksum_1_1 + 3), 6, B
	BANKSEL	(_CalcIPBufferChecksum_Checksum_1_1 + 3)
	BCF	(_CalcIPBufferChecksum_Checksum_1_1 + 3), 7, B
	BANKSEL	_CalcIPBufferChecksum_Checksum_1_1
	BCF	_CalcIPBufferChecksum_Checksum_1_1, 0, B
	BANKSEL	_CalcIPBufferChecksum_Checksum_1_1
	BCF	_CalcIPBufferChecksum_Checksum_1_1, 1, B
	BANKSEL	_CalcIPBufferChecksum_Checksum_1_1
	BCF	_CalcIPBufferChecksum_Checksum_1_1, 2, B
	BANKSEL	_CalcIPBufferChecksum_Checksum_1_1
	BCF	_CalcIPBufferChecksum_Checksum_1_1, 3, B
	BANKSEL	_CalcIPBufferChecksum_Checksum_1_1
	BCF	_CalcIPBufferChecksum_Checksum_1_1, 4, B
	BANKSEL	_CalcIPBufferChecksum_Checksum_1_1
	BCF	_CalcIPBufferChecksum_Checksum_1_1, 5, B
	BANKSEL	_CalcIPBufferChecksum_Checksum_1_1
	BCF	_CalcIPBufferChecksum_Checksum_1_1, 6, B
	BANKSEL	_CalcIPBufferChecksum_Checksum_1_1
	BCF	_CalcIPBufferChecksum_Checksum_1_1, 7, B
	BANKSEL	(_CalcIPBufferChecksum_Checksum_1_1 + 1)
	BCF	(_CalcIPBufferChecksum_Checksum_1_1 + 1), 0, B
	BANKSEL	(_CalcIPBufferChecksum_Checksum_1_1 + 1)
	BCF	(_CalcIPBufferChecksum_Checksum_1_1 + 1), 1, B
	BANKSEL	(_CalcIPBufferChecksum_Checksum_1_1 + 1)
	BCF	(_CalcIPBufferChecksum_Checksum_1_1 + 1), 2, B
	BANKSEL	(_CalcIPBufferChecksum_Checksum_1_1 + 1)
	BCF	(_CalcIPBufferChecksum_Checksum_1_1 + 1), 3, B
	BANKSEL	(_CalcIPBufferChecksum_Checksum_1_1 + 1)
	BCF	(_CalcIPBufferChecksum_Checksum_1_1 + 1), 4, B
	BANKSEL	(_CalcIPBufferChecksum_Checksum_1_1 + 1)
	BCF	(_CalcIPBufferChecksum_Checksum_1_1 + 1), 5, B
	BANKSEL	(_CalcIPBufferChecksum_Checksum_1_1 + 1)
	BCF	(_CalcIPBufferChecksum_Checksum_1_1 + 1), 6, B
	BANKSEL	(_CalcIPBufferChecksum_Checksum_1_1 + 1)
	BCF	(_CalcIPBufferChecksum_Checksum_1_1 + 1), 7, B
	BANKSEL	(_CalcIPBufferChecksum_Checksum_1_1 + 2)
	BCF	(_CalcIPBufferChecksum_Checksum_1_1 + 2), 0, B
	BANKSEL	(_CalcIPBufferChecksum_Checksum_1_1 + 2)
	BCF	(_CalcIPBufferChecksum_Checksum_1_1 + 2), 1, B
	BANKSEL	(_CalcIPBufferChecksum_Checksum_1_1 + 2)
	BCF	(_CalcIPBufferChecksum_Checksum_1_1 + 2), 2, B
	BANKSEL	(_CalcIPBufferChecksum_Checksum_1_1 + 2)
	BCF	(_CalcIPBufferChecksum_Checksum_1_1 + 2), 3, B
	BANKSEL	(_CalcIPBufferChecksum_Checksum_1_1 + 2)
	BCF	(_CalcIPBufferChecksum_Checksum_1_1 + 2), 4, B
	BANKSEL	(_CalcIPBufferChecksum_Checksum_1_1 + 2)
	BCF	(_CalcIPBufferChecksum_Checksum_1_1 + 2), 5, B
	BANKSEL	(_CalcIPBufferChecksum_Checksum_1_1 + 2)
	BCF	(_CalcIPBufferChecksum_Checksum_1_1 + 2), 6, B
	BANKSEL	(_CalcIPBufferChecksum_Checksum_1_1 + 2)
	BCF	(_CalcIPBufferChecksum_Checksum_1_1 + 2), 7, B
	BANKSEL	(_CalcIPBufferChecksum_Checksum_1_1 + 3)
	BCF	(_CalcIPBufferChecksum_Checksum_1_1 + 3), 0, B
	BANKSEL	(_CalcIPBufferChecksum_Checksum_1_1 + 3)
	BCF	(_CalcIPBufferChecksum_Checksum_1_1 + 3), 1, B
	BANKSEL	(_CalcIPBufferChecksum_Checksum_1_1 + 3)
	BCF	(_CalcIPBufferChecksum_Checksum_1_1 + 3), 2, B
	BANKSEL	(_CalcIPBufferChecksum_Checksum_1_1 + 3)
	BCF	(_CalcIPBufferChecksum_Checksum_1_1 + 3), 3, B
	BANKSEL	(_CalcIPBufferChecksum_Checksum_1_1 + 3)
	BCF	(_CalcIPBufferChecksum_Checksum_1_1 + 3), 4, B
	BANKSEL	(_CalcIPBufferChecksum_Checksum_1_1 + 3)
	BCF	(_CalcIPBufferChecksum_Checksum_1_1 + 3), 5, B
	BANKSEL	(_CalcIPBufferChecksum_Checksum_1_1 + 3)
	BCF	(_CalcIPBufferChecksum_Checksum_1_1 + 3), 6, B
	BANKSEL	(_CalcIPBufferChecksum_Checksum_1_1 + 3)
	BCF	(_CalcIPBufferChecksum_Checksum_1_1 + 3), 7, B
;	.line	833; TCPIP_Stack/ETH97J60.c	Start = ((WORD)ERDPTH)<<8|ERDPTL;
	MOVFF	_ERDPTH, r0x02
	CLRF	r0x03
	MOVF	r0x02, W
	MOVWF	r0x05
	CLRF	r0x04
	MOVFF	_ERDPTL, r0x02
	CLRF	r0x03
	MOVF	r0x04, W
	IORWF	r0x02, F
	MOVF	r0x05, W
	IORWF	r0x03, F
_00305_DS_:
;	.line	835; TCPIP_Stack/ETH97J60.c	while(len)
	MOVF	r0x00, W
	IORWF	r0x01, W
	BTFSC	STATUS, 2
	BRA	_00307_DS_
;	.line	839; TCPIP_Stack/ETH97J60.c	ChunkLen = len > sizeof(DataBuffer) ? sizeof(DataBuffer) : len;
	MOVLW	0x00
	SUBWF	r0x01, W
	BNZ	_00319_DS_
	MOVLW	0x15
	SUBWF	r0x00, W
_00319_DS_:
	BNC	_00310_DS_
	MOVLW	0x14
	MOVWF	r0x04
	CLRF	r0x05
	BRA	_00311_DS_
_00310_DS_:
	MOVFF	r0x00, r0x04
	MOVFF	r0x01, r0x05
_00311_DS_:
	MOVFF	r0x04, _CalcIPBufferChecksum_ChunkLen_1_1
	MOVFF	r0x05, (_CalcIPBufferChecksum_ChunkLen_1_1 + 1)
;	.line	840; TCPIP_Stack/ETH97J60.c	MACGetArray(DataBuffer, ChunkLen);
	MOVLW	HIGH(_CalcIPBufferChecksum_DataBuffer_1_1)
	MOVWF	r0x07
	MOVLW	LOW(_CalcIPBufferChecksum_DataBuffer_1_1)
	MOVWF	r0x06
	MOVLW	0x80
	MOVWF	r0x08
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	MOVF	r0x08, W
	MOVWF	POSTDEC1
	MOVF	r0x07, W
	MOVWF	POSTDEC1
	MOVF	r0x06, W
	MOVWF	POSTDEC1
	CALL	_MACGetArray
	MOVLW	0x05
	ADDWF	FSR1L, F
;	.line	842; TCPIP_Stack/ETH97J60.c	len -= ChunkLen;
	MOVF	r0x04, W
	SUBWF	r0x00, F
	MOVF	r0x05, W
	SUBWFB	r0x01, F
	BANKSEL	_CalcIPBufferChecksum_ChunkLen_1_1
;	.line	845; TCPIP_Stack/ETH97J60.c	if(((WORD_VAL*)&ChunkLen)->bits.b0)
	BTFSS	_CalcIPBufferChecksum_ChunkLen_1_1, 0, B
	BRA	_00301_DS_
;	.line	847; TCPIP_Stack/ETH97J60.c	DataBuffer[ChunkLen] = 0x00;
	MOVLW	LOW(_CalcIPBufferChecksum_DataBuffer_1_1)
	BANKSEL	_CalcIPBufferChecksum_ChunkLen_1_1
	ADDWF	_CalcIPBufferChecksum_ChunkLen_1_1, W, B
	MOVWF	r0x04
	MOVLW	HIGH(_CalcIPBufferChecksum_DataBuffer_1_1)
	BANKSEL	(_CalcIPBufferChecksum_ChunkLen_1_1 + 1)
	ADDWFC	(_CalcIPBufferChecksum_ChunkLen_1_1 + 1), W, B
	MOVWF	r0x05
	MOVFF	r0x04, FSR0L
	MOVFF	r0x05, FSR0H
	MOVLW	0x00
	MOVWF	INDF0
	BANKSEL	_CalcIPBufferChecksum_ChunkLen_1_1
;	.line	848; TCPIP_Stack/ETH97J60.c	ChunkLen++;
	INCF	_CalcIPBufferChecksum_ChunkLen_1_1, F, B
	BNC	_10492_DS_
	BANKSEL	(_CalcIPBufferChecksum_ChunkLen_1_1 + 1)
	INCF	(_CalcIPBufferChecksum_ChunkLen_1_1 + 1), F, B
_10492_DS_:
_00301_DS_:
;	.line	852; TCPIP_Stack/ETH97J60.c	DataPtr = (WORD*)&DataBuffer[0];
	MOVLW	HIGH(_CalcIPBufferChecksum_DataBuffer_1_1)
	MOVWF	r0x05
	MOVLW	LOW(_CalcIPBufferChecksum_DataBuffer_1_1)
	MOVWF	r0x04
	MOVLW	0x80
	MOVWF	r0x06
;	.line	853; TCPIP_Stack/ETH97J60.c	while(ChunkLen)
	MOVFF	_CalcIPBufferChecksum_ChunkLen_1_1, r0x07
	MOVFF	(_CalcIPBufferChecksum_ChunkLen_1_1 + 1), r0x08
_00302_DS_:
	MOVF	r0x07, W
	IORWF	r0x08, W
	BTFSC	STATUS, 2
	BRA	_00305_DS_
;	.line	855; TCPIP_Stack/ETH97J60.c	Checksum.Val += *DataPtr++;
	MOVFF	r0x04, FSR0L
	MOVFF	r0x05, PRODL
	MOVF	r0x06, W
	CALL	__gptrget2
	MOVWF	r0x09
	MOVFF	PRODL, r0x0a
	MOVLW	0x02
	ADDWF	r0x04, F
	MOVLW	0x00
	ADDWFC	r0x05, F
	MOVLW	0x00
	ADDWFC	r0x06, F
	CLRF	r0x0b
	CLRF	r0x0c
	BANKSEL	_CalcIPBufferChecksum_Checksum_1_1
	MOVF	_CalcIPBufferChecksum_Checksum_1_1, W, B
	ADDWF	r0x09, F
	BANKSEL	(_CalcIPBufferChecksum_Checksum_1_1 + 1)
	MOVF	(_CalcIPBufferChecksum_Checksum_1_1 + 1), W, B
	ADDWFC	r0x0a, F
	BANKSEL	(_CalcIPBufferChecksum_Checksum_1_1 + 2)
	MOVF	(_CalcIPBufferChecksum_Checksum_1_1 + 2), W, B
	ADDWFC	r0x0b, F
	BANKSEL	(_CalcIPBufferChecksum_Checksum_1_1 + 3)
	MOVF	(_CalcIPBufferChecksum_Checksum_1_1 + 3), W, B
	ADDWFC	r0x0c, F
	MOVF	r0x09, W
	BANKSEL	_CalcIPBufferChecksum_Checksum_1_1
	MOVWF	_CalcIPBufferChecksum_Checksum_1_1, B
	MOVF	r0x0a, W
	BANKSEL	(_CalcIPBufferChecksum_Checksum_1_1 + 1)
	MOVWF	(_CalcIPBufferChecksum_Checksum_1_1 + 1), B
	MOVF	r0x0b, W
	BANKSEL	(_CalcIPBufferChecksum_Checksum_1_1 + 2)
	MOVWF	(_CalcIPBufferChecksum_Checksum_1_1 + 2), B
	MOVF	r0x0c, W
	BANKSEL	(_CalcIPBufferChecksum_Checksum_1_1 + 3)
	MOVWF	(_CalcIPBufferChecksum_Checksum_1_1 + 3), B
;	.line	856; TCPIP_Stack/ETH97J60.c	ChunkLen -= 2;
	MOVLW	0xfe
	ADDWF	r0x07, F
	BTFSS	STATUS, 0
	DECF	r0x08, F
	BRA	_00302_DS_
_00307_DS_:
;	.line	861; TCPIP_Stack/ETH97J60.c	ERDPTL = LOW(Start);
	MOVF	r0x02, W
	MOVWF	r0x00
	CLRF	r0x01
	MOVF	r0x00, W
	MOVWF	_ERDPTL
;	.line	862; TCPIP_Stack/ETH97J60.c	ERDPTH = HIGH(Start);
	MOVF	r0x03, W
	MOVWF	r0x02
	CLRF	r0x03
	CLRF	r0x03
	MOVF	r0x02, W
	MOVWF	_ERDPTH
;	.line	865; TCPIP_Stack/ETH97J60.c	Checksum.Val = (DWORD)Checksum.w[0] + (DWORD)Checksum.w[1];
	MOVFF	_CalcIPBufferChecksum_Checksum_1_1, r0x00
	MOVFF	(_CalcIPBufferChecksum_Checksum_1_1 + 1), r0x01
	CLRF	r0x02
	CLRF	r0x03
	MOVFF	(_CalcIPBufferChecksum_Checksum_1_1 + 2), r0x04
	MOVFF	(_CalcIPBufferChecksum_Checksum_1_1 + 3), r0x05
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
	BANKSEL	_CalcIPBufferChecksum_Checksum_1_1
	MOVWF	_CalcIPBufferChecksum_Checksum_1_1, B
	MOVF	r0x01, W
	BANKSEL	(_CalcIPBufferChecksum_Checksum_1_1 + 1)
	MOVWF	(_CalcIPBufferChecksum_Checksum_1_1 + 1), B
	MOVF	r0x02, W
	BANKSEL	(_CalcIPBufferChecksum_Checksum_1_1 + 2)
	MOVWF	(_CalcIPBufferChecksum_Checksum_1_1 + 2), B
	MOVF	r0x03, W
	BANKSEL	(_CalcIPBufferChecksum_Checksum_1_1 + 3)
	MOVWF	(_CalcIPBufferChecksum_Checksum_1_1 + 3), B
	BANKSEL	(_CalcIPBufferChecksum_Checksum_1_1 + 2)
;	.line	869; TCPIP_Stack/ETH97J60.c	Checksum.w[0] += Checksum.w[1];
	MOVF	(_CalcIPBufferChecksum_Checksum_1_1 + 2), W, B
	BANKSEL	_CalcIPBufferChecksum_Checksum_1_1
	ADDWF	_CalcIPBufferChecksum_Checksum_1_1, W, B
	MOVWF	r0x00
	BANKSEL	(_CalcIPBufferChecksum_Checksum_1_1 + 3)
	MOVF	(_CalcIPBufferChecksum_Checksum_1_1 + 3), W, B
	BANKSEL	(_CalcIPBufferChecksum_Checksum_1_1 + 1)
	ADDWFC	(_CalcIPBufferChecksum_Checksum_1_1 + 1), W, B
	MOVWF	r0x01
	MOVF	r0x00, W
	BANKSEL	_CalcIPBufferChecksum_Checksum_1_1
	MOVWF	_CalcIPBufferChecksum_Checksum_1_1, B
	MOVF	r0x01, W
	BANKSEL	(_CalcIPBufferChecksum_Checksum_1_1 + 1)
	MOVWF	(_CalcIPBufferChecksum_Checksum_1_1 + 1), B
	BANKSEL	_CalcIPBufferChecksum_Checksum_1_1
;	.line	872; TCPIP_Stack/ETH97J60.c	return ~Checksum.w[0];
	COMF	_CalcIPBufferChecksum_Checksum_1_1, W, B
	MOVWF	r0x00
	BANKSEL	(_CalcIPBufferChecksum_Checksum_1_1 + 1)
	COMF	(_CalcIPBufferChecksum_Checksum_1_1 + 1), W, B
	MOVWF	r0x01
	MOVFF	r0x01, PRODL
	MOVF	r0x00, W
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
S_ETH97J60__MACCalcRxChecksum	code
_MACCalcRxChecksum:
;	.line	699; TCPIP_Stack/ETH97J60.c	WORD MACCalcRxChecksum(WORD offset, WORD len)
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
	BANKSEL	_CurrentPacketLocation
;	.line	705; TCPIP_Stack/ETH97J60.c	temp = CurrentPacketLocation.Val + sizeof(ENC_PREAMBLE) + offset;
	MOVF	_CurrentPacketLocation, W, B
	ADDLW	0x14
	MOVWF	r0x04
	MOVLW	0x00
	BANKSEL	(_CurrentPacketLocation + 1)
	ADDWFC	(_CurrentPacketLocation + 1), W, B
	MOVWF	r0x05
	MOVF	r0x04, W
	ADDWF	r0x00, F
	MOVF	r0x05, W
	ADDWFC	r0x01, F
;	.line	706; TCPIP_Stack/ETH97J60.c	if(temp > RXSTOP)		// Adjust value if a wrap is needed
	MOVFF	r0x00, r0x04
	MOVFF	r0x01, r0x05
	CLRF	r0x06
	CLRF	r0x07
	MOVLW	0x00
	SUBWF	r0x07, W
	BNZ	_00295_DS_
	MOVLW	0x00
	SUBWF	r0x06, W
	BNZ	_00295_DS_
	MOVLW	0x1a
	SUBWF	r0x05, W
	BNZ	_00295_DS_
	MOVLW	0x0a
	SUBWF	r0x04, W
_00295_DS_:
	BNC	_00291_DS_
;	.line	708; TCPIP_Stack/ETH97J60.c	temp -= RXSIZE;
	MOVLW	0xf6
	ADDWF	r0x04, F
	MOVLW	0xe5
	ADDWFC	r0x05, F
	MOVLW	0xff
	ADDWFC	r0x06, F
	MOVLW	0xff
	ADDWFC	r0x07, F
	MOVF	r0x04, W
	MOVWF	r0x00
	MOVF	r0x05, W
	MOVWF	r0x01
_00291_DS_:
;	.line	711; TCPIP_Stack/ETH97J60.c	RDSave = ((WORD)ERDPTH)<<8|ERDPTL;
	MOVFF	_ERDPTH, r0x04
	CLRF	r0x05
	MOVF	r0x04, W
	MOVWF	r0x07
	CLRF	r0x06
	MOVFF	_ERDPTL, r0x04
	CLRF	r0x05
	MOVF	r0x04, W
	IORWF	r0x06, F
	MOVF	r0x05, W
	IORWF	r0x07, F
;	.line	712; TCPIP_Stack/ETH97J60.c	ERDPTL = LOW(temp);
	MOVF	r0x00, W
	MOVWF	r0x04
	CLRF	r0x05
	MOVF	r0x04, W
	MOVWF	_ERDPTL
;	.line	713; TCPIP_Stack/ETH97J60.c	ERDPTH = HIGH(temp);
	MOVF	r0x01, W
	MOVWF	r0x04
	CLRF	r0x05
	CLRF	r0x05
	MOVF	r0x04, W
	MOVWF	_ERDPTH
;	.line	714; TCPIP_Stack/ETH97J60.c	temp = CalcIPBufferChecksum(len);
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	CALL	_CalcIPBufferChecksum
	MOVWF	r0x00
	MOVFF	PRODL, r0x01
	MOVLW	0x02
	ADDWF	FSR1L, F
;	.line	715; TCPIP_Stack/ETH97J60.c	ERDPTL = LOW(RDSave);
	MOVF	r0x06, W
	MOVWF	r0x02
	CLRF	r0x03
	MOVF	r0x02, W
	MOVWF	_ERDPTL
;	.line	716; TCPIP_Stack/ETH97J60.c	ERDPTH = HIGH(RDSave);
	MOVF	r0x07, W
	MOVWF	r0x06
	CLRF	r0x07
	CLRF	r0x07
	MOVF	r0x06, W
	MOVWF	_ERDPTH
;	.line	718; TCPIP_Stack/ETH97J60.c	return temp;
	MOVFF	r0x01, PRODL
	MOVF	r0x00, W
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
S_ETH97J60__MACSetReadPtr	code
_MACSetReadPtr:
;	.line	669; TCPIP_Stack/ETH97J60.c	WORD MACSetReadPtr(WORD address)
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
;	.line	673; TCPIP_Stack/ETH97J60.c	oldVal = ((WORD)ERDPTH)<<8|ERDPTL;
	MOVFF	_ERDPTH, r0x02
	CLRF	r0x03
	MOVF	r0x02, W
	MOVWF	r0x05
	CLRF	r0x04
	MOVFF	_ERDPTL, r0x02
	CLRF	r0x03
	MOVF	r0x02, W
	IORWF	r0x04, F
	MOVF	r0x03, W
	IORWF	r0x05, F
;	.line	674; TCPIP_Stack/ETH97J60.c	ERDPTL = LOW(address);
	MOVF	r0x00, W
	MOVWF	r0x02
	CLRF	r0x03
	MOVF	r0x02, W
	MOVWF	_ERDPTL
;	.line	675; TCPIP_Stack/ETH97J60.c	ERDPTH = HIGH(address);
	MOVF	r0x01, W
	MOVWF	r0x00
	CLRF	r0x01
	CLRF	r0x01
	MOVF	r0x00, W
	MOVWF	_ERDPTH
;	.line	676; TCPIP_Stack/ETH97J60.c	return oldVal;
	MOVFF	r0x05, PRODL
	MOVF	r0x04, W
	MOVFF	PREINC1, r0x05
	MOVFF	PREINC1, r0x04
	MOVFF	PREINC1, r0x03
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_ETH97J60__MACSetWritePtr	code
_MACSetWritePtr:
;	.line	642; TCPIP_Stack/ETH97J60.c	WORD MACSetWritePtr(WORD address)
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
;	.line	646; TCPIP_Stack/ETH97J60.c	oldVal = ((WORD)EWRPTH)<<8|EWRPTL;
	MOVFF	_EWRPTH, r0x02
	CLRF	r0x03
	MOVF	r0x02, W
	MOVWF	r0x05
	CLRF	r0x04
	MOVFF	_EWRPTL, r0x02
	CLRF	r0x03
	MOVF	r0x02, W
	IORWF	r0x04, F
	MOVF	r0x03, W
	IORWF	r0x05, F
;	.line	648; TCPIP_Stack/ETH97J60.c	EWRPTL = LOW(address);
	MOVF	r0x00, W
	MOVWF	r0x02
	CLRF	r0x03
	MOVF	r0x02, W
	BANKSEL	_EWRPTL
	MOVWF	_EWRPTL, B
;	.line	649; TCPIP_Stack/ETH97J60.c	EWRPTH = HIGH(address);
	MOVF	r0x01, W
	MOVWF	r0x00
	CLRF	r0x01
	CLRF	r0x01
	MOVF	r0x00, W
	BANKSEL	_EWRPTH
	MOVWF	_EWRPTH, B
;	.line	650; TCPIP_Stack/ETH97J60.c	return oldVal;
	MOVFF	r0x05, PRODL
	MOVF	r0x04, W
	MOVFF	PREINC1, r0x05
	MOVFF	PREINC1, r0x04
	MOVFF	PREINC1, r0x03
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_ETH97J60__MACSetReadPtrInRx	code
_MACSetReadPtrInRx:
;	.line	609; TCPIP_Stack/ETH97J60.c	void MACSetReadPtrInRx(WORD offset)
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
	BANKSEL	_CurrentPacketLocation
;	.line	615; TCPIP_Stack/ETH97J60.c	ReadPT.Val = CurrentPacketLocation.Val + sizeof(ENC_PREAMBLE) + offset;
	MOVF	_CurrentPacketLocation, W, B
	ADDLW	0x14
	MOVWF	r0x02
	MOVLW	0x00
	BANKSEL	(_CurrentPacketLocation + 1)
	ADDWFC	(_CurrentPacketLocation + 1), W, B
	MOVWF	r0x03
	MOVF	r0x02, W
	ADDWF	r0x00, F
	MOVF	r0x03, W
	ADDWFC	r0x01, F
	MOVF	r0x00, W
	BANKSEL	_MACSetReadPtrInRx_ReadPT_1_1
	MOVWF	_MACSetReadPtrInRx_ReadPT_1_1, B
	MOVF	r0x01, W
	BANKSEL	(_MACSetReadPtrInRx_ReadPT_1_1 + 1)
	MOVWF	(_MACSetReadPtrInRx_ReadPT_1_1 + 1), B
;	.line	618; TCPIP_Stack/ETH97J60.c	if(ReadPT.Val > RXSTOP)  ReadPT.Val -= RXSIZE;
	MOVFF	_MACSetReadPtrInRx_ReadPT_1_1, r0x02
	MOVFF	(_MACSetReadPtrInRx_ReadPT_1_1 + 1), r0x03
	CLRF	r0x04
	CLRF	r0x05
	MOVLW	0x00
	SUBWF	r0x05, W
	BNZ	_00275_DS_
	MOVLW	0x00
	SUBWF	r0x04, W
	BNZ	_00275_DS_
	MOVLW	0x1a
	SUBWF	r0x01, W
	BNZ	_00275_DS_
	MOVLW	0x0a
	SUBWF	r0x00, W
_00275_DS_:
	BNC	_00271_DS_
	CLRF	r0x00
	CLRF	r0x01
	MOVLW	0xf6
	ADDWF	r0x02, F
	MOVLW	0xe5
	ADDWFC	r0x03, F
	MOVLW	0xff
	ADDWFC	r0x00, F
	MOVLW	0xff
	ADDWFC	r0x01, F
	MOVF	r0x02, W
	BANKSEL	_MACSetReadPtrInRx_ReadPT_1_1
	MOVWF	_MACSetReadPtrInRx_ReadPT_1_1, B
	MOVF	r0x03, W
	BANKSEL	(_MACSetReadPtrInRx_ReadPT_1_1 + 1)
	MOVWF	(_MACSetReadPtrInRx_ReadPT_1_1 + 1), B
_00271_DS_:
;	.line	621; TCPIP_Stack/ETH97J60.c	ERDPTL = ReadPT.v[0];
	MOVFF	_MACSetReadPtrInRx_ReadPT_1_1, _ERDPTL
;	.line	622; TCPIP_Stack/ETH97J60.c	ERDPTH = ReadPT.v[1];
	MOVFF	(_MACSetReadPtrInRx_ReadPT_1_1 + 1), _ERDPTH
	MOVFF	PREINC1, r0x05
	MOVFF	PREINC1, r0x04
	MOVFF	PREINC1, r0x03
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_ETH97J60__MACFlush	code
_MACFlush:
;	.line	563; TCPIP_Stack/ETH97J60.c	void MACFlush(void)
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVFF	r0x02, POSTDEC1
	MOVFF	r0x03, POSTDEC1
;	.line	569; TCPIP_Stack/ETH97J60.c	ECON1bits.TXRST = 1;
	BSF	_ECON1bits, 7
;	.line	570; TCPIP_Stack/ETH97J60.c	ECON1bits.TXRST = 0;
	BCF	_ECON1bits, 7
;	.line	574; TCPIP_Stack/ETH97J60.c	{volatile BYTE i = 8; while(i--);}
	MOVLW	0x08
	BANKSEL	_MACFlush_i_2_2
	MOVWF	_MACFlush_i_2_2, B
_00262_DS_:
	MOVFF	_MACFlush_i_2_2, r0x00
	BANKSEL	_MACFlush_i_2_2
	DECF	_MACFlush_i_2_2, F, B
	MOVF	r0x00, W
	BNZ	_00262_DS_
;	.line	575; TCPIP_Stack/ETH97J60.c	EIRbits.TXERIF = 0;
	BCF	_EIRbits, 1
;	.line	582; TCPIP_Stack/ETH97J60.c	ECON1bits.TXRTS = 1;
	BSF	_ECON1bits, 3
;	.line	583; TCPIP_Stack/ETH97J60.c	wTXWatchdog = TickGet();
	CALL	_TickGet
	MOVWF	r0x00
	MOVFF	PRODL, r0x01
	MOVFF	PRODH, r0x02
	MOVFF	FSR0L, r0x03
	MOVF	r0x00, W
	BANKSEL	_wTXWatchdog
	MOVWF	_wTXWatchdog, B
	MOVF	r0x01, W
	BANKSEL	(_wTXWatchdog + 1)
	MOVWF	(_wTXWatchdog + 1), B
	MOVFF	PREINC1, r0x03
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_ETH97J60__MACPutHeader	code
_MACPutHeader:
;	.line	515; TCPIP_Stack/ETH97J60.c	void MACPutHeader(MAC_ADDR *remote, BYTE type, WORD dataLen)
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
	MOVLW	0x05
	MOVFF	PLUSW2, r0x03
	MOVLW	0x06
	MOVFF	PLUSW2, r0x04
	MOVLW	0x07
	MOVFF	PLUSW2, r0x05
;	.line	518; TCPIP_Stack/ETH97J60.c	EWRPTL = LOW(TXSTART + 1);
	MOVLW	0x0b
	BANKSEL	_EWRPTL
	MOVWF	_EWRPTL, B
;	.line	519; TCPIP_Stack/ETH97J60.c	EWRPTH = HIGH(TXSTART + 1);
	MOVLW	0x1a
	BANKSEL	_EWRPTH
	MOVWF	_EWRPTH, B
;	.line	522; TCPIP_Stack/ETH97J60.c	dataLen += (WORD)sizeof(ETHER_HEADER) + TXSTART;
	MOVFF	r0x04, r0x06
	MOVFF	r0x05, r0x07
	CLRF	r0x08
	CLRF	r0x09
	MOVLW	0x18
	ADDWF	r0x06, F
	MOVLW	0x1a
	ADDWFC	r0x07, F
	MOVLW	0x00
	ADDWFC	r0x08, F
	MOVLW	0x00
	ADDWFC	r0x09, F
	MOVF	r0x06, W
	MOVWF	r0x04
	MOVF	r0x07, W
	MOVWF	r0x05
;	.line	525; TCPIP_Stack/ETH97J60.c	ETXNDL = LOW(dataLen);
	MOVF	r0x04, W
	MOVWF	r0x06
	CLRF	r0x07
	MOVF	r0x06, W
	BANKSEL	_ETXNDL
	MOVWF	_ETXNDL, B
;	.line	526; TCPIP_Stack/ETH97J60.c	ETXNDH = HIGH(dataLen);
	MOVF	r0x05, W
	MOVWF	r0x04
	CLRF	r0x05
	CLRF	r0x05
	MOVF	r0x04, W
	BANKSEL	_ETXNDH
	MOVWF	_ETXNDH, B
;	.line	530; TCPIP_Stack/ETH97J60.c	MACPutArray((BYTE*)remote, sizeof(*remote));
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
	CALL	_MACPutArray
	MOVLW	0x05
	ADDWF	FSR1L, F
;	.line	533; TCPIP_Stack/ETH97J60.c	MACPutArray((BYTE*)&AppConfig.MyMACAddr, sizeof(AppConfig.MyMACAddr));
	MOVLW	HIGH(_AppConfig + 45)
	MOVWF	r0x01
	MOVLW	LOW(_AppConfig + 45)
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
	CALL	_MACPutArray
	MOVLW	0x05
	ADDWF	FSR1L, F
;	.line	536; TCPIP_Stack/ETH97J60.c	MACPut(0x08);
	MOVLW	0x08
	MOVWF	POSTDEC1
	CALL	_MACPut
	INCF	FSR1L, F
;	.line	537; TCPIP_Stack/ETH97J60.c	MACPut((type == MAC_IP) ? ETHER_IP : ETHER_ARP);
	MOVF	r0x03, W
	BSF	STATUS, 0
	TSTFSZ	WREG
	BCF	STATUS, 0
	CLRF	r0x03
	RLCF	r0x03, F
	MOVF	r0x03, W
	BZ	_00256_DS_
	CLRF	r0x00
	CLRF	r0x01
	BRA	_00257_DS_
_00256_DS_:
	MOVLW	0x06
	MOVWF	r0x00
	CLRF	r0x01
_00257_DS_:
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_MACPut
	INCF	FSR1L, F
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
S_ETH97J60__MACGetHeader	code
_MACGetHeader:
;	.line	425; TCPIP_Stack/ETH97J60.c	BOOL MACGetHeader(MAC_ADDR *remote, BYTE* type)
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
	MOVLW	0x05
	MOVFF	PLUSW2, r0x03
	MOVLW	0x06
	MOVFF	PLUSW2, r0x04
	MOVLW	0x07
	MOVFF	PLUSW2, r0x05
	BANKSEL	_EPKTCNT
;	.line	430; TCPIP_Stack/ETH97J60.c	if(EPKTCNT == 0u)
	MOVF	_EPKTCNT, W, B
	BNZ	_00213_DS_
;	.line	432; TCPIP_Stack/ETH97J60.c	return FALSE;
	CLRF	WREG
	BRA	_00230_DS_
_00213_DS_:
	BANKSEL	_WasDiscarded
;	.line	436; TCPIP_Stack/ETH97J60.c	if(WasDiscarded == FALSE)
	MOVF	_WasDiscarded, W, B
	BNZ	_00215_DS_
;	.line	438; TCPIP_Stack/ETH97J60.c	MACDiscardRx();
	CALL	_MACDiscardRx
;	.line	439; TCPIP_Stack/ETH97J60.c	return FALSE;
	CLRF	WREG
	BRA	_00230_DS_
_00215_DS_:
	BANKSEL	_NextPacketLocation
;	.line	442; TCPIP_Stack/ETH97J60.c	CurrentPacketLocation.Val = NextPacketLocation.Val;
	MOVF	_NextPacketLocation, W, B
	BANKSEL	_CurrentPacketLocation
	MOVWF	_CurrentPacketLocation, B
	BANKSEL	(_NextPacketLocation + 1)
	MOVF	(_NextPacketLocation + 1), W, B
	BANKSEL	(_CurrentPacketLocation + 1)
	MOVWF	(_CurrentPacketLocation + 1), B
	BANKSEL	(_CurrentPacketLocation + 1)
;	.line	445; TCPIP_Stack/ETH97J60.c	ERDPTH = HIGH(CurrentPacketLocation.Val);
	MOVF	(_CurrentPacketLocation + 1), W, B
	MOVWF	r0x06
	CLRF	r0x07
	CLRF	r0x07
	MOVF	r0x06, W
	MOVWF	_ERDPTH
	BANKSEL	_CurrentPacketLocation
;	.line	446; TCPIP_Stack/ETH97J60.c	ERDPTL = LOW(CurrentPacketLocation.Val);
	MOVF	_CurrentPacketLocation, W, B
	MOVWF	r0x06
	CLRF	r0x07
	MOVF	r0x06, W
	MOVWF	_ERDPTL
;	.line	449; TCPIP_Stack/ETH97J60.c	MACGetArray((BYTE*)&header, sizeof(header));
	MOVLW	HIGH(_MACGetHeader_header_1_1)
	MOVWF	r0x07
	MOVLW	LOW(_MACGetHeader_header_1_1)
	MOVWF	r0x06
	MOVLW	0x80
	MOVWF	r0x08
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x14
	MOVWF	POSTDEC1
	MOVF	r0x08, W
	MOVWF	POSTDEC1
	MOVF	r0x07, W
	MOVWF	POSTDEC1
	MOVF	r0x06, W
	MOVWF	POSTDEC1
	CALL	_MACGetArray
	MOVLW	0x05
	ADDWF	FSR1L, F
	BANKSEL	(_MACGetHeader_header_1_1 + 19)
;	.line	453; TCPIP_Stack/ETH97J60.c	header.Type.Val = swaps(header.Type.Val);
	MOVF	(_MACGetHeader_header_1_1 + 19), W, B
	MOVWF	POSTDEC1
	BANKSEL	(_MACGetHeader_header_1_1 + 18)
	MOVF	(_MACGetHeader_header_1_1 + 18), W, B
	MOVWF	POSTDEC1
	CALL	_swaps
	MOVWF	r0x06
	MOVFF	PRODL, r0x07
	MOVLW	0x02
	ADDWF	FSR1L, F
	MOVF	r0x06, W
	BANKSEL	(_MACGetHeader_header_1_1 + 18)
	MOVWF	(_MACGetHeader_header_1_1 + 18), B
	MOVF	r0x07, W
	BANKSEL	(_MACGetHeader_header_1_1 + 19)
	MOVWF	(_MACGetHeader_header_1_1 + 19), B
;	.line	458; TCPIP_Stack/ETH97J60.c	if(header.NextPacketPointer > RXSTOP || 
	MOVFF	_MACGetHeader_header_1_1, r0x06
	MOVFF	(_MACGetHeader_header_1_1 + 1), r0x07
	CLRF	r0x08
	CLRF	r0x09
	MOVLW	0x00
	SUBWF	r0x09, W
	BNZ	_00244_DS_
	MOVLW	0x00
	SUBWF	r0x08, W
	BNZ	_00244_DS_
	MOVLW	0x1a
	SUBWF	r0x07, W
	BNZ	_00244_DS_
	MOVLW	0x0a
	SUBWF	r0x06, W
_00244_DS_:
	BC	_00219_DS_
	BANKSEL	_MACGetHeader_header_1_1
;	.line	459; TCPIP_Stack/ETH97J60.c	((BYTE_VAL*)(&header.NextPacketPointer))->bits.b0 ||
	BTFSC	_MACGetHeader_header_1_1, 0, B
	BRA	_00219_DS_
	BANKSEL	(_MACGetHeader_header_1_1 + 5)
;	.line	460; TCPIP_Stack/ETH97J60.c	header.StatusVector.bits.Zero ||
	BTFSC	(_MACGetHeader_header_1_1 + 5), 7, B
	BRA	_00219_DS_
	BANKSEL	(_MACGetHeader_header_1_1 + 4)
;	.line	461; TCPIP_Stack/ETH97J60.c	header.StatusVector.bits.CRCError ||
	BTFSC	(_MACGetHeader_header_1_1 + 4), 4, B
	BRA	_00219_DS_
;	.line	462; TCPIP_Stack/ETH97J60.c	header.StatusVector.bits.ByteCount > 1518u ||
	MOVLW	0x05
	BANKSEL	(_MACGetHeader_header_1_1 + 3)
	SUBWF	(_MACGetHeader_header_1_1 + 3), W, B
	BNZ	_00245_DS_
	MOVLW	0xef
	BANKSEL	(_MACGetHeader_header_1_1 + 2)
	SUBWF	(_MACGetHeader_header_1_1 + 2), W, B
_00245_DS_:
	BC	_00219_DS_
	BANKSEL	(_MACGetHeader_header_1_1 + 4)
;	.line	463; TCPIP_Stack/ETH97J60.c	!header.StatusVector.bits.ReceiveOk)
	BTFSC	(_MACGetHeader_header_1_1 + 4), 7, B
	BRA	_00220_DS_
_00219_DS_:
;	.line	465; TCPIP_Stack/ETH97J60.c	DisplayString(0,"error reading hdr");while(1);//////////////////////ML
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
_00217_DS_:
	BRA	_00217_DS_
_00220_DS_:
	BANKSEL	_MACGetHeader_header_1_1
;	.line	470; TCPIP_Stack/ETH97J60.c	NextPacketLocation.Val = header.NextPacketPointer;
	MOVF	_MACGetHeader_header_1_1, W, B
	BANKSEL	_NextPacketLocation
	MOVWF	_NextPacketLocation, B
	BANKSEL	(_MACGetHeader_header_1_1 + 1)
	MOVF	(_MACGetHeader_header_1_1 + 1), W, B
	BANKSEL	(_NextPacketLocation + 1)
	MOVWF	(_NextPacketLocation + 1), B
;	.line	475; TCPIP_Stack/ETH97J60.c	memcpy((void*)remote->v, (void*)header.SourceMACAddr.v, sizeof(*remote));
	MOVLW	HIGH(_MACGetHeader_header_1_1 + 12)
	MOVWF	r0x07
	MOVLW	LOW(_MACGetHeader_header_1_1 + 12)
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
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_memcpy
	MOVLW	0x08
	ADDWF	FSR1L, F
;	.line	478; TCPIP_Stack/ETH97J60.c	*type = MAC_UNKNOWN;
	MOVLW	0xff
	MOVWF	POSTDEC1
	MOVFF	r0x03, FSR0L
	MOVFF	r0x04, PRODL
	MOVF	r0x05, W
	CALL	__gptrput1
;	.line	479; TCPIP_Stack/ETH97J60.c	if( (header.Type.v[1] == 0x08u) &&
	MOVFF	(_MACGetHeader_header_1_1 + 19), r0x00
	CLRF	r0x01
	MOVF	r0x00, W
	XORLW	0x08
	BNZ	_00246_DS_
	MOVF	r0x01, W
	BZ	_00247_DS_
_00246_DS_:
	BRA	_00227_DS_
_00247_DS_:
;	.line	480; TCPIP_Stack/ETH97J60.c	((header.Type.v[0] == ETHER_IP) || (header.Type.v[0] == ETHER_ARP)) )
	MOVFF	(_MACGetHeader_header_1_1 + 18), r0x00
	MOVF	r0x00, W
	BZ	_00226_DS_
	MOVFF	r0x00, r0x01
	CLRF	r0x02
	MOVF	r0x01, W
	XORLW	0x06
	BNZ	_00248_DS_
	MOVF	r0x02, W
	BZ	_00226_DS_
_00248_DS_:
	BRA	_00227_DS_
_00226_DS_:
;	.line	482; TCPIP_Stack/ETH97J60.c	*type = header.Type.v[0];
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x03, FSR0L
	MOVFF	r0x04, PRODL
	MOVF	r0x05, W
	CALL	__gptrput1
_00227_DS_:
	BANKSEL	_WasDiscarded
;	.line	486; TCPIP_Stack/ETH97J60.c	WasDiscarded = FALSE;
	CLRF	_WasDiscarded, B
;	.line	487; TCPIP_Stack/ETH97J60.c	return TRUE;
	MOVLW	0x01
_00230_DS_:
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
S_ETH97J60__MACGetFreeRxSize	code
_MACGetFreeRxSize:
;	.line	367; TCPIP_Stack/ETH97J60.c	WORD MACGetFreeRxSize(void)
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVFF	r0x02, POSTDEC1
	MOVFF	r0x03, POSTDEC1
	MOVFF	r0x04, POSTDEC1
	MOVFF	r0x05, POSTDEC1
_00186_DS_:
	BANKSEL	_EPKTCNT
;	.line	377; TCPIP_Stack/ETH97J60.c	ReadPT.v[0] = EPKTCNT;
	MOVF	_EPKTCNT, W, B
	BANKSEL	_MACGetFreeRxSize_ReadPT_1_1
	MOVWF	_MACGetFreeRxSize_ReadPT_1_1, B
;	.line	379; TCPIP_Stack/ETH97J60.c	WritePT.Val = ((WORD)ERXWRPTH)<<8|ERXWRPTL;
	MOVFF	_ERXWRPTH, r0x00
	CLRF	r0x01
	MOVF	r0x00, W
	MOVWF	r0x03
	CLRF	r0x02
	MOVFF	_ERXWRPTL, r0x00
	CLRF	r0x01
	MOVF	r0x00, W
	IORWF	r0x02, F
	MOVF	r0x01, W
	IORWF	r0x03, F
	MOVF	r0x02, W
	BANKSEL	_MACGetFreeRxSize_WritePT_1_1
	MOVWF	_MACGetFreeRxSize_WritePT_1_1, B
	MOVF	r0x03, W
	BANKSEL	(_MACGetFreeRxSize_WritePT_1_1 + 1)
	MOVWF	(_MACGetFreeRxSize_WritePT_1_1 + 1), B
	BANKSEL	_EPKTCNT
;	.line	380; TCPIP_Stack/ETH97J60.c	} while(EPKTCNT != ReadPT.v[0]);
	MOVF	_EPKTCNT, W, B
	BANKSEL	_MACGetFreeRxSize_ReadPT_1_1
	XORWF	_MACGetFreeRxSize_ReadPT_1_1, W, B
	BNZ	_00186_DS_
;	.line	383; TCPIP_Stack/ETH97J60.c	ReadPT.Val = ERXRDPTH<<8|ERXRDPTL;
	MOVFF	_ERXRDPTH, r0x00
	CLRF	r0x01
	MOVF	r0x00, W
	MOVWF	r0x03
	CLRF	r0x02
	MOVFF	_ERXRDPTL, r0x00
	CLRF	r0x01
	MOVF	r0x00, W
	IORWF	r0x02, F
	MOVF	r0x01, W
	IORWF	r0x03, F
	MOVF	r0x02, W
	BANKSEL	_MACGetFreeRxSize_ReadPT_1_1
	MOVWF	_MACGetFreeRxSize_ReadPT_1_1, B
	MOVF	r0x03, W
	BANKSEL	(_MACGetFreeRxSize_ReadPT_1_1 + 1)
	MOVWF	(_MACGetFreeRxSize_ReadPT_1_1 + 1), B
;	.line	388; TCPIP_Stack/ETH97J60.c	if(WritePT.Val > ReadPT.Val)
	MOVFF	_MACGetFreeRxSize_ReadPT_1_1, r0x00
	MOVFF	(_MACGetFreeRxSize_ReadPT_1_1 + 1), r0x01
	BANKSEL	(_MACGetFreeRxSize_WritePT_1_1 + 1)
	MOVF	(_MACGetFreeRxSize_WritePT_1_1 + 1), W, B
	SUBWF	r0x01, W
	BNZ	_00205_DS_
	BANKSEL	_MACGetFreeRxSize_WritePT_1_1
	MOVF	_MACGetFreeRxSize_WritePT_1_1, W, B
	SUBWF	r0x00, W
_00205_DS_:
	BC	_00193_DS_
;	.line	390; TCPIP_Stack/ETH97J60.c	return (RXSTOP - RXSTART) - (WritePT.Val - ReadPT.Val);
	MOVF	r0x00, W
	BANKSEL	_MACGetFreeRxSize_WritePT_1_1
	SUBWF	_MACGetFreeRxSize_WritePT_1_1, W, B
	MOVWF	r0x02
	MOVF	r0x01, W
	BANKSEL	(_MACGetFreeRxSize_WritePT_1_1 + 1)
	SUBWFB	(_MACGetFreeRxSize_WritePT_1_1 + 1), W, B
	MOVWF	r0x03
	CLRF	r0x04
	CLRF	r0x05
	MOVF	r0x02, W
	SUBLW	0x09
	MOVWF	r0x02
	MOVLW	0x1a
	SUBFWB	r0x03, F
	MOVLW	0x00
	SUBFWB	r0x04, F
	MOVLW	0x00
	SUBFWB	r0x05, F
	MOVFF	r0x03, PRODL
	MOVF	r0x02, W
	BRA	_00195_DS_
_00193_DS_:
	BANKSEL	_MACGetFreeRxSize_WritePT_1_1
;	.line	392; TCPIP_Stack/ETH97J60.c	else if(WritePT.Val == ReadPT.Val)
	MOVF	_MACGetFreeRxSize_WritePT_1_1, W, B
	XORWF	r0x00, W
	BNZ	_00206_DS_
	BANKSEL	(_MACGetFreeRxSize_WritePT_1_1 + 1)
	MOVF	(_MACGetFreeRxSize_WritePT_1_1 + 1), W, B
	XORWF	r0x01, W
	BZ	_00207_DS_
_00206_DS_:
	BRA	_00190_DS_
_00207_DS_:
;	.line	394; TCPIP_Stack/ETH97J60.c	return RXSIZE - 1;
	MOVLW	0x1a
	MOVWF	PRODL
	MOVLW	0x09
	BRA	_00195_DS_
_00190_DS_:
	BANKSEL	_MACGetFreeRxSize_WritePT_1_1
;	.line	398; TCPIP_Stack/ETH97J60.c	return ReadPT.Val - WritePT.Val - 1;
	MOVF	_MACGetFreeRxSize_WritePT_1_1, W, B
	SUBWF	r0x00, F
	BANKSEL	(_MACGetFreeRxSize_WritePT_1_1 + 1)
	MOVF	(_MACGetFreeRxSize_WritePT_1_1 + 1), W, B
	SUBWFB	r0x01, F
	MOVLW	0xff
	ADDWF	r0x00, F
	BTFSS	STATUS, 0
	DECF	r0x01, F
	MOVFF	r0x01, PRODL
	MOVF	r0x00, W
_00195_DS_:
	MOVFF	PREINC1, r0x05
	MOVFF	PREINC1, r0x04
	MOVFF	PREINC1, r0x03
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_ETH97J60__MACDiscardRx	code
_MACDiscardRx:
;	.line	313; TCPIP_Stack/ETH97J60.c	void MACDiscardRx(void)
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVFF	r0x02, POSTDEC1
	MOVFF	r0x03, POSTDEC1
	BANKSEL	_WasDiscarded
;	.line	318; TCPIP_Stack/ETH97J60.c	if(WasDiscarded) return;
	MOVF	_WasDiscarded, W, B
	BNZ	_00177_DS_
;	.line	319; TCPIP_Stack/ETH97J60.c	WasDiscarded = TRUE;
	MOVLW	0x01
	BANKSEL	_WasDiscarded
	MOVWF	_WasDiscarded, B
	BANKSEL	_NextPacketLocation
;	.line	325; TCPIP_Stack/ETH97J60.c	NewRXRDLocation.Val = NextPacketLocation.Val - 1;
	MOVF	_NextPacketLocation, W, B
	ADDLW	0xff
	MOVWF	r0x00
	MOVLW	0xff
	BANKSEL	(_NextPacketLocation + 1)
	ADDWFC	(_NextPacketLocation + 1), W, B
	MOVWF	r0x01
	MOVF	r0x00, W
	BANKSEL	_MACDiscardRx_NewRXRDLocation_1_1
	MOVWF	_MACDiscardRx_NewRXRDLocation_1_1, B
	MOVF	r0x01, W
	BANKSEL	(_MACDiscardRx_NewRXRDLocation_1_1 + 1)
	MOVWF	(_MACDiscardRx_NewRXRDLocation_1_1 + 1), B
;	.line	327; TCPIP_Stack/ETH97J60.c	if(NewRXRDLocation.Val > RXSTOP)
	MOVFF	_MACDiscardRx_NewRXRDLocation_1_1, WREG
	MOVFF	(_MACDiscardRx_NewRXRDLocation_1_1 + 1), WREG
	CLRF	r0x02
	CLRF	r0x03
	MOVLW	0x00
	SUBWF	r0x03, W
	BNZ	_00181_DS_
	MOVLW	0x00
	SUBWF	r0x02, W
	BNZ	_00181_DS_
	MOVLW	0x1a
	SUBWF	r0x01, W
	BNZ	_00181_DS_
	MOVLW	0x0a
	SUBWF	r0x00, W
_00181_DS_:
	BNC	_00176_DS_
;	.line	332; TCPIP_Stack/ETH97J60.c	NewRXRDLocation.Val = RXSTOP;
	MOVLW	0x09
	BANKSEL	_MACDiscardRx_NewRXRDLocation_1_1
	MOVWF	_MACDiscardRx_NewRXRDLocation_1_1, B
	MOVLW	0x1a
	BANKSEL	(_MACDiscardRx_NewRXRDLocation_1_1 + 1)
	MOVWF	(_MACDiscardRx_NewRXRDLocation_1_1 + 1), B
_00176_DS_:
	BANKSEL	_ECON2bits
;	.line	336; TCPIP_Stack/ETH97J60.c	ECON2bits.PKTDEC = 1;
	BSF	_ECON2bits, 6, B
;	.line	341; TCPIP_Stack/ETH97J60.c	ERXRDPTL = NewRXRDLocation.v[0];
	MOVFF	_MACDiscardRx_NewRXRDLocation_1_1, _ERXRDPTL
;	.line	342; TCPIP_Stack/ETH97J60.c	ERXRDPTH = NewRXRDLocation.v[1];
	MOVFF	(_MACDiscardRx_NewRXRDLocation_1_1 + 1), _ERXRDPTH
;	.line	347; TCPIP_Stack/ETH97J60.c	EIRbits.PKTIF = 0;
	BCF	_EIRbits, 6
_00177_DS_:
	MOVFF	PREINC1, r0x03
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_ETH97J60__MACIsTxReady	code
_MACIsTxReady:
;	.line	278; TCPIP_Stack/ETH97J60.c	BOOL MACIsTxReady(void)
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVFF	r0x02, POSTDEC1
	MOVFF	r0x03, POSTDEC1
;	.line	280; TCPIP_Stack/ETH97J60.c	if(!ECON1bits.TXRTS)
	BTFSC	_ECON1bits, 3
	BRA	_00161_DS_
;	.line	281; TCPIP_Stack/ETH97J60.c	return TRUE;
	MOVLW	0x01
	BRA	_00164_DS_
_00161_DS_:
;	.line	285; TCPIP_Stack/ETH97J60.c	if((WORD)TickGet() - wTXWatchdog >= (3ull*TICK_SECOND/1000ull))
	CALL	_TickGet
	MOVWF	r0x00
	MOVFF	PRODL, r0x01
	MOVFF	PRODH, r0x02
	MOVFF	FSR0L, r0x03
	BANKSEL	_wTXWatchdog
	MOVF	_wTXWatchdog, W, B
	SUBWF	r0x00, F
	BANKSEL	(_wTXWatchdog + 1)
	MOVF	(_wTXWatchdog + 1), W, B
	SUBWFB	r0x01, F
	CLRF	r0x02
	CLRF	r0x03
	MOVLW	0x00
	SUBWF	r0x03, W
	BNZ	_00168_DS_
	MOVLW	0x00
	SUBWF	r0x02, W
	BNZ	_00168_DS_
	MOVLW	0x00
	SUBWF	r0x01, W
	BNZ	_00168_DS_
	MOVLW	0x7a
	SUBWF	r0x00, W
_00168_DS_:
	BNC	_00163_DS_
;	.line	287; TCPIP_Stack/ETH97J60.c	ECON1bits.TXRTS = 0;
	BCF	_ECON1bits, 3
;	.line	288; TCPIP_Stack/ETH97J60.c	MACFlush();
	CALL	_MACFlush
_00163_DS_:
;	.line	290; TCPIP_Stack/ETH97J60.c	return FALSE;
	CLRF	WREG
_00164_DS_:
	MOVFF	PREINC1, r0x03
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_ETH97J60__MACIsLinked	code
_MACIsLinked:
;	.line	244; TCPIP_Stack/ETH97J60.c	BOOL MACIsLinked(void)
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
;	.line	253; TCPIP_Stack/ETH97J60.c	pr.Val= ReadPHYReg(PHSTAT1);
	MOVLW	0x01
	MOVWF	POSTDEC1
	CALL	_ReadPHYReg
	MOVWF	r0x00
	MOVFF	PRODL, r0x01
	INCF	FSR1L, F
	MOVF	r0x00, W
	BANKSEL	_MACIsLinked_pr_1_1
	MOVWF	_MACIsLinked_pr_1_1, B
	MOVF	r0x01, W
	BANKSEL	(_MACIsLinked_pr_1_1 + 1)
	MOVWF	(_MACIsLinked_pr_1_1 + 1), B
;	.line	254; TCPIP_Stack/ETH97J60.c	return pr.PHSTAT1bits.LLSTAT;
	CLRF	r0x00
	BANKSEL	_MACIsLinked_pr_1_1
	BTFSC	_MACIsLinked_pr_1_1, 2, B
	INCF	r0x00, F
	MOVF	r0x00, W
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_ETH97J60__MACInit	code
_MACInit:
;	.line	131; TCPIP_Stack/ETH97J60.c	void MACInit(void)
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
;	.line	135; TCPIP_Stack/ETH97J60.c	TRISAbits.TRISA0 = 0; // Set LEDA as output (green on ethernet connector)
	BCF	_TRISAbits, 0
;	.line	136; TCPIP_Stack/ETH97J60.c	TRISAbits.TRISA1 = 0; // Set LEDB as output (yellow on ethernet connector)
	BCF	_TRISAbits, 1
	BANKSEL	_ECON2bits
;	.line	137; TCPIP_Stack/ETH97J60.c	ECON2bits.ETHEN = 1;    // Enable Ethernet!
	BSF	_ECON2bits, 5, B
_00105_DS_:
	BANKSEL	_ESTATbits
;	.line	140; TCPIP_Stack/ETH97J60.c	while(!ESTATbits.PHYRDY);
	BTFSS	_ESTATbits, 0, B
	BRA	_00105_DS_
;	.line	144; TCPIP_Stack/ETH97J60.c	WasDiscarded = TRUE;
	MOVLW	0x01
	BANKSEL	_WasDiscarded
	MOVWF	_WasDiscarded, B
	BANKSEL	_NextPacketLocation
;	.line	145; TCPIP_Stack/ETH97J60.c	NextPacketLocation.Val = RXSTART;
	CLRF	_NextPacketLocation, B
	BANKSEL	(_NextPacketLocation + 1)
	CLRF	(_NextPacketLocation + 1), B
	BANKSEL	_ERXSTL
;	.line	146; TCPIP_Stack/ETH97J60.c	ERXSTL = LOW(RXSTART);
	CLRF	_ERXSTL, B
	BANKSEL	_ERXSTH
;	.line	147; TCPIP_Stack/ETH97J60.c	ERXSTH = HIGH(RXSTART);
	CLRF	_ERXSTH, B
;	.line	149; TCPIP_Stack/ETH97J60.c	ERXRDPTL = LOW(RXSTOP);	// Write low byte first
	MOVLW	0x09
	BANKSEL	_ERXRDPTL
	MOVWF	_ERXRDPTL, B
;	.line	150; TCPIP_Stack/ETH97J60.c	ERXRDPTH = HIGH(RXSTOP);    // Write high byte last
	MOVLW	0x1a
	BANKSEL	_ERXRDPTH
	MOVWF	_ERXRDPTH, B
;	.line	152; TCPIP_Stack/ETH97J60.c	ERXNDL = LOW(RXSTOP);
	MOVLW	0x09
	BANKSEL	_ERXNDL
	MOVWF	_ERXNDL, B
;	.line	153; TCPIP_Stack/ETH97J60.c	ERXNDH = HIGH(RXSTOP);
	MOVLW	0x1a
	BANKSEL	_ERXNDH
	MOVWF	_ERXNDH, B
;	.line	155; TCPIP_Stack/ETH97J60.c	ETXSTL = LOW(TXSTART);
	MOVLW	0x0a
	BANKSEL	_ETXSTL
	MOVWF	_ETXSTL, B
;	.line	156; TCPIP_Stack/ETH97J60.c	ETXSTH = HIGH(TXSTART);
	MOVLW	0x1a
	BANKSEL	_ETXSTH
	MOVWF	_ETXSTH, B
;	.line	159; TCPIP_Stack/ETH97J60.c	EWRPTL = LOW(TXSTART);
	MOVLW	0x0a
	BANKSEL	_EWRPTL
	MOVWF	_EWRPTL, B
;	.line	160; TCPIP_Stack/ETH97J60.c	EWRPTH = HIGH(TXSTART);
	MOVLW	0x1a
	BANKSEL	_EWRPTH
	MOVWF	_EWRPTH, B
;	.line	161; TCPIP_Stack/ETH97J60.c	EDATA = 0x00;
	CLRF	_EDATA
;	.line	171; TCPIP_Stack/ETH97J60.c	MACON1 = MACON1_TXPAUS | MACON1_RXPAUS | MACON1_MARXEN; Nop();
	MOVLW	0x0d
	BANKSEL	_MACON1
	MOVWF	_MACON1, B
	nop 
;	.line	179; TCPIP_Stack/ETH97J60.c	MACON3 = MACON3_PADCFG0 | MACON3_TXCRCEN | MACON3_FRMLNEN; Nop();
	MOVLW	0x32
	BANKSEL	_MACON3
	MOVWF	_MACON3, B
	nop 
;	.line	180; TCPIP_Stack/ETH97J60.c	MABBIPG = 0x12; Nop();
	MOVLW	0x12
	BANKSEL	_MABBIPG
	MOVWF	_MABBIPG, B
	nop 
;	.line	186; TCPIP_Stack/ETH97J60.c	MACON4 = MACON4_DEFER; Nop();
	MOVLW	0x40
	BANKSEL	_MACON4
	MOVWF	_MACON4, B
	nop 
;	.line	191; TCPIP_Stack/ETH97J60.c	MAIPGL = 0x12; Nop();
	MOVLW	0x12
	BANKSEL	_MAIPGL
	MOVWF	_MAIPGL, B
	nop 
;	.line	192; TCPIP_Stack/ETH97J60.c	MAIPGH = 0x0C; Nop();
	MOVLW	0x0c
	BANKSEL	_MAIPGH
	MOVWF	_MAIPGH, B
	nop 
;	.line	195; TCPIP_Stack/ETH97J60.c	MAMXFLL = LOW(6+6+2+1500+4); Nop();
	MOVLW	0xee
	BANKSEL	_MAMXFLL
	MOVWF	_MAMXFLL, B
	nop 
;	.line	196; TCPIP_Stack/ETH97J60.c	MAMXFLH = HIGH(6+6+2+1500+4); Nop();
	MOVLW	0x05
	BANKSEL	_MAMXFLH
	MOVWF	_MAMXFLH, B
	nop 
;	.line	199; TCPIP_Stack/ETH97J60.c	MAADR1 = AppConfig.MyMACAddr.v[0]; Nop();
	MOVFF	(_AppConfig + 45), _MAADR1
	nop 
;	.line	200; TCPIP_Stack/ETH97J60.c	MAADR2 = AppConfig.MyMACAddr.v[1]; Nop();
	MOVFF	(_AppConfig + 46), _MAADR2
	nop 
;	.line	201; TCPIP_Stack/ETH97J60.c	MAADR3 = AppConfig.MyMACAddr.v[2]; Nop();
	MOVFF	(_AppConfig + 47), _MAADR3
	nop 
;	.line	202; TCPIP_Stack/ETH97J60.c	MAADR4 = AppConfig.MyMACAddr.v[3]; Nop();
	MOVFF	(_AppConfig + 48), _MAADR4
	nop 
;	.line	203; TCPIP_Stack/ETH97J60.c	MAADR5 = AppConfig.MyMACAddr.v[4]; Nop();
	MOVFF	(_AppConfig + 49), _MAADR5
	nop 
;	.line	204; TCPIP_Stack/ETH97J60.c	MAADR6 = AppConfig.MyMACAddr.v[5]; Nop();
	MOVFF	(_AppConfig + 50), _MAADR6
	nop 
;	.line	207; TCPIP_Stack/ETH97J60.c	WritePHYReg(PHCON2, PHCON2_HDLDIS | PHCON2_RXAPDIS);
	MOVLW	0x01
	MOVWF	POSTDEC1
	MOVLW	0x10
	MOVWF	POSTDEC1
	MOVLW	0x10
	MOVWF	POSTDEC1
	CALL	_WritePHYReg
	MOVLW	0x03
	ADDWF	FSR1L, F
;	.line	210; TCPIP_Stack/ETH97J60.c	SetLEDConfig(0x3472);
	MOVLW	0x34
	MOVWF	POSTDEC1
	MOVLW	0x72
	MOVWF	POSTDEC1
	MOVLW	0x14
	MOVWF	POSTDEC1
	CALL	_WritePHYReg
	MOVLW	0x03
	ADDWF	FSR1L, F
;	.line	216; TCPIP_Stack/ETH97J60.c	WritePHYReg(PHCON1, 0x0000);
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	CALL	_WritePHYReg
	MOVLW	0x03
	ADDWF	FSR1L, F
;	.line	220; TCPIP_Stack/ETH97J60.c	ECON1bits.RXEN = 1;
	BSF	_ECON1bits, 2
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
__str_0:
	DB	0x65, 0x72, 0x72, 0x6f, 0x72, 0x20, 0x72, 0x65, 0x61, 0x64, 0x69, 0x6e
	DB	0x67, 0x20, 0x68, 0x64, 0x72, 0x00


; Statistics:
; code size:	 5346 (0x14e2) bytes ( 4.08%)
;           	 2673 (0x0a71) words
; udata size:	  141 (0x008d) bytes ( 3.67%)
; access size:	   13 (0x000d) bytes


	end
