/*******************************************************************************

 File:
        ZGDriverRaw.c

 Description:
        RAW Driver functions.

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

//============================================================================
//                              Includes
//============================================================================

#include "HardwareProfile.h"
#if defined(ZG_CS_TRIS)


#include "TCPIP Stack/TCPIP.h"

#include "TCPIP Stack/ZG2100.h"
#include "TCPIP Stack/ZGDriverPrv.h"


//============================================================================
//                              RAW Register Defines
//============================================================================

/* 8-bit registers */
#define kZGHostRAW0Data                 (0x20)
#define kZGHostRAW1Data                 (0x21)

/* 16 bit registers */
#define kZGHostRAW0Ctrl0Reg             (0x25)
#define kZGHostRAW0Ctrl1Reg             (0x26)
#define kZGHostRAW0IndexReg             (0x27)
#define kZGHostRAW0StatusReg            (0x28)
#define kZGHostRAW1Ctrl0Reg             (0x29)
#define kZGHostRAW1Ctrl1Reg             (0x2a)
#define kZGHostRAW1IndexReg             (0x2b)
#define kZGHostRAW1StatusReg            (0x2c)

// RAW register masks
#define kZGHostRAWStatusErrorMask       (0x0002)
#define kZGHostRAWStatusBusyMask        (0x0001)
#define kZGHostRegisterReadMask         (0x40)

#define kZGRAWCtrlRegisterLength        (2)
#define kZGHostRAWIndexRegisterLength   (2)
#define kZGHostRAWStatusRegisterLength  (2)

#define kZGRawCtrlRawIsDestinationByte  (0)
#define kZGRawCtrlRawIsDestinationMask  (0x80)
#define kZGRawCtrlSrcDestByte           (0)
#define kZGRawCtrlSrcDestMask           (0x70)
#define kZGRawCtrlPoolByteCountMSByte   (0)
#define kZGRawCtrlPoolByteCountMSMask   (0x0f)
#define kZGRawCtrlPoolByteCountMSShift  (8)
#define kZGRawCtrlPoolByteCountLSByte   (1)
#define kZGRawCtrlPoolByteCountLSMask   (0x00ff)

#define kZGTransportCommandLength       (1)
#define kZGTransportStatusLength        (1)


//============================================================================
//                              Typedefs
//============================================================================
typedef struct
{
    tZGU8 reserved;
    tZGU8 type;
    tZGU8 subType;
} tRxTxPreamble;

//============================================================================
//                              Globals
//============================================================================
Boolean gHostRAWDataPacketReceived = kZGBoolFalse;  // set true by state machine in ZGDriverCom.c
extern tZGBool gRxIndexSetBeyondBuffer;   // debug -- remove after test

//============================================================================
//                              Local Globals
//============================================================================



//=========================================================================
//                              Local Functions
//============================================================================
static tZGU16 ZGWaitForRawMoveComplete(tZGU8 rawId);



/*****************************************************************************
 * FUNCTION: ZGRawMove
 *
 * RETURNS: Number of bytes that were overlayed (not always applicable)
 *
 * PARAMS:
 *      rawId   - RAW ID
 *      srcDest - ZG2100 object that will either source or destination of move
 *      rawIsDestination - true if RAW engine is the destination, false if its the source
 *      size    - number of bytes to overlay (not always applicable)
 *
 *  NOTES: Performs a RAW move operation between a RAW engine and a G2100 object
 *****************************************************************************/
tZGU16 ZGRawMove(tZGU16   rawId,             // RAW engine to use (0 or 1)
                 tZGU16   srcDest,           // ZG2100 object
                 Boolean  rawIsDestination,  // true if RAW is the destination
                 tZGU16   size)              // number of bytes to overlay (may be 0)
{
    tZGU16 byteCount;
    tZGU8 regId;
    tZGU8  regValue8;
    tZGU16 ctrlVal = 0;

    if (rawIsDestination)
    {
        ctrlVal |= 0x8000;
    }
    ctrlVal |= (srcDest << 8);              /* defines are already shifted by 4 bits */
    ctrlVal |= ((size >> 8) & 0x0f) << 8;   /* MS 4 bits of size (bits 11:8)         */
    ctrlVal |= (size & 0x00ff);             /* LS 8 bits of size (bits 7:0)          */

    /* Clear the interrupt bit in the register */
    regValue8 = (rawId == kZGRawId0)?kZGCOMRegHostIntMaskRAW0Intr0:kZGCOMRegHostIntMaskRAW1Intr0;
    Write8BitZGRegister(kZGCOMRegHostInt, regValue8);

    /* write update control value to register to control register */
    regId = (rawId==kZGRawId0)?kZGHostRAW0Ctrl0Reg:kZGHostRAW1Ctrl0Reg;
    ZGHAL_SPI_CONTEXT_SET_SUPPRESS_DONE_HANDLER_CALL(kZGBoolTrue);
    Write16BitZGRegister(regId, ctrlVal);

    // Wait for the RAW move operation to complete, and read back the number of bytes, if any, that were overlayed
    byteCount = ZGWaitForRawMoveComplete(rawId);

    return byteCount;
}

/*****************************************************************************
 * FUNCTION: ZGRawSetIndex
 *
 * RETURNS: True if successful, else False
 *
 * PARAMS:
 *      rawId - RAW ID
 *      index - desired index
 *
 *  NOTES: Sets the RAW index for the specified RAW engine
 *****************************************************************************/
Boolean ZGRawSetIndex(tZGU16 rawId, tZGU16 index)
{
    tZGU16 count = 0;
    tZGU8 regId;
    tZGU16 regValue;

    // set the RAW index
    regId = (rawId==kZGRawId0)?kZGHostRAW0IndexReg:kZGHostRAW1IndexReg;
    Write16BitZGRegister(regId, index);

    regId = (rawId==kZGRawId0)?kZGHostRAW0StatusReg:kZGHostRAW1StatusReg;
    while (1)
    {
        regValue = Read16BitZGRegister(regId);
        if ((regValue & kZGHostRAWStatusBusyMask) == 0u)
        {
            return kZGBoolTrue;
        }

        // if we have looped (way) longer than it should take, then get out of loop
        ++count;
        if (count > 100u)
        {
            break;
        }
    }

    return kZGBoolFalse;

}

/*****************************************************************************
 * FUNCTION: ZGRawGetIndex
 *
 * RETURNS: Returns the current RAW index for the specified RAW engine.
 *
 * PARAMS:
 *      rawId - RAW ID
 *
 *  NOTES: None
 *****************************************************************************/
tZGU16 ZGRawGetIndex(tZGU16 rawId)
{
    tZGU8  regId;
    tZGU16 index;

    regId = (rawId==kZGRawId0)?kZGHostRAW0IndexReg:kZGHostRAW1IndexReg;
    index = Read16BitZGRegister(regId);

    return index;
}

extern tZGU8 zgBufferRAWState[2];

/*****************************************************************************
 * FUNCTION: ZGRawGetByte
 *
 * RETURNS: True if successful, else false
 *
 * PARAMS:
 *      rawId   - RAW ID
 *      pBuffer - Buffer to read bytes into
 *      length  - number of bytes to read
 *
 *  NOTES: Reads bytes from the RAW engine
 *****************************************************************************/
Boolean ZGRawGetByte(tZGU16 rawId, tZGU8 *pBuffer, tZGU16 length)
{
    tZGU8 regId;

    // if RAW index previously set out of range and caller is trying to do illegal read
    if ( (rawId==0u) && gRxIndexSetBeyondBuffer && (zgBufferRAWState[0] == 2u) ) // 2==kZGRAWBufferMounted
    {
        char buf[10];
        ZG_PUTRSUART("Rd past end: len=");
        uitoa(length, (BYTE *)buf);
        ZG_PUTSUART( buf);
        ZG_PUTRSUART("\r\n");
    }

    regId = (rawId==kZGRawId0)?kZGHostRAW0Data:kZGHostRAW1Data;
    ReadZGArray(regId, pBuffer, length);

    return true;
}

/*****************************************************************************
 * FUNCTION: ZGRawSetByte
 *
 * RETURNS: True if successful, else false
 *
 * PARAMS:
 *      rawId   - RAW ID
 *      pBuffer - Buffer containing bytes to write
 *      length  - number of bytes to read
 *
 *  NOTES: Reads bytes from the RAW engine
 *****************************************************************************/
Boolean ZGRawSetByte(tZGU16 rawId, tZGU8 *pBuffer, tZGU16 length)
{
    tZGU8 regId;

    /* if previously set index past legal range and now trying to write to RAW engine */
    if ( (rawId==0u) && gRxIndexSetBeyondBuffer && (zgBufferRAWState[0]==2u) )
    {
        char buf[10];
        ZG_PUTRSUART("Wr past end: len=");
        uitoa(length, (BYTE *)buf);
        ZG_PUTSUART(buf);
        ZG_PUTRSUART("\r\n");
    }

    /* write RAW data to chip */
    regId = (rawId==kZGRawId0)?kZGHostRAW0Data:kZGHostRAW1Data;
    WriteZGArray(regId, pBuffer, length);

    return true;
}

/*****************************************************************************
 * FUNCTION: ZGRawSetByteROM
 *
 * RETURNS: True if successful, else false
 *
 * PARAMS:
 *      rawId   - RAW ID
 *      pBuffer - Buffer containing bytes to write
 *      length  - number of bytes to read
 *
 *  NOTES: Reads bytes from the RAW engine.  Same as ZGRawSetByte except
 *         using a ROM pointer instead of RAM pointer
 *****************************************************************************/
Boolean ZGRawSetByteROM(tZGU16 rawId, ROM tZGU8 *pBuffer, tZGU16 length)
{
    tZGU8 regId;

    regId = (rawId==kZGRawId0)?kZGHostRAW0Data:kZGHostRAW1Data;
    WriteZGROMArray(regId, pBuffer, length);
    return true;
}


/*****************************************************************************
 * FUNCTION: ZGWaitForRawMoveComplete
 *
 * RETURNS: Number of bytes that were overlayed (not always applicable)
 *
 * PARAMS:
 *      rawId   - RAW ID
 *
 *  NOTES: Waits for a RAW move to complete.
 *****************************************************************************/
static tZGU16 ZGWaitForRawMoveComplete(tZGU8 rawId)

{
    //tZGU8  buf[2];
    tZGU8  rawIntMask;
    tZGU16 byteCount;
    tZGU16 loopCount = 0;
    tZGU8  val8;
    tZGU8  regId;

    /* create mask to check against for either RAW0 or RAW1 */
    rawIntMask = (rawId == kZGRawId0)?kZGCOMRegHostIntMaskRAW0Intr0:kZGCOMRegHostIntMaskRAW1Intr0;

    /* poll int status register until we get the raw interrupt status bit set, indicating Move complete */
    while (1)
    {
        /* read interrupt status register */
        val8 = Read8BitZGRegister(kZGCOMRegHostInt);
        if ((val8 & rawIntMask) != 0u)
        {
            /* break out of loop when interrupt bit goes high (move complete) */
            break;
        }

        /* if we wait too long for move to complete then fail */
        if ( ++loopCount > 10000u )
        {
            #if defined(USE_LCD)
                /* this is a case that should never happen */
                strcpypgm2ram((char*)LCDText, "DPoolMv Failed  "
                                              "DPoolMv Failed  ");
                LCDUpdate();
            #endif
            while(1);
        }
    } /* end while */

    /* Clear the interrupt bit in Host Int by writing a 1 to it */
    Write8BitZGRegister(kZGCOMRegHostInt, val8 & rawIntMask);

    /* read the byte count and return it */
    regId = (rawId == kZGRawId0)?kZGCOMRegRAW0Ctrl1:kZGCOMRegRAW1Ctrl1;
    byteCount = Read16BitZGRegister(regId);

    return ( byteCount );
}




/*****************************************************************************
 * FUNCTION: SendRAWDataFrame
 *
 * RETURNS: kZGMACSuccess or kZGMACFailure
 *
 * PARAMS:
 *      tZGU8* pBuf -> pointer to the command buffer.
 *      tZGU16 bufLen -> length in bytes of the buffer (pBuf).
 *
 *
 *  NOTES: SendRAWDataFrame sends a Data Transmit request to the ZG chip
 *          using the Random Access Window (RAW) interface.  The pre-buffer
 *          is used by the ZGMAC to send routing information for the packet
 *          while pBuf is the request that was submitted by the application.
 *          The order of operations are
 *              1) reserve a memory buffer of sufficient length on the ZG chip
 *              using ZGRawMove.
 *              2) Write the bytes for the pre-buffer and then the buffer
 *              using the ZGRawSetByte. Because the bytes are written
 *              sequentially there is no need to call ZGRawSetIndex
 *              to adjust the write position.
 *              3) instruct the ZG chip that the command is ready for
 *              processing.
 *              4) perform any necessary cleanup.
 *          After successful submission the ZG chip will transmit the frame
 *          and return a TxData Confirm indicating success or failure
 *          of the operation.  Tx Confirm from the ZG chip is an asynchronous
 *          event that will need to be handled later.  Typically it is only
 *          needed so that the host can track how many data requests are
 *          currently in progress on the ZG chip. The ZG chip is limited
 *          on the number and size of tx Requests that it can manage at any
 *          given time. An host that submits many tx requests could cause
 *          a backup on the ZG chip.
 *****************************************************************************/
Boolean ZGSendRAWDataFrame(tZGU16 bufLen)
{
    Boolean res = false;
    tZGU16 moveLen = 0;
    tZGU8 buf[2];
    tRxTxPreamble gPreBuf;


    gPreBuf.type    = kZGMACTypeDataReq;
    gPreBuf.subType = kZGMSGDataStd;

    /* do--->while(0) loop */
    do
    {
        /* now we can access the buffer using ZGRawSetByte */
        /* write the pre-buffer */
        if(ZGRawSetByte(kTxPipeRAW, &(gPreBuf.type), kZGMsgPreambleLen - 1) == 0)
        {
            /* failure */
            break;
        }

        /* this code sets up the application specific request id field */
        /* we aren't currently using it in the driver */
        buf[0] = 1;
        buf[1] = 0;
        /* write the buffer */
        if(ZGRawSetByte(kTxPipeRAW, buf, 2) == 0)
        {
            /* failure */
            break;
        }

        /* Instruct ZG chip to transmit the packet data in the raw window */
        moveLen = ZGRawMove(kTxPipeRAW, kZGRawSrcDestCmdProcessor, false, bufLen);

        /* success as there is no way to determine if the last ZGRawMove failed */
        res = true;
    } while(0);

    /* handle failure condition performing any necessary cleaunup */
    if(res == false)
    {
        /* release the reserved memory on the ZG chip */
		/* The compiler may warn that moveLen is being used here uninitialized.
		   This is a benign warning.  moveLen is a don't care in the ZGRawMove()
		   function when releasing memory. */
        ZGRawMove(kTxPipeRAW, kZGRawSrcDestDataPool, false, moveLen);
    }

    return res;
}


/*****************************************************************************
 * FUNCTION: ZGMACIFService
 *
 * RETURNS: Number of bytes in the Data Rx packet if one is received, else 0.
 *
 * PARAMS:
 *  None
 *
 *  NOTES: Called by MACGetHeader() to see if any data packets have been received.
 *         If the G2100 has received a data packet and the data packet is not
 *         a management data packet, then this function returns the number of
 *         bytes in the data packet. Otherwise it returns 0.
 *****************************************************************************/
tZGU16 ZGMACIFService(tZGVoidInput)
{
    tZGU16 byteCount = 0; /* num bytes returned */
    tRxTxPreamble gPreBuf;


    // if no rx data packet to process or not yet finished with mgmt rx processing
    if (!gHostRAWDataPacketReceived)
    {
        return byteCount;
    }
    // else interrupt has signalled that a data packet received by G2100
    // and needs to be handled by RAW manager
    else
    {
        gHostRAWDataPacketReceived = false; // clear flag for next data packet
    }

    // made it here if RAW rx data packet to handle


    /* host is providing a buffer to read data from the chip
     * the module (this function) should check the data before
     * deciding to forward it up.  Only data frames should get
     * forwarded. */

    /* Mount Read FIFO to RAW Rx window.  Allows use of RAW engine to read rx data packet. */
    /* Function call returns number of bytes in the data packet.                           */
    byteCount = ZGRawMove(kRxPipeRAW, kZGRawSrcDestCmdProcessor, true, 0);

    // now that buffer mounted it is safe to reenable interrupts
    zgHALEintEnable();

    /* If the byteCount is 0, something bad happened. */
    if(byteCount == 0u )
    {
   //     putrsUART("z\r\n");
        goto errorExit_ZGMACIFService;
    }

    // read the first two bytes of the Rx packet
    if((tZGU8)(ZGRawGetByte(kRxPipeRAW, (tZGU8*)&(gPreBuf.type), 2u)) == 0u)
    {
        /* failure */
      //  putrsUART("g\r\n");
        byteCount = 0;
        goto errorExit_ZGMACIFService;
    }

    // If the packet is a data packet (which it should be)
    if (gPreBuf.type == kZGMACTypeRxDataIndicate)
    {
        // if the packet is too small
        if(byteCount < 10u)
        {
            byteCount = 0;
            // Uart_Printf("tiny %d\n", numBytesExpected);
     //       putrsUART("<\r\n");

            goto errorExit_ZGMACIFService;;
        }
    }
    // else packet is not a rx data packet
    else
    {
        byteCount = 0;
  //      putrsUART("i\r\n");
        goto errorExit_ZGMACIFService;;
    }

errorExit_ZGMACIFService:

    /******************/
    /* packet cleanup */
    /******************/
    // map for uchip

    // if anything went wrong
    if ( byteCount == 0u )
    {
        /* unmount the raw to free up receive packet and the RAW engine */
        ZGRawMove(kRxPipeRAW, kZGRawSrcDestDataPool, false, 0);
    }

    return byteCount;
}

#else
// dummy func to keep compiler happy when module has no executeable code
void ZGDriverRaw_EmptyFunc(void)
{
}
#endif /* ZG_CS_TRIS */


/* EOF */
