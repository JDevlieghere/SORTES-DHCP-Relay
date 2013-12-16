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
/*        ZGConsoleIwpriv.c                                                   */
/*                                                                            */
/* Description:                                                               */
/*        Implements iwpriv command.                                          */
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
#include "TCPIP Stack/ZGConsoleIwpriv.h"
#include "TCPIP Stack/ZGConsoleMsgs.h"
#include "TCPIP Stack/ZGConsoleMsgHandler.h"


//============================================================================
//                                  Constants
//============================================================================

// These defines must match indexes in gParam[]
enum {

    kZGWpaPskParam = 0,
    kZGWpaStrParam,
    kZGEncTypeParam,
    kZGWepAuthParam,
    kZGWepKeyParam,
    kZGBeaconParam,
    kZGNumParam  /* must be last */
};

#define kZGUnknownParam         (0xff)


// states for state machine
enum
{
    kZGWaitingForParamKeyword = 0,
    kZGWaitingForWpaPsk,
    kZGWaitingForWpaStr,
    kZGWaitingForEnc,
    kZGWaitingForWepAuth,
    kZGWaitingForWepKey,
    kZGWaitingForBeacon
};


//============================================================================
//                                  Globals
//============================================================================

// the indexes of these param strings are used in the flags array in gParamState
ROM FAR char* gParams2[] = {
    "psk",
    "phrase",
    "enc",
    "auth",
    "key",
    "beacon"
};


//static tZGIfParams   gParamState;         // used to process an individual ifconfig command
static tZGU8         gLineParseState;


//============================================================================
//                                  Local Function Prototypes
//============================================================================
static tZGVoidReturn IwprivDisplayStatus(tZGVoidInput);
static tZGBool getParam(tZGU8 index);
static tZGU8 getParamType(tZGS8 *p_paramString);
static tZGVoidReturn iwpriv_beacon(tZGVoidInput);

/*****************************************************************************
* FUNCTION: do_iwpriv_cmd
*
* RETURNS: None
*
* PARAMS:    None
*
* NOTES:   Responds to the user invoking ifconfig
*****************************************************************************/
tZGVoidReturn do_iwpriv_cmd(tZGVoidInput)
{
    tZGU8  i;
    tZGU8  temp;
    tZGBool cont_parse;
    tZGS8* ptrString;

    gLineParseState = kZGWaitingForParamKeyword;

    // if user only typed in iwpriv with no other parameters
    if (ARGC == 1u)
    {
        IwprivDisplayStatus();
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
                    return;
                }

                break;

            case kZGWaitingForWpaPsk:

                /* Can only set security in idle state */
                if ( ZG_IS_CONNECTED() == kZGBoolTrue )
                {
                    ZG_PUTRSUART("Security context may only be set in idle state\n\r");
                    return;
                }

                /* The ARGV buffer is modified in place  */
                if ( !ExtractandValidateWpaPSK( ARGV[i] ) )
                {
                    ZG_PUTRSUART("WPA PSK must be exactly 64 bytes\n\r");
                    return;
                }

                ZG_SET_WPAPSK( (tZGU8Ptr) ARGV[i] );
                gLineParseState = kZGWaitingForParamKeyword;

                break;

            case kZGWaitingForWpaStr:

                /* Can only set security in idle state */
                if ( ZG_IS_CONNECTED() == kZGBoolTrue )
                {
                    ZG_PUTRSUART("Security context may only be set in idle state\n\r");
                    return;
                }

                ptrString = ARGV[i++];

                /* if the start char is found, gobble that char */
                if ( (cont_parse = ExtractWpaStrStart(ptrString)) == kZGBoolTrue)
                {
                    ptrString++;
                }

                /* this code concats tokens together with whitespace */
                /* until no more tokens or the EOS " char is found */
                while ( cont_parse && (i++ < ARGC))
                {
                    cont_parse = ExtractWpaStrEnd( ptrString );
                }

                /* if the EOS char is not found then cont parse is true */
                if (cont_parse)
                {
                    ZG_PUTRSUART("Passphrase missing EOS '\"' \n\r");
                    return;
                }

                /* temp contains the string length after call */
                if ( !ValidateWpaStr(&ptrString, &temp) )
                {
                    ZG_PUTRSUART("Passphrase must be between 8 and 63 chars\n\r");
                    return;
                }

                ZG_SET_WPA_PASSPHRASE( ptrString, temp );

                gLineParseState = kZGWaitingForParamKeyword;

                break;

            case kZGWaitingForEnc:
                /* Can only set security in idle state */
                if ( ZG_IS_CONNECTED() == kZGBoolTrue )
                {
                    ZG_PUTRSUART("Security context may only be set in idle state\n\r");
                    return;
                }

                /* temp contains the encryption type enum */
                if ( !ExtractandValidateEncType(ARGV[i], &temp) )
                {
                    ZG_PUTRSUART("Invalid encyption type\n\r");
                    return;
                }

                ZG_SET_ENC_TYPE( temp );
                gLineParseState = kZGWaitingForParamKeyword;

                break;


            case kZGWaitingForWepAuth:

                /* Can only set security in idle state */
                if ( ZG_IS_CONNECTED() == kZGBoolTrue )
                {
                    ZG_PUTRSUART("Security context may only be set in idle state\n\r");
                    return;
                }

                /* temp contains the Wep Auth type enum */
                if ( !ExtractandValidateAuthType(ARGV[i], &temp) )
                {
                    ZG_PUTRSUART("Invalid WEP Auth type\n\r");
                    return;
                }

                ZG_SET_AUTH_TYPE( temp );
                gLineParseState = kZGWaitingForParamKeyword;

                break;

            case kZGWaitingForWepKey:

                /* Can only set security in idle state */
                if ( ZG_IS_CONNECTED() == kZGBoolTrue )
                {
                    ZG_PUTRSUART("Security context may only be set in idle state\n\r");
                    return;
                }

                /* temp contains the active WEP key index 1 of 4 */
                if ( !ExtractandValidateWepIndex(ARGV[i], &temp) )
                {
                    ZG_PUTRSUART("Invalid WEP key index\n\r");
                    return;
                }

                /* check for a 3rd optional parameter */
                if ( (i+1 < ARGC) &&
                    (getParamType(ARGV[i+1]) == kZGUnknownParam) )
                {

                    i++;  /* advance to the optional param */

                    /* The ARGV buffer is modified in place  */
                    if ( ExtractandValidateWepLong( ARGV[i] ) )
                    {
                        ZG_SET_WEP_KEY_LONG( (tZGU8Ptr) ARGV[i], temp );
                    }
                    else if ( ExtractandValidateWepShort( ARGV[i] ) )
                    {
                        ZG_SET_WEP_KEY_SHORT( (tZGU8Ptr) ARGV[i], temp );
                    }
                    else
                    {
                        ZG_PUTRSUART("\n\rWarning, 64/128bit WEP key format not valid \n\r\t");
                        return;
                    }
                }

                ZG_SET_WEP_ACTIVE_INDEX(temp);

                gLineParseState = kZGWaitingForParamKeyword;
                break;

            default:

                ZGSYS_MODULE_ASSERT(2, (ROM FAR char*)"iwpriv param");
                break;

            } // end switch

        } // end for
    }

    switch (gLineParseState)
    {
    case kZGWaitingForBeacon:

        // Send an untampered frame that looks like a Beacon.
        iwpriv_beacon();

        gLineParseState = kZGWaitingForParamKeyword;
        break;

    default:
        //do nothing
        break;
    }

    if (gLineParseState != (tZGU8)kZGWaitingForParamKeyword)
    {
        ZG_PUTRSUART("Missing value after last parameter\n\r");
    }

}

/*****************************************************************************
* FUNCTION: IwconfigDisplayStatus
*
* RETURNS: None
*
* PARAMS:    None
*
* NOTES:   Responds to the user invoking ifconfig with no parameters
*****************************************************************************/
static tZGVoidReturn IwprivDisplayStatus(tZGVoidInput)
{

    tZGU8 i, j;
    tZGU8Ptr ptrTemp;

    sprintf( (char *) g_ConsoleContext.txBuf,

#if defined( __18CXX)
        "\nEncryption: %HS\n\r",
#else
        "\nEncryption: %s\n\r",
#endif
        (ROM FAR char*) ZG_GET_CUR_ENC_STR() );

    ZG_PUTSUART( (char *) g_ConsoleContext.txBuf );

    switch ( ZG_GET_ENC_TYPE() )
    {

    case kKeyTypeWep:

        sprintf( (char *) g_ConsoleContext.txBuf,
#if defined( __18CXX)
            "  Auth: %HS\n\r",
#else
            "  Auth: %s\n\r",
#endif
            (ROM FAR char*) ZG_GET_CUR_AUTH_STR());
        ZG_PUTSUART( (char *) g_ConsoleContext.txBuf );

        for( j=0; j < (tZGU8)kZGNumDefWepKeys; j++)
        {

            if ( j == ZG_GET_WEP_ACTIVE_INDEX() )
                ZG_PUTRSUART("* ");
            else
                ZG_PUTRSUART("  ");

            sprintf( (char *) g_ConsoleContext.txBuf,
                "Wep key[%d]:  0x",j+1);
            ZG_PUTSUART( (char *) g_ConsoleContext.txBuf );

            ptrTemp = ZG_GET_WEPKEY(j);

            for ( i=0; i < ZG_GET_WEP_KEY_LEN(); i++ )
            {
                sprintf( (char *) g_ConsoleContext.txBuf,
                    "%.2x", ptrTemp[i]);
                ZG_PUTSUART( (char *) g_ConsoleContext.txBuf );
            }

            ZG_PUTRSUART("\n\r");

        }

        break;

    case kKeyTypePsk:

        ZG_PUTRSUART("  PSK:  0x");

        ptrTemp = ZG_GET_WPAPSK();

        for ( i=0; i <  (tZGU8)kZGMaxPmkLen; i++ )
        {
            sprintf( (char *) g_ConsoleContext.txBuf,
                "%.2x", ptrTemp[i]);
            ZG_PUTSUART( (char *) g_ConsoleContext.txBuf );

        }

        ZG_PUTRSUART("\n\r");
        break;

    case kKeyTypeCalcPsk:

        /* if no pass phrase show a user friendly string */
        if ( ZG_GET_PASSPHRASE_LEN() == 0u )
        {
            sprintf( (char *) g_ConsoleContext.txBuf,
#if defined( __18CXX)
                "  Phrase:  \"%HS\"\n\r",
#else
                "  Phrase:  \"%s\"\n\r",
#endif
                (ROM FAR char*)  kZGNone);
        }
        else
        {
            sprintf( (char *) g_ConsoleContext.txBuf,
                "  Phrase:  \"%s\"\n\r",
                ZG_GET_WPA_PASSPHRASE() );
        }
        ZG_PUTSUART( (char *) g_ConsoleContext.txBuf );


        sprintf( (char *) g_ConsoleContext.txBuf,
            "  SSID:    %s\n\r", ZG_GET_SSID());
        ZG_PUTSUART( (char *) g_ConsoleContext.txBuf );

        break;

    }


}

#define kUntamperedMsgHeaderSize 8
#define kMyDataSize              54
static unsigned char untampered_frame[kUntamperedMsgHeaderSize + kMyDataSize];

//
// This function sends an untampered frame that looks like a Beacon.
// Source MAC address is 00:00:00:00:00:00
// Destinaion MAc address is 00:00:00:00:00:00
// BSSID is also 00:00:00:00:00:00
//
// The MAC frame size over-the-air is 58-byte (54B data + 4B FCS)
//

static tZGVoidReturn iwpriv_beacon(tZGVoidInput)
{
    // clear all bytes to 0
    memset(untampered_frame, 0, kUntamperedMsgHeaderSize + kMyDataSize);

    // Start: untampered-data-request message header.

    untampered_frame[0] = 0x00; // reqID
    untampered_frame[1] = 0x02; // Number of retransmits; 2 => each frame will be transmitted 3 times
    untampered_frame[2] = 0x00; // flags (2 bytes)
    untampered_frame[3] = 0x00; //

    // msg header bytes [4:7] are txTable[4]

    // End: untampered-data-request message header.


    // Start: untampered-data-request message payload.
    // Start of an 802.11 frame

    // frame data [0] is the "Version | Type | Subtype" field
    untampered_frame[kUntamperedMsgHeaderSize + 0] = 0x80; // "beacon"

    // [1] is "Frame control"
    untampered_frame[kUntamperedMsgHeaderSize + 1] = 0x00; // "frame control"

    // The follwoing will be all 0's
    // [2:3] is "Duration"
    // [4:9] is "Dst MAC"
    // [10:15] is "Src MAC"
    // [16:21] is "BSSID"
    // [22:23] is "Sequence | Fragment number"
    // [24:31] is "Timestamp"
    // [32:33] is "Beacon interval"
    // [34:35] is "Cap info"

    // End of fixed fields of a Beacon frame.

    // And the rest are IE's ...

    // Set the "SSID" field
    // [36] is "Element ID"
    untampered_frame[kUntamperedMsgHeaderSize + 36] = 0x00; // SSID
    // [37] is "Length"
    untampered_frame[kUntamperedMsgHeaderSize + 37] = 16; // sizeof("ZeroG Untampered") == 16
    // [38:53] is the SSID name
    memcpy((void *) &(untampered_frame[kUntamperedMsgHeaderSize + 38]), (void *)"ZeroG Untampered", 16);

    // End: untampered-data-request message payload.

    // Send it
    ZGDataSendUntampered((tZGTxUntamperedFrameReqPtr) untampered_frame, kUntamperedMsgHeaderSize + kMyDataSize);
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

    case kZGWpaPskParam:
        gLineParseState = kZGWaitingForWpaPsk;
        break;

    case kZGWpaStrParam:
        gLineParseState = kZGWaitingForWpaStr;
        break;

    case kZGEncTypeParam:
        gLineParseState = kZGWaitingForEnc;
        break;

    case kZGWepAuthParam:
        gLineParseState = kZGWaitingForWepAuth;
        break;

    case kZGWepKeyParam:
        gLineParseState = kZGWaitingForWepKey;
        break;

    case kZGBeaconParam:
        gLineParseState = kZGWaitingForBeacon;
        break;

    default:
        sprintf( (char *) g_ConsoleContext.txBuf,
            "Param %d not handled", tokenIndex);

        return kZGBoolFalse;
    }

    return kZGBoolTrue;
}


static tZGU8 getParamType(tZGS8 *p_paramString)
{
    tZGU8 i;

    for (i = 0; i < sizeof(gParams2)/sizeof(gParams2[0]); ++i)
    {
        if ( strcmppgm2ram((char *)p_paramString, (ROM FAR char*)gParams2[i]) == 0)
        {
            return i;
        }
    }

    return kZGUnknownParam;
}

#endif /* ZG_CONFIG_CONSOLE */


