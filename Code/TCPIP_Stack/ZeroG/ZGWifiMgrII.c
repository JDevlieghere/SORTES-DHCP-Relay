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
 *  State machine & callbacks for BSS - managed mode networks.
 *
 *********************************************************************
 * FileName:        ZGWiFiMgrII.c
 * Dependencies:    None
 * Company:         ZeroG Wireless, Inc.
 *
 * Software License Agreement
 *
 * Copyright © 2009 ZeroG Wireless Inc.  All rights
 * reserved.
 *
 * ZeroG licenses to you the right to use, modify, copy,
 * distribute, and port the Software driver source files ZGWiFiMgrII.c
 * and ZGWiFiMgrII.h when used in conjunction with the ZeroG ZG2100 for
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





#if !defined (ZG_CONFIG_NO_WIFIMGRII)

#include "TCPIP Stack/ZGConsole.h"
#include "TCPIP Stack/ZGWifiMgrII.h"
#include "TCPIP Stack/ZGCommon.h"

/* These FSM tables are intended for ROM */
ROM tFSMState g_mangedFSM[ZG_MAX_STATES] =
{
    /* kNULL */
    FSM_STATE( kNULL, kNULL, kNULL, kNULL, kNULL, kNULL ),

    /* kSTIdle */
    FSM_STATE( kNULL, kNULL, kNULL, genericIdleNextState, kNULL, kNULL ),

    /* kSTGetChipVersion */
    FSM_STATE( ZGLibGetChipVersion, kNULL, genericGetChipVerComplete, kNULL, kSTEnThrottleTable, kSTIdle ),

#ifdef CONNECTION_LOST_FEATURE

    /* kSTEnThrottleTable */
    FSM_STATE( ZGLibSetThrottleTable, genericThrottleTableRequest, genericComplete, kNULL, kSTSetConnLostCondition,  kSTIdle ),

    /* kSTSetConnLostCondition */
    FSM_STATE( ZGLibSetConnLost, WiFiConnLostRequest, genericComplete, genericThrottleTableNext, kSTSetMacAddr, kSTIdle ),

#else

    /* kSTEnThrottleTable */
    FSM_STATE( ZGLibSetThrottleTable, genericThrottleTableRequest, genericComplete, genericThrottleTableNext, kSTSetMacAddr,  kSTIdle ),

    /* kSTSetConnLostCondition */
    FSM_STATE( kNULL, kNULL, kNULL, kNULL, kNULL, kNULL ),

#endif

    /* kSTSetMacAddr */
    FSM_STATE( ZGLibSetMacAddr, genericSetMacAddrRequest, genericSetMacAddrComplete, kNULL, kSTSetRegDom, kSTIdle ),

    /* kSTGetMacAddr */
    FSM_STATE( ZGLibGetMacAddr, kNULL, genericGetMacAddrComplete, kNULL, kSTSetRegDom, kSTIdle ),

    /* kSTSetRegDom */
    FSM_STATE( ZGLibSetDom, genericSetDomRequest, genericSetDomComplete, WiFiDomNextState, kNULL, kNULL),

    //kSTCalcPSK
    FSM_STATE( ZGLibCalcPSK, genericCalcPSKRequest, genericCalcPSKComplete, kNULL, kSTInstallPSK, kSTIdle),

    /* kSTInstallWEPKey */
    FSM_STATE( ZGLibInstallWEPKeys, genericInstallWEPKeyRequest, genericComplete, kNULL, kSTScan, kSTIdle ),

    /* kSTInstallPSK */
    FSM_STATE( ZGLibInstallPSK, genericInstallPSKRequest, genericComplete, kNULL, kSTScan, kSTIdle),

    /* kSTScan */
    FSM_STATE( ZGLibScan, WiFiScanRequest, genericScanComplete, WiFiScanNextState, kNULL, kNULL ),

    /* kSTStart */
    FSM_STATE( kNULL, kNULL, kNULL, kNULL, kNULL, kNULL ),

    /* kSTConnect */
    FSM_STATE( kNULL, kNULL, kNULL, kNULL, kNULL, kNULL ),

    /* kSTJoin */
    FSM_STATE( ZGLibJoin, WiFiJoinRequest, WiFiJoinComplete, kNULL, kSTAuth, kSTIdle ),

    /* kSTAuth */
    FSM_STATE( ZGLibAuth, WiFiAuthRequest, WiFiAuthComplete, kNULL, kSTAssoc, kSTDisconnect ),

    /* kSTAssoc */
    FSM_STATE( ZGLibAssoc, WiFiAssocRequest, WiFiAssocComplete, kNULL, kSTMaintainConnect, kSTDisconnect ),

    /* kSTMaintainConnect */
    FSM_STATE( kNULL, kNULL, kNULL, WiFiMainConnNextState, kNULL, kNULL ),

    /* kSTDisconnect */
    FSM_STATE( ZGLibDisconnect, WiFiDisconnRequest, genericComplete, WiFiDisconnNextState, kNULL, kNULL )

};


/**********************************/
/*  WiFi FSM Next State Callbacks */
/**********************************/

enum tFSMValidStates
WiFiScanNextState( tZGVoidInput )
{
  enum tFSMValidStates nextState = kSTIdle;

  if ( APPCXT.FSM.stateStatus == kSUCCESS )
  {

#if defined ( ZG_CONFIG_CONSOLE )
    sprintf( (char *) g_ConsoleContext.txBuf,
             "    AP selected = [%ld] \n\r", APPCXT.selectedBSS );
    ZG_PUTSUART( (char *) g_ConsoleContext.txBuf );
#endif

    nextState = kSTJoin;
  }
  else if ( APPCXT.FSM.stateStatus == kFAILURE )
  {

#if defined ( ZG_CONFIG_CONSOLE )
    ZG_PUTRSUART("    AP is configured on different channel \n\r");
#else
    ZG_PUTRSUART("AP not found.\n\r");
#endif

    ZG_SETNEXT_MODE( kZGLMNetworkModeIdle );

  }
  else
  {
      if ( ++(APPCXT.nScanRetryState) < MAX_WIFI_SCAN_RETRY )
      {

#if defined ( ZG_CONFIG_CONSOLE )
           sprintf( (char *) g_ConsoleContext.txBuf,
                    "    retry ... (%d/%d)\n\r",
                    APPCXT.nScanRetryState, MAX_WIFI_SCAN_RETRY);

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
WiFiDisconnNextState( tZGVoidInput  )
{

   enum tFSMValidStates nextState = kSTIdle;

   if ( APPCXT.FSM.stateStatus == kSUCCESS )
   {
       APPCXT.FSM.bSilent =  kZGBoolTrue;

       if ( APPCXT.bRetryBSSConnect == kZGBoolTrue )
       {

          if ( ++(APPCXT.nRetryBSSConnect) < MAX_CONNECT_RETRY )
          {
             /* Retry again, without changing settings */

#if defined ( ZG_CONFIG_CONSOLE )
             sprintf( (char *) g_ConsoleContext.txBuf,
                       "Connection retry ... (%d/%d)\n\r",
                       APPCXT.nRetryBSSConnect, MAX_CONNECT_RETRY);

             ZG_PUTSUART( (char *) g_ConsoleContext.txBuf );
#endif

             nextState = kSTScan;
             return ( nextState );
          }
#if defined ( ZG_CONFIG_CONSOLE )
          else
          {
             ZG_PUTRSUART("Disconnect completed ... (*)\n\r");
          }
#endif

          /* Retry failed so return to idle */
          ZG_SETNEXT_MODE( kZGLMNetworkModeIdle );

       }

   }
   else  /* Failure */
   {
#if defined ( ZG_CONFIG_CONSOLE )
      ZG_PUTRSUART("    disconnecting anyway...\n\r");
#endif

      /* failed so return to idle */
      ZG_SETNEXT_MODE( kZGLMNetworkModeIdle );

   }


   /* Disable link up/down indicates */
   if ( !ZGLibEnableIndicate( ZG_INDICATE_HANDLE(genericIndicate), kZGBoolFalse) )
   {
      ZGSYS_MODULE_ASSERT(1, (ROM FAR char*)"Disable indicate\n\r");
   }

   return  nextState;

}


enum tFSMValidStates
WiFiMainConnNextState( tZGVoidInput  )
{

  enum tFSMValidStates nextState = kSTMaintainConnect;

  if (  ZG_GETNEXT_MODE() != kZGLMNetworkModeInfrastructure )
  {
     /* We have been asked to exit from the infrastructure mode */
#if defined ( ZG_CONFIG_CONSOLE )
     ZG_PUTRSUART("\n\r");    /* right justify console msgs */
#endif

     nextState  = kSTDisconnect;
#if 0
     ZGLedOff(kZGLedConnectionIndicator);
#endif
     APPCXT.bRetryBSSConnect = kZGBoolFalse;
  }
  else if( APPCXT.bConnected == kZGBoolFalse)
  {
#if defined ( ZG_CONFIG_CONSOLE )
     ZG_PUTRSUART("\n\r");  /* right justify console msgs */
#endif
     nextState = kSTJoin;
#if 0
     ZGLedOff(kZGLedConnectionIndicator);
#endif
  }
  else if(APPCXT.bConnLost == kZGBoolTrue)
  {
       /* the G2100 has sent a message indicating that
        * it has stopped receiving beacons from the AP.
        * This is most likely because this station is
        * now out of range or because the AP is turned off.
        * The solution implemented by this sample is to
        * send a disconnect to the G2100 (it still assumes
        * that it is connected) and to move to the scan State
        * where this station will try and re-establish contact
        * with the AP. */
#if defined ( ZG_CONFIG_CONSOLE )
      ZG_PUTRSUART("\n\r");  /*right justify console msgs */
#endif
      APPCXT.bConnLost = kZGBoolFalse;
      nextState = kSTDisconnect;
  }
   return  nextState;

}

enum tFSMValidStates
WiFiDomNextState( tZGVoidInput  )
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
           nextState = kSTCalcPSK;
           break;

      case kKeyTypePsk:
           nextState = kSTInstallPSK;
           break;

      case kKeyTypeNone:
           nextState = kSTScan;
           break;

      default:
          ZGSYS_MODULE_ASSERT(1, (ROM FAR char*) "Unknown security encryption type\n\r");
          break;
    }

  }

  return nextState;

}

/******************************************/
/*  WiFi FSM Management Request Callbacks */
/******************************************/

tZGU8
WiFiScanRequest(void * const ptrRequest, tZGVoidInput *appOpaquePtr)
{
  tZGScanReqPtr ptrScan = (tZGScanReqPtr)ptrRequest;


  buildScanRequest( ptrScan );

  ptrScan->bss =  kZGBssInfra;
  ptrScan->snType = kZGScanTypeActive;

#if defined ( ZG_CONFIG_CONSOLE )
  sprintf( (char *) g_ConsoleContext.txBuf,
           "Scan ... for ssid \"%s\"\n\r", ZG_GET_SSID() );

  ZG_PUTSUART( (char *) g_ConsoleContext.txBuf );
#endif

  /* This return information is required for the RAW driver */
  return ( sizeof(tZGScanReq) );
}


tZGU8
WiFiConnLostRequest(void * const ptrRequest, tZGVoidInput *appOpaquePtr)
{
  tZGU8Ptr ptrConnLost = ptrRequest;
  ptrConnLost[0] = kDefaultNumMissedBeaconsAllowed;

  APPCXT.FSM.bSilent =  kZGBoolTrue;

  /* This return information is required for the RAW driver */
  return ( sizeof(tZGU8) );
}

tZGU8
WiFiJoinRequest( void * const ptrRequest, tZGVoidInput *appOpaquePtr)
{
   tZGJoinReqPtr ptrJoin = (tZGJoinReqPtr)ptrRequest;

   ptrJoin->to  =  HSTOZGS(kJoinTimeout);

   /* These U16 may have been converted for little endian host */
   ptrJoin->beaconPeriod = HSTOZGS( (tZGU16) APPCXT.bssDesc.beaconPeriod );
   ptrJoin->channel = APPCXT.bssDesc.channel;
   ptrJoin->ssidLen = APPCXT.bssDesc.ssidLen;
   memcpy( (void*) ptrJoin->bssid, (const void *) APPCXT.bssDesc.bssid, kZGMACAddrLen);
   memcpy( (void*) ptrJoin->ssid, (const void *) APPCXT.bssDesc.ssid, APPCXT.bssDesc.ssidLen);

#if defined ( ZG_CONFIG_CONSOLE )
   ZG_PUTRSUART("Join ...\n\r");
#endif

   /* This return information is required for the RAW driver */
   return ( sizeof(tZGJoinReq) );
}

tZGU8
WiFiAuthRequest( void * const ptrRequest, tZGVoidInput *appOpaquePtr)
{
   tZGAuthReqPtr ptr = (tZGAuthReqPtr)ptrRequest;

   memcpy( (void *) ptr->addr, (const void *) APPCXT.bssDesc.bssid, kZGMACAddrLen);   /* the BSSID of the network with which to authenticate */
   ptr->to = HSTOZGS(kAuthTimeout);                                                   /* authentication timeout in 10's of msec */

   if( (APPCXT.capInfo[0] & kWifiMgrCapBitPrivacy) == 0u ||
       (APPCXT.securityInfo[0] != 0u || APPCXT.securityInfo[1] != 0u))
   {
     ptr->alg = kZGAuthAlgOpen;
   }
   else
   {
     ptr->alg = ZG_GET_AUTH_TYPE();
   }

#if defined ( ZG_CONFIG_CONSOLE )
   ZG_PUTRSUART("Authenticate ...\n\r");
#endif

   /* This return information is required for the RAW driver */
   return ( sizeof(tZGAuthReq) );
}

tZGU8
WiFiAssocRequest( void * const ptrRequest, tZGVoidInput *appOpaquePtr)
{
   tZGAssocReqPtr ptrReq = (tZGAssocReqPtr)ptrRequest;

#if defined ( ZG_CONFIG_CONSOLE )
   ZG_PUTRSUART("Associate ...\n\r");
#endif

   memcpy( (void *) ptrReq->addr,  (const void *) APPCXT.bssDesc.bssid, kZGMACAddrLen);
   ptrReq->channel = 0; /* not used */

   /* security selection bits to instruct construction
    * of a security IE */

   /* set default to no flags - must initialize to zero */
   ptrReq->flags = 0; /* WEP */

   if((APPCXT.capInfo[0] & kWifiMgrCapBitPrivacy) != 0u)
   {
        /* defaults to WPA if both are available */
        if( APPCXT.securityInfo[0] & kWifiMgrSecInfoAuthPsk) /* WPA */
           ptrReq->flags = (APPCXT.securityInfo[0] & kWifiMgrSecInfoGrpCcmp)? kWifiMgrSecInfoReqWpaPskCcmp : kWifiMgrSecInfoReqWpaPskTkip;
        else if(APPCXT.securityInfo[1] & kWifiMgrSecInfoAuthPsk) /* RSN */
           ptrReq->flags = (APPCXT.securityInfo[1] & kWifiMgrSecInfoGrpTkip)? kWifiMgrSecInfoReqRsnPskTkip : kWifiMgrSecInfoReqRsnPskCcmp;
   }

   /* This is optional code, but for maximum interoperability advertise all rates 1,2,5.5,11 */
#if 0
   /* Only echo rates on first associate attempt, on subsequent retry just advertise all rates */
   /* for maximum compatiblility with AP */
   if (  APPCXT.nAssocRetryState == 0 )
   {
     ptrReq->flags |= kAssocReqFlagDontEchoDataRates;
     ZG_PUTRSUART("    echo basic rates\n\r");
   }
#endif

   /* association timeout in 10's of msec */
   ptrReq->to = HSTOZGS(kAssocTimeout);

   /* The RAW driver has different endian expectations... As well as, it is seemingly a 16bit capInfo defn */
   #ifdef ZG_RAW_DRIVER
     ptrReq->capInfo[0] = APPCXT.capInfo[0] & kWifiMgrCapBitAllowedMask;
     ptrReq->capInfo[1] = 0;
   #else
     /* the capabilities of this station. */
     ptrReq->capInfo[0] = APPCXT.capInfo[0] & kWifiMgrCapBitAllowedMask;
     ptrReq->capInfo[1] = 0;
   #endif


   /* the number of beacons that may pass between
    * listen attempts by this Station. Indicates to
    * the AP how how much resources may be required to
    * buffer for this station while its sleeps */
   ptrReq->listenIntval = HSTOZGS(kSleepInterval);
   /* length of additional elements to be included in
    * the assoc frame that immediately follows this
    * data structure */
   ptrReq->elemLen = HSTOZGS( (tZGU16) 0);

   /* This return information is required for the RAW driver */
   return ( sizeof(tZGAssocReq) );
}

tZGU8
WiFiDisconnRequest( void * const ptrRequest, tZGVoidInput *appOpaquePtr)
{
  tZGDisconnectReqPtr ptrDisconn = (tZGDisconnectReqPtr)ptrRequest;

  ptrDisconn->reasonCode = HSTOZGS( (tZGU16) 3); /* 1: "Unspecified", 3: "STA left BSS and is deauthenticated" */
  ptrDisconn->disconnect = 1;                    /* Upon completion, MAC shall enter (0) joined state (1) idle state */
  ptrDisconn->txFrame = 1;                       /* MAC shall (0) do nothing, or (1) tx a deauth frame */

#if defined ( ZG_CONFIG_CONSOLE )
  ZG_PUTRSUART("Disconnect...\n\r");
  APPCXT.FSM.bSilent =  kZGBoolFalse;
#else
  ZG_PUTRSUART("Not connected.\n\r");
  APPCXT.FSM.bSilent =  kZGBoolTrue;
#endif

  APPCXT.bConnected = kZGBoolFalse;


  /* This return information is required for the RAW driver */
  return ( sizeof(tZGDisconnectReq) );

}


/* Helper function for WiFiJoinComplete.  Verifies that the security level the host is asking for matches */
/* what the AP supports.                                                                                 */
static tZGBool isSecurityLevelMatched(tZGVoidInput)
{
    tZGU16 apSecurityType;
    
    /* If AP has security enabled */
    if(APPCXT.capInfo[0] & kWifiMgrCapBitPrivacy) 
    {
        if(APPCXT.securityInfo[1] & kWifiMgrSecInfoAuthPsk)
        {
            apSecurityType = kKeyTypePsk;
        }        
        else if(APPCXT.securityInfo[0] & kWifiMgrSecInfoAuthPsk)
        {
            apSecurityType = kKeyTypePsk;
        }        
        else
        {
            apSecurityType = kKeyTypeWep;
        }   
    }
    /* else AP does not have security enabled */
    else 
    {
          apSecurityType = kKeyTypeNone;
    }
    
    // check if configured security type matches the available security on the AP
    if ( apSecurityType != g_encType) 
    {
          // configured security does not match AP security
          return kZGBoolFalse;
    }
    
    return kZGBoolTrue;
}  

/*******************************************/
/*  WiFi FSM Management Complete Callbacks */
/*******************************************/

tZGVoidReturn
WiFiJoinComplete(tZGU8 type, tZGDataPtr fourByteHeader, tZGDataPtr pBuf,
                 tZGU16 len, tZGVoidInput *appOpaquePtr)
{
  tZGJoinCnfPtr ptrJoinRequest = (tZGJoinCnfPtr) pBuf;
  tZGU8 result   = fourByteHeader[0];
  tZGU8 macState = fourByteHeader[1];

  APPCXT.FSM.stateStatus = kFAILURE;

  if (result == (tZGU8)kZGResultSuccess)
  {

#if defined ( ZG_CONFIG_CONSOLE )
     ZG_PUTRSUART("    succeeded\n\r");
#endif
     ZGLibLoadConfirmBuffer(pBuf, sizeof(tZGJoinCnf), 0);

     /* save the capInfo and secInfo[0] and secInfo[1] */
     APPCXT.capInfo[0] = (tZGU8) ptrJoinRequest->capInfo;
     APPCXT.capInfo[1] = (tZGU8) (ptrJoinRequest->capInfo >> 8);
     APPCXT.securityInfo[0] = ptrJoinRequest->securityInfo[0];
     APPCXT.securityInfo[1] = ptrJoinRequest->securityInfo[1];

     if(macState != (tZGU8)kZGMACStateJoined)
     {
        ZGSYS_MODULE_ASSERT(1, (ROM FAR char*) "unexpected mac state following join confirm success.\n\r");
     }

     /* if configured security matches AP security level */
     if (isSecurityLevelMatched())
     {
        APPCXT.FSM.stateStatus = kSUCCESS;
     }
     /* else configured security does NOT match AP security level */
     else   
     {
        APPCXT.FSM.stateStatus = kFAILURE;    
        ZG_PUTRSUART("    Error: Host security level does not match AP\n\r");
        ZG_PUTRSUART("           See TCPIPConfig.h, MY_DEFAULT_ENCRYPTION_TYPE\n\r");

        APPCXT.nJoinRetryState = 0;
        ZG_SETNEXT_MODE( kZGLMNetworkModeIdle );
     }
  }
  else
  {
     if ( ++(APPCXT.nJoinRetryState) < MAX_JOIN_RETRY )
     {

#if defined ( ZG_CONFIG_CONSOLE )
        sprintf( (char *) g_ConsoleContext.txBuf,
                 "    retry(%d/%d)\n\r",
                 APPCXT.nJoinRetryState, MAX_JOIN_RETRY);

        ZG_PUTSUART( (char *) g_ConsoleContext.txBuf );
#endif

        APPCXT.FSM.stateStatus= kRETRY;
     }
     else
     {

#if defined ( ZG_CONFIG_CONSOLE )
        ZG_PUTRSUART("    retry failed\n\r");
#else
        ZG_PUTRSUART("Not connected.\n\r");
#endif

        APPCXT.nJoinRetryState = 0;

        /* It is unnecessary to disconnect, until a join is successful */
        /* So this code can return to idle, but need to reset the link manager's state */
        ZG_SETNEXT_MODE( kZGLMNetworkModeIdle );

     }

  }

}


tZGVoidReturn
WiFiAuthComplete(tZGU8 type, tZGDataPtr fourByteHeader, tZGDataPtr pBuf,
                 tZGU16 len, tZGVoidInput *appOpaquePtr)
{
    tZGU8 result   = fourByteHeader[0];

    APPCXT.FSM.stateStatus = kFAILURE;

    if(result == (tZGU8)kZGResultSuccess)
    {
#if defined ( ZG_CONFIG_CONSOLE )
       ZG_PUTRSUART("    succeeded\n\r");
#endif
       APPCXT.FSM.stateStatus= kSUCCESS;

       ZGLibLoadConfirmBuffer(pBuf, sizeof(tZGAuthReq), 0);

       APPCXT.nAuthRetryState = 0;
    }
    else
    {
         /* Some errors should never occur so asserts are in order */
         if(result == (tZGU8)kZGResultNotJoined)
         {
            /* refer to CNFCXT.macState to determine the current MAC State. Most
             * likely there is a bug with the wifiMgr State machine. */
            ZGSYS_MODULE_ASSERT(1, (ROM FAR char*) "Mac must be in Joined State to authenticate\n\r");
         }
         else if(result == (tZGU8)kZGResultInvalidParams)
         {
            /* refer to programmers guide for proper values of Auth Request
             * parameters. Also ensure that multi-byte integers are big-endian. */
            ZGSYS_MODULE_ASSERT(1, (ROM FAR char*) "Invalid Params reported in Auth request\n\r");
         }
#if defined ( ZG_CONFIG_CONSOLE )
         else if(result == (tZGU8)kZGResultAuthRefused)
         {
            ZG_PUTRSUART("    Warning, AP authentication refused\n\r");
            ZG_PUTRSUART("    Try changing open/shared algorithm\n\r");
         }
#endif

         /* Logic to retry this state machine */

         /* After a certain number of attempts give up regardless */
         if ( ++(APPCXT.nAuthRetryState) < MAX_AUTH_RETRY )
         {

#if defined ( ZG_CONFIG_CONSOLE )
            sprintf( (char *) g_ConsoleContext.txBuf,
                     "    retry(%d/%d)\n\r",
                     APPCXT.nAuthRetryState, MAX_AUTH_RETRY);

            ZG_PUTSUART( (char *) g_ConsoleContext.txBuf );
#endif
            APPCXT.FSM.stateStatus= kRETRY;
         }
         else
         {
            /* Need to do deauth to expunge local firmware records */
            /* otherwise we may have failure in adhoc mode due to managed mode residue */

#if defined ( ZG_CONFIG_CONSOLE )
            sprintf( (char *) g_ConsoleContext.txBuf,
                     "    authentication retry failed %d.\n\r", result);

            ZG_PUTSUART( (char *) g_ConsoleContext.txBuf );
#endif
            APPCXT.nAuthRetryState = 0;
         }

    }

}


tZGVoidReturn
WiFiAssocComplete(tZGU8 type, tZGDataPtr fourByteHeader, tZGDataPtr pBuf,
                  tZGU16 len, tZGVoidInput *appOpaquePtr)
{

   tZGU8 result   = fourByteHeader[0];

   APPCXT.FSM.stateStatus = kFAILURE;

   if(result == (tZGU8)kZGResultSuccess)
   {

#if defined ( ZG_CONFIG_CONSOLE )
      ZG_PUTRSUART("    succeeded\n\r");
#endif

      ZGLibLoadConfirmBuffer(pBuf, sizeof(tZGAssocCnf), 0);

      /* Clear the counter */
      APPCXT.nAssocRetryState = 0;

       /* copy the capInfo one more time */
      memcpy( (void *) &(APPCXT.capInfo[0]), (const void *) &(((tZGAssocCnfPtr)pBuf)->capInfo[0]), 2);
      APPCXT.bConnected = kZGBoolTrue;

      /* Enable link up/down indicates */
      if ( !ZGLibEnableIndicate( ZG_INDICATE_HANDLE(genericIndicate), kZGBoolTrue) )
      {
         ZGSYS_MODULE_ASSERT(1, (ROM FAR char*) "Enable link up/down\n\r");
      }

      ZG_PUTRSUART("Connected!\n\r");

      APPCXT.FSM.stateStatus = kSUCCESS;

      #ifdef ZG_CONFIG_STATIC_IP
      printIPAddr();
      #endif

   }
   else
   {

     if(result == (tZGU8)kZGResultInvalidParams)
     {
         /* refer to programmers guide for proper values of Assoc Request
          * parameters. Also ensure that multi-byte integers are big-endian. */
        ZGSYS_MODULE_ASSERT(1, (ROM FAR char*) "Invalid Params reported in Assoc request\n\r");
     }

     /* After a certain number of attempts give up regardless */
     if ( ++(APPCXT.nAssocRetryState) < MAX_ASSOC_RETRY )
     {

#if defined ( ZG_CONFIG_CONSOLE )
         sprintf( (char *) g_ConsoleContext.txBuf,
                  "    retry(%d/%d)\n\r",
                  APPCXT.nAssocRetryState, MAX_ASSOC_RETRY);

         ZG_PUTSUART( (char *) g_ConsoleContext.txBuf );
#endif

         APPCXT.FSM.stateStatus = kRETRY;
     }
     else
     {
#if defined ( ZG_CONFIG_CONSOLE )
        ZG_PUTRSUART("    retry failed\n\r");
#endif
        APPCXT.nAssocRetryState = 0;
     }


  }


}


#endif /* ZG_CONFIG_LINKMGRII */

#endif // #if defined(ZG_CS_TRIS)
