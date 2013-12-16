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

/******************************************************************************/
/*                                                                            */
/* File:                                                                      */
/*     ZGConsoleIwconfig.c                                                    */
/*                                                                            */
/* Description:                                                               */
/*     Implements iwconfig command.                                           */
/*                                                                            */
/* DO NOT DELETE THIS LEGAL NOTICE:                                           */
/*  2008 © ZeroG Wireless, Inc.  All Rights Reserved.                         */
/*  Confidential and proprietary software of ZeroG Wireless, Inc.             */
/*  Do no copy, forward or distribute.                                        */
/*                                                                            */
/******************************************************************************/
#include "TCPIP Stack/TCPIP.h"

#if defined(ZG_CS_TRIS) && defined ( ZG_CONFIG_CONSOLE )


//============================================================================
//                                  Includes
//============================================================================
#include <ctype.h>
#include <stdio.h>
#include <string.h>

#include "TCPIP Stack/ZGLinkMgrII.h"
#include "TCPIP Stack/ZGLibCfg.h"
#include "TCPIP Stack/ZGConsole.h"
#include "TCPIP Stack/ZGConsoleIwconfig.h"
#include "TCPIP Stack/ZGConsoleMsgs.h"
#include "TCPIP Stack/ZGConsoleMsgHandler.h"


//============================================================================
//                                  Constants
//============================================================================

// These defines must match indexes in gParams[]
enum {
    kZGAuthModeParam = 0,
    kZGChannelParam,
    kZGDomainParam,
    kZGKeyParam,
    kZGMacParam,
    kZGModeParam,
    kZGPowerParam,
    kZGRateParam,
    kZGRetryParam,
    kZGRtsParam,
    kZGSensParam,
    kZGSsidParam,
    kZGTxPowerParam,
    kZGTxRateParam,
    kZGNumParam  /* must be last */
};

#define kZGUnknownParam         (0xff)

// command line parsing states
enum
{
    kZGWaitingForParamKeyword = 0,
    kZGWaitingForAuthMode,
    kZGWaitingForChannel,
    kZGWaitingForDomain,
    kZGWaitingForKey,
    kZGWaitingForMac,
    kZGWaitingForMode,
    kZGWaitingForPower,
    kZGWaitingForRate,
    kZGWaitingForRetry,
    kZGWaitingForRts,
    kZGWaitingForSens,
    kZGWaitingForSsid,
    kZGWaitingForTxPower,
    kZGWaitingForTxRate
};


//============================================================================
//                                  Globals
//============================================================================

// the indexes of these param strings are used in the flags array in gParamState
ROM FAR char* gParams1[] = {
    "authmode",
    "channel",
    "domain",
    "key",
    "mac",
    "mode",
    "power",
    "rate",
    "retry",
    "rts",
    "sens",
    "ssid",
    "txpower",
    "txrate"
};

static tZGU8         gLineParseState;

//============================================================================
//                                  Local Function Prototypes
//============================================================================
static tZGBool getParam(tZGU8 index);
static tZGU8 getParamType(tZGS8 *p_paramString);

static tZGBool g_bDisplay;

static tZGVoidReturn IwconfigDisplayStatus(tZGVoidInput);

#define IWCONFIG_CONFIG_TXRATE  y

#if !defined(ZG_NO_FUNC_PTRS) && defined(IWCONFIG_CONFIG_TXRATE)
  static tZGVoidReturn iwconfig_set_txrate(tZGU8 rate);
  static tZGVoidReturn iwconfig_get_txrate(tZGVoidInput);
#else
  #define iwconfig_set_txrate(x)
  #define iwconfig_get_txrate()
#endif

/*****************************************************************************
 * FUNCTION: iwconfigSetRtsRequest
 *
 * RETURNS: None
 *
 * PARAMS:   tZGVoidInput *appOpaquePtr for application data pass through...
 *
 * NOTES: Callback from the ZGLib, extern prototype in ZGLibRequest.h
 ************************************************************************/

tZGU8
iwconfigSetRtsRequest(void * const ptrRequest, tZGVoidInput *appOpaquePtr)
{
  tZGU8 *ptrReq = ptrRequest;
  tZGU16 *ptrRtsValue = (tZGU16 *) appOpaquePtr;

  if ( appOpaquePtr == kNULL )
     ZGSYS_MODULE_ASSERT(2, (ROM FAR char*)"SetRts\n\r");

  ptrReq[0] = (tZGU8) (*ptrRtsValue >> 8);
  ptrReq[1] = (tZGU8) (*ptrRtsValue & 0x00FF);

  /* This return information is required for the RAW driver */
  /* Two bytes were modified in request buffer */
   return ( sizeof(tZGU8) * 2 );

}


/*****************************************************************************
 * FUNCTION: iwconfigComplete
 *
 * RETURNS: None
 *
 * PARAMS:  tZGVoidInput *appOpaquePtr for application data pass through...
 *
 * NOTES: Callback from the ZGLib, extern prototype in ZGLibComplete.h
 *****************************************************************************/

tZGVoidReturn
iwconfigSetRtsComplete (tZGU8 type, tZGDataPtr fourByteHeader, tZGDataPtr pBuf,
                        tZGU16 len, tZGVoidInput *appOpaquePtr)
{
   tZGU8  result = fourByteHeader[0];
   tZGU16 *ptrRtsValue = (tZGU16 *) appOpaquePtr;

   if( result == (tZGU8)kZGResultSuccess )
   {
      /* Update the user value to the global cache - the set worked */
      ZG_SET_RTS ( *ptrRtsValue );
   }
   else
       ZG_PUTRSUART("\tError, unable to set RTS\n\r");

}


tZGVoidReturn
iwconfigGetRtsComplete (tZGU8 type, tZGDataPtr fourByteHeader, tZGDataPtr pBuf,
                        tZGU16 len, tZGVoidInput *appOpaquePtr)
{
   tZGBool *bDisplayPtr  = (tZGBool*) appOpaquePtr;
   tZGU8  result = fourByteHeader[0];

   if( result == (tZGU8)kZGResultSuccess )
   {
      ZGLibLoadConfirmBuffer(pBuf, sizeof(tZGU8)*2, 0);

      /* Update the global cached copy from the get request */
      ZG_SET_RTS ( ((tZGU16)pBuf[kZGGetMACParamCnfSZ] << 8) | pBuf[kZGGetMACParamCnfSZ+1] );

      if (bDisplayPtr != NULL)
      {
       if ( *bDisplayPtr == kZGBoolTrue )
           {
         IwconfigDisplayStatus();
   }
      }     
   }
   else
       ZG_PUTRSUART("\tError, unable to get RTS\n\r");

}



tZGVoidReturn
iwconfigGetRadioComplete (tZGU8 type, tZGDataPtr fourByteHeader, tZGDataPtr pBuf,
                     tZGU16 len, tZGVoidInput *appOpaquePtr)
{
   tZGBool *bDisplayPtr  = (tZGBool*) appOpaquePtr;
   tZGU8  result = fourByteHeader[0];

   if( result == (tZGU8)kZGResultSuccess )
   {
      ZGLibLoadConfirmBuffer(pBuf, sizeof(tZGU8), 0);

      /* Update Global Cache with current radio state */
      ZG_SET_RADIO_STATE( (tZGU8) pBuf[kZGGetMACParamCnfSZ] );

      if (bDisplayPtr != NULL)
      {
      if ( *bDisplayPtr == kZGBoolTrue )
           {
         IwconfigDisplayStatus();
   }
      }     
   }

}


/*****************************************************************************
 * FUNCTION: displayStatus
 *
 * RETURNS: None
 *
 * PARAMS:    None
 *
 * NOTES:   Responds to the user invoking iwconfig with no parameters
 *****************************************************************************/
tZGVoidReturn
IwconfigDisplayStatus(tZGVoidInput)
{
    tZGU8 tmp;

    if ( ZG_GET_RADIO_STATE() )
    {
        tZGU8Ptr list = ZG_GET_CHANNELS_LIST();
        ZG_PUTRSUART("\tchannel:  ");

        tmp = ZG_GET_ACTIVE_CHANNELS();

        while ( --tmp > 0u )
        {
           sprintf( (char *) g_ConsoleContext.txBuf,"%d,", *list);
           ZG_PUTSUART( (char *) g_ConsoleContext.txBuf );
           list++;
        }

        sprintf( (char *) g_ConsoleContext.txBuf,"%d\n\r", *list);
        ZG_PUTSUART( (char *) g_ConsoleContext.txBuf );

    }
    else
    {
        ZG_PUTRSUART("\tchannel:  RF disabled\n\r");
    }


    sprintf( (char *) g_ConsoleContext.txBuf,

#if defined( __18CXX)
            "\tdomain:   %HS\n\r",
#else
            "\tdomain:   %s\n\r",
#endif
            (ROM FAR char*) ZG_GET_CUR_DOM_STR() );


    ZG_PUTSUART( (char *) g_ConsoleContext.txBuf );


    sprintf( (char *) g_ConsoleContext.txBuf,
             "\trts:      %d\n\r", ZG_GET_RTS() );
    ZG_PUTSUART( (char *) g_ConsoleContext.txBuf );


    switch ( ZG_GET_MODE() )
    {

#if !defined (ZG_CONFIG_NO_WIFIMGRII)
      case kZGLMNetworkModeInfrastructure :

        sprintf( (char *) g_ConsoleContext.txBuf,

        #if defined( __18CXX)
                "\tmode:     %HS\n\r",
        #else
                "\tmode:     %s\n\r",
        #endif
                (ROM FAR char*) kZGManagedModeString);


        ZG_PUTSUART( (char *) g_ConsoleContext.txBuf );
        break;
#endif /* WIFI MANAGER */

#if !defined (ZG_CONFIG_NO_ADHOCMGRII)
      case kZGLMNetworkModeAdhoc:

        sprintf( (char *) g_ConsoleContext.txBuf,

        #if defined( __18CXX)
                 "\tmode:     %HS\n\r",
        #else
                 "\tmode:     %s\n\r",
        #endif
                 (ROM FAR char*) kZGAdHocModeString);

        ZG_PUTSUART( (char *) g_ConsoleContext.txBuf );
        break;
#endif /* ADHOC MANAGER */

      case kZGLMNetworkModeIdle:

        sprintf( (char *) g_ConsoleContext.txBuf,
        #if defined( __18CXX)
                "\tmode:     %HS\n\r",
        #else
                "\tmode:     %s\n\r",
        #endif
               (ROM FAR char*) kZGIdleModeString);

        ZG_PUTSUART( (char *) g_ConsoleContext.txBuf );
        break;

       default:

         ZG_PUTRSUART( "\tmode:     Unknown\n\r");

     } /* end case */


     sprintf( (char *) g_ConsoleContext.txBuf,
              "\tssid:     %s\n\r", (char *) ZG_GET_SSID() );

     ZG_PUTSUART( (char *) g_ConsoleContext.txBuf );


    if ( ZG_IS_PWR_MGMT_ENABLED() == kZGBoolTrue )
    {
       ZG_PUTRSUART("\tpwrsave:  enabled\n\r");

       if (  ZG_IS_DTIM_ENABLED() == kZGBoolTrue )
           ZG_PUTRSUART("\tdtim rx:  enabled\n\r");
       else
           ZG_PUTRSUART("\tdtim rx:  disabled\n\r");
    }
    else
        ZG_PUTRSUART("\tpwrsave:  disabled\n\r");

    //ZGConsoleReleaseConsoleMsg();
}

/*****************************************************************************
 * FUNCTION: do_iwconfig_cmd
 *
 * RETURNS: None
 *
 * PARAMS:    None
 *
 * NOTES:   Responds to the user invoking iwconfig
 *****************************************************************************/
tZGVoidReturn
do_iwconfig_cmd(tZGVoidInput)
{
    tZGU8 i;
    tZGU8 buf[4];
    tZGU16 val;

    //ZGConsoleSetMsgFlag();

    /* reset the parse state, otherwise a "iwconfig" by itself, following a real parse error */
    /* will cause the "Missing value" msg, when in fact a sole iwconfig byitself is ok */
    gLineParseState = kZGWaitingForParamKeyword;

    // if user only typed in iwconfig with no other parameters
    if (ARGC == 1u)
    {

       if ( DISPATCH_ZGLIB( ZG_LIB_FUNC(ZGLibGetRTS),
                            kNULL,
                            ZG_COMP_FUNC(iwconfigGetRtsComplete),
                            kNULL ) != kZGSuccess )
       {
         ZG_PUTRSUART("Device busy, try again...\n\r");
       }
       else
       {
          g_bDisplay =  kZGBoolTrue;

          if ( DISPATCH_ZGLIB( ZG_LIB_FUNC(ZGLibGetRadioState),
                               kNULL,
                               ZG_COMP_FUNC(iwconfigGetRadioComplete),
                               &g_bDisplay ) != kZGSuccess )
          {
            ZG_PUTRSUART( "Device busy, try again...\n\r");
          }
       }

    }
   // else loop through each parameter
    else
    {
        // parse each param and set state variables
        for (i = 1; i < ARGC; ++i)
        {
            switch (gLineParseState)
            {
                case kZGWaitingForParamKeyword:
                    if ( !getParam(i) )
                    {
                        goto iwconfig_cmd_error; //return;
                    }
                    break;


                case kZGWaitingForDomain:
                    if ( ZG_IS_CONNECTED() == kZGBoolTrue )
                    {
                         ZG_PUTRSUART("Domain can only be set in idle mode");
                        goto iwconfig_cmd_error; //return;
                    }

                    buf[0] = ZG_GET_DOM();

                    if (!ExtractandValidateDomain(ARGV[i], &buf[0]) )
                    {
                        goto iwconfig_cmd_error; //return;
                    }

                    /* set to the desired domain */
                    ZG_SET_DOM(buf[0]);

                    /* automatically select appropriate channels for this domain */
                    ZG_SET_ALL_CHANNELS();
                    gLineParseState = kZGWaitingForParamKeyword;
                    break;


                case kZGWaitingForChannel:
                    if ( ZG_IS_CONNECTED() == kZGBoolTrue )
                    {
                         ZG_PUTRSUART("Channel can only be set in idle mode");
                        goto iwconfig_cmd_error; //return;
                    }
                    if ( ExtractandValidateRfChannelAll( ARGV[i] ) )
                    {
                        ZG_SET_ALL_CHANNELS();
                    }
                    /* buf[0] will contain the size of the channel list */
                    /* Will parse and modify ARGV in place, to remove comma delimeter */
                    else if ( ExtractandValidateRfChannelList( ARGV[i], &buf[0]) )
                    {

                       if ( !ZG_SET_CHANNEL_LIST( (tZGU8Ptr) ARGV[i], buf[0] ) )
                       {
                          ZG_PUTRSUART("Channel selection invalid for domain type");
                          goto iwconfig_cmd_error; //return;
                       }
                    }
                    else
                        goto iwconfig_cmd_error; //return;

                    gLineParseState = kZGWaitingForParamKeyword;
                    break;


                case kZGWaitingForRts:

                    if ( !ExtractandValidateRts(ARGV[i], &g_Rts) )
                    {
                        goto iwconfig_cmd_error; //return;
                    }

                    if ( DISPATCH_ZGLIB( ZG_LIB_FUNC(ZGLibSetRTS),
                                         ZG_REQ_FUNC(iwconfigSetRtsRequest),
                                         ZG_COMP_FUNC(iwconfigSetRtsComplete),
                                         &g_Rts ) != kZGSuccess )
                    {
                       ZG_PUTRSUART( "Device busy, try again...\n\r");
                    }

                    g_bDisplay =  kZGBoolFalse;

                    if ( DISPATCH_ZGLIB( ZG_LIB_FUNC(ZGLibGetRadioState),
                                         kNULL,
                                         ZG_COMP_FUNC(iwconfigGetRadioComplete),
                                         &g_bDisplay ) != kZGSuccess )
                    {
                        ZG_PUTRSUART( "Device busy, try again...\n\r");
                    }

                    gLineParseState = kZGWaitingForParamKeyword;
                    break;

               case kZGWaitingForTxRate:

                   if ( !ExtractandValidateU16Range(ARGV[i], &val, 0, 2) )
                   {
                     goto iwconfig_cmd_error; //return;
                   }

                   iwconfig_set_txrate(val);

                   ZG_SET_TXRATE ( val );

                   gLineParseState = kZGWaitingForParamKeyword;
                   break;

                case kZGWaitingForMode:
                    if ( !ExtractandValidateMode(ARGV[i], &buf[0]) )
                    {
                        goto iwconfig_cmd_error; //return;
                    }
                    ZG_SETNEXT_MODE( buf[0] );
                    gLineParseState = kZGWaitingForParamKeyword;

                    //ZGConsoleReleaseConsoleMsg();
                    break;


                case kZGWaitingForPower:

                    #if !defined (ZG_CONFIG_NO_ADHOCMGRII)
                    if ( ZG_GET_MODE() == kZGLMNetworkModeAdhoc )
                    {
                       ZG_PUTRSUART("   Power save not avail in adhoc mode");
                       goto iwconfig_cmd_error; //return;
                    }
                    #endif

                    /* buf[2] contains a boolean */
                    if ( ExtractandValidatePower(ARGV[i], &buf[2]) )
                    {
                        ZG_SET_PWR_MGMT( (tZGBool) buf[2] );
                        gLineParseState = kZGWaitingForParamKeyword;
                    }
                    else if ( ExtractandValidateDTIM(ARGV[i], &buf[2]) )
                    {
                        ZG_SET_DTIM( (tZGBool) buf[2] );
                        gLineParseState = kZGWaitingForParamKeyword;
                    }
                    else
                    {
                        ZG_PUTRSUART("   Invalid power param");
                        goto iwconfig_cmd_error; //return;
                    }
                    break;


                case kZGWaitingForSsid:
                    if ( ZG_IS_CONNECTED() == kZGBoolTrue )
                    {
                        ZG_PUTRSUART("SSID can only be set in idle mode");
                        goto iwconfig_cmd_error; //return;
                    }
                    /* buf[3] contains strlen */
                    if ( !ExtractandValidateSSID(ARGV[i], &buf[3]) )
                    {

                        sprintf( (char *) g_ConsoleContext.txBuf,
                                "SSID must be < %d chars", kZGMaxSsidLen);

                        ZG_PUTSUART( (char *) g_ConsoleContext.txBuf );

                        goto iwconfig_cmd_error; //return;
                    }
                    ZG_SET_SSID( ARGV[i], buf[3]);
                    gLineParseState = kZGWaitingForParamKeyword;
                    break;


                case kZGWaitingForAuthMode:
                case kZGWaitingForKey:
                case kZGWaitingForMac:
                case kZGWaitingForRate:
                case kZGWaitingForRetry:
                case kZGWaitingForSens:
                case kZGWaitingForTxPower:
                    break;


            } // end switch

//            ZGConsolePrintf("%s ", ARGV[i]);

        } // end for
    }

    switch (gLineParseState)
    {
    case kZGWaitingForTxRate:
        iwconfig_get_txrate();
        gLineParseState = kZGWaitingForParamKeyword;
        break;

    default:
        // do nothing
        break;
    }

    if (gLineParseState != (tZGU8)kZGWaitingForParamKeyword)
    {
        ZG_PUTRSUART("Missing value for last parameter");
        goto iwconfig_cmd_error; //return;
    }

    return;

iwconfig_cmd_error:

    ZG_PUTRSUART("iwconfig cmd error");

    return;
}


/*****************************************************************************
 * FUNCTION: getParam

 *
 * RETURNS: None
 *
 * PARAMS:    tokenIndex -- index of token in the command line
 *
 * NOTES:
 *****************************************************************************/
static tZGBool getParam(tZGU8 tokenIndex)
{
    tZGU8 paramType;

    // Parse the token and return it's corresponding paramType id
    paramType = getParamType(ARGV[tokenIndex]);

    // set the state of the line parsing state machine based on the parameter type.
    // Either need to wait for a value or go on to the next parameter
    switch (paramType)
    {
        case kZGUnknownParam:
            sprintf( (char *) g_ConsoleContext.txBuf,
                     "Param %d invalid", tokenIndex);
            ZG_PUTSUART( (char *) g_ConsoleContext.txBuf );
            return kZGBoolFalse;

        case kZGAuthModeParam:
            gLineParseState = kZGWaitingForAuthMode;
            break;

        case kZGChannelParam:
            gLineParseState = kZGWaitingForChannel;
            break;

        case kZGDomainParam:
            gLineParseState = kZGWaitingForDomain;
            break;

        case kZGRtsParam:
            gLineParseState = kZGWaitingForRts;
            break;

        case kZGModeParam:
            gLineParseState = kZGWaitingForMode;
            break;

        case kZGPowerParam:
            gLineParseState = kZGWaitingForPower;
            break;

        case kZGSsidParam:
            gLineParseState = kZGWaitingForSsid;
            break;

        case kZGTxRateParam:
             gLineParseState = kZGWaitingForTxRate;
        break;

        case kZGKeyParam:
        case kZGMacParam:
        case kZGRateParam:
        case kZGRetryParam:
        case kZGSensParam:
        case kZGTxPowerParam:
            sprintf( (char *) g_ConsoleContext.txBuf,
                     "Param %d not supported", tokenIndex);
            ZG_PUTSUART( (char *) g_ConsoleContext.txBuf );
            return kZGBoolFalse;

        default:
            sprintf( (char *) g_ConsoleContext.txBuf,
                    "Param %d not handled", tokenIndex);
            ZG_PUTSUART( (char *) g_ConsoleContext.txBuf );
            return kZGBoolFalse;
    }

    return kZGBoolTrue;
}


static tZGU8 getParamType(tZGS8 *p_paramString)
{
    tZGU8 i;

    for (i = 0; i < sizeof(gParams1)/sizeof(gParams1[0]); ++i)
    {
        if ( strcmppgm2ram((char *)p_paramString, gParams1[i]) == 0)
        {
            return i;
        }
    }

    return kZGUnknownParam;
}

#if !defined(ZG_NO_FUNC_PTRS)
/* Requires function pointers */

/*
* The following utility functions are written to demostrate how
* Link Manager Library API functions work.
* Code size is sacrificed in exchange for clarity.
*
*/

/*
* Common and generic
*
*/

static tZGU16 gGenericCtx;

static tZGVoidReturn
iwconfig_generic_set_command_complete_cb (tZGU8 type, tZGDataPtr fourByteHeader, tZGDataPtr pBuf,
                                          tZGU16 len, tZGVoidInput *appOpaquePtr)
{
    tZGU8  result = fourByteHeader[0];

    if( result != kZGResultSuccess )
        ZG_PUTRSUART("\tError, unable to set parameter value\n");
}

static tZGU8
iwconfig_generic_get_command_request_cb(void * const ptrRequest, tZGVoidInput *appOpaquePtr)
{
    /* do nothing */
    return 0;
}

static tZGVoidReturn
iwconfig_generic_get_command_complete_cb (tZGU8 type, tZGDataPtr fourByteHeader, tZGDataPtr pBuf,
                                          tZGU16 len, tZGVoidInput *appOpaquePtr)
{
    tZGU8  result = fourByteHeader[0];
    /* tZGU8  *ptr = (tZGU8 *) pBuf; */

    if( result != kZGResultSuccess )
    {
        ZG_PUTRSUART("\tError, unable to set parameter value\n");
        return;
    }

    /* The following move the pointer over and pass the fourByteHeader[] */
    /* ptr += 4; */

    /* ptr now points to the info requested. */
}

#ifdef IWCONFIG_CONFIG_TXRATE

/* -------------------------------------------------------------------
*
* command: "iwconfig txrate [0 | 1 | 2]"
*
*/

typedef struct
{
    tZGU8 rate;
} tZGParamTxThrottleTableOnOff;

static tZGU8
iwconfig_set_txrate_request_cb(void * const ptrRequest, tZGVoidInput *appOpaquePtr)
{
    tZGParamTxThrottleTableOnOff *ptrReq = ptrRequest;
    tZGU16 value = *((tZGU16 *)appOpaquePtr);

    switch (value)
    {
    case 0:
        ptrReq->rate = 0x01; /* auto-rate */
        break;

    case 1:
        ptrReq->rate = 0x20; /* 1 Mbps */
        break;

    case 2:
        ptrReq->rate = 0x40; /* 2 Mbps */
        break;

    default:
        ptrReq->rate = 0x01; /* auto-rate */
        break;
    }

    return (sizeof(tZGParamTxThrottleTableOnOff));
}

static tZGVoidReturn
iwconfig_get_txrate_complete_cb (tZGU8 type, tZGDataPtr fourByteHeader, tZGDataPtr pBuf,
                                 tZGU16 len, tZGVoidInput *appOpaquePtr)
{
    tZGGetMACParamCnf *pConfirm = (tZGGetMACParamCnf *) &(fourByteHeader[0]);
    tZGParamTxThrottleTableOnOff  *ptr = (tZGParamTxThrottleTableOnOff  *) (((tZGU8 *) pBuf) + 4) ;

    if( pConfirm->result != kZGResultSuccess )
    {
        ZG_PUTRSUART("\tError, unable to set parameter value\n");
        return;
    }

    if (ptr->rate & 0x01)       /* auto-rate */
    {
        ptr->rate = 0;
    }
    else if (ptr->rate & 0x20)  /* 1 Mbps */
    {
        ptr->rate = 1;
    }
    else if (ptr->rate & 0x40)  /* 2 Mbps */
    {
        ptr->rate = 2;
    }
    else
    {
        /* Error condition. Don't really know what to do. */
        /* Here we call the generic cb function just to make the compiler happy. */
        iwconfig_generic_get_command_complete_cb(type, fourByteHeader, pBuf, len, appOpaquePtr);
        return;
    }

    sprintf( (char *) g_ConsoleContext.txBuf,
        "%u \n", (tZGU16) ptr->rate);
    ZG_PUTSUART( (char *) g_ConsoleContext.txBuf );
}

static tZGVoidReturn
iwconfig_set_txrate(tZGU8 rate)
{
    gGenericCtx = rate;

    if ( ZGLibManagementRequest(
        sizeof(tZGParamTxThrottleTableOnOff),
        kZGMSGSetParam,
        kZGParamTxThrottleTableOnOff,
        ZG_REQ_FUNC(iwconfig_set_txrate_request_cb),
        ZG_COMP_FUNC(iwconfig_generic_set_command_complete_cb), /* generic version for "set-complete" callback is usually adequate */
        &gGenericCtx)
        != kZGSuccess )
    {
        ZG_PUTRSUART("Device busy, try again...\n");
    }
}

static tZGVoidReturn
iwconfig_get_txrate(tZGVoidInput)
{
    if ( ZGLibManagementRequest(
        sizeof(tZGParamTxThrottleTableOnOff),
        kZGMSGGetParam,
        kZGParamTxThrottleTableOnOff,
        ZG_REQ_FUNC(iwconfig_generic_get_command_request_cb),  /* generic version for "get-request" callback is usually adequate */
        ZG_COMP_FUNC(iwconfig_get_txrate_complete_cb),
        &gGenericCtx)
        != kZGSuccess )
    {
        ZG_PUTRSUART("Device busy, try again...\n");
    }
}
#endif /* IWCONFIG_CONFIG_TXRATE */

#endif /* !defined(ZG_NO_FUNC_PTRS) */

#endif  /* ZG_CONFIG_CONSOLE */
