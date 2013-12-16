/*********************************************************************
 *
 *  Medium Access Control (MAC) Layer for Microchip ZG2100
 *  Module for Microchip TCP/IP Stack
 *   -Provides access to ZG2100 WiFi controller
 *   -Reference: ZG2100 Data sheet, IEEE 802.11 Standard
 *
 *********************************************************************
 * FileName:        ZG2100.c
 * Dependencies:    ZG2100.h
 *                  TCPIP.h
 * Processor:       PIC18, PIC24F, PIC24H, dsPIC30F, dsPIC33F
 * Compiler:        Microchip C18 v3.02 or higher
 *                  Microchip C30 v2.01 or higher
 * Company:         ZeroG Wireless, Inc.
 *
 * Software License Agreement

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

 * Copyright © 2002-2007 ZeroG Wireless Inc.  All rights
 * reserved.
 *
 * ZeroG licenses to you the right to use, modify, copy,
 * distribute, and port the Software driver source files ZG2100.c
 * and ZG2100.h when used in conjunction with the ZeroG ZG2100 for
 * the sole purpose of interfacing with the ZeroG ZG2100.
 *
 * You should refer to the license agreement accompanying this
 * Software for additional information regarding your rights and
 * obligations.
 *
 * THE SOFTWARE AND DOCUMENTATION ARE PROVIDED “AS IS” WITHOUT
 * WARRANTY OF ANY KIND, EITHER EXPRESS OR IMPLIED, INCLUDING WITHOUT
 * LIMITATION, ANY WARRANTY OF MERCHANTABILITY, FITNESS FOR A
 * PARTICULAR PURPOSE, TITLE AND NON-INFRINGEMENT. IN NO EVENT SHALL
 * MICROCHIP BE LIABLE FOR ANY INCIDENTAL, SPECIAL, INDIRECT OR
 * CONSEQUENTIAL DAMAGES, LOST PROFITS OR LOST DATA, COST OF
 * PROCUREMENT OF SUBSTITUTE GOODS, TECHNOLOGY OR SERVICES, ANY CLAIMS
 * BY THIRD PARTIES (INCLUDING BUT NOT LIMITED TO ANY DEFENSE
 * THEREOF), ANY CLAIMS FOR INDEMNITY OR CONTRIBUTION, OR OTHER
 * SIMILAR COSTS, WHETHER ASSERTED ON THE BASIS OF CONTRACT, TORT
 * (INCLUDING NEGLIGENCE), BREACH OF WARRANTY, OR OTHERWISE.

Author               Date           Comment
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Michael Palladino   10/13/07    Original
KO                  31 Oct 2008 Port to PIC24F and PIC32 for TCP/IP stack v4.52
KH                  19 Jun 2009 Modified MACMemCopyAsync to support TCB to TCB copy
********************************************************************/

#include "HardwareProfile.h"

#if defined(ZG_CS_TRIS)


#define __ZG2100_C

#include "TCPIP Stack/TCPIP.h"
#include "TCPIP Stack/ZGDriverPrv.h"

//============================================================================
//                                  Include Files
//============================================================================
#include "TCPIP Stack/ZG2100.h"
#include "TCPIP Stack/ZGDriverAccessSys.h"

#if defined (ZG_CONFIG_LINKMGRII)
#include "TCPIP Stack/ZGLinkMgrII.h"
#endif

//============================================================================
//                                  Defines
//============================================================================
#define kSnap       (0xaau)
#define kSnapCtrl   (0x03u)
#define kSnapType   (0x00u)

#define ETHER_IP    (0x00u)
#define ETHER_ARP   (0x06u)

#if defined( __PIC32MX__ )   
    #define IPL_MASK  ((tZGU32)0x3f << 10)
#endif

//============================================================================
//                                  Preamble Constants and structures
//============================================================================
// A header appended at the start of all RX frames by the hardware
typedef struct _ENC_PREAMBLE
{
    WORD            NextPacketPointer;
    RXSTATUS        StatusVector;
    MAC_ADDR        DestMACAddr;
    MAC_ADDR        SourceMACAddr;
    WORD_VAL        Type;
} ENC_PREAMBLE;

#define kENCPreambleSize    (sizeof(ENC_PREAMBLE))
#define kZGRxPreambleOffset (10)

typedef struct
{
    MAC_ADDR        SourceMACAddr;
    tZGU8           reserved[6];
    tZGU8           snap[6];
    WORD_VAL        Type;
} tZGRxPreamble;

#define kZGRxPreambleSize   (sizeof(tZGRxPreamble))
#define kZGTxPreambleOffset (0)

typedef struct
{
    tZGU8           reserved[4];
} tZGTxPreamble;

#define kZGTxPreambleSize   (sizeof(tZGTxPreamble))


//============================================================================
//                                  Rx/Tx Buffer Constants
// Used to correlate former Ethernet packets to ZG2100 packets.
//============================================================================
#define kZGENCRxBufferToRxBufferAdjustment          ((RXSTART+kENCPreambleSize)-(kZGRxPreambleOffset+kZGRxPreambleSize))
#define kZGENCTxBufferToTxBufferAdjustment          ((TXSTART+kZGTxPreambleSize)-(kZGTxPreambleOffset+kZGTxPreambleSize))
#define kZGENCTCBBufferToScratchBufferAdjustment    (BASE_TCB_ADDR)

//============================================================================
//                                  RAW Constants
//============================================================================
#define kENCRdPtrId (0u)
#define kENCWrPtrId (1u)

#define kZGRxBufferRAWId    ((tZGU8)(kZGRawId0))
#define kZGTxBufferRAWId    ((tZGU8)(kZGRawId1))
#define kZGInvalidRAWId     (0xff)

#define kZGRAWUnmounted             (0u)
#define kZGRAWScratchMounted        (1u)
#define kZGRAWDataBufMounted        (2u)
#define kZGRAWMgmtBufMounted        (3u)

//============================================================================
//                          Internal MAC level variables and flags.
//============================================================================
#define kZGSnapSize (6)
static ROM BYTE snap[kZGSnapSize] = {kSnap, kSnap, kSnapCtrl, kSnapType, kSnapType, kSnapType};
static BOOL WasDiscarded;
static tZGU8 encPtrRAWId[2];
static tZGU16 encPtr[2];           // index 0 stores current ENC read index, index 1 stores current ENC write index
tZGU8 zgBufferRAWState[2];
static Boolean zgBufferReady[2];   // for Tx and Rx, true = ready for use, false = not ready for use
static tZGU16 zgRxBufferSize;
static tZGU16 zgTxPacketLength;
static Boolean zgTxBufferFlushed;
static Boolean RawMgmtRxInProgress = kZGBoolFalse;
static Boolean RawMgmtAppWaiting = kZGBoolFalse;
static tZGU16  SizeofScratchMemory = 0;


//============================================================================
//                          Internal Function Prototypes
//============================================================================
static Boolean CreateTxBuffer(tZGU16 srcDest);
static tZGBool isMgmtTxBufAvailable(tZGVoidInput);

extern tZGVoidReturn ChangeLowPowerMode(tZGBool bEnable);
tZGBool gRxIndexSetBeyondBuffer;        // debug -- remove after test



/* retry constant & calibration variables for SyncENCPtrRAWState */
#define MAX_CREATE_TXBUF_RETRY  10000u

#if 0 
tZGU16 highWaterMark = 0;
#endif

/*****************************************************************************
 * FUNCTION: SyncENCPtrRAWState
 *
 * RETURNS: None
 *
 * PARAMS:
 *          encPtrId -- identifies if doing an access to an rx, tx, or tcb buffer
 *
 *  NOTES: Any time stack code changes the index within the 'logical' Ethernet RAM
 *         this function must be called to assure the RAW driver is synced up with
 *         where the stack code thinks it is within the Ethernet RAM.  This applies
 *         to reading/writing tx data, rx data, or tcb data
 *****************************************************************************/
static void SyncENCPtrRAWState(tZGU8 encPtrId)
{
    tZGU8 rawId;
    tZGU16 index;
    Boolean encPtrCheck;
    tZGU16 byteCount;
    //Boolean res;

    //---------------------------------------------------
    // if encPtr[encPtrId] in the enc rx or enc tx buffer
    //---------------------------------------------------
    if ( encPtr[encPtrId] < BASE_TCB_ADDR )
    {
        //-------------------------------------
        // if encPtr[encPtrId] in enc rx buffer
        //-------------------------------------
        if ( encPtr[encPtrId] < TXSTART )
        {
            // set the rawId
            rawId = kZGRxBufferRAWId;

            // set the index
            index = encPtr[encPtrId] - kZGENCRxBufferToRxBufferAdjustment;

            // encPtr[encPtrId] < (RXSTART + kENCPreambleSize) is an error since we don't have
            // the same preamble as the ENC chip
            encPtrCheck = !(encPtr[encPtrId] < (RXSTART + kENCPreambleSize));
        }
        //---------------------------------------
        // else encPtr[encPtrId] in enc tx buffer
        //---------------------------------------
        else
        {
          
            if ( !zgBufferReady[kZGTxBufferRAWId] )
            {
                tZGU16 retryCounter = 0;
       
                /* Retry until G2100 has drained it's prior TX pkts -  multiple sockets & flows can load the G2100 */
                /* The CreateTxBuffer call may not succeed immediately.   However, there is a maximum retry count */
                /* before a fatal error is assumed.    The max retry count was calibrated, by taking 100x the highest */
                /* measured valued on PIC18 and PIC24, with multiple test runs of web app & ping sessions */  

                while ( !CreateTxBuffer(kZGRawSrcDestDataPool) )
                {

                   #if 0   /* Calibration Method */     
                   if ( retryCounter > highWaterMark )
                     highWaterMark = retryCounter;
                   #endif

                   /* After X number of retry a fatal error is assumed */
                   if ( ++retryCounter > MAX_CREATE_TXBUF_RETRY )
                   {
	                    #if defined(USE_LCD)
                            strcpypgm2ram((char*)LCDText, "Can't create TxB"
                            "Can't create TxB");
                            LCDUpdate();
                        #endif
                      while(1);
                   }

                } 

                zgBufferReady[kZGTxBufferRAWId] = true;
                zgBufferRAWState[kZGTxBufferRAWId] = kZGRAWDataBufMounted;

            }

            // set the rawId
            rawId = kZGTxBufferRAWId;

            // set the index
            index = encPtr[encPtrId] - kZGENCTxBufferToTxBufferAdjustment;

            // encPtr[encPtrId] < BASE_TX_ADDR is an error since we don't have the same
            // pre-BASE_TX_ADDR or post tx buffer as the ENC chip
            encPtrCheck = !((encPtr[encPtrId] < BASE_TX_ADDR) || (encPtr[encPtrId] > (BASE_TX_ADDR + MAX_PACKET_SIZE)));
        }

        //-----------------------------------------------------------------
        // if the buffer is not ready or the encode pointer is out of range
        //-----------------------------------------------------------------
        if ( (!zgBufferReady[rawId]) || (!encPtrCheck) )
        {
            // !zgBufferReady[rawId] is an error because we do not currently have a buffer

            // for the RX buffer this should only be the case before we have received
            // our first data packet

            // for the TX buffer this could only be the case after a macflush()
            // where we couldn't re-mount a new buffer and before a macistxready()
            // that successfully re-mounts a new tx buffer
            #if defined(USE_LCD)
                strcpypgm2ram((char*)LCDText, "Bad encPtr      "
                                              "Bad encPtr      ");
                LCDUpdate();
            #endif
            while(1);
        }

        //------------------------------------------
        // if the ZG buffer is ready but not mounted
        //------------------------------------------
        if ( zgBufferRAWState[rawId] != kZGRAWDataBufMounted )
        {
            // if the buffer is not mounted then it must be restored from Mem
            // a side effect is that if the scratch buffer was mounted in the raw
            // then it will no longer be mounted
            byteCount = ZGRawMove(rawId, kZGRawSrcDestMemory, true, 0);
            if ( byteCount == 0u )
            {
                #if defined(USE_LCD)
                    strcpypgm2ram((char*)LCDText, "BufferMv Failed "
                                                  "BufferMv Failed ");
                    LCDUpdate();
                #endif
                while(1);
            }

           // set the buffer state
           zgBufferRAWState[rawId] = kZGRAWDataBufMounted;

        }
    }
    //-----------------------------------------------
    // else encPtr[encPtrId] is in the enc tcb buffer
    //-----------------------------------------------
    else
    {
        //-----------------------------------------------------------------------------------
        // if the scratch buffer used for the enc tcb is already mounted in the RX buffer raw
        //-----------------------------------------------------------------------------------
        if ( zgBufferRAWState[kZGRxBufferRAWId] == kZGRAWScratchMounted )
        {
            rawId = kZGRxBufferRAWId;
        }
        //-----------------------------------------------------------------------------------
        // if the scratch buffer used for the enc tcb is already mounted in the TX buffer raw
        //-----------------------------------------------------------------------------------
        else if ( zgBufferRAWState[kZGTxBufferRAWId] == kZGRAWScratchMounted )
        {
            rawId = kZGTxBufferRAWId;
        }
        //--------------------------------------------------------------
        // else Scratch buffer used for enc tcb is not currently mounted
        //--------------------------------------------------------------
        else
        {
            if ( (encPtrRAWId[1u - encPtrId]) == kZGRxBufferRAWId )
            {
                // the other enc pointer is in use in the rx buffer raw
                // so use the tx buffer raw to mount the scratch buffer

                // set the rawId
                rawId = kZGTxBufferRAWId;
            }
            else
            {
                // the other enc pointer is in use in the tx buffer raw or invalid
                // so use the rx buffer raw to mount the scratch buffer

                // set the rawId
                rawId = kZGRxBufferRAWId;
            }

            // if we currently have a buffer mounted then we need to save it
            if ( zgBufferRAWState[rawId] == kZGRAWDataBufMounted )
            {
                ZGRawMove(rawId, kZGRawSrcDestMemory, false, 0);
            }

            // mount the scratch window in the selected raw
            byteCount = ZGRawMove(rawId, kZGRawSrcDestScratchPool, true, 0);
            if ( byteCount == 0u )
            {
                #if defined(USE_LCD)
                    strcpypgm2ram((char*)LCDText, "ScrtchMv Failed "
                                                  "ScrtchMv Failed ");
                    LCDUpdate();
                #endif
                while(1);
            }

            // set the buffer state
            zgBufferRAWState[rawId] = kZGRAWScratchMounted;
        }

        // set the index
        index = encPtr[encPtrId] - kZGENCTCBBufferToScratchBufferAdjustment;
    }

    // set RAW pointer
    if ( !ZGRawSetIndex(rawId, index) )
    {
        if ( rawId == 0u )
        {
            gRxIndexSetBeyondBuffer = true;
        }
    }
    else
    {
        if ( rawId == 0u )
        {
            gRxIndexSetBeyondBuffer = false;
        }
    }

    // for now, only dump message

    // if we fail the set index we should...
    // use a case statement to determine the object that is mounted (rawId==0, could be rxbuffer object or scratch object)
    // (rawId==1, could be txbuffer or scratch object
    // dismount the object in the appropriate manner (rxbuffer ... save operation, txbuffer save operation, scratch save operation)
    // set the index to 0
    // mark the zgBufferRAWState[rawId] = kZGRAWUnmounted
    // mark the encPtrRAWId[encPtrId] = kZGInvalidRAWId


    // set the encPtrRAWId
    encPtrRAWId[encPtrId] = rawId;

    // if the opposite encPtr was pointing to the raw window
    // that was re-configured by this routine then it is
    // no longer in sync
    if ( encPtrRAWId[1-encPtrId] == encPtrRAWId[encPtrId] )
    {
        encPtrRAWId[1-encPtrId] = kZGInvalidRAWId;
    }
}

/*****************************************************************************
 * FUNCTION: MACProcess
 *
 * RETURNS: None
 *
 * PARAMS:
 *          None
 *
 *  NOTES: Called form main loop to support ZG 802.11 operations
 *****************************************************************************/
void MACProcess(void)
{
    // Let ZeroG 802.11 processes have a chance to run
    ZGProcess();

    /* SG. Deadlock avoidance code when two applications contend for the one tx pipe                              */
    /* ApplicationA is a data plane application, and applicationB is a control plane application                  */
    /* In this scenario, the data plane application could be the WiFi manager, and the control plane application  */
    /* a sockets application.  If the sockets application keeps doing a IsUDPPutReady() and never follows with    */
    /* a UDPFlush, then the link manager will be locked out.   This would be catescrophic if an AP connection     */
    /* goes down, then the link manager could never re-establish connection.  Why?  The link manager is a control */
    /* plane application, which does mgmt request/confirms.                                                       */
    /*                                                                                              */
    /* Sequence of events:                                                                          */
    /* T0: ApplicationA will issue a call like UDPIsPutReady(), which results in a CreateTxBuffer() */
    /* T1: ApplicationB attempts a mgmt request with IsTxMbmtReady() call.  The call fails.         */
    /* T3: Stack process runs and does not deallocate the tx pipe from the data plane application.  */
    /* T4: ApplicationB attempts N+1th time, and fails.                                             */
    if ( RawMgmtAppWaiting )
    {

       if ( zgBufferRAWState[kZGTxBufferRAWId] == kZGRAWDataBufMounted )
       {
          /* deallocate the RAW on G2100 - return memory to pool */
          ZGRawMove(kZGTxBufferRAWId, kZGRawSrcDestDataPool, false, 0);

          /* Unmount the window - a host driver state */
          zgBufferReady[kZGTxBufferRAWId] = false;
          zgBufferRAWState[kZGTxBufferRAWId] = kZGRAWUnmounted;

          if ( encPtrRAWId[kENCRdPtrId] == kZGTxBufferRAWId )
          {
            encPtrRAWId[kENCRdPtrId] = kZGInvalidRAWId;
          }

          if ( encPtrRAWId[kENCWrPtrId] == kZGTxBufferRAWId )
          {
           encPtrRAWId[kENCWrPtrId] = kZGInvalidRAWId;
          }
       }

       /* This else is important in that it gives the main loop one iteration for the mgmt application to get it's timeslice  */
       /* Otherwise, a data plane task could snatch away the tx pipe again, especially if it's placed before                  */
       /* the link manager in the main()'s while(1) blk.  This code is functionally coupled with ZGisRawRxMgmtInProgress()    */
       /* as it will keep the dataplane application locked out for 1 iteration, until this else is executed on N+2 iteration    */
       else
         RawMgmtAppWaiting = kZGBoolFalse;

    }

}

 /******************************************************************************
 * Function:        tZGU16 ZGGetTCBSize(ZGZVoidInput)
 *
 * PreCondition:    None
 *
 * Input:           None
 *
 * Output:          Number of bytes in the TCB
 *
 * Side Effects:    None
 *
 * Overview:        Returns number of bytes available in TCP Control Block (TCB) so
 *                  higher-layer code can determine if the number of bytes available
 *                  can support the structures designated to be stored in the TCB.
 *
 * Note:            When running with ZeroG the TCB is contained in the Scratch Memory
 *                  on the ZG2100.
 *****************************************************************************/
tZGU16 ZGGetTCBSize(void)
{
    return SizeofScratchMemory;
}

 /******************************************************************************
 * Function:        void MACInit(void)
 *
 * PreCondition:    None
 *
 * Input:           None
 *
 * Output:          None
 *
 * Side Effects:    None
 *
 * Overview:        MACInit sets up the PIC's SPI module and all the
 *                  registers in the ZG2100 so that normal operation can
 *                  begin.
 *
 * Note:            None
 *****************************************************************************/
void MACInit(void)
{
    //tZGU16 scratchSize;
    ZGInit();

    // By default (on latest B2 firmware) Scratch is mounted to RAW 1 after reset.  In order to mount it on RAW0
    // we need to first unmount it from RAW 1.
    ZGRawMove(kZGTxBufferRAWId, kZGRawSrcDestScratchPool, false, 0);

    // mount scratch temporarily to see how many bytes it has, then unmount it
    SizeofScratchMemory = ZGRawMove(0, kZGRawSrcDestScratchPool, true, 0);
    ZGRawMove(0, kZGRawSrcDestScratchPool, false, 0);


    zgBufferRAWState[kZGRxBufferRAWId] = kZGRAWUnmounted;
    zgBufferReady[kZGRxBufferRAWId] = false;

    encPtrRAWId[kENCRdPtrId] = kZGRxBufferRAWId;
    encPtr[kENCRdPtrId] = BASE_TCB_ADDR;

    // don't mount tx raw at init because it's needed for raw mgmt messages
    zgBufferReady[kZGTxBufferRAWId] = false;
    zgBufferRAWState[kZGTxBufferRAWId] = kZGRAWUnmounted;
    encPtrRAWId[kENCWrPtrId] = kZGInvalidRAWId;

    encPtr[kENCWrPtrId] = BASE_TX_ADDR;                         // set tx encode ptr (index) to start of tx buf + 4 bytes

    WasDiscarded = TRUE;                                        // set state such that last rx packet was discarded
    zgRxBufferSize = 0;                                         // current rx buffer length (none) is 0 bytes
    zgTxPacketLength = 0;                                       // current tx packet length (none) is 0 bytes
    zgTxBufferFlushed = true;                                   // tx buffer is flushed

    // from ENC MAC init
    // encWrPtr is left pointing to BASE_TX_ADDR
    // encRdPtr is not initialized... we leave it pointing to BASE_TCB_ADDR

    gRxIndexSetBeyondBuffer = false;

}//end MACInit




/******************************************************************************
 * Function:        BOOL MACIsLinked(void)
 *
 * PreCondition:    None
 *
 * Input:           None
 *
 * Output:          TRUE: If the PHY reports that a link partner is present
 *                        and the link has been up continuously since the last
 *                        call to MACIsLinked()
 *                  FALSE: If the PHY reports no link partner, or the link went
 *                         down momentarily since the last call to MACIsLinked()
 *
 * Side Effects:    None
 *
 * Overview:        Returns the PHSTAT1.LLSTAT bit.
 *
 * Note:            None
 *****************************************************************************/
BOOL MACIsLinked(void)
{
    BOOL result = FALSE;

#if defined (ZG_CONFIG_LINKMGRII)
    result = ZGLinkMgrIsConnected();
#endif

    return result;
}


/******************************************************************************
 * Function:        BOOL MACIsTxReady(void)
 *
 * PreCondition:    None
 *
 * Input:           None
 *
 * Output:          TRUE: If no Ethernet transmission is in progress
 *                  FALSE: If a previous transmission was started, and it has
 *                         not completed yet.  While FALSE, the data in the
 *                         transmit buffer and the TXST/TXND pointers must not
 *                         be changed.
 *
 * Side Effects:    None
 *
 * Overview:        Returns the ECON1.TXRTS bit
 *
 * Note:            None
 *****************************************************************************/
BOOL MACIsTxReady(void)
{
    BOOL result = TRUE;
    //tZGU16 byteCount;

    /* if waiting for a management response then block data tx until */
    /* mgmt response received                                        */
    if (ZGisRawRxMgmtInProgress())
    {
        ZGProcess();   // allow mgmt message to be received (stack can call this
                       // function in an infinite loop so need to allow ZeroG state
                       // machines to run.
        return FALSE;
    }
    
    if ( !zgBufferReady[kZGTxBufferRAWId] )
    {
        zgBufferRAWState[kZGTxBufferRAWId] = kZGRAWUnmounted;

        if ( encPtrRAWId[kENCRdPtrId] == kZGTxBufferRAWId )
        {
            encPtrRAWId[kENCRdPtrId] = kZGInvalidRAWId;
        }

        if ( encPtrRAWId[kENCWrPtrId] == kZGTxBufferRAWId )
        {
            encPtrRAWId[kENCWrPtrId] = kZGInvalidRAWId;
        }

        /* if the chip is in low power mode then it must first be
         * brought out of low power before attempting a write
         * operation. */
        if(COMCXT.bLowPowerModeActive)
        {
            ChangeLowPowerMode(kZGBoolFalse);
        }

        // create the new tx buffer
        if ( CreateTxBuffer(kZGRawSrcDestDataPool) )
        {
            zgBufferReady[kZGTxBufferRAWId] = true;
            zgBufferRAWState[kZGTxBufferRAWId] = kZGRAWDataBufMounted;
        }
        else
        {
            result = FALSE;
        }
    }

    return result;
}

// determines if a RAW Tx buf is ready for a management msg, and if so, creates the RAW tx buffer.
// Returns true if successful, else false.
tZGBool ZGisTxMgmtReady(tZGVoidInput)
{
    BOOL res = kZGBoolTrue;

    if (isMgmtTxBufAvailable())
    {
        // create and mount tx buffer to hold RAW Mgmt packet
        if (CreateTxBuffer(kZGRawSrcDestManagementPool))
        {
            // set tx raw buffer as in use
            zgBufferReady[kZGTxBufferRAWId] = true;
            zgBufferRAWState[kZGTxBufferRAWId] = kZGRAWMgmtBufMounted;
            res = kZGBoolTrue;

            /* Bug. This flag must be set otherwise the data path does not know */
            /* that the tx pipe has been mounted for mgmt operation.  SG */
            ZGSetRawRxMgmtInProgress(kZGBoolTrue);
        }
        else
        {
            res = kZGBoolFalse;
        }
    }
    // else Tx RAW not available for Mgmt packet
    else
    {
        res = kZGBoolFalse;

        /* See comment in MACProcess */
        RawMgmtAppWaiting = kZGBoolTrue;
    }

    return res;
}


tZGVoidReturn ZGFreeMgmtTx(tZGVoidInput)
{
    zgBufferReady[kZGTxBufferRAWId] = false;
    zgBufferRAWState[kZGTxBufferRAWId] = kZGRAWUnmounted;
}

static tZGBool isMgmtTxBufAvailable(tZGVoidInput)
{
    // if the Tx RAW buf is not being used for a data packet or scratch, then it
    // is available for a Mgmt packet.
    if ((zgBufferReady[kZGTxBufferRAWId] == false)                   &&
        (zgBufferRAWState[kZGTxBufferRAWId] == kZGRAWUnmounted))
    {
        return kZGBoolTrue;
    }
    else
    {
        return kZGBoolFalse;
    }
}

Boolean ZGSendRAWManagementFrame(tZGU16 bufLen)
{
    tZGU16 moveLen = 0;

    /* Instruct ZG chip to transmit the packet data in the raw window */
    moveLen = ZGRawMove(kTxPipeRAW, kZGRawSrcDestCmdProcessor, false, bufLen);

    /* let tx buffer be reused (for either data or management tx) */
    ZGFreeMgmtTx();

    return true;
}




// returns true if able to acquire the RAW Rx window for the purpose
// of processing a management receive message

Boolean ZGRawGetMgmtRxBuffer(tZGU16 *p_numBytes)
{
    tZGBool res = kZGBoolTrue;
   // tZGU16  numBytes;
    *p_numBytes = 0;

    // if Raw Rx is not currently mounted, or the Scratch is mounted
    if (zgBufferRAWState[kZGRxBufferRAWId] == kZGRAWDataBufMounted)
    {
        // save it
        ZGRawMove(0, kZGRawSrcDestMemory, kZGBoolFalse, 0);
    }

    // mount the mgmt pool rx data, returns number of bytes in mgmt msg.  Index
    // defaults to 0.
    *p_numBytes = ZGRawMove(0, kZGRawSrcDestCmdProcessor, kZGBoolTrue, 0);
    if (*p_numBytes == 0u)
    {
        #if defined(USE_LCD)
            strcpypgm2ram((char*)LCDText, "Can't read Mgmt "
                                          "Can't read Mgmt ");
            LCDUpdate();
        #endif
        while(1);
    }

    // set flag so we do not try to mount an incoming data packet until after the rx Mgmt msg
    // has been handled.
    ZGSetRawRxMgmtInProgress(kZGBoolTrue);


    return res;
}

tZGVoidReturn ZGSetRawRxMgmtInProgress(Boolean action)
{
    if (action == (Boolean)kZGBoolFalse)
    {
//        zgBufferReady[kZGRxBufferRAWId] = true;
        zgBufferRAWState[kZGRxBufferRAWId] = kZGRAWUnmounted;
    }

    RawMgmtRxInProgress = action;
}

Boolean ZGisRawRxMgmtInProgress(tZGVoidInput)
{
#if 0
     /* See comment in MACProcess */
     return ( RawMgmtRxInProgress || RawMgmtAppWaiting );    // ken debug -- original code
#endif     

     return RawMgmtRxInProgress;        // ken debug -- experiment
}


/******************************************************************************
 * Function:        void MACDiscardRx(void)
 *
 * PreCondition:    None
 *
 * Input:           None
 *
 * Output:          None
 *
 * Side Effects:    None
 *
 * Overview:        Marks the last received packet (obtained using
 *                  MACGetHeader())as being processed and frees the buffer
 *                  memory associated with it
 *
 * Note:            It is safe to call this function multiple times between
 *                  MACGetHeader() calls.  Extra packets won't be thrown away
 *                  until MACGetHeader() makes it available.
 *****************************************************************************/
void MACDiscardRx(void)
{
    WasDiscarded = TRUE;
}


/******************************************************************************
 * Function:        WORD MACGetFreeRxSize(void)
 *
 * PreCondition:    None
 *
 * Input:           None
 *
 * Output:          A WORD estimate of how much RX buffer space is free at
 *                  the present time.
 *
 * Side Effects:    None
 *
 * Overview:        None
 *
 * Note:            None
 *****************************************************************************/
WORD MACGetFreeRxSize(void)
{
    WORD size;

    if ( WasDiscarded )
    {
        size = RXSIZE - 1;
    }
    else
    {
        if ( (RXSTOP - RXSTART) > zgRxBufferSize )
        {
            size = (RXSTOP - RXSTART) - zgRxBufferSize;
        }
        else
        {
            size = 0;
        }
    }

    return size;
}

/******************************************************************************
 * Function:        BOOL MACGetHeader(MAC_ADDR *remote, BYTE* type)
 *
 * PreCondition:    None
 *
 * Input:           *remote: Location to store the Source MAC address of the
 *                           received frame.
 *                  *type: Location of a BYTE to store the constant
 *                         MAC_UNKNOWN, ETHER_IP, or ETHER_ARP, representing
 *                         the contents of the Ethernet type field.
 *
 * Output:          TRUE: If a packet was waiting in the RX buffer.  The
 *                        remote, and type values are updated.
 *                  FALSE: If a packet was not pending.  remote and type are
 *                         not changed.
 *
 * Side Effects:    Last packet is discarded if MACDiscardRx() hasn't already
 *                  been called.
 *
 * Overview:        None
 *
 * Note:            None
 *****************************************************************************/
BOOL MACGetHeader(MAC_ADDR *remote, BYTE* type)
{
    tZGU16 len;
    tZGRxPreamble header;
#if defined(__18CXX)    	
    BYTE GIESave;
#elif defined(__C30__)
    tZGU8 curIPL;
#elif defined( __PIC32MX__ )   
    tZGU32 statusReg;
#endif    
    //tZGU8 i;

    gRxIndexSetBeyondBuffer = false;

    // if we currently have a rx buffer mounted then we need to save it
    if ( zgBufferRAWState[kZGRxBufferRAWId] == kZGRAWDataBufMounted )
    {
        // unmount RAW window and save its state
        ZGRawMove(kZGRxBufferRAWId, kZGRawSrcDestMemory, false, 0);
    }

    // RAW 0 is now unmounted (and available)
    zgBufferRAWState[kZGRxBufferRAWId] = kZGRAWUnmounted;

    if ( encPtrRAWId[kENCRdPtrId] == kZGRxBufferRAWId )
    {
        encPtrRAWId[kENCRdPtrId] = kZGInvalidRAWId;
    }

    if ( encPtrRAWId[kENCWrPtrId] == kZGRxBufferRAWId )
    {
        encPtrRAWId[kENCWrPtrId] = kZGInvalidRAWId;
    }

#if defined (__18CXX)
  	GIESave = INTCON & 0xC0;		// Save GIEH and GIEL bits
	INTCON &= 0x3F;					// Clear INTCONbits.GIEH and INTCONbits.GIEL
#elif defined(__C30__)
    curIPL     = SRbits.IPL;  // save current state of IPL field
	SRbits.IPL = 7;	          // Disable all user interrupts
#elif defined( __PIC32MX__ )
    statusReg = _CP0_GET_STATUS();         // save current state of IPL field        
	_CP0_SET_STATUS(statusReg | IPL_MASK); // Disable all user interrupts
#else
    #error Unknown device type
#endif

    len = ZGMACIFService();

#if defined (__18CXX)
	INTCON |= GIESave;				// Restore GIEH and GIEL value
#elif defined(__C30__)
	SRbits.IPL = curIPL;	// Restore interrupts
#elif defined( __PIC32MX__ )
    _CP0_SET_STATUS(statusReg & ~IPL_MASK);  // Restore interrupts
#else
    #error Unknown device type
#endif
    if ( len == 0u )
    {
        return FALSE;
    }

    // set RAW pointer to ZG Preamble
    if ( !ZGRawSetIndex(kZGRxBufferRAWId, kZGRxPreambleOffset) )
    {
        // got here if failed to set index (unmount and release RAW resource)
        ZGRawMove(kZGRxBufferRAWId, kZGRawSrcDestDataPool, false, 0);
        return FALSE;
    }

    // read the ZG Preamble bytes
    if ( !ZGRawGetByte(kZGRxBufferRAWId, (tZGU8 *)&header, kZGRxPreambleSize) )
    {
        // got here if preamble read failed (unmount and release RAW resource)
        ZGRawMove(kZGRxBufferRAWId, kZGRawSrcDestDataPool, false, 0);

        return FALSE;
    }

    // check the SNAP header
    /* as a sanity check verify that the expected bytes contain the SNAP header */
    if (!(header.snap[0] == kSnap && header.snap[1] == kSnap &&
          header.snap[2] == kSnapCtrl &&
          header.snap[3] == kSnapType && header.snap[4] == kSnapType && header.snap[5] == kSnapType) )
    {
        // after header bytes read, MOVE RAW0->DataPool [frees memory used in read operation]
        ZGRawMove(kZGRxBufferRAWId, kZGRawSrcDestDataPool, false, 0);
        return FALSE;
    }

    // Make absolutely certain that any previous packet was discarded
    WasDiscarded = TRUE;

    // we can flush any saved rx buffers now by saving and restoring the current rx buffer
    ZGRawMove(kZGRxBufferRAWId, kZGRawSrcDestMemory, false, 0); // MOVE RAW0->Mem
    ZGRawMove(kZGRxBufferRAWId, kZGRawSrcDestMemory, true,  0); // MOVE Mem->RAW0

    // set RAW pointer to 802.11 payload
    if ( !ZGRawSetIndex(kZGRxBufferRAWId, (kZGRxPreambleOffset+kZGRxPreambleSize)) )
    {
        #if defined(USE_LCD)
            strcpypgm2ram((char*)LCDText, "Set Index failed"
                                          "Set Index failed");
            LCDUpdate();
        #endif
        return false;
    }

    zgRxBufferSize = len;
    zgBufferReady[kZGRxBufferRAWId] = true;
    zgBufferRAWState[kZGRxBufferRAWId] = kZGRAWDataBufMounted;
    encPtrRAWId[kENCRdPtrId] = kZGRxBufferRAWId;
    encPtr[kENCRdPtrId] = RXSTART + sizeof(ENC_PREAMBLE);

    // The EtherType field, like most items transmitted on the Ethernet medium
    // are in big endian.
    header.Type.Val = swaps(header.Type.Val);

    // Return the Ethernet frame's Source MAC address field to the caller
    // This parameter is useful for replying to requests without requiring an
    // ARP cycle.
    memcpy((void*)remote->v, (void*)header.SourceMACAddr.v, sizeof(*remote));

    // Return a simplified version of the EtherType field to the caller
    *type = MAC_UNKNOWN;
    if( (header.Type.v[1] == 0x08u) &&
        ((header.Type.v[0] == ETHER_IP) || (header.Type.v[0] == ETHER_ARP)) )
    {
        *type = header.Type.v[0];
    }

    // Mark this packet as discardable
    WasDiscarded = FALSE;

    return TRUE;
}


/******************************************************************************
 * Function:        void MACPutHeader(MAC_ADDR *remote, BYTE type, WORD dataLen)
 *
 * PreCondition:    MACIsTxReady() must return TRUE.
 *
 * Input:           *remote: Pointer to memory which contains the destination
 *                           MAC address (6 bytes)
 *                  type: The constant ETHER_ARP or ETHER_IP, defining which
 *                        value to write into the Ethernet header's type field.
 *                  dataLen: Length of the Ethernet data payload
 *
 * Output:          None
 *
 * Side Effects:    None
 *
 * Overview:        None
 *
 * Note:            Because of the dataLen parameter, it is probably
 *                  advantagous to call this function immediately before
 *                  transmitting a packet rather than initially when the
 *                  packet is first created.  The order in which the packet
 *                  is constructed (header first or data first) is not
 *                  important.
 *****************************************************************************/
void MACPutHeader(MAC_ADDR *remote, BYTE type, WORD dataLen)
{
    zgTxBufferFlushed = false;
    zgTxPacketLength = dataLen + (WORD)sizeof(ETHER_HEADER) + kZGTxPreambleSize;

    // Set the SPI write pointer to the beginning of the transmit buffer (post kZGTxPreambleSize)
    encPtr[kENCWrPtrId] = TXSTART + kZGTxPreambleSize;
    SyncENCPtrRAWState(kENCWrPtrId);

    // Set the per-packet control byte and write the Ethernet destination
    // address
    MACPutArray((BYTE*)remote, sizeof(*remote));

    // Write our MAC address in the Ethernet source field
    MACPutROMArray(snap, kZGSnapSize);

    // Write the appropriate Ethernet Type WORD for the protocol being used
    MACPut(0x08);
    MACPut((type == MAC_IP) ? ETHER_IP : ETHER_ARP);
}


/******************************************************************************
 * Function:        void MACFlush(void)
 *
 * PreCondition:    A packet has been created by calling MACPut() and
 *                  MACPutHeader().
 *
 * Input:           None
 *
 * Output:          None
 *
 * Side Effects:    None
 *
 * Overview:        MACFlush causes the current TX packet to be sent out on
 *                  the Ethernet medium.  The hardware MAC will take control
 *                  and handle CRC generation, collision retransmission and
 *                  other details.
 *
 * Note:            After transmission completes (MACIsTxReady() returns TRUE),
 *                  the packet can be modified and transmitted again by calling
 *                  MACFlush() again.  Until MACPutHeader() or MACPut() is
 *                  called (in the TX data area), the data in the TX buffer
 *                  will not be corrupted.
 *****************************************************************************/
void MACFlush(void)
{
    //tZGU16 byteCount;

    // If there is no Tx buffer ready to transmit
    if ( !zgBufferReady[kZGTxBufferRAWId] )
    {
        #if defined(USE_LCD)
            // Error (this function should never be called unless there is a tx packet to send)
            strcpypgm2ram((char*)LCDText, "txbuffer not rdy"
                                          "txbuffer not rdy");
            LCDUpdate();
        #endif
        while(1);
    }

    // If the Tx buffer has been flushed
    if ( zgTxBufferFlushed )
    {
        #if defined(USE_LCD)
            // this captures the case where a tx buffer is reused
            // we can't do this
            strcpypgm2ram((char*)LCDText, "txbuffer is gone"
                                          "txbuffer is gone");
            LCDUpdate();
        #endif
        while(1);
    }

    zgTxBufferFlushed = true;

    // If the RAW engine not yet mounted
    if ( zgBufferRAWState[kZGTxBufferRAWId] != kZGRAWDataBufMounted )
    {
        // Pop it off Mem and mount it
        ZGRawMove(kZGTxBufferRAWId, kZGRawSrcDestMemory, true, 0);
    }
    // else RAW engine already mounted
    else
    {
        // set the RAW index to start of Tx buffer
        ZGRawSetIndex(kZGTxBufferRAWId, 0);
    }

    // at this point the txbuffer should be mounted and ready to go

    if ( zgTxPacketLength !=  0u )
    {
        if ( ZGSendRAWDataFrame(zgTxPacketLength) == false )
        {
            #if defined(USE_LCD)
                // this is a case that we cannot handle
                strcpypgm2ram((char*)LCDText, "DataSend Failed "
                                              "DataSend Failed ");
                LCDUpdate();
            #endif
            while(1);
        }
    }
    else
    {
        #if defined(USE_LCD)
            strcpypgm2ram((char*)LCDText, "Tx = 0"
                                          "Tx = 0");
            LCDUpdate();
        #endif
        return;
    }



    // make sure to de-sync any affected pointers
    zgBufferReady[kZGTxBufferRAWId] = false;
    zgBufferRAWState[kZGTxBufferRAWId] = kZGRAWUnmounted;

    if ( encPtrRAWId[kENCRdPtrId] == kZGTxBufferRAWId )
    {
        encPtrRAWId[kENCRdPtrId] = kZGInvalidRAWId;
    }

    if ( encPtrRAWId[kENCWrPtrId] == kZGTxBufferRAWId )
    {
        encPtrRAWId[kENCWrPtrId] = kZGInvalidRAWId;
    }
}

static Boolean CreateTxBuffer(tZGU16 srcDest)
{
    //tZGU8 buffer[2];
    tZGU16 bufAvail;
    tZGU16 byteCount;
    tZGU16 bytesNeeded;

    if (srcDest == kZGRawSrcDestDataPool)
    {
        bytesNeeded = (4ul+MAX_PACKET_SIZE+4ul);
    }        
    else
    {
        bytesNeeded = kLibMgrCxtBufLen;
    }    

    // get number of bytes available in RAW tx buffer (LS 12 bits)
    bufAvail = Read16BitZGRegister(kZGCOMRegWrtFifo0ByteCnt) & 0x0fff;

    if ( bufAvail >= bytesNeeded )
    {
        // create the new tx buffer
        byteCount = ZGRawMove(kZGTxBufferRAWId, srcDest, true, bytesNeeded);
        if ( byteCount == 0u )
        {
#if 0
            #if defined(USE_LCD)
                // this is a case that should never happen
                strcpypgm2ram((char*)LCDText, "DPoolMv Failed  "
                                              "DPoolMv Failed  ");
                LCDUpdate();
            #endif
            while(1);
#else
            return false;
#endif
        }
    }
    else
    {
        return false;

    }

    return true;
}

/******************************************************************************
 * Function:        void MACSetReadPtrInRx(WORD offset)
 *
 * PreCondition:    A packet has been obtained by calling MACGetHeader() and
 *                  getting a TRUE result.
 *
 * Input:           offset: WORD specifying how many bytes beyond the Ethernet
 *                          header's type field to relocate the SPI read
 *                          pointer.
 *
 * Output:          None
 *
 * Side Effects:    None
 *
 * Overview:        SPI read pointer are updated.  All calls to
 *                  MACGet() and MACGetArray() will use these new values.
 *
 * Note:            RXSTOP must be statically defined as being > RXSTART for
 *                  this function to work correctly.  In other words, do not
 *                  define an RX buffer which spans the 0x1FFF->0x0000 memory
 *                  boundary.
 *****************************************************************************/
void MACSetReadPtrInRx(WORD offset)
{
    encPtr[kENCRdPtrId] = RXSTART + sizeof(ENC_PREAMBLE) + offset;
    SyncENCPtrRAWState(kENCRdPtrId);
}


/******************************************************************************
 * Function:        WORD MACSetWritePtr(WORD Address)
 *
 * PreCondition:    None
 *
 * Input:           Address: Address to seek to
 *
 * Output:          WORD: Old EWRPT location
 *
 * Side Effects:    None
 *
 * Overview:        SPI write pointer is updated.  All calls to
 *                  MACPut() and MACPutArray() will use this new value.
 *
 * Note:            None
 *****************************************************************************/
WORD MACSetWritePtr(WORD address)
{
    WORD oldVal;

    oldVal = encPtr[kENCWrPtrId];

    encPtr[kENCWrPtrId] = address;

    SyncENCPtrRAWState(kENCWrPtrId);

    return oldVal;
}

/******************************************************************************
 * Function:        WORD MACSetReadPtr(WORD Address)
 *
 * PreCondition:    None
 *
 * Input:           Address: Address to seek to
 *
 * Output:          WORD: Old ERDPT value
 *
 * Side Effects:    None
 *
 * Overview:        SPI write pointer is updated.  All calls to
 *                  MACPut() and MACPutArray() will use this new value.
 *
 * Note:            None
 *****************************************************************************/
WORD MACSetReadPtr(WORD address)
{
    WORD oldVal;

    oldVal = encPtr[kENCRdPtrId];

    encPtr[kENCRdPtrId] = address;
    SyncENCPtrRAWState(kENCRdPtrId);

    return oldVal;
}


/******************************************************************************
 * Function:        WORD MACCalcRxChecksum(WORD offset, WORD len)
 *
 * PreCondition:    None
 *
 * Input:           offset  - Number of bytes beyond the beginning of the
 *                          Ethernet data (first byte after the type field)
 *                          where the checksum should begin
 *                  len     - Total number of bytes to include in the checksum
 *
 * Output:          16-bit checksum as defined by RFC 793.
 *
 * Side Effects:    None
 *
 * Overview:        This function performs a checksum calculation in the MAC
 *                  buffer itself
 *
 * Note:            None
 *****************************************************************************/
WORD MACCalcRxChecksum(WORD offset, WORD len)
{
    WORD temp;
    tZGU16 rdSave;

    // Add the offset requested by firmware plus the Ethernet header
    temp = RXSTART + sizeof(ENC_PREAMBLE) + offset;

    rdSave = encPtr[kENCRdPtrId];

    encPtr[kENCRdPtrId] = temp;
    SyncENCPtrRAWState(kENCRdPtrId);

    temp = CalcIPBufferChecksum(len);

    encPtr[kENCRdPtrId] = rdSave;
    SyncENCPtrRAWState(kENCRdPtrId);

    return temp;
}


/******************************************************************************
 * Function:        void MACMemCopyAsync(WORD destAddr, WORD sourceAddr, WORD len)
 *
 * PreCondition:    SPI bus must be initialized (done in MACInit()).
 *
 * Input:           destAddr:   Destination address in the Ethernet memory to
 *                              copy to.  If the MSb is set, the current EWRPT
 *                              value will be used instead.
 *                  sourceAddr: Source address to read from.  If the MSb is
 *                              set, the current ERDPT value will be used
 *                              instead.
 *                  len:        Number of bytes to copy
 *
 * Output:          Byte read from the ZG2100's RAM
 *
 * Side Effects:    None
 *
 * Overview:        Bytes are asynchrnously transfered within the buffer.  Call
 *                  MACIsMemCopyDone() to see when the transfer is complete.
 *
 * Note:            If a prior transfer is already in progress prior to
 *                  calling this function, this function will block until it
 *                  can start this transfer.
 *
 *                  If a negative value is used for the sourceAddr or destAddr
 *                  parameters, then that pointer will get updated with the
 *                  next address after the read or write.
 *****************************************************************************/
void MACMemCopyAsync(WORD destAddr, WORD sourceAddr, WORD len)
{
    tZGU16 readSave = 0, writeSave = 0;
    Boolean updateWritePointer;
    Boolean updateReadPointer;
    tZGU8 rawScratchId;
    tZGU8 copyBuf[8];
    tZGU16 writeIndex, readIndex;
    tZGU16 bytesLeft;
    tZGU16 origRawIndex;

    if( ((WORD_VAL*)&destAddr)->bits.b15 )
    {
        updateWritePointer = TRUE;
        destAddr = encPtr[kENCWrPtrId];
        if ( encPtrRAWId[kENCWrPtrId] == kZGInvalidRAWId )
        {
            SyncENCPtrRAWState(kENCWrPtrId);
        }
    }
    else
    {
        updateWritePointer = FALSE;
        writeSave = encPtr[kENCWrPtrId];
        encPtr[kENCWrPtrId] = destAddr;
        SyncENCPtrRAWState(kENCWrPtrId);
    }

    if( ((WORD_VAL*)&sourceAddr)->bits.b15 )
    {
        updateReadPointer = TRUE;
        sourceAddr = encPtr[kENCRdPtrId];
        if ( encPtrRAWId[kENCRdPtrId] == kZGInvalidRAWId )
        {
            SyncENCPtrRAWState(kENCRdPtrId);
        }
    }
    else
    {
        updateReadPointer = FALSE;
        readSave = encPtr[kENCRdPtrId];
        encPtr[kENCRdPtrId] = sourceAddr;
        SyncENCPtrRAWState(kENCRdPtrId);
    }
    
    // if copying bytes from TCB to TCB
    // This is a special case because we cannot do a RAW copy within the same RAW window
    // but we can easily copy Scratch data from one section of Scratch to another section of Scratch.
    if ( (len > 0u) && (destAddr >= BASE_TCB_ADDR) && (sourceAddr >= BASE_TCB_ADDR) )
    {
        bytesLeft = len;
        
        // if Raw Rx window mounted to scratch
        if (zgBufferRAWState[kZGRxBufferRAWId] == kZGRAWScratchMounted)
        {
            rawScratchId = kZGRxBufferRAWId;
        }
        // else if Raw Tx window mounted to scratch
        else if (zgBufferRAWState[kZGTxBufferRAWId] == kZGRAWScratchMounted)   
        {
            rawScratchId = kZGTxBufferRAWId;
        }
        else
        {
            #if defined(USE_LCD)
                // this is a case that we cannot handle
                strcpypgm2ram((char*)LCDText, "No Scratch      "
                                              "No Scratch      ");
                LCDUpdate();
            #endif
            
            // should never happen
            while (1);
        }         
        
        // save the current RAW index in this scratch window
        origRawIndex = ZGRawGetIndex(rawScratchId);
        
        // If TCB src block does not overlap TCB dest block, or if destAddr > sourceAddr.
        // We can do a forward copy.
        if ( ((sourceAddr + len) <= destAddr) ||    // end of source before dest  (no overlap)
             ((destAddr + len) <= sourceAddr) ||    // end of dest before source  (no overlap)
              (destAddr < sourceAddr)               // dest before source (overlap)              
           )
        {
            // map read index from TCB address to Scratch Index
            readIndex  = sourceAddr - kZGENCTCBBufferToScratchBufferAdjustment;
            writeIndex = destAddr - kZGENCTCBBufferToScratchBufferAdjustment;
            
            while (bytesLeft > 0u)
            {
                // if a full copyBuf worth of bytes to copy
                if (bytesLeft >= sizeof(copyBuf))
                {
                    // set raw index in source memory
                    ZGRawSetIndex(rawScratchId, readIndex);
                    
                    // read a block of bytes from source
                    ZGRawGetByte(rawScratchId, copyBuf, sizeof(copyBuf));
                    
                    // set raw index in dest memory
                    ZGRawSetIndex(rawScratchId, writeIndex);
                    
                    // write block of bytes to dest
                    ZGRawSetByte(rawScratchId, copyBuf, sizeof(copyBuf));
                    
                    // index to next block in source and dest
                    readIndex  += sizeof(copyBuf);
                    writeIndex += sizeof(copyBuf);
                    bytesLeft  -= sizeof(copyBuf);
                }
                // else less than a full copyBuf left to copy
                else
                {
                    if (bytesLeft > 0u)
                    {
                        ZGRawSetIndex(rawScratchId, readIndex);
                        ZGRawGetByte(rawScratchId, copyBuf, bytesLeft);
                        ZGRawSetIndex(rawScratchId, writeIndex);
                        ZGRawSetByte(rawScratchId, copyBuf, bytesLeft);
                        bytesLeft = 0;
                    }    
                }        
            }    
        } // end while
        // else start of TCB dest block within TCB src block --> destAddr > sourcAddr
        // Do a backward copy.
        else if (destAddr > sourceAddr)
        {
            // map read index from TCB address to Scratch Index
            readIndex  = sourceAddr - kZGENCTCBBufferToScratchBufferAdjustment + len - 1;
            writeIndex = destAddr - kZGENCTCBBufferToScratchBufferAdjustment + len - 1;
            
            while (bytesLeft > 0u)
            {
                // if a full copyBuf worth of bytes to copy
                if (bytesLeft >= sizeof(copyBuf))
                {
                    // set raw index in source memory
                    ZGRawSetIndex(rawScratchId, readIndex - sizeof(copyBuf) + 1);
                    
                    // read a block of bytes from source
                    ZGRawGetByte(rawScratchId, copyBuf, sizeof(copyBuf));
                    
                    // set raw index in dest memory
                    ZGRawSetIndex(rawScratchId, writeIndex - sizeof(copyBuf) + 1);
                    
                    // write block of bytes to dest
                    ZGRawSetByte(rawScratchId, copyBuf, sizeof(copyBuf));
                    
                    // index to next block in source and dest
                    readIndex  -= sizeof(copyBuf);
                    writeIndex -= sizeof(copyBuf);
                    bytesLeft  -= sizeof(copyBuf);
                }
                // else less than a full copyBuf left to copy
                else
                {
                    if (bytesLeft > 0u)
                    {
                        ZGRawSetIndex(rawScratchId, readIndex - bytesLeft + 1);
                        ZGRawGetByte(rawScratchId, copyBuf, bytesLeft - 1);
                        ZGRawSetIndex(rawScratchId, writeIndex - bytesLeft + 1);
                        ZGRawSetByte(rawScratchId, copyBuf, bytesLeft - 1);
                        bytesLeft = 0;
                    }    
                }        
            } // end while    
        }    
        // restore raw index to where it was when this function was called
        ZGRawSetIndex(rawScratchId, origRawIndex); 

    } 
    // else if not copying from TCB to TCB and there is at least one byte to copy
    else if ( len > 0u )
    {
        // Check if app is trying to copy data within same RAW window (can't do that)
        if ( (encPtrRAWId[kENCRdPtrId] == kZGInvalidRAWId) ||
             (encPtrRAWId[kENCWrPtrId] == kZGInvalidRAWId) )
        {
            #if defined(USE_LCD)
                // this is a case that we cannot handle
                strcpypgm2ram((char*)LCDText, "encRdPtrRAWId = "
                                              "encWrPtrRAWId   ");
                LCDUpdate();
            #endif
            //while(1);
//            ++g_FuncCount;
            return;
        }

        ZGRawMove(encPtrRAWId[kENCWrPtrId], kZGRawSrcDestRawDataCopy, true, len);
    }

    if ( !updateReadPointer )
    {
        encPtr[kENCRdPtrId] = readSave;
        SyncENCPtrRAWState(kENCRdPtrId);
    }

    if ( !updateWritePointer )
    {
        encPtr[kENCWrPtrId] = writeSave;
        SyncENCPtrRAWState(kENCWrPtrId);
    }
}


BOOL MACIsMemCopyDone(void)
{
    return TRUE;
}


/******************************************************************************
 * Function:        BYTE MACGet()
 *
 * PreCondition:    SPI bus must be initialized (done in MACInit()).
 *                  ERDPT must point to the place to read from.
 *
 * Input:           None
 *
 * Output:          Byte read from the ZG2100's RAM
 *
 * Side Effects:    None
 *
 * Overview:        MACGet returns the byte pointed to by ERDPT and
 *                  increments ERDPT so MACGet() can be called again.  The
 *                  increment will follow the receive buffer wrapping boundary.
 *
 * Note:            None
 *****************************************************************************/
BYTE MACGet()
{
    BYTE result;

    if ( encPtrRAWId[kENCRdPtrId] == kZGInvalidRAWId )
    {
        SyncENCPtrRAWState(kENCRdPtrId);
    }

    ZGRawGetByte(encPtrRAWId[kENCRdPtrId], &result, 1);

    encPtr[kENCRdPtrId] += 1;

    return result;
}//end MACGet


/******************************************************************************
 * Function:        WORD MACGetArray(BYTE *val, WORD len)
 *
 * PreCondition:    SPI bus must be initialized (done in MACInit()).
 *                  ERDPT must point to the place to read from.
 *
 * Input:           *val: Pointer to storage location
 *                  len:  Number of bytes to read from the data buffer.
 *
 * Output:          Byte(s) of data read from the data buffer.
 *
 * Side Effects:    None
 *
 * Overview:        Burst reads several sequential bytes from the data buffer
 *                  and places them into local memory.  With SPI burst support,
 *                  it performs much faster than multiple MACGet() calls.
 *                  ERDPT is incremented after each byte, following the same
 *                  rules as MACGet().
 *
 * Note:            None
 *****************************************************************************/
WORD MACGetArray(BYTE *val, WORD len)
{
    WORD i = 0;
    tZGU8 byte;

    if ( encPtrRAWId[kENCRdPtrId] == kZGInvalidRAWId )
    {
        SyncENCPtrRAWState(kENCRdPtrId);
    }

    if ( val )
    {
        ZGRawGetByte(encPtrRAWId[kENCRdPtrId], val, len);
    }
    else
    {
        // Read the data
        while(i<len)
        {
            ZGRawGetByte(encPtrRAWId[kENCRdPtrId], &byte, 1);
            i++;
        }
    }
    encPtr[kENCRdPtrId] += len;

    return len;
}//end MACGetArray


/******************************************************************************
 * Function:        void MACPut(BYTE val)
 *
 * PreCondition:    SPI bus must be initialized (done in MACInit()).
 *                  EWRPT must point to the location to begin writing.
 *
 * Input:           Byte to write into the ZG2100 buffer memory
 *
 * Output:          None
 *
 * Side Effects:    None
 *
 * Overview:        MACPut outputs the Write Buffer Memory opcode/constant
 *                  (8 bits) and data to write (8 bits) over the SPI.
 *                  EWRPT is incremented after the write.
 *
 * Note:            None
 *****************************************************************************/
void MACPut(BYTE val)
{
    tZGU8 byte = val;

    if ( encPtrRAWId[kENCWrPtrId] == kZGInvalidRAWId )
    {
        SyncENCPtrRAWState(kENCWrPtrId);
    }

    ZGRawSetByte(encPtrRAWId[kENCWrPtrId], &byte, 1);

    encPtr[kENCWrPtrId] += 1;
}//end MACPut


/******************************************************************************
 * Function:        void MACPutArray(BYTE *val, WORD len)
 *
 * PreCondition:    SPI bus must be initialized (done in MACInit()).
 *                  EWRPT must point to the location to begin writing.
 *
 * Input:           *val: Pointer to source of bytes to copy.
 *                  len:  Number of bytes to write to the data buffer.
 *
 * Output:          None
 *
 * Side Effects:    None
 *
 * Overview:        MACPutArray writes several sequential bytes to the
 *                  ZG2100 RAM.  It performs faster than multiple MACPut()
 *                  calls.  EWRPT is incremented by len.
 *
 * Note:            None
 *****************************************************************************/
void MACPutArray(BYTE *val, WORD len)
{
    if ( encPtrRAWId[kENCWrPtrId] == kZGInvalidRAWId )
    {
        SyncENCPtrRAWState(kENCWrPtrId);
    }

    ZGRawSetByte(encPtrRAWId[kENCWrPtrId], val, len);

    encPtr[kENCWrPtrId] += len;
}//end MACPutArray


/******************************************************************************
 * Function:        void MACPutROMArray(ROM BYTE *val, WORD len)
 *
 * PreCondition:    SPI bus must be initialized (done in MACInit()).
 *                  EWRPT must point to the location to begin writing.
 *
 * Input:           *val: Pointer to source of bytes to copy.
 *                  len:  Number of bytes to write to the data buffer.
 *
 * Output:          None
 *
 * Side Effects:    None
 *
 * Overview:        MACPutArray writes several sequential bytes to the
 *                  ZG2100 RAM.  It performs faster than multiple MACPut()
 *                  calls.  EWRPT is incremented by len.
 *
 * Note:            None
 *****************************************************************************/
#if defined(__18CXX)
void MACPutROMArray(ROM BYTE *val, WORD len)
{
    if ( encPtr[kENCWrPtrId] == kZGInvalidRAWId )
    {
        SyncENCPtrRAWState(kENCWrPtrId);
    }

    ZGRawSetByteROM(encPtrRAWId[kENCWrPtrId], val, len);

    encPtr[kENCWrPtrId] += len;
}//end MACPutROMArray
#endif


/******************************************************************************
 * Function:        void MACPowerDown(void)
 *
 * PreCondition:    SPI bus must be initialized (done in MACInit()).
 *
 * Input:           None
 *
 * Output:          None
 *
 * Side Effects:    None
 *
 * Overview:        MACPowerDown puts the ZG2100 in low power sleep mode. In
 *                  sleep mode, no packets can be transmitted or received.
 *                  All MAC and PHY registers should not be accessed.
 *
 * Note:            If a packet is being transmitted while this function is
 *                  called, this function will block until it is it complete.
 *                  If anything is being received, it will be completed.
 *****************************************************************************/
void MACPowerDown(void)
{
}//end MACPowerDown


/******************************************************************************
 * Function:        void MACPowerUp(void)
 *
 * PreCondition:    SPI bus must be initialized (done in MACInit()).
 *
 * Input:           None
 *
 * Output:          None
 *
 * Side Effects:    None
 *
 * Overview:        MACPowerUp returns the ZG2100 back to normal operation
 *                  after a previous call to MACPowerDown().  Calling this
 *                  function when already powered up will have no effect.
 *
 * Note:            If a link partner is present, it will take 10s of
 *                  milliseconds before a new link will be established after
 *                  waking up.  While not linked, packets which are
 *                  transmitted will most likely be lost.  MACIsLinked() can
 *                  be called to determine if a link is established.
 *****************************************************************************/
void MACPowerUp(void)
{
}//end MACPowerUp


tZGReturnStatus
ZGRawSendUntamperedData(tZGU8 *pReq, tZGU16 len)
{
	tZGReturnStatus status = kZGFailure;
	tZGU8 preambleBuf[2];
	tZGU16 byteCount;

	if ( zgBufferRAWState[kZGTxBufferRAWId] == kZGRAWDataBufMounted )
	{
		// putsUART("RAW window already mounted \r\n");

		// RAW window kZGTxBufferRAWId is in use by IP Stack or Link Manager.
		// Do not proceed. Wait for the next turn ...

		return status;
	}

	// RAW memory alloc
	byteCount = ZGRawMove(kZGTxBufferRAWId, kZGRawSrcDestDataPool, true, len);

	if (byteCount <= len)
	{
		// Failed to allocate enough RAW space.
		// Release whatever has been allocated.
		ZGRawMove(kZGTxBufferRAWId, kZGRawSrcDestDataPool, false, 0);

#if 0
		while(1);
#endif

		return status;
	}

	/* fill out 2 byte preamble of request message */
	preambleBuf[0] = kZGMACTypeDataReq;     // indicate this is a data msg
	preambleBuf[1] = kZGMSGDataUntampered;  //

	// set raw index to index 0 in mgmt tx msg
	ZGRawSetIndex(kTxPipeRAW, 0);

	// write out preamble to raw tx mgmt msg
	ZGRawSetByte(kTxPipeRAW, preambleBuf, sizeof(preambleBuf));

	// write out payload
	ZGRawSetByte(kTxPipeRAW, (tZGU8 *) pReq, len);

	// Instruct ZG chip to transmit the packet data in the raw window
	byteCount = ZGRawMove(kTxPipeRAW, kZGRawSrcDestCmdProcessor, false, len + sizeof(preambleBuf));

	return status;
}

#else
/* dummy func to keep compiler happy when module has no executeable code */
void ZG2100_EmptyFunc(void)
{
    ;
}
#endif /* ZG_CS_TRIS */


