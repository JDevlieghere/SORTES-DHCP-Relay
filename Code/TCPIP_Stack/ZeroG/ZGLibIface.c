/*******************************************************************************

ZeroG Driver File for the Microchip TCP/IP Stack

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

*******************************************************************************/

/*********************************************************************
 *
 * Library shim between driver and applications.  For FIFO Driver, this
 * shim is asynchronous.  For RAW driver, this shim is synchronous.
 *
 *********************************************************************
 * FileName:        ZGLibIface.c
 * Dependencies:    None
 * Company:         ZeroG Wireless, Inc.
 *
 * Software License Agreement
 *
 * Copyright © 2009 ZeroG Wireless Inc.  All rights
 * reserved.
 *
 * ZeroG licenses to you the right to use, modify, copy,
 * distribute, and port the Software driver source files ZGLibIface.c
 * and ZGLibIface.h when used in conjunction with the ZeroG ZG2100 for
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
 * ZEROG BE LIABLE FOR ANY INCIDENTAL, SPECIAL, INDIRECT OR
 * CONSEQUENTIAL DAMAGES, LOST PROFITS OR LOST DATA, COST OF
 * PROCUREMENT OF SUBSTITUTE GOODS, TECHNOLOGY OR SERVICES, ANY CLAIMS
 * BY THIRD PARTIES (INCLUDING BUT NOT LIMITED TO ANY DEFENSE
 * THEREOF), ANY CLAIMS FOR INDEMNITY OR CONTRIBUTION, OR OTHER
 * SIMILAR COSTS, WHETHER ASSERTED ON THE BASIS OF CONTRACT, TORT
 * (INCLUDING NEGLIGENCE), BREACH OF WARRANTY, OR OTHERWISE.
 *
 *
 * Author               Date   		Comment
 *~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 * SG                  12/12/08
********************************************************************/
#include "HardwareProfile.h"

#if defined(ZG_CS_TRIS)

#include <string.h>
#include <stdarg.h>

#include "TCPIP Stack/ZGLibIface.h"
#include "TCPIP Stack/ZGLibCfg.h"
#include "TCPIP Stack/TCPIP.h"

#if defined (ZG_CONFIG_LIBRARY)

#ifdef ZG_RAW_DRIVER

  #if ( ZG_LIB_MGMT_Q_SIZE > 1 )
    #error "RAW MODE ONLY ALLOWS 1 DEEP SYNCHRONOUS ENTRY"
  #endif

  #if defined(__18CXX)
    /* Put the large data structure into a continous section in link script */
    #pragma udata zglib_section
    static tZGLibCall       gLibQ;
    static tZGBool          gPending = kZGBoolFalse;
    #pragma udata
  #else
    static tZGLibCall       gLibQ;
    static tZGBool          gPending = kZGBoolFalse;
  #endif

#else

/* the library queue should match the management queue */
static tZGLibCall       gLibQ[ ZG_LIB_MGMT_Q_SIZE ];
static tZGU8            gHead = 0;
static tZGU8            gTail = 0;
static tZGU8            gConsumed = 0;

#endif

/* the library indicate array has no order round robin priority */
static tZGU8            gIndicateMask[ MASK_INDICATE_SIZE ];

ZG_LIBRARY_DISPATCHER()
ZG_INDICATE_DISPATCHER()
ZG_COMPLETE_DISPATCHER()
ZG_REQUEST_DISPATCHER()
ZG_NEXT_DISPATCHER()


#ifdef ZG_RAW_DRIVER

tZGReturnStatus
ZGLibLoadConfirmBuffer( tZGU8Ptr ptrBuf, tZGU16 length, tZGU16 offset )
{

  /* If no pending transaction return */
  if ( !gPending )
    return kZGFailure;

  /* 2 for SPI preamble & 4 for fourbyte header */
  ZGRawSetIndex(kRxPipeRAW, 6 + offset );

  /* Set the buffer pointer ahead 4 to skip fourbyte header */
  /* which was already loaded */
  ptrBuf += (4 + offset);

  ZGRawGetByte(kRxPipeRAW, ptrBuf, length);

  return kZGSuccess;
}


static tZGReturnStatus
ZGLibQDelete( tZGU8 cfrm_type )
{
  tZGDataPtr cfrm_pBuf;
  tZGU16 cfrm_len;

  /* reuse the request buffer to stuff confirmation results */
  cfrm_pBuf = gLibQ.request;

  cfrm_len = (sizeof( tZGU8 ) * kLibMgrCxtBufLen);
  memset( (void *) cfrm_pBuf, 0, kLibMgrCxtBufLen);

  /* Skip the SPI preamble which is 2 bytes*/
  ZGRawSetIndex(kRxPipeRAW, 2);

  /* Read the 4 byte header */
  ZGRawGetByte(kRxPipeRAW, (tZGU8Ptr) cfrm_pBuf, 4);

  DISPATCH_COMPLETE( gLibQ.completeCallback, cfrm_type, cfrm_pBuf,
                     cfrm_pBuf, cfrm_len, gLibQ.opaquePtr );

  /* The library request/complete is now free */
  gPending = kZGBoolFalse;
  
  /* NOTE:  Added to force an unmount of the RAW window
            Fixes the case where an automatic release of
             the RAW window is not possible */
  ZGRawMove(kRxPipeRAW, kZGRawSrcDestDataPool, false, 0);

  return kZGSuccess;
}

static tZGReturnStatus
ZGLibRAWSendMessage( tZGVoidInput )
{
    tZGReturnStatus retCode = kZGFailure;

    if ( gLibQ.type == kZGMSGGetParam )
    {
        /* ZGRawSetIndex(kTxPipeRAW, kRawSetParamMsgStartIndex); */
        retCode = ZGGetParam( gLibQ.info );
    }
    else if ( gLibQ.type == kZGMSGSetParam )
    {
        ZGRawSetIndex(kTxPipeRAW, kRawSetParamMsgStartIndex);

        if ( gLibQ.reqLen != 0u )
          ZGRawSetByte(kTxPipeRAW, (tZGU8Ptr) gLibQ.request, gLibQ.reqLen);

        retCode = ZGSetParam( gLibQ.info, gLibQ.len );
    }
    else
    {
       ZGRawSetIndex(kTxPipeRAW, 2);

       if ( gLibQ.reqLen != 0u )
         ZGRawSetByte(kTxPipeRAW, (tZGU8Ptr) gLibQ.request, gLibQ.reqLen);

       retCode = SendManagementMsg( gLibQ.len, gLibQ.type,  gLibQ.info );
    }
    return retCode;
}


static  tZGReturnStatus
ZGLibQAdd( tZGU16 mgmt_len, tZGU8 mgmt_type, tZGU8 mgmt_info,
           tDispatchRequest appRequestHandler,
           tDispatchComplete  appCompleteHandler,
           tZGVoidInput *appOpaquePtr)
{

  tZGReturnStatus retCode = kZGFailure;

  /* space available ? */
  if ( gPending  )
  {
      return retCode;
  }

  if ( appCompleteHandler == kNULL )
  {
      ZGSYS_MODULE_ASSERT(1, (ROM FAR char*)"No Completion Handler Provided");
  }

  /* Make sure the RAW windown is ready & mounted */
  if ( !ZGisTxMgmtReady() )
  {
      return retCode;
  }

  gLibQ.completeCallback = appCompleteHandler;
  gLibQ.opaquePtr = appOpaquePtr;
  gLibQ.len = mgmt_len;
  gLibQ.type = mgmt_type;
  gLibQ.info = mgmt_info;
  gLibQ.reqLen = 0;

  /* immediately call the user callback to fill out it's request data structure */
  if ( appRequestHandler != kNULL )
  {
    memset( (void *) &gLibQ.request, 0, kLibMgrCxtBufLen);
    gLibQ.reqLen =  DISPATCH_REQUEST(  appRequestHandler, (void *) &gLibQ.request, (void *) appOpaquePtr );
  }
  else if ( mgmt_type != kZGMSGGetParam )
  {
    ZGSYS_MODULE_ASSERT(1, (ROM FAR char*)"Request Handler Necessary for GetParam");
  }


  /* Must block for the completion - there is only 1 TX RAW pipe, and any dataplane or other ctrl plane  */
  /* application can mess up mgmt this request transaction "in flight" with a new request */
  if ( (retCode = ZGLibRAWSendMessage()) == kZGSuccess )
  {
     gPending = kZGBoolTrue;

     do
     {
       ZGProcess();

            // if received a data rx don't send a mgmt until data processed
            if (gHostRAWDataPacketReceived)
            {
                gHostRAWDataPacketReceived = kZGBoolFalse;
         
                /* Mount Read FIFO to RAW Rx window.  Allows use of RAW engine to read rx data packet. */
                /* Function call returns number of bytes in the data packet.                           */
                ZGRawMove(kRxPipeRAW, kZGRawSrcDestCmdProcessor, true, 0);

                /* unmount the raw to free up receive packet and the RAW engine */
                ZGRawMove(kRxPipeRAW, kZGRawSrcDestDataPool, false, 0);

                // ensure interrupts enabled
                zgHALEintEnable();
      
            }    
        } while ( gPending );
  }

  return retCode;
}


#else /* FIFO DRIVER */

static tZGReturnStatus
ZGLibQDelete( tZGU8 cfrm_type, tZGDataPtr cfrm_fourByteHeader, tZGDataPtr cfrm_pBuf, tZGU16 cfrm_len)
{

  if ( gConsumed == 0 )
    ZGSYS_MODULE_ASSERT(2, "Unknown complete callbackn\r");

  DISPATCH_COMPLETE( gLibQ[gTail].completeCallback, cfrm_type, cfrm_fourByteHeader,
                     cfrm_pBuf, cfrm_len, gLibQ[gTail].opaquePtr );

  gTail++;
  if(gTail >= ZG_LIB_MGMT_Q_SIZE) gTail = 0;
  gConsumed--;

  return kZGSuccess;
}


static  tZGReturnStatus
ZGLibQAdd( tZGU16 mgmt_len, tZGU8 mgmt_type, tZGU8 mgmt_info,
           tDispatchRequest appRequestHandler,
           tDispatchComplete  appCompleteHandler,
           tZGVoidInput *appOpaquePtr)
{

  tZGReturnStatus retCode = kZGFailure;

  /* space available ? */
  if ( gConsumed+1 > ZG_LIB_MGMT_Q_SIZE )
    return retCode;

  if ( appCompleteHandler == kNULL )
    ZGSYS_MODULE_ASSERT(2, "Complete Missing\n\r");

  gLibQ[gHead].completeCallback = appCompleteHandler;
  gLibQ[gHead].opaquePtr = appOpaquePtr;
  gLibQ[gHead].len = mgmt_len;
  gLibQ[gHead].type = mgmt_type;
  gLibQ[gHead].info = mgmt_info;
  gLibQ[gHead].reqLen = 0;

  /* immediately call the user callback to fill out it's request data structure */
  if ( appRequestHandler != kNULL )
    gLibQ[gHead].reqLen = DISPATCH_REQUEST(  appRequestHandler, &gLibQ[gHead].request, appOpaquePtr );
  else if ( mgmt_type != kZGMSGGetParam )
    ZGSYS_MODULE_ASSERT(2, "Request Missing\n\r");

  retCode = SendManagementMsg( gLibQ[gHead].request, gLibQ[gHead].len, gLibQ[gHead].type, gLibQ[gHead].info );

  gHead++;
  if(gHead >= ZG_LIB_MGMT_Q_SIZE) gHead = 0;
  gConsumed++;

  return retCode;
}

#endif /* FIFO DRIVER */


tZGVoidReturn
ZGLibInitialize( tZGVoidInput )
{

#ifdef ZG_RAW_DRIVER
  memset( (void *) &gLibQ, 0, sizeof(tZGLibCall) );

  /* RAW mode is a synchronous call to chip, at the current time */

  /* The RAW mode driver & stack does not expect confirmations for every pkt TX */
  while ( !ZG_SET_DATA_CFRM( kZGBoolFalse ) )
    ZGProcess();

  /* Default is power management disabled for the system */
  while ( !ZG_SET_PWR_MGMT( kZGBoolFalse ) )
    ZGProcess();
#else
  memset( (void *) gLibQ, 0, sizeof(tZGLibCall) * ZG_LIB_MGMT_Q_SIZE );

  ZG_SET_PWR_MGMT( kZGBoolFalse );
#endif

  memset( (void *) gIndicateMask, 0, sizeof(tZGU8) * MASK_INDICATE_SIZE );

#ifdef ZG_CONFIG_DHCP
 ZG_SET_DHCP_STATE(DHCP_ENABLED);
#endif

}


/* These functions are necessary wrappers, if the link manager is compiled with pointers to functions */
/* using a macro will not work, because a function address is needed for the table */

tZGReturnStatus
ZGLibSetDataCfrm(tDispatchRequest appPrepareCallback, tDispatchComplete  appDoneCallback, tZGVoidInput *appOpaquePtr)
{
  return ZGLibQAdd( kZGSetTxDataConfirmLen, kZGMSGSetParam, kZGParamConfirmDataTxReq,
                    appPrepareCallback, appDoneCallback, appOpaquePtr );
}


tZGReturnStatus
ZGLibScan(tDispatchRequest appPrepareCallback, tDispatchComplete  appDoneCallback, tZGVoidInput *appOpaquePtr)
{
   return ZGLibQAdd( kZGScanReqSZ, kZGMSGScan, 0,
                     appPrepareCallback, appDoneCallback, appOpaquePtr );
}


tZGReturnStatus
ZGLibCalcPSK (tDispatchRequest appPrepareCallback, tDispatchComplete  appDoneCallback, tZGVoidInput *appOpaquePtr)
{
  return ZGLibQAdd( kZGPskCalcReqSZ, kZGMSGCalcPSK, 0,
                    appPrepareCallback, appDoneCallback, appOpaquePtr );
}


tZGReturnStatus
ZGLibInstallWEPKeys (tDispatchRequest appPrepareCallback, tDispatchComplete  appDoneCallback, tZGVoidInput *appOpaquePtr)
{
  return ZGLibQAdd( kZGWEPKeyReqSZ, kZGMSGWEPKey, 0,
                    appPrepareCallback, appDoneCallback, appOpaquePtr );
}


tZGReturnStatus
ZGLibInstallPSK (tDispatchRequest appPrepareCallback, tDispatchComplete  appDoneCallback, tZGVoidInput *appOpaquePtr)
{
  return ZGLibQAdd( kZGPMKKeyReqSZ, kZGMSGPMKKey, 0,
                    appPrepareCallback, appDoneCallback, appOpaquePtr );
}


tZGReturnStatus
ZGLibJoin (tDispatchRequest appPrepareCallback, tDispatchComplete  appDoneCallback, tZGVoidInput *appOpaquePtr)
{
  return ZGLibQAdd( kZGJoinReqSZ, kZGMSGJoin, 0,
                    appPrepareCallback, appDoneCallback, appOpaquePtr );
}


tZGReturnStatus
ZGLibAuth (tDispatchRequest appPrepareCallback, tDispatchComplete  appDoneCallback, tZGVoidInput *appOpaquePtr)
{
  return ZGLibQAdd( kZGAuthReqSZ, kZGMSGAuth, 0,
                    appPrepareCallback, appDoneCallback, appOpaquePtr );
}


tZGReturnStatus
ZGLibAssoc (tDispatchRequest appPrepareCallback, tDispatchComplete  appDoneCallback, tZGVoidInput *appOpaquePtr)
{
  return ZGLibQAdd( kZGAssocReqSZ, kZGMSGAssoc, 0,
                    appPrepareCallback, appDoneCallback, appOpaquePtr );
}


tZGReturnStatus
ZGLibDisconnect (tDispatchRequest appPrepareCallback, tDispatchComplete  appDoneCallback, tZGVoidInput *appOpaquePtr)
{
  return ZGLibQAdd( kZGDisconnectReqSZ, kZGMSGDisconnect, 0,
                    appPrepareCallback, appDoneCallback, appOpaquePtr );
}


tZGReturnStatus
ZGLibStart (tDispatchRequest appPrepareCallback, tDispatchComplete  appDoneCallback, tZGVoidInput *appOpaquePtr)
{
  return ZGLibQAdd( kZGAdhocStartReqSZ, kZGMSGAdhocStart, 0,
                    appPrepareCallback, appDoneCallback, appOpaquePtr );
}

tZGReturnStatus
ZGLibConnect (tDispatchRequest appPrepareCallback, tDispatchComplete  appDoneCallback, tZGVoidInput *appOpaquePtr)
{
  return ZGLibQAdd( kZGAdhocConnectReqSZ, kZGMSGAdhocConnect, 0,
                    appPrepareCallback, appDoneCallback, appOpaquePtr );
}


tZGReturnStatus
ZGLibGetChipVersion(tDispatchRequest appPrepareCallback, tDispatchComplete  appDoneCallback, tZGVoidInput *appOpaquePtr)
{
  return ZGLibQAdd( 0, kZGMSGGetParam, kZGParamSystemVersion,
                    appPrepareCallback, appDoneCallback, appOpaquePtr );
}

tZGReturnStatus
ZGLibGetMacAddr(tDispatchRequest appPrepareCallback, tDispatchComplete  appDoneCallback, tZGVoidInput *appOpaquePtr)
{
  return ZGLibQAdd( 0, kZGMSGGetParam, kZGParamMACAddress,
                    appPrepareCallback, appDoneCallback, appOpaquePtr );
}


tZGReturnStatus
ZGLibSetThrottleTable (tDispatchRequest appPrepareCallback, tDispatchComplete  appDoneCallback, tZGVoidInput *appOpaquePtr)
{
  return ZGLibQAdd( 1, kZGMSGSetParam, kZGParamTxThrottleTableOnOff,
                    appPrepareCallback, appDoneCallback, appOpaquePtr );
}

tZGReturnStatus
ZGLibSetMacAddr (tDispatchRequest appPrepareCallback, tDispatchComplete  appDoneCallback, tZGVoidInput *appOpaquePtr)
{
  return ZGLibQAdd( kZGMACAddrLen, kZGMSGSetParam, kZGParamMACAddress,
                    appPrepareCallback, appDoneCallback, appOpaquePtr );
}

tZGReturnStatus
ZGLibSetDom (tDispatchRequest appPrepareCallback, tDispatchComplete  appDoneCallback, tZGVoidInput *appOpaquePtr)
{
  return ZGLibQAdd( kZGRegDomainLen, kZGMSGSetParam, kZGParamRegDomain,
                    appPrepareCallback, appDoneCallback, appOpaquePtr );
}

#ifdef CONNECTION_LOST_FEATURE
tZGReturnStatus
ZGLibSetConnLost (tDispatchRequest appPrepareCallback, tDispatchComplete  appDoneCallback, tZGVoidInput *appOpaquePtr)
{
  return ZGLibQAdd( 1, kZGMSGSetParam, kZGParamNumMissedBeaconsAllowed,
                    appPrepareCallback, appDoneCallback, appOpaquePtr );
}
#endif

tZGReturnStatus
ZGLibGetRTS (tDispatchRequest appPrepareCallback, tDispatchComplete  appDoneCallback, tZGVoidInput *appOpaquePtr)
{
  return ZGLibQAdd( 0, kZGMSGGetParam, kZGParamRTSThreshold,
                    appPrepareCallback, appDoneCallback, appOpaquePtr );
}


tZGReturnStatus
ZGLibSetRTS (tDispatchRequest appPrepareCallback, tDispatchComplete  appDoneCallback, tZGVoidInput *appOpaquePtr)
{
  return ZGLibQAdd( 2, kZGMSGSetParam, kZGParamRTSThreshold,
                    appPrepareCallback, appDoneCallback, appOpaquePtr );
}


tZGReturnStatus
ZGLibGetRadioState (tDispatchRequest appPrepareCallback, tDispatchComplete  appDoneCallback, tZGVoidInput *appOpaquePtr)
{
  return ZGLibQAdd( 0, kZGMSGGetParam, kZGParamOnOffRadio,
                    appPrepareCallback, appDoneCallback, appOpaquePtr );
}

tZGReturnStatus
ZGLibSetRadioState (tDispatchRequest appPrepareCallback, tDispatchComplete  appDoneCallback, tZGVoidInput *appOpaquePtr)
{
  return ZGLibQAdd( 1, kZGMSGSetParam, kZGParamOnOffRadio,
                    appPrepareCallback, appDoneCallback, appOpaquePtr );
}


tZGReturnStatus
ZGLibSetPwrSaveMode (tDispatchRequest appPrepareCallback, tDispatchComplete  appDoneCallback, tZGVoidInput *appOpaquePtr)
{
  return ZGLibQAdd( kZGPwrModeReqSZ, kZGMSGSetPwrMode, 0,
                    appPrepareCallback, appDoneCallback, appOpaquePtr );
}


#ifndef ZG_RAW_DRIVER

tZGVoidReturn
ZGLibConfirm(tZGU8 type, tZGDataPtr fourByteHeader, tZGDataPtr pBuf, tZGU16 len)
{

   if ( ZGLibQDelete(type, fourByteHeader, pBuf, len) == kZGFailure )
   {
     ZGSYS_MODULE_ASSERT(1, "ZGLibConfirm Error\n\r");
   }

   if ( pBuf != NULL)
   {
      ZGSYS_READBUF_CLEAN(pBuf);
      len = 0;
   }

}

#else

tZGVoidReturn
ZGLibConfirm(tZGU8 type)
{

  if ( ZGLibQDelete(type) == kZGFailure )
  {
     ZGSYS_MODULE_ASSERT(1, (ROM FAR char *) "ZGLibConfirm Error\n\r");
  }

   ZGSetRawRxMgmtInProgress(kZGBoolFalse);

}

#endif


/* This routine enables/disables indication spray for registered callbacks */
tZGBool
ZGLibEnableIndicate( tDispatchZGIndicate handle, tZGBool bEnable )
{
  tZGU8 mod8 = 0;
  tZGU8 div8 = 0;

  if ( handle > MAX_INDICATE_LIST )
    return kZGBoolFalse;

  div8 = handle >> 3;
  mod8 = (handle & 0x07);

  if ( bEnable )
    gIndicateMask[div8] |= ( 1 << mod8);
  else
    gIndicateMask[div8] &= ~( 1 << mod8);

  return kZGBoolTrue;

}

/* This routine sprays indicates to registered applications */
#ifndef ZG_RAW_DRIVER

tZGVoidReturn
ZGLibIndicate(tZGU8 type, tZGDataPtr fourByteHeader, tZGDataPtr pBuf, tZGU16 len)

#else

tZGVoidReturn
ZGLibIndicate( tZGU8 type )

#endif

{
    tZGU8 idx;
    tZGU8 mod8 = 0;
    tZGU8 div8 = 0;
    tZGU8 temp = gIndicateMask[div8];

#ifdef ZG_RAW_DRIVER
    tZGU8 fourByteHeader[4];
    tZGDataPtr pBuf =  NULL;
    tZGU16 len = 0;

    /* Skip the SPI preamble which is 2 bytes*/
    ZGRawSetIndex(kRxPipeRAW, 2);

    /* Read the 4 byte header */
    ZGRawGetByte(kRxPipeRAW, (tZGU8Ptr) fourByteHeader, 4);

#endif

    for (idx = 0; idx < (tZGU8)MAX_INDICATE_LIST; idx++ )
    {
      if ( mod8++ >= 8u )
      {
          mod8 = 0;
          div8++;
          temp = gIndicateMask[div8];
      }

      if ( temp & 0x01 )
        DISPATCH_INDICATE( idx, type, fourByteHeader, pBuf, len);

      temp >>= 1;
    }

    /* currently we don't use any additional information from pBuf.
     * the deauth message contains the mac address of the AP and
     * the 2 byte reason code, but this information is not used. */

#ifndef ZG_RAW_DRIVER
    if(pBuf != kZGDataPtrNULL)
    {
      ZGSYS_READBUF_CLEAN(pBuf);
      len = 0;
    }
#endif

}

tZGReturnStatus
ZGLibManagementRequest (	tZGU16 appMgmtValueLen,    /* buffer length to hold the parameter request/response */
							tZGU8 appMgmtSubType,      /* E.g., kZGMSGGetParam or kZGMSGSetParam               */
							tZGParam appMgmtParamName, /* Valid values are enumerated and defined in tZGParam  */
							tDispatchRequest appPrepareCallback,
							tDispatchComplete  appDoneCallback,
							tZGVoidInput *appOpaquePtr)
{
   return ZGLibQAdd( appMgmtValueLen, appMgmtSubType, appMgmtParamName,
                     appPrepareCallback, appDoneCallback, appOpaquePtr );
}

#endif  /* ZG_CONFIG_LIBRARY */

#endif // #if defined(ZG_CS_TRIS)
