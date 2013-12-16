/*******************************************************************************

 File:
        ZGSpi.c

 Description:
        Zero G Driver SPI Driver C file.

Copyright © 2009 Microchip Technology Inc.  All rights reserved.

Microchip licenses to you the right to use, modify, copy and distribute
Software only when embedded on a Microchip microcontroller or digital signal
controller that is integrated into your product or third party product
(pursuant to the sublicense terms in the accompanying license agreement).

You should refer to the license agreement accompanying this Software for
additional information regarding your rights and obligations.

SOFTWARE AND DOCUMENTATION ARE PROVIDED “AS IS” WITHOUT WARRANTY OF ANY KIND,
EITHER EXPRESS OR IMPLIED, INCLUDING WITHOUT LIMITATION, ANY WARRANTY OF
MERCHANTABILITY, TITLE, NON-INFRINGEMENT AND FITNESS FOR A PARTICULAR PURPOSE.
IN NO EVENT SHALL MICROCHIP OR ITS LICENSORS BE LIABLE OR OBLIGATED UNDER
CONTRACT, NEGLIGENCE, STRICT LIABILITY, CONTRIBUTION, BREACH OF WARRANTY, OR
OTHER LEGAL EQUITABLE THEORY ANY DIRECT OR INDIRECT DAMAGES OR EXPENSES
INCLUDING BUT NOT LIMITED TO ANY INCIDENTAL, SPECIAL, INDIRECT, PUNITIVE OR
CONSEQUENTIAL DAMAGES, LOST PROFITS OR LOST DATA, COST OF PROCUREMENT OF
SUBSTITUTE GOODS, TECHNOLOGY, SERVICES, OR ANY CLAIMS BY THIRD PARTIES
(INCLUDING BUT NOT LIMITED TO ANY DEFENSE THEREOF), OR OTHER SIMILAR COSTS.

 DO NOT DELETE THIS LEGAL NOTICE:
  2006, 2007, 2008 © ZeroG Wireless, Inc.  All Rights Reserved.
  Confidential and proprietary software of ZeroG Wireless, Inc.
  Do no copy, forward or distribute.

Author               Date       Comment
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Zero G              Sep 2008    Initial version
KO                  31 Oct 2008 Port to PIC24F and PIC32 for TCP/IP stack v4.52

*******************************************************************************/

#include "HardwareProfile.h"
#if defined(ZG_CS_TRIS)


/*****************************************************************************
 * Include Files
 *****************************************************************************/
#include "TCPIP Stack/TCPIP.h"
#include "TCPIP Stack/ZG2100.h"


/*****************************************************************************
 * Function Prototypes
 *****************************************************************************/




/*****************************************************************************
 * Constants & #defines
 *****************************************************************************/


/*****************************************************************************
 * Static Globals
 *****************************************************************************/
//static  tZGU16      spiTxLength;
//static  tZGU16      spiRxLength;
//static  tZGU16      spiCurrentLength;
static  tZGBool     spiSuppressDoneHandlerCall;

typedef struct
{
    tZGDataPtr      pTxPreambleBuffer;
    tZGDataPtr      pTxBuffer;             // if not NULL, pTxBufferRom will be NULL
    ROM tZGDataPtr  pTxRomBuffer;          // if not NULL, pTxBuffer will be NULL
    tZGDataPtr      pRxPreambleBuffer;
    tZGDataPtr      pRxBuffer;
    tZGU16          txPreambleLength;
    tZGU16          txLength;
    tZGU16          rxPreambleLength;
    tZGU16          rxBufferLength;
    tZGU16          excessRxLength;
    Boolean         suppressDoneHandlerCall;
} tSpiContext;

static tSpiContext gSpiCxt;

#ifndef DEDICATED_SPI_ZG
    static BYTE         SPIONSave;
    #if defined( __18CXX)
        static BYTE     SPICON1Save;
        static BYTE     SPISTATSave;
    #elif defined( __C30__ )
        static WORD     SPICON1Save;
        static WORD     SPICON2Save;
        static WORD     SPISTATSave;
    #elif defined( __PIC32MX__ )
        static DWORD    SPICON1Save;
        static DWORD    SPISTATSave;
    #else
        #error Cannot define SPI context save variables.
    #endif
#endif

#define SPICXT (gSpiCxt)


//============================================================================
//                          Local Function Prototypes
//============================================================================
#ifndef DEDICATED_SPI_ZG
    static tZGVoidReturn SaveSpiContext(tZGVoidInput);
    static tZGVoidReturn RestoreSpiContext(tZGVoidInput);
#endif

//============================================================================
//                          SPI Definitions
//============================================================================

#if defined (__18CXX)
    #define ClearSPIDoneFlag()  {ZG_SPI_IF = 0;}
    #define WaitForDataByte()   {while(!ZG_SPI_IF); ZG_SPI_IF = 0;}
    #define SPI_ON_BIT          (ZG_SPICON1bits.SSPEN)
#elif defined(__C30__)
    #define ClearSPIDoneFlag()
    static inline __attribute__((__always_inline__)) void WaitForDataByte( void )
    {
        while ((ZG_SPISTATbits.SPITBF == 1) || (ZG_SPISTATbits.SPIRBF == 0));
    }

    #define SPI_ON_BIT          (ZG_SPISTATbits.SPIEN)
#elif defined( __PIC32MX__ )
    #define ClearSPIDoneFlag()
    static inline __attribute__((__always_inline__)) void WaitForDataByte( void )
    {
        while (!ZG_SPISTATbits.SPITBE || !ZG_SPISTATbits.SPIRBF);
    }

    #define SPI_ON_BIT          (ZG_SPICON1bits.ON)
#else
    #error Determine SPI flag mechanism
#endif

/*****************************************************************************
 * FUNCTION: zgHALSpiInit
 *
 * RETURNS:  None
 *
 * PARAMS:   None
 *
 *  NOTES: Called by ZGPrvComInit() during init to configure the SPI I/O.
 *****************************************************************************/
tZGVoidReturn zgHALSpiInit(tZGVoidInput)
{
    /* disable the spi interrupt */
    #if defined( __PIC32MX__ )
        ZG_SPI_IE_CLEAR = ZG_SPI_INT_BITS;
    #else
        ZG_SPI_IE = 0;
    #endif
    #if defined( __18CXX)
        ZG_SPI_IP = 0;
    #endif

    // Set up the SPI module on the PIC for communications with the ZG2100

    /* enable the SPI pins */
//  #if defined(EEPROM_CS_TRIS)
//      EEPROM_CS_IO   = 1;     // deselect EEPROM
//      EEPROM_CS_TRIS = 0;     // Drive SPI EEPROM chip select pin
//  #endif
    ZG_CS_IO       = 1;
    ZG_CS_TRIS     = 0;     // Drive SPI ZG2100 chip select pin
    #if defined( __18CXX)
        ZG_SCK_TRIS    = 0;
        ZG_SDO_TRIS    = 0;
        ZG_SDI_TRIS    = 1;
    #else
        // We'll let the module control the pins.
    #endif

    /* clear the completion flag */
    ClearSPIDoneFlag();

    #ifdef DEDICATED_SPI_ZG
        // Configure the SPI here, instead of every time we access it.
        /*---------------------------------------------*/
        /* Configure SPI I/O for ZG2100 communications */
        /*---------------------------------------------*/
        /* enable the SPI clocks */
        /* set as master */
        /* clock idles high */
        /* ms bit first */
        /* 8 bit tranfer length */
        /* data changes on falling edge */
        /* data is sampled on rising edge */
        /* set the clock divider */
        // Set up SPI
        #if defined(__18CXX)
            ZG_SPICON1 = 0x30;      // SSPEN bit is set, SPI in master mode, (0x30 is for FOSC/4),
                                    //   IDLE state is high level (0x32 is for FOSC/64)
            ZG_SPISTATbits.CKE = 0; // Transmit data on falling edge of clock
            ZG_SPISTATbits.SMP = 1; // Input sampled at end? of data output time
        #elif defined(__C30__)
            ZG_SPICON1 = 0x027B;    // Fcy Primary prescaler 1:1, secondary prescaler 2:1, CPK=1, CKE=0, SMP=1
            ZG_SPICON2 = 0x0000;
            ZG_SPISTAT = 0x8000;    // Enable the module
        #elif defined( __PIC32MX__ )
            ZG_SPI_BRG = (GetPeripheralClock()-1ul)/2ul/ZG_MAX_SPI_FREQ;
            ZG_SPICON1 = 0x00000260;    // sample at end, data change idle to active, clock idle high, master
            ZG_SPICON1bits.ON = 1;
        #else
            #error Configure SPI for the selected processor
        #endif
    #endif

    SPICXT.suppressDoneHandlerCall = FALSE;
}



/*****************************************************************************
 * FUNCTION: zgHALSpiTxRx
 *
 * RETURNS:  True is successful, else False
 *
 * PARAMS:   None
 *
 *  NOTES: SPI Tx/Rx mechansim between Host CPU and ZG2100.
 *****************************************************************************/
tZGBool zgHALSpiTxRx(tZGVoidInput)
{
    #if defined(__18CXX)
        volatile tZGU8 dummy;
    #endif
    tZGU16 numRxPreambleBytes, numTxPreambleBytes;
    tZGU16 numRxDataBytes, numTxDataBytes;
    tZGU16 totalNumBytes;
    tZGU8 *p_txPreBuf, *p_rxPreBuf;
    tZGU8 *p_txDataBuf, *p_rxDataBuf;
    tZGU8 ROM *p_txDataRomBuf;
    tZGU8 romFlag;
    tZGU8 rxTrash;

    numRxPreambleBytes = SPICXT.rxPreambleLength;
    numTxPreambleBytes = SPICXT.txPreambleLength;

    numRxDataBytes     = SPICXT.rxBufferLength + SPICXT.excessRxLength;
    numTxDataBytes     = SPICXT.txLength;

    p_rxPreBuf         = SPICXT.pRxPreambleBuffer;
    p_txPreBuf         = SPICXT.pTxPreambleBuffer;

    p_txDataBuf        = SPICXT.pTxBuffer;
    p_txDataRomBuf     = SPICXT.pTxRomBuffer;
    p_rxDataBuf        = SPICXT.pRxBuffer;
    
    // if more tx bytes than rx bytes, or the same count for both
    if ( (numTxPreambleBytes + numTxDataBytes) >= (numRxPreambleBytes + numRxDataBytes) )
    {
        totalNumBytes = numTxPreambleBytes + numTxDataBytes;
    }    
    // else more rx bytes than tx bytes
    else
    {
        totalNumBytes = numRxPreambleBytes + numRxDataBytes;        
    } 
    
    // if any tx data
    if (numTxDataBytes > 0u)
    {
        // if using tx RAM buffer
        if (SPICXT.pTxBuffer != 0u)
        {
            romFlag = kZGBoolFalse;
        }
        else if (SPICXT.pTxRomBuffer != 0u)
        {
            romFlag = kZGBoolTrue;
        }    
        else
        {
            ZGSYS_DRIVER_ASSERT(5, (ROM char *)"SpiTxRx: Invalid Tx pointer.\n");
        }    
            
    }       

    spiSuppressDoneHandlerCall = SPICXT.suppressDoneHandlerCall;
    SPICXT.suppressDoneHandlerCall = FALSE;  // set back to default state of false, only raw txrx will set true

#ifndef DEDICATED_SPI_ZG
    // Save SPI context so we can restore it to function entry state at end of this function
    SaveSpiContext();

    /*---------------------------------------------*/
    /* Configure SPI I/O for ZG2100 communications */
    /*---------------------------------------------*/
    /* enable the SPI clocks */
    /* set as master */
    /* clock idles high */
    /* ms bit first */
    /* 8 bit tranfer length */
    /* data changes on falling edge */
    /* data is sampled on rising edge */
    /* set the clock divider */
    // Set up SPI
    #if defined(__18CXX)
        ZG_SPICON1 = 0x30;      // SSPEN bit is set, SPI in master mode, (0x30 is for FOSC/4),
                                //   IDLE state is high level (0x32 is for FOSC/64)
        ZG_SPISTATbits.CKE = 0; // Transmit data on falling edge of clock
        ZG_SPISTATbits.SMP = 1; // Input sampled at end? of data output time
    #elif defined(__C30__)
        ZG_SPICON1 = 0x027B;    // Fcy Primary prescaler 1:1, secondary prescaler 2:1, CKP=1, CKE=0, SMP=1
        ZG_SPICON2 = 0x0000;
        ZG_SPISTAT = 0x8000;    // Enable the module
    #elif defined( __PIC32MX__ )
        ZG_SPI_BRG = (GetPeripheralClock()-1ul)/2ul/ZG_MAX_SPI_FREQ;
        ZG_SPICON1 = 0x00000260;    // sample at end, data change idle to active, clock idle high, master
        ZG_SPICON1bits.ON = 1;
    #else
        #error Configure SPI for the selected processor
    #endif
#endif /* DEDICATED_SPI_ZG */

    /* set SS low */
    ZG_CS_IO = 0;

    /* clear any pending interrupts */
    #if defined(__18CXX)
        dummy = ZG_SSPBUF;
        ClearSPIDoneFlag();
    #endif

    // while Tx and/or Rx bytes left to handle
    while (totalNumBytes > 0u)
    {
#if 0
        {
            unsigned short i = 400;  // 0x40; fails on PIC18
            while(i--)
            {
                Nop();
                Nop();
            }
        }    
#endif                
        
        // if still outputting tx preamble bytes
        if (numTxPreambleBytes > 0u)
        {
            --numTxPreambleBytes;
            ZG_SSPBUF = *p_txPreBuf++;
        }
        // else if still outputting tx data bytes
        else if (numTxDataBytes > 0u)
        {
            --numTxDataBytes;
            // if outputting from RAM buffer
            if (!romFlag)
            {
                ZG_SSPBUF = *p_txDataBuf++;
            }        
            // else outputting from ROM buffer
            else
            {
                ZG_SSPBUF = *p_txDataRomBuf++;
            }    
        }       
        // else there were no Tx bytes to output or we are done, so just stuff an FF into SPI tx register
        else
        {
           ZG_SSPBUF = 0xff; 
        }    
        
        // wait until tx/rx byte completely clocked out
        WaitForDataByte();
         
        
        // if still reading Rx preamble bytes
        if (numRxPreambleBytes > 0u)
        {
            --numRxPreambleBytes;
            *p_rxPreBuf++ = ZG_SSPBUF;
        }   
        // else if still reading Rx data bytes 
        else if (numRxDataBytes > 0u)
        {
            --numRxDataBytes;
            *p_rxDataBuf++ = ZG_SSPBUF;
        }  
        // else done with Rx data
        else
        {
            // throw away rx byte
            rxTrash = ZG_SSPBUF;
            
        }      
        
        --totalNumBytes;
    } // end while    


    /* Disable the interrupt */
    #if defined( __PIC32MX__ )
        ZG_SPI_IE_CLEAR = ZG_SPI_INT_BITS;
    #else
        ZG_SPI_IE = 0;
    #endif

    /* set SS high */
    ZG_CS_IO = 1;

    if ( !spiSuppressDoneHandlerCall )
    {
        zgDriverSpiTxRxDoneHandler();
    }


    #ifndef DEDICATED_SPI_ZG
        // Restore SPI I/O state to what it was when this function was entered
        RestoreSpiContext();
    #endif

    return kZGBoolTrue;
}


/*****************************************************************************
 * FUNCTION: SaveSpiContext
 *
 * RETURNS:  None
 *
 * PARAMS:   None
 *
 *  NOTES: Saves the SPI context (mainly speed setting) before using the SPI to
 *         access ZG2100.  Turn off the SPI module before reconfiguring it.
 *         We only need this function if we have to share the SPI.
 *****************************************************************************/

#ifndef DEDICATED_SPI_ZG
static tZGVoidReturn SaveSpiContext(tZGVoidInput)
{
    // Save SPI state (clock speed)
    SPICON1Save = ZG_SPICON1;
    #if defined( __C30__ )
        SPICON2Save = ZG_SPICON2;
    #endif
    SPISTATSave = ZG_SPISTAT;
    SPIONSave   = SPI_ON_BIT;
    SPI_ON_BIT  = 0;
}
#endif

/*****************************************************************************
 * FUNCTION: RestoreSpiContext
 *
 * RETURNS:  None
 *
 * PARAMS:   None
 *
 *  NOTES: Restores the SPI context (mainly speed setting) after using the SPI to
 *         access ZG2100.  Turn off the SPI module before reconfiguring it.
 *         We only need this function if we have to share the SPI.
 *****************************************************************************/
#ifndef DEDICATED_SPI_ZG
static tZGVoidReturn RestoreSpiContext(tZGVoidInput)
{
    SPI_ON_BIT  = 0;
    ZG_SPICON1  = SPICON1Save;
    #if defined( __C30__ )
        ZG_SPICON2  = SPICON2Save;
    #endif
    ZG_SPISTAT  = SPISTATSave;
    SPI_ON_BIT  = SPIONSave;
}
#endif



/* ZGHAL_SPI_CONTEXT_SET_TX_PRE_BUF_PTR(pTxPreambleBuffer) */
tZGVoidReturn SpiSetTxPreBufPtr(tZGDataPtr pBuf)
{
    SPICXT.pTxPreambleBuffer = pBuf;
}


/* ZGHAL_SPI_CONTEXT_SET_TX_PRE_LEN(txPreambleLength) */
tZGVoidReturn SpiSetTxPreLen(tZGU16 len)
{
    SPICXT.txPreambleLength = len;
}


/* ZGHAL_SPI_CONTEXT_SET_TX_BUF_PTR(pTxBuffer) */
tZGVoidReturn SpiSetTxBufPtr(tZGDataPtr pBuf)
{
    SPICXT.pTxBuffer = pBuf;
    SPICXT.pTxRomBuffer = 0;
}

/* ZGHAL_SPI_CONTEXT_SET_ROM_TX_BUF_PTR */
tZGVoidReturn SpiSetTxRomBufPtr(ROM tZGDataPtr pBuf)
{
    SPICXT.pTxRomBuffer = pBuf;
    SPICXT.pTxBuffer    = 0;
}

/* ZGHAL_SPI_CONTEXT_SET_TX_LEN(txLength) */
tZGVoidReturn SpiSetTxBufLen(tZGU16 len)
{
    SPICXT.txLength = len;
}

/* ZGHAL_SPI_CONTEXT_SET_RX_PRE_BUF_PTR(pRxPreambleBuffer) */
tZGVoidReturn SpiSetRxPreBufPtr(tZGDataPtr pBuf)
{
    SPICXT.pRxPreambleBuffer = pBuf;
}

/* ZGHAL_SPI_CONTEXT_SET_RX_PRE_LEN(rxPreambleLength) */
tZGVoidReturn SpiSetRxPreBufLen(tZGU16 len)
{
    SPICXT.rxPreambleLength = len;
}

/* ZGHAL_SPI_CONTEXT_SET_RX_BUF_PTR(pRxBuffer) */
tZGVoidReturn SpiSetRxBufPtr(tZGDataPtr pBuf)
{
    SPICXT.pRxBuffer = pBuf;
}

/* ZGHAL_SPI_CONTEXT_SET_RX_LEN(rxLength) */
tZGVoidReturn SpiSetRxBufLen(tZGU16 len)
{
    SPICXT.rxBufferLength = len;
}

/* ZGHAL_SPI_CONTEXT_SET_RX_EXCESS_LEN(excessRxLength) */
tZGVoidReturn SpiSetRxExcessLen(tZGU16 len)
{
    SPICXT.excessRxLength = len;
}

/* ZGHAL_SPI_CONTEXT_SET_SUPPRESS_DONE_HANDLER_CALL(suppressDoneHandlerCall) */
tZGVoidReturn SpiSetSuppressDoneHandlerCall(tZGBool suppressDoneHandlerCall)
{
    SPICXT.suppressDoneHandlerCall = suppressDoneHandlerCall;
}


#else
// dummy func to keep compiler happy when module has no executeable code
void MCHP_Spi_EmptyFunc(void)
{
}
#endif /* ZG_CS_TRIS */

/* EOF */
