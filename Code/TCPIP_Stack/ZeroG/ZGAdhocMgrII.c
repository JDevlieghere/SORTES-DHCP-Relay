
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
 *  Finite State Machine and callbacks for Adhoc IBSS networks 
 *
 *********************************************************************
 * FileName:        ZGAdhocMgrII.c
 * Dependencies:    None
 * Company:         ZeroG Wireless, Inc.
 *
 * Software License Agreement
 *
 * Copyright © 2009 ZeroG Wireless Inc.  All rights  
 * reserved.
 *
 * ZeroG licenses to you the right to use, modify, copy, 
 * distribute, and port the Software driver source files ZGAdhocMgrII.c
 * and ZGAdhocMgrII.h when used in conjunction with the ZeroG ZG2100 for
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


#include <string.h> /* for memcpy */

#include "TCPIP Stack/ZGLinkMgrII.h"

#if !defined (ZG_CONFIG_NO_ADHOCMGRII)

#include "TCPIP Stack/ZGConsole.h"
#include "TCPIP Stack/ZGAdhocMgrII.h"
#include "TCPIP Stack/ZGCommon.h"


ROM tFSMState g_adhocFSM[ZG_MAX_STATES] =
{	

    /* kNULL */
    FSM_STATE( kNULL, kNULL, kNULL, kNULL, kNULL, kNULL ),

    /* kSTIdle */
    FSM_STATE( kNULL, kNULL, kNULL, genericIdleNextState, kNULL, kNULL ),
    
    /* kSTGetChipVersion */
    FSM_STATE( kNULL, kNULL, kNULL, kNULL, kNULL, kNULL ),
  
    /* kSTEnThrottleTable */
    FSM_STATE( ZGLibSetThrottleTable, genericThrottleTableRequest, genericComplete, genericThrottleTableNext, kSTSetMacAddr,  kSTIdle ),
   
    /* kSTSetConnLostCondition */
    FSM_STATE( kNULL, kNULL, kNULL, kNULL, kNULL, kNULL ),
    
    /* kSTSetMacAddr */
    FSM_STATE( ZGLibSetMacAddr, genericSetMacAddrRequest, genericSetMacAddrComplete, kNULL, kSTSetRegDom, kSTIdle ),

    /* kSTGetMacAddr */
    FSM_STATE( ZGLibGetMacAddr, kNULL, genericGetMacAddrComplete, kNULL, kSTSetRegDom, kSTIdle ),
    
    /* kSTSetRegDom */
    FSM_STATE( ZGLibSetDom, genericSetDomRequest, genericSetDomComplete, adHocDomNextState, kNULL, kNULL ),
        
    /* kSTCalcPSK */
    FSM_STATE( kNULL, kNULL, kNULL, kNULL, kNULL, kNULL ),

    /* kSTInstallWEPKey */
    FSM_STATE( ZGLibInstallWEPKeys, genericInstallWEPKeyRequest, genericComplete, kNULL, kSTScan, kSTIdle ),

    /* kSTInstallPSK */
    FSM_STATE( kNULL, kNULL, kNULL, kNULL, kNULL, kNULL ),
    
    /* kSTScan */
    FSM_STATE( ZGLibScan, adHocScanRequest, genericScanComplete, adHocScanNextState, kNULL,  kNULL ),
     
    /* kSTStart */ 
    FSM_STATE( ZGLibStart, adHocStartRequest, adHocConnStartComplete, kNULL, kSTMaintainConnect, kSTIdle ),
    
    /* kSTConnect */
    FSM_STATE(  ZGLibConnect, adHocConnRequest, adHocConnStartComplete, kNULL, kSTMaintainConnect, kSTIdle ),
    
    /* kSTJoin */
    FSM_STATE( kNULL, kNULL, kNULL, kNULL, kNULL, kNULL ),
    
    /* kSTAuth */
    FSM_STATE( kNULL, kNULL, kNULL, kNULL, kNULL, kNULL ),
    
    /* kSTAssoc */
    FSM_STATE( kNULL, kNULL, kNULL, kNULL, kNULL, kNULL ),
    
    /* kSTMaintainConnect */
    FSM_STATE( kNULL, kNULL, kNULL, adHocMainConnNextState, kNULL, kNULL ),

    /* kSTDisconnect */
    FSM_STATE( ZGLibDisconnect, adHocDisconnRequest, adHocDisconnComplete, kNULL, kSTIdle, kNULL )
    
   
};


/***********************************/
/*  Adhoc FSM Next State Callbacks */
/***********************************/

enum tFSMValidStates
adHocScanNextState( tZGVoidInput  )
{  
  enum tFSMValidStates nextState = kSTIdle;  
  
  if ( APPCXT.FSM.stateStatus == kSUCCESS )
  {

#if defined ( ZG_CONFIG_CONSOLE )
     sprintf( (char *) g_ConsoleContext.txBuf,
             "    IBSS selected = [%ld] \n\r", (tZGU32) APPCXT.selectedBSS );

     ZG_PUTSUART( (char *) g_ConsoleContext.txBuf );
#endif
 
     nextState = kSTConnect;     
  } 
  else if ( APPCXT.FSM.stateStatus == kFAILURE )
  {

#if defined ( ZG_CONFIG_CONSOLE )
      ZG_PUTRSUART("    starting network ...\n\r");
#endif

      nextState = kSTStart;   
  }
  else
  {   
      if ( ++(APPCXT.nScanRetryState) < MAX_ADHOC_SCAN_RETRY )
      {

#if defined ( ZG_CONFIG_CONSOLE )
           sprintf( (char *) g_ConsoleContext.txBuf,
                    "    retry ... (%d/%d)\n\r", 
                    APPCXT.nScanRetryState,
                    MAX_ADHOC_SCAN_RETRY);

           ZG_PUTSUART( (char *) g_ConsoleContext.txBuf );
#endif
                            
           nextState = kSTScan;
      }
      else
      {
#if defined ( ZG_CONFIG_CONSOLE )
        ZG_PUTRSUART("    failed ... (*)\n\r");
#endif
        ZG_SETNEXT_MODE( kZGLMNetworkModeIdle );
      } 
    
  }
    
  return nextState;  

}

enum tFSMValidStates
adHocMainConnNextState( tZGVoidInput  )
{
    
  enum tFSMValidStates nextState = kSTMaintainConnect;
  
  if (  ZG_GETNEXT_MODE() != kZGLMNetworkModeAdhoc )
  {

#if defined ( ZG_CONFIG_CONSOLE )
     /* We have been asked to exit from the adhoc mode */
     ZG_PUTRSUART("\n\r");   /* right justify console msgs */
#endif

     nextState  = kSTDisconnect;
  }
 
  return nextState;  
   
}

enum tFSMValidStates
adHocDomNextState( tZGVoidInput  )
{  
  enum tFSMValidStates nextState = kSTIdle;
  
  if ( APPCXT.FSM.stateStatus != kFAILURE )
  {
        
    switch ( ZG_GET_ENC_TYPE() )
    {

      case kKeyTypeWep:
           nextState = kSTInstallWEPKey;
           break;
        
      case kKeyTypeCalcPsk:
      case kKeyTypePsk:
           nextState = kSTIdle;
           ZG_SETNEXT_MODE( kZGLMNetworkModeIdle );
#if defined ( ZG_CONFIG_CONSOLE )
           ZG_PUTRSUART("PSK/WPA not supported in AdHoc mode.\n\r");
#endif
           break;  
    
      case kKeyTypeNone:
           nextState = kSTScan;
           break;  
       
      default:
          ZGSYS_MODULE_ASSERT(1, (ROM FAR char*) "Unknown security encryption type");
          break;  
    }

  }
  
  return nextState;
      
}


/*******************************************/
/*  Adhoc FSM Management Request Callbacks */
/*******************************************/

tZGU8
adHocScanRequest(void * const ptrRequest, tZGVoidInput *appOpaquePtr)
{  
  tZGScanReqPtr ptrScan = (tZGScanReqPtr)ptrRequest;

  buildScanRequest( ptrScan );

  ptrScan->bss =  kZGBssAdHoc;    
  ptrScan->snType = kZGScanTypeActive;
 
#if defined ( ZG_CONFIG_CONSOLE )            
  ZG_PUTRSUART("Scan ...\n\r");
#endif
  
  return ( sizeof(tZGScanReq) );
}


tZGU8
adHocDisconnRequest( void * const ptrRequest, tZGVoidInput *appOpaquePtr) 
{  
  tZGDisconnectReqPtr ptrDisconn = (tZGDisconnectReqPtr)ptrRequest;     
    
  ptrDisconn->reasonCode = HSTOZGS( (tZGU16) 1);   /* 1: "Unspecified", 3: "STA left BSS and is deauthenticated" */
  ptrDisconn->disconnect = 1;                      /* Upon completion, MAC shall enter (0) joined state (1) idle state */
  ptrDisconn->txFrame = 0;                         /* MAC shall (0) do nothing, or (1) tx a deauth frame */
  
  ZG_PUTRSUART("Disconnect...\n\r");
  
  APPCXT.bConnected = kZGBoolFalse; 
  APPCXT.FSM.bSilent =  kZGBoolFalse; 

  return ( sizeof(tZGDisconnectReq) );
     
}

tZGU8
adHocConnRequest( void * const ptrRequest, tZGVoidInput *appOpaquePtr) 
{    
    tZGAdhocConnectReqPtr ptrConn = (tZGAdhocConnectReqPtr)ptrRequest;
    
    ptrConn->timeout = HSTOZGS( (tZGU16) 50);            /* *10 msec */
    ptrConn->beaconPrd = HSTOZGS( (tZGU16) 100);
    ptrConn->channel = APPCXT.bssDesc.channel;           /* Use the channel found in scan */
    memcpy( (void *) ptrConn->bssid, (const void *) APPCXT.bssDesc.bssid, kZGMACAddrLen);
    
    ptrConn->ssidLen = ZG_SSID_LEN(); 
    memcpy( (void *) ptrConn->ssid, (const void *) ZG_GET_SSID(), ptrConn->ssidLen); 
    
    ZG_PUTRSUART("Connect ...\n\r");

    return ( sizeof(tZGAdhocConnectReq) );
}

tZGU8
adHocStartRequest( void * const ptrRequest, tZGVoidInput *appOpaquePtr) 
{  
  tZGAdhocStartReqPtr ptrStart = (tZGAdhocStartReqPtr)ptrRequest;
    
  /* choose the first channel in ordered list for network start */
  if ( ZG_GET_ACTIVE_CHANNELS() == 0u )
  {
      ZGSYS_MODULE_ASSERT(1, (ROM FAR char *)"Adhoc StartReq: empty channel list\n\r");
  }
  else
      ptrStart->channel = ZG_CHANNEL(0);
      
  ptrStart->beaconPrd = HSTOZGS( (tZGU16) 100);
  ptrStart->capInfo[0] = kZGAdhocMgrCapBitIbss; /* was | kZGAdhocMgrCapBitShortPreamble;  0x22 */
  
  /* If in WEP mode, set the corresponding bit. */
  if ( ZG_GET_ENC_TYPE() == (tZGU8)kKeyTypeWep )
  {
    ptrStart->capInfo[0] = ptrStart->capInfo[0] | kZGAdhocMgrCapBitPrivacy;
  }

  ptrStart->capInfo[1] = 0;
  ptrStart->ssidLen = ZG_SSID_LEN();  
  memcpy( (void *) ptrStart->ssid, (const void*) ZG_GET_SSID(), ptrStart->ssidLen);	
    
  /* These values are part of the adhoc network beacon */
  /* and are part of the "basic rate" set, not to be */
  /* confused with supported rate set */
  ptrStart->dataRateLen = 2;
  ptrStart->dataRates[0] = 0x82; /* 1Mbps */ 
  ptrStart->dataRates[1] = 0x84; /* 2Mbps */

  ZG_PUTRSUART("Start ...\n\r");

  return ( sizeof(tZGAdhocStartReq) );
}


/********************************************/
/*  Adhoc FSM Management Complete Callbacks */
/********************************************/

tZGVoidReturn 
adHocConnStartComplete(tZGU8 type, tZGDataPtr fourByteHeader, tZGDataPtr pBuf,
                       tZGU16 len, tZGVoidInput *appOpaquePtr)
{

   tZGU8 result = fourByteHeader[0];
   APPCXT.FSM.stateStatus= kFAILURE; 

   if(result == (tZGU8)kZGResultSuccess)
   { 
      ZG_PUTRSUART("    succeeded\n\r");
      APPCXT.bConnected = kZGBoolTrue;
      APPCXT.FSM.stateStatus= kSUCCESS; 
      
      /* Enable link up/down indicates */
      if ( !ZGLibEnableIndicate( ZG_INDICATE_HANDLE(genericIndicate), kZGBoolTrue) )
      {
         ZGSYS_MODULE_ASSERT(1, (ROM FAR char*) "Enable link up/down\n\r");
      }
      
      #ifdef ZG_CONFIG_STATIC_IP 
      printIPAddr();
      #endif
               
   }
   else
   { 
      ZG_PUTRSUART("    failed\n\r");
   }
   
}

tZGVoidReturn 
adHocDisconnComplete(tZGU8 type, tZGDataPtr fourByteHeader, tZGDataPtr pBuf,
                     tZGU16 len, tZGVoidInput *appOpaquePtr)
{
   APPCXT.FSM.stateStatus= kSUCCESS; 
   
    /* Disable link up/down indicates */
   if ( !ZGLibEnableIndicate( ZG_INDICATE_HANDLE(genericIndicate), kZGBoolFalse) )
   {
     ZGSYS_MODULE_ASSERT(1, (ROM FAR char*) "Error Disable indicate\n\r");
   }
      
   ZG_PUTRSUART("    succeeded\n\r");
    
}


#endif /* ZG_CONFIG_LINKMGRII */

#endif // #if defined(ZG_CS_TRIS)
