/*******************************************************************************

 File:
        ZGDriverMac.c

 Description:
        Zero G Driver MAC layer C file.

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

#include "TCPIP Stack/TCPIP.h"
#include "TCPIP Stack/ZGDriverPrv.h"

// macros to determine number of bytes needed in array
#define kNumBytes  (kZGMSGAdhocStart / 8)
#if ((kZGMSGLastMessage % 8) > 0)
    #define kNumBytesDisableMgmtBitMap  (kNumBytes + 1)
#else
    #define kNumBytesDisableMgmtBitMap  (kNumBytes)
#endif

static tZGU8 DisableMgmtMsgBitMap[kNumBytesDisableMgmtBitMap];


/* gblDriverContext represents the one and only global variable for the
 * Zero_G Reference Driver.  This variable should be used
 * only within ZGDriverMac.c, ZGDriverCom.c and ZGDriverIFace.c */
tZGDriverContext gblDriverContext;
/* MACROS for managing access to the COM layer */
#define ZGCOM_IS_IDLE() (MACCXT.bComIdle)
#define ZGCOM_SET_BUSY() (MACCXT.bComIdle = kZGBoolFalse)
#define ZGCOM_CLEAR_BUSY() (MACCXT.bComIdle = kZGBoolTrue)

static tZGVoidReturn ZGPrvMacOpCompleteWrite(tZGVoidInput);
static tZGVoidReturn ZGPrvMacOpCompleteRead(tZGVoidInput);
static tZGVoidReturn SetDisableMgmtMsgType(tZGU8 msgType, tZGBool action);
static tZGBool GetDisableMgmtMsgType(tZGU8 mgmtMsgType);

/*****************************************************************************
 * FUNCTION: ZGPrvMacInit
 *
 * RETURNS: N/A
 *
 * PARAMS:
 *
 *
 *  NOTES: Used to initialize the MAC layer.  Takes as input a boolean that
 *      can be used to configure the priority of data write operations vs.
 *      long read operations.  Not very critical for most applications.
 *****************************************************************************/
tZGVoidReturn ZGPrvMacInit(tZGVoidInput)
{
    MACCXT.bMgmtRxMsgReady     = kZGBoolFalse;
    MACCXT.bMgmtTxMsgReady = kZGBoolFalse;
    MACCXT.bDataTrafficEnabled = kZGBoolFalse;
    MACCXT.bComIdle = kZGBoolTrue;
    MACCXT.pendingMgmtConfirm = 0;

    RWCXT.len = 0;
    RWCXT.dir = 0;

    // first, initialize all msg types to false
    memset(DisableMgmtMsgBitMap, 0x00, sizeof(DisableMgmtMsgBitMap));
    // now set those that should be true (those mgmt msgs that should disable data msgs until mgmt response received)
    SetDisableMgmtMsgType(kZGMSGSetPwrMode, kZGBoolTrue);
    SetDisableMgmtMsgType(kZGMSGPMKKey,     kZGBoolTrue);
    SetDisableMgmtMsgType(kZGMSGWEPMap,     kZGBoolTrue);
    SetDisableMgmtMsgType(kZGMSGWEPKey,     kZGBoolTrue);
    SetDisableMgmtMsgType(kZGMSGTempKey,    kZGBoolTrue);
    SetDisableMgmtMsgType(kZGMSGWEPKeyID,   kZGBoolTrue);
    SetDisableMgmtMsgType(kZGMSGGetParam,   kZGBoolTrue);

    ZGPrvComInit();
    /* set these after initializing COM just as a precaution
     * in a multi-threaded environment */
    MACCXT.bMgmtTxMsgReady = kZGBoolTrue;
    MACCXT.bDataTrafficEnabled = kZGBoolTrue;

}

static tZGVoidReturn SetDisableMgmtMsgType(tZGU8 msgType, tZGBool action)
{
    tZGU8 byteIndex;
    tZGU8 bitMask;

    byteIndex = (msgType - 1) / 8;
    bitMask = 0x01 << ((msgType - 1) % 8);

    if (action == kZGBoolTrue)
    {
        DisableMgmtMsgBitMap[byteIndex] |= bitMask;
    }
    else
    {
        DisableMgmtMsgBitMap[byteIndex] &= ~bitMask;
    }
}

static tZGBool GetDisableMgmtMsgType(tZGU8 mgmtMsgType)
{
    tZGU8 byteIndex;
    tZGU8 bitMask;

    byteIndex = (mgmtMsgType - 1) / 8;
    bitMask = 0x01 << ((mgmtMsgType - 1) % 8);

    if ((DisableMgmtMsgBitMap[byteIndex] & bitMask) > 0u)
    {
        return kZGBoolTrue;
    }
    else
    {
        return kZGBoolFalse;
    }

}


/*****************************************************************************
 * FUNCTION: ZGProcess
 *
 * RETURNS: None
 *
 * PARAMS:
 *          None
 *
 *  NOTES: Called by the application code whenever it is able to provide a
 *          thread of execution to the Zero G Driver. The Application may
 *          also call this function to get Driver State information and to
 *          learn if there is data available to be processed.
 *****************************************************************************/
tZGVoidReturn ZGProcess(tZGVoidInput)
{
    tZGSignal sig = kZGSignalExit;

    while((sig = ZGSYS_SIGNAL_WAIT()) != kZGSignalExit)
    {
        /* if there is a message on the internal queue AND
         * the COMStateMachine is not currently busy THEN
         * Pop the next
         * message from the internal queue and send to
         * the COMStateMachine */
        if( ZGCOM_IS_IDLE() == kZGBoolTrue )
        {
            /* if the ZG chip has a mgmt msg then read it */
            if(MACCXT.bMgmtRxMsgReady == kZGBoolTrue)
            {
                RWCXT.dir = kZGDirRead;
                ZGPrvComFifoOperation();
                ZGCOM_SET_BUSY();
                MACCXT.bMgmtRxMsgReady = kZGBoolFalse;
                break;
            }

            /* if the chip is ready to send a management msg then send it */
            if (MACCXT.bMgmtTxMsgReady == kZGBoolTrue)
            {
                ZGPrvComFifoOperation();
                ZGCOM_SET_BUSY();
                MACCXT.bMgmtTxMsgReady = kZGBoolFalse;
                /* some mgmt requests will require that data traffic get disabled while the
                 * the request is processed. Data traffic is re-enabled when the management confirm is received. */
                MACCXT.bDataTrafficEnabled = GetDisableMgmtMsgType(MACCXT.pendingMgmtConfirm);

                if(ZGCOM_IS_IDLE() == 0u)
                    break;
            }
        }
        /* allow the xport layer to run */
        ZGPrvComStateMachine();
    }
}

/*****************************************************************************
 * FUNCTION: ZGPrvMacOpComplete
 *
 * RETURNS: N/A
 *
 * PARAMS:
 *
 *
 *  NOTES: Used by the COM layer to report to the MAC layer that the last
 *      fifo operation completed.  The read-write context is read-only by
 *      the COM layer so the MAC layer can use it to determine the
 *      details of the operation that completed. The function also clears
 *      the flag that indicates whether a fifo operation is in progress.
 *      If the operation was a write operation then the message is cleaned
 *      using the appropriate macro for management or data messages. if
 *      the operation was a read operation then the function calls
 *      the appropriate macro to forward it out of the driver.
 *****************************************************************************/
tZGVoidReturn ZGPrvMacOpComplete(tZGVoidInput)
{
    //tZGU8Ptr pBuf;
    //tZGU16 numChunks;
    //tZGU16 len;

    ZGCOM_CLEAR_BUSY();

    if(RWCXT.dir == kZGDirWrite)
    {
        ZGPrvMacOpCompleteWrite();
    }
    else/* kZGRead */
    {
        ZGPrvMacOpCompleteRead();
    }
}


static tZGVoidReturn ZGPrvMacOpCompleteWrite(tZGVoidInput)
{
    //tZGU8Ptr pBuf;
    //tZGU16 numChunks;
    //tZGU16 len;
    tZGU8  msgType;

    msgType = kZGMACTypeMgmtReq;  // if RAW mode only management writes invoke calls to this function
}


static tZGVoidReturn ZGPrvMacOpCompleteRead(tZGVoidInput)
{
    tZGU8 msgType;
    tZGU8 mgmtConfirmType;
    tZGU8 mgmtIndicateType;
    static tZGU8 buf[4];

    /* read msg type from received msg (index 0 of msg) */
    ZGRawSetIndex(kRxPipeRAW, 0);
    ZGRawGetByte(kRxPipeRAW, &msgType, 1);

    /* long read */
    switch(msgType)
    {
        case kZGMACTypeMgmtConfirm:
            // get mgmt type (in second byte, index 1, of 4 byte header)
            ZGRawSetIndex(kRxPipeRAW, 1);
            ZGRawGetByte(kRxPipeRAW, &mgmtConfirmType, 1);

            if(MACCXT.pendingMgmtConfirm == mgmtConfirmType)
            {
                MACCXT.bDataTrafficEnabled = kZGBoolTrue;

                ZGAPP_HANDLE_MGMTCONFIRM(mgmtConfirmType);
            }
            else
            {
                /* error unexpected management confirm from hardware */
                ZGSYS_DRIVER_ASSERT(4, (ROM char *)"Unexpected Mgmt Confirm.\n");
            }
            break;

        case kZGMACTypeMgmtIndicate:
            /* read the msg subtype (index 1) for the management indicate */
            ZGRawSetIndex(kRxPipeRAW, 1);
            ZGRawGetByte(kRxPipeRAW, &mgmtIndicateType, 1);
            ZGAPP_HANDLE_MGMTINDICATE(mgmtIndicateType);
            break;


        default:

            ZGRawSetIndex(kRxPipeRAW, 0);
            ZGRawGetByte(kRxPipeRAW, buf, 4);

            ZGSYS_DRIVER_ASSERT(2, (ROM char*)"Invalid read type.\n");



            while(1);
            break;

    }
}


/*****************************************************************************
 * FUNCTION: ZGPrvMacReadReady
 *
 * RETURNS: N/A
 *
 * PARAMS:
 *      tZGU16 len - the number of bytes that are ready to be read as a
 *          single message.
 *
 *
 *  NOTES: Used by the COM layer to report to the MAC layer that there is
 *      a Message to be read from the G2100. This function sets the
 *      appropriate read flag as dictated by the length. Short reads can
 *      be accommadated by the internal MAC buffer while long reads require
 *      a buffer from the system.
 *****************************************************************************/
tZGVoidReturn ZGPrvMacReadReady(tZGVoidInput)
{
    MACCXT.bMgmtRxMsgReady = kZGBoolTrue;
}


#else
// dummy func to keep compiler happy when module has no executeable code
void ZGDriverMac_EmptyFunc(void)
{
}
#endif /* ZG_CS_TRIS */
/* EOF */
