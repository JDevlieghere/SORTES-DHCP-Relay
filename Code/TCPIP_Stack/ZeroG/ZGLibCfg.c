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
 *  A cache of Wireless 802.11 configuration setting and access methods
 *  This cache provides tools the ability to configure the WiFi connection
 *  attributes
 *
 *********************************************************************
 * FileName:        ZGLibCfg.c
 * Dependencies:    None
 * Company:         ZeroG Wireless, Inc.
 *
 * Software License Agreement
 *
 * Copyright © 2009 ZeroG Wireless Inc.  All rights
 * reserved.
 *
 * ZeroG licenses to you the right to use, modify, copy,
 * distribute, and port the Software driver source files ZGLibCfg.c
 * and ZGLibCfg.h when used in conjunction with the ZeroG ZG2100 for
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
 * Author               Date        Comment
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


tZGBool   g_DHCP = DHCP_DISABLED;


#if defined ( ZG_CONFIG_CONSOLE )

/* SYSTEM WIDE STRINGS */
ROM FAR tZGS8 *g_DomainStrings[] = { (ROM FAR tZGS8 *) "fcc",    /* kZGRegDomainFCC */
                                     (ROM FAR tZGS8 *) "ic",     /* kZGRegDomainIC */
                                     (ROM FAR tZGS8 *) "etsi",   /* kZGRegDomainETSI */
                                     (ROM FAR tZGS8 *) "spain",  /* kZGRegDomainSpain */
                                     (ROM FAR tZGS8 *) "france", /* kZGRegDomainFrance */
                                     (ROM FAR tZGS8 *) "japana", /* kZGRegDomainJapanA */
                                     (ROM FAR tZGS8 *) "japanb", /* kZGRegDomainJapanB */
                                      NULL };

ROM FAR tZGS8 *g_EncStrings[] = { (ROM FAR tZGS8 *) "none",         /* kKeyTypeNone */
                                  (ROM FAR tZGS8 *) "wep",          /* kKeyTypeWep */
                                  (ROM FAR tZGS8 *) "wpa-psk",      /* kKeyTypePsk */
                                  (ROM FAR tZGS8 *) "wpa-phrase",   /* kKeyTypeCalcPsk */
                                  NULL };

ROM FAR tZGS8 *g_WepAuthStrings[] = {(ROM FAR tZGS8 *)"open",    /*kZGAuthAlgOpen*/
                                     (ROM FAR tZGS8 *) "shared",  /*kZGAuthAlgShared*/
                                     NULL };


ROM FAR tRssiQuanta g_rssiTable[MAX_RSSI_TABLE_SZ] = { {200,181},
                                                       {180,161},
                                                       {160,141},
                                                       {140,121},
                                                       {120,100} };

#endif

ROM tZGS8 g_SDKVersion[] = "1.5.1.0";


#ifdef ZG_CONFIG_LIBRARY

/* SYSTEM WIDE GLOBALS  - these g_  globals are exportable */
/* ANSI C - uninitialized portions of arrays will be zero-ed*/
/* +1 for EOS '/0' because 32 chars are ok for SSID */
#if !defined ( MY_DEFAULT_SSID_NAME )
#error "SSID string must be specified in a .h file"
#endif

#if defined ( MY_DEFAULT_CHANNEL_SCAN_LIST )
tZGU8           g_targetChannels[kZGMaxScanChannels] = MY_DEFAULT_CHANNEL_SCAN_LIST;
tZGU8           g_targetActiveChannels = MY_DEFAULT_CHANNEL_LIST_SIZE;
#else
tZGU8           g_targetChannels[kZGMaxScanChannels] = {1, 6, 11};
tZGU8           g_targetActiveChannels = 3;
#endif

#if !defined ( MY_DEFAULT_MAC_BYTE1 )
#error "MAC address must be specified in a .h file"
#endif

#if defined ( MY_DEFAULT_DOMAIN )
tZGU8           g_targetRegDom = MY_DEFAULT_DOMAIN;
#else
tZGU8           g_targetRegDom =  kZGRegDomainFCC;
#endif

#if defined ( MY_DEFAULT_ENCRYPTION_TYPE )
tZGU8           g_encType = MY_DEFAULT_ENCRYPTION_TYPE;
tZGU8           g_authType = MY_DEFAULT_WEP_AUTH;
tZGU8           g_wepKeyIndex = MY_DEFAULT_WEP_KEY_INDEX;
tZGU8           g_wepKeyLen = MY_DEFAULT_WEP_KEY_LEN;

  #if defined(__18CXX)
  #pragma idata zglib_init
  tZGU8         g_PMKKeyData[kZGMaxPmkLen] =  MY_DEFAULT_PSK;
  tZGS8         g_targetPassPhrase[kZGMaxPhraseLen+1] = MY_DEFAULT_PSK_PHRASE;
  tWEP          g_WEPKeyData[kZGNumDefWepKeys] = MY_DEFAULT_WEP_KEYS;
  #pragma idata
  #else
  tZGU8         g_PMKKeyData[kZGMaxPmkLen] =  MY_DEFAULT_PSK;
  tZGS8         g_targetPassPhrase[kZGMaxPhraseLen+1] = MY_DEFAULT_PSK_PHRASE;
  tWEP          g_WEPKeyData[kZGNumDefWepKeys] = MY_DEFAULT_WEP_KEYS;
  #endif

#else
tZGU8           g_encType = kKeyTypeNone;
#endif

tZGU16          g_Rts;
tZGBool         g_RfEnabled;
tZGBool         g_pwrMgmtEnabled;
tZGBool         g_pwrRxDTIMEnabled = kZGBoolTrue;
tZGBool         g_dataConfirmation = kZGBoolTrue;

tZGU8           g_txRate;

/* File globals */
static tZGLibPwrParam   g_pwrParam[ZG_LIB_MGMT_Q_SIZE] = {{kZGBoolFalse, kZGBoolFalse, kZGBoolFalse} };
static tZGS8            g_AppCounter = 0;

static tZGPsPwrMode    g_savePwrMode;
static tZGBool         g_savePwrDTIM;


/*****************************************************************************
 * FUNCTION: ZGLibCfgSetWpaPSK
 *
 * RETURNS: tZGVoidReturn
 *
 * PARAMS: psk
 *
 * NOTES:
 *****************************************************************************/
tZGVoidReturn
ZGLibCfgSetWpaPassPhrase(tZGS8Ptr userFriendlyStr, tZGU8 length)
{
   memcpy ( (void *) g_targetPassPhrase, (const void *) userFriendlyStr, length);
   g_targetPassPhrase[length] = (char) '\0';

   g_encType = kKeyTypeCalcPsk;
}

/*****************************************************************************
 * FUNCTION: ZGLibCfgMgmtSetWpaPSK
 *
 * RETURNS: tZGVoidReturn
 *
 * PARAMS: psk
 *
 * NOTES:
 *****************************************************************************/
tZGVoidReturn
ZGLibCfgSetWpaPSK(tZGU8Ptr psk)
{
   memcpy ( (void *) g_PMKKeyData, (const void *) psk, kZGMaxPmkLen );

   g_encType = kKeyTypePsk;
}


/*****************************************************************************
 * FUNCTION: ZGLibCfgMgmtSetWEPKey
 *
 * RETURNS: tZGVoidReturn
 *
 * PARAMS: psk
 *
 * NOTES:
 *****************************************************************************/
tZGVoidReturn
ZGLibCfgSetWEPKey(tZGU8Ptr wep, tZGU8 index, tZGU8 keyLen)
{
   memcpy ( (void *) g_WEPKeyData[index].key, (const void *) wep, keyLen );
   g_wepKeyLen = keyLen;

   g_encType =  kKeyTypeWep;
}


/*****************************************************************************
 * FUNCTION: ZGLibCfgSetMacAddress
 *
 * RETURNS: tZGVoidReturn
 *
 * PARAMS: tZGU8Ptr pMac - A pointer to a 6 byte array of MAC address
 *
 * NOTES: This routine will set the global g_targetMacAddress[] used by Adhoc
 *        and WiFi managers.
 *****************************************************************************/
tZGVoidReturn
ZGLibCfgSetMacAddress(tZGU8Ptr pMac)
{
    g_targetMACAddress[0] = (tZGU8) *pMac;
    g_targetMACAddress[1] = (tZGU8) *(pMac+1);
    g_targetMACAddress[2] = (tZGU8) *(pMac+2);
    g_targetMACAddress[3] = (tZGU8) *(pMac+3);
    g_targetMACAddress[4] = (tZGU8) *(pMac+4);
    g_targetMACAddress[5] = (tZGU8) *(pMac+5);

}

/*****************************************************************************
 * FUNCTION: ZGLibCfgSetSSID
 *
 * RETURNS: tZGVoidReturn
 *
 * PARAMS: tZGS8* pSsid = pointer to a string with SSID
 *         tZGU8 len = length of the string with SSID
 *
 * NOTES: This routine will set the global g_targetSsid[] used by Adhoc
 *        and WiFi managers.
 *****************************************************************************/
tZGVoidReturn
ZGLibCfgSetSSID(tZGS8* pSsid, tZGU8 len)
{
    memcpy( (void *) g_targetSsid, (const void *) pSsid, len);
    g_targetSsid[len] = (char) '\0';
}

/*****************************************************************************
 * FUNCTION: getAvailChannelRange
 *
 * RETURNS: tZGBool
 *                 TRUE 1 = the domain is known.
 *                 FALSE 0 = the domain is unknown.
 *
 * PARAMS: tZGU8 domain - Input only.   The Domain to check
 *         tZGU8Ptr min, max  - Output.  The min and max range of channel.
 *
 * NOTES: This routine will return a min <-> max range for a certain domain.
 *****************************************************************************/
static tZGBool
getAvailChannelRange( tZGU8 domain, tZGU8Ptr min, tZGU8Ptr max )
{

    switch ( domain )
    {
       case kZGRegDomainFCC:
       case kZGRegDomainIC:
            *min = 1;
            *max = 11;
            break;

       case kZGRegDomainETSI:
       case kZGRegDomainSpain:
       case kZGRegDomainFrance:
            *min=1;
            *max=13;
            break;

       case kZGRegDomainJapanA:
            *min=14;
            *max=14;
            break;

       case kZGRegDomainJapanB:
            *min=1;
            *max=13;
            break;

       default:
            return  kZGBoolFalse;
            break;

    }

    return kZGBoolTrue;

}

/*****************************************************************************
 * FUNCTION: ZGLibCfgSetRfChannelList
 *
 * RETURNS: tZGBool
 *                 TRUE 1 = the channel(s) could be set for current domain.
 *                 FALSE 0 = the channel(s) could not be set.
 *
 * PARAMS: tZGU8Ptr channelList - a byte array with no bounds.
 *         tZGU8 size - size of the byte array.
 *
 * NOTES: This routine will take a byte array, check it against domain range
 *        make sure the size is ok, then set g_targetChannels
 *****************************************************************************/
tZGBool
ZGLibCfgSetRfChannelList(tZGU8Ptr channelList, tZGU8 size)
{
  tZGU8 i, min, max;

  if ( size > kZGMaxScanChannels )
    return kZGBoolFalse;

  if ( !getAvailChannelRange( g_targetRegDom, &min, &max) )
  {
    ZGSYS_MODULE_ASSERT(1, (ROM FAR char*) "Selected Domain doesn't match channel table\n");
  }
  /* pre-parse the list for validity against domain */
  for (i=0; i < size; i++)
  {
    if ( (*channelList < min) || (*channelList > max))
       /* set all channels active to handle user input error */
       return kZGBoolFalse;
  }

  /* set the master/unified copy */
  for (i=0; i < size; i++)
  {
    g_targetChannels[i] = *channelList;
    channelList++;
  }

  g_targetActiveChannels = size;

  return kZGBoolTrue;

}

/*****************************************************************************
 * FUNCTION: ZGLibCfgSetAllRfChannels
 *
 * RETURNS: tZGVoidReturn
 *
 * PARAMS:  tZGVoidInput
 *
 * NOTES: This routine will set all channels for the current domain.
 *****************************************************************************/
tZGVoidReturn
ZGLibCfgSetAllRfChannels( tZGVoidInput )
{
  tZGU8 i, min, max;

  if ( !getAvailChannelRange( g_targetRegDom, &min, &max) )
  {
    ZGSYS_MODULE_ASSERT(1, (ROM FAR char*) "Selected Domain doesn't match channel table\n");
  }

  g_targetActiveChannels = (max-min)+1;

  for (i=0; i<g_targetActiveChannels; i++)
  {
    g_targetChannels[i] = min+i;
  }

}

/*****************************************************************************
 * FUNCTION: ZGLibCfgClearAllRfChannels
 *
 * RETURNS: tZGVoidReturn
 *
 * PARAMS:  tZGVoidInput
 *
 * NOTES: This routine will clear all channnels to zero.
 ****************************************************************************/
tZGVoidReturn
ZGLibCfgClearAllRfChannels( tZGVoidInput )
{
   memset(g_targetChannels, 0, kZGMaxScanChannels);
   g_targetActiveChannels = 0;
}



/*****************************************************************************
 * FUNCTION: dataCfrmRequest
 *
 * RETURNS: None
 *
 * PARAMS:   tZGVoidInput *appOpaquePtr for application data pass through...
 *
 * NOTES: Callback from the ZGLib, extern prototype in ZGLibRequest.h
 *****************************************************************************/
tZGU8
dataCfrmRequest (void * const ptrRequest, tZGVoidInput *appOpaquePtr)
{
    tZGU8Ptr ptrDataCfrmReq = (tZGU8Ptr)ptrRequest;

    if ( g_dataConfirmation == kZGBoolFalse )
      *ptrDataCfrmReq = 0;
    else
      *ptrDataCfrmReq = 1;

    return ( sizeof(tZGU8) );
}

/*****************************************************************************
 * FUNCTION: dataCfrmComplete
 *
 * RETURNS: None
 *
 * PARAMS:  tZGVoidInput *appOpaquePtr for application data pass through...
 *
 * NOTES: Callback from the ZGLib, extern prototype in ZGLibComplete.h
 *****************************************************************************/

tZGVoidReturn
dataCfrmComplete ( tZGU8 type, tZGDataPtr fourByteHeader, tZGDataPtr pBuf,
                   tZGU16 len, tZGVoidInput *appOpaquePtr)
{
   tZGU8 result = fourByteHeader[0];

   if( result != (tZGU8)kZGResultSuccess )
   {
      ZGSYS_MODULE_ASSERT(1, (ROM FAR char*) "Set TxData CFRM");
   }

}


/*****************************************************************************
 * FUNCTION: ZGLibSetDataCfrm
 *
 * RETURNS: tZGVoidReturn
 *
 * PARAMS: tZGBool bEnabled
 *                 1 = turn on confirmation on every pkt TX
 *                 0 = turn off confirmation on every pkt TX
 *
 * NOTES: This routine enables/disables data confirmation.  For RAW driver,
 *        it is necessary to disable data cfrm, as the stack and driver are not
 *        configured for this handshaking.   This is a CFG library function
 *        because this may be a very early setting, most appropriate for system
 *        wide init time.  Not so appropriate for a FSM table.
 *****************************************************************************/
tZGBool
ZGLibCfgSetDataCfrm(tZGBool bEnabled )
{
   tZGBool retCode = kZGBoolFalse;


   /* False0 to disable and True1 to enable */
   g_dataConfirmation = bEnabled;

   retCode = DISPATCH_ZGLIB( ZG_LIB_FUNC(ZGLibSetDataCfrm),
                             ZG_REQ_FUNC(dataCfrmRequest),
                             ZG_COMP_FUNC(dataCfrmComplete),
                             kNULL);

   return retCode;
}


/*****************************************************************************
 * FUNCTION: pwrStateRequest
 *
 * RETURNS: None
 *
 * PARAMS:   tZGVoidInput *appOpaquePtr for application data pass through...
 *
 * NOTES: Callback from the ZGLib, extern prototype in ZGLibRequest.h
 *****************************************************************************/

tZGU8
pwrStateRequest (void * const ptrRequest, tZGVoidInput *appOpaquePtr)
{
    tZGPwrModeReqPtr ptr = (tZGPwrModeReqPtr)ptrRequest;
    tZGLibPwrParamPtr ptrParam = (tZGLibPwrParamPtr) appOpaquePtr;

    if( ptrParam->enabled )
    {
        ZGPrvComSetLowPowerMode( kZGBoolTrue );
        ptr->mode = kZGPsPwrModeSave;
        ptr->wake = 0;
        ptr->rcvDtims = ptrParam->rxDTIM;
    }
    else

    {
        ZGPrvComSetLowPowerMode( kZGBoolFalse );
        ptr->mode = kZGPsPwrModeActive;
        ptr->wake = 1;
        ptr->rcvDtims = 1;
    }

    ptrParam->pending = kZGBoolTrue;

    return ( sizeof(tZGPwrModeReq) );

}


/*****************************************************************************
 * FUNCTION: pwrStateComplete
 *
 * RETURNS: None
 *
 * PARAMS:  tZGVoidInput *appOpaquePtr for application data pass through...
 *
 * NOTES: Callback from the ZGLib, extern prototype in ZGLibComplete.h
 *****************************************************************************/

tZGVoidReturn
pwrStateComplete ( tZGU8 type, tZGDataPtr fourByteHeader, tZGDataPtr pBuf,
                   tZGU16 len, tZGVoidInput *appOpaquePtr)
{
   tZGLibPwrParamPtr ptrParam = (tZGLibPwrParamPtr) appOpaquePtr;
   tZGU8 result = fourByteHeader[0];

   if( result == (tZGU8)kZGResultSuccess )
   {
       ZGLibLoadConfirmBuffer(pBuf, sizeof(tZGLibPwrParam), 0);

       g_pwrMgmtEnabled= ptrParam->enabled;
       g_pwrRxDTIMEnabled = ptrParam->rxDTIM;
   }

   /* the slot can be re-used */
   ptrParam->pending = kZGBoolFalse;
}


/*****************************************************************************
 * FUNCTION: ZGLibCfgSetPwrMgmtState
 *
 * RETURNS: tZGVoidReturn
 *
 * PARAMS: tZGBool bActive
 *                 1 = enable power savings ( disable RF )
 *                 0 = disable power savings ( active mode )
 *
 * NOTES: This routine sets the desired power mode.  The instaneous mode
 *        can be overridden by any system L7 application or the WiFi mgr.
 *****************************************************************************/
tZGBool
ZGLibCfgSetPwrMgmtState(tZGBool bEnabled, tZGBool bRxDTIM )
{
   tZGBool retCode = kZGBoolFalse;
   tZGU8 slot = 0;

   /* On a RTOS this code would need to be protected with a mutex */

   /* linear search for a free slot for the caller's parameters */
   while ( slot < ZG_LIB_MGMT_Q_SIZE )
   {

     /* In theory, multiple applications could call this API */
     /* each call would have it's own context. Each caller's context */
     /* can't be comitted to one global variable unitl the G2100  */
     /* completes each ZGSet successfully.  This can be done in the complete */
     /* callback */
     if  ( !g_pwrParam[slot].pending )
     {
        g_pwrParam[slot].enabled = bEnabled;
        g_pwrParam[slot].rxDTIM = bRxDTIM;

        retCode =  DISPATCH_ZGLIB( ZG_LIB_FUNC(ZGLibSetPwrSaveMode),
                                   ZG_REQ_FUNC(pwrStateRequest),
                                   ZG_COMP_FUNC(pwrStateComplete),
                                   &g_pwrParam[slot] );

        break;
     }

     slot++;
   }

   return retCode;
}

/*****************************************************************************
 * FUNCTION: ZGLibCfgTempRestorePwrState
 *
 * RETURNS:  tZGVoidReturn
 *
 * PARAMS: tZGVoidReturn
 *
 * NOTES: This routine is called when the L7 application is done with a RX/TX
 *        burst.  If an application knows it will being sending/recieving
 *        traffic, then it is best to disable power saving.  When the application
 *        is done, this routine will decrement a total interested count.  The
 *        last system application  ( count = 0)  will restore the desired
 *        power savings mode.
 *****************************************************************************/
tZGVoidReturn
ZGLibCfgTempRestorePwrState(tZGVoidInput)
{

    /* Note: For RTOS this should be protected with a mutex */
    if ( --g_AppCounter <= 0 )
    {
      /* spin until library can complete this request */
      while ( !ZGLibCfgSetPwrMgmtState(g_savePwrMode, g_savePwrDTIM) )
      {
         ZGProcess();
      }

       g_AppCounter = 0;
    }

}

/*****************************************************************************
 * FUNCTION: ZGLibCfgTempDisablePwrState
 *
 * RETURNS:  tZGVoidReturn
 *
 * PARAMS: tZGVoidReturn
 *
 * NOTES: This routine is called when the L7 application is ready with a RX/TX
 *        burst.  If an application knows it will being sending/recieving
 *        traffic, then it is best to temp disable power saving.
 *****************************************************************************/
tZGVoidReturn
ZGLibCfgTempDisablePwrState(tZGVoidInput)
{

    /* Note: For RTOS this should be protected with a mutex */
    if ( g_AppCounter++ == 0 )
    {
       /* spin until library can complete this request */
       while ( !ZGLibCfgSetPwrMgmtState(kZGBoolFalse, kZGBoolTrue) )
       {
         ZGProcess();
       }

       g_savePwrMode =  g_pwrMgmtEnabled;
       g_savePwrDTIM =  g_pwrRxDTIMEnabled;

    }

}

/*****************************************************************************
 * FUNCTION: ZGLibCfgSetDHCPState(tZGBool dhcp)
 *
 * RETURNS:  tZGVoidReturn
 *
 * PARAMS: tZGBool
 *                 DHCP_ENABLED  = TRUE = 1 = Enable DHCP Client
 *                 DHCP_DISABLED = FALSE = 0 = Disable DHCP Client
 *
 * NOTES: This routine is called by the ifconfig application to turn on
 *        DHCP ( dynamic IP address) discovery & renewal.
 *****************************************************************************/
#if defined(ZG_CONFIG_DHCP) && defined(STACK_USE_DHCP_CLIENT)
tZGVoidReturn
ZGLibCfgSetDHCPState(tZGBool dhcp)
{
    if ( dhcp != g_DHCP )
    {
       g_DHCP = dhcp;

       if ( g_DHCP == DHCP_ENABLED )
       {
         AppConfig.Flags.bIsDHCPEnabled = TRUE;
         DHCPEnable(0);
       }
       else
       {
         AppConfig.Flags.bIsDHCPEnabled = FALSE;
         DHCPDisable(0);
       }

    }
}
#endif /* ZG_CONFIG_DHCP */


#endif /* ZG_CONFIG_LIBRARY */


#endif // #if defined(ZG_CS_TRIS)
