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
/*        ZGConsoleIfconfig.c                                                 */
/*                                                                            */
/* Description:                                                               */
/*        Implements ifconfig command.                                        */
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
#include "TCPIP Stack/ZGConsoleIfconfig.h"
#include "TCPIP Stack/ZGConsoleMsgs.h"
#include "TCPIP Stack/ZGConsoleMsgHandler.h"


//============================================================================
//                                  Constants
//============================================================================

// These defines must match indexes in gParam[]
enum {
    kZGArpParam = 0,
    kZGMinusArpParam,
    kZGBroadcastParam,
    kZGDownParam,
    kZGMtuParam,
    kZGNetmaskParam,
    kZGUpParam,
    kZGDHCPParam,
    kZGGatewayParam,
    kZGNumParam  /* must be last */
};

#define kZGUnknownParam         (0xff)

// states for state machine
enum
{
    kZGWaitingForParamKeyword,
    kZGWaitingForNetmaskValue,
    kZGWaitingForDHCP,
    kZGWaitingForGateway
};


//============================================================================
//                                  Globals
//============================================================================

// the indexes of these param strings are used in the flags array in gParamState
ROM FAR char *gParams[] = {
    "arp",
    "-arp",
    "broadcast",
    "down",
    "mtu",
    "netmask",
    "up",
    "auto-dhcp",
    "gateway"
};


//static tZGIfParams   gParamState;         // used to process an individual ifconfig command
static tZGU8         gLineParseState;


//============================================================================
//                                  Local Function Prototypes
//============================================================================
static tZGVoidReturn IfconfigDisplayStatus(tZGVoidInput);
static tZGBool       isIPAddress(tZGS8 *p_string, tZGU8 *p_Address);
static tZGBool       isMacAddress(tZGS8 *p_string, tZGU8 *p_Address);
static tZGU8         getParamType(tZGS8 *p_paramString);
static tZGBool       getParam(tZGU8 index);


#if 0   /* These are currently not used */
static tZGVoidReturn setParamFlag(tZGU8 paramNumber);
static tZGBool       isParamFlagSet(tZGU8 paramNumber);
static tZGBool       processParam(tZGU8 paramIndex);
#endif


#ifdef USE_LCD
void LCDDisplayIPValue(IP_ADDR IPVal)
{
    BYTE IPDigit[4];
    BYTE i;
    BYTE j;
    BYTE LCDPos=16;

    for(i = 0; i < sizeof(IP_ADDR); i++)
    {
        uitoa((WORD)IPVal.v[i], IPDigit);

        for(j = 0; j < strlen((char*)IPDigit); j++)
        {
            LCDText[LCDPos++] = IPDigit[j];
        }
        if(i == sizeof(IP_ADDR)-1)
            break;
        LCDText[LCDPos++] = '.';
    }


    if(LCDPos < 32u)
        LCDText[LCDPos] = 0;
    LCDUpdate();
}
#endif

/*****************************************************************************
 * FUNCTION: do_ifconfig_cmd
 *
 * RETURNS: None
 *
 * PARAMS:    None
 *
 * NOTES:   Responds to the user invoking ifconfig
 *****************************************************************************/
tZGVoidReturn do_ifconfig_cmd(tZGVoidInput)
{
    tZGU8 i;
    tZGU8 address[6];
#if defined(ZG_CONFIG_DHCP) && defined(STACK_USE_DHCP_CLIENT)
    tZGU16 tmp[4]; // uip requires these be 2-byte words.
#endif


   gLineParseState = kZGWaitingForParamKeyword;

    // if user only typed in ifconfig with no other parameters
    if (ARGC == 1u)
    {
        IfconfigDisplayStatus();
    }
    // else if 2 arguments and the second arg is IP address
    else if ( (ARGC == 2u) && (isIPAddress(ARGV[1], address)) )
    {
        if ( ZG_GET_DHCP_STATE() == DHCP_ENABLED )
        {

          sprintf( (char *) g_ConsoleContext.txBuf,
                     "Static IP address should not be set with DHCP enabled.\n\r");

          ZG_PUTSUART( (char *) g_ConsoleContext.txBuf );
          return;
        }

        AppConfig.MyIPAddr.v[0] = address[0];
        AppConfig.MyIPAddr.v[1] = address[1];
        AppConfig.MyIPAddr.v[2] = address[2];
        AppConfig.MyIPAddr.v[3] = address[3];

        /* Microchip DHCP client clobbers static ip on every iteration of loop, even if dhcp is turned off*/
        AppConfig.DefaultIPAddr.v[0] = address[0];
        AppConfig.DefaultIPAddr.v[1] = address[1];
        AppConfig.DefaultIPAddr.v[2] = address[2];
        AppConfig.DefaultIPAddr.v[3] = address[3];

#ifdef USE_LCD
        LCDDisplayIPValue(AppConfig.MyIPAddr);
#endif
    }
    // else if 2 args and second arg is MAC address
    else if ( (ARGC == 2u) && isMacAddress(ARGV[1], address))
    {
        /* Can only set MAC address in idle state */
        if ( ZG_IS_CONNECTED() == kZGBoolTrue )
        {
            sprintf( (char *) g_ConsoleContext.txBuf,
                     "HW MAC address can only be set in idle mode");

            ZG_PUTSUART( (char *) g_ConsoleContext.txBuf );

            return;
        }

        /* update G2100 */
        ZG_SET_MAC_ADDR( address );

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

                case kZGWaitingForNetmaskValue:

                    if ( ZG_GET_DHCP_STATE() == DHCP_ENABLED )
                    {
                        sprintf( (char *) g_ConsoleContext.txBuf,
                                "The Netmask should not be set with DHCP enabled.\n\r");

                        ZG_PUTSUART( (char *) g_ConsoleContext.txBuf );
                        return;
                    }

                    if ( !isIPAddress(ARGV[i], address) )
                    {
                        sprintf( (char *) g_ConsoleContext.txBuf,
                                 "Invalid netmask value");
                        ZG_PUTSUART( (char *) g_ConsoleContext.txBuf );
                        return;
                    }

                    AppConfig.MyMask.v[0] = address[0];
                    AppConfig.MyMask.v[1] = address[1];
                    AppConfig.MyMask.v[2] = address[2];
                    AppConfig.MyMask.v[3] = address[3];

                    /* Microchip DHCP client clobbers static netmask on every iteration of loop, even if dhcp is turned off*/
                    AppConfig.DefaultMask.v[0] = address[0];
                    AppConfig.DefaultMask.v[1] = address[1];
                    AppConfig.DefaultMask.v[2] = address[2];
                    AppConfig.DefaultMask.v[3] = address[3];


                    gLineParseState = kZGWaitingForParamKeyword;
                    break;

#if defined(ZG_CONFIG_DHCP) && defined(STACK_USE_DHCP_CLIENT)
                case kZGWaitingForDHCP:
                    /* buf[4] contains DHCP enable/disable enum */
                    if ( !ExtractandValidateDHCP(ARGV[i], (tZGU8 *) &tmp[0]) )
                    {
                        return;
                    }

                    ZG_SET_DHCP_STATE( (tZGBool) tmp[0] );
                    gLineParseState = kZGWaitingForParamKeyword;
                    break;
#endif

                case kZGWaitingForGateway:
                    if ( !isIPAddress(ARGV[i], address) )
                    {
                        sprintf( (char *) g_ConsoleContext.txBuf,
                                 "Invalid gateway value");
                        ZG_PUTSUART( (char *) g_ConsoleContext.txBuf );
                        return;
                    }

                    AppConfig.MyGateway.v[0] = address[0];
                    AppConfig.MyGateway.v[1] = address[1];
                    AppConfig.MyGateway.v[2] = address[2];
                    AppConfig.MyGateway.v[3] = address[3];

                    // There is no such thing as AppConfig.DefaultGateway

                    gLineParseState = kZGWaitingForParamKeyword;
                    break;

            } // end switch
//            ZGConsolePrintf("%s ", ARGV[i]);
        } // end for
    }

    if (gLineParseState != (tZGU8)kZGWaitingForParamKeyword)
    {
        sprintf( (char *) g_ConsoleContext.txBuf,
                  "Missing value after last parameter");

        ZG_PUTSUART( (char *) g_ConsoleContext.txBuf );
    }

}

static tZGBool getParam(tZGU8 index)
{
    tZGU8 paramType;

    paramType = getParamType(ARGV[index]);
    switch (paramType)
    {
        case kZGUnknownParam:
            sprintf( (char *) g_ConsoleContext.txBuf,
                      "Param %d invalid", index);

            ZG_PUTSUART( (char *) g_ConsoleContext.txBuf );

            return kZGBoolFalse;

        case kZGNetmaskParam:
            gLineParseState = kZGWaitingForNetmaskValue;
            return kZGBoolTrue;

#ifdef ZG_CONFIG_DHCP
        case kZGDHCPParam:
            gLineParseState = kZGWaitingForDHCP;
            return kZGBoolTrue;
#endif

        case kZGGatewayParam:
            gLineParseState = kZGWaitingForGateway;
            return kZGBoolTrue;

        case kZGArpParam:
        case kZGMinusArpParam:
        case kZGDownParam:
        case kZGUpParam:
            sprintf( (char *) g_ConsoleContext.txBuf,
                     "Param %d not supported", index);

            ZG_PUTSUART( (char *) g_ConsoleContext.txBuf );

            return kZGBoolFalse;

        default:
            sprintf( (char *) g_ConsoleContext.txBuf,
                     "Param %d not handled", index);

            ZG_PUTSUART( (char *) g_ConsoleContext.txBuf );

            return kZGBoolFalse;
    }

    return kZGBoolTrue;
}

#if 0
static tZGVoidReturn setParamFlag(tZGU8 paramNumber)
{
    tZGU8  index = paramNumber / 16;
    tZGU16 mask  = (tZGU16)0x01 << (paramNumber - (index * 16));

    gParamState.flags[index] |= ((tZGU16)0x01 << mask);
}

static tZGBool isParamFlagSet(tZGU8 paramNumber)
{
    tZGU8  index = paramNumber / 16;
    tZGU16 mask  = (tZGU16)0x01 << (paramNumber - (index * 16));

    return ((gParamState.flags[index] & mask) > 0);
}
#endif

static tZGU8 getParamType(tZGS8 *p_paramString)
{
    tZGU8 i;

    for (i = 0; i < sizeof(gParams)/sizeof(gParams[0]); ++i)
    {
        if ( strcmppgm2ram((char *)p_paramString, gParams[i]) == 0)
        {
            return i;
        }
    }

    return kZGUnknownParam;
}

/*****************************************************************************
 * FUNCTION: isIPAddress
 *
 * RETURNS: True if valid IP address, else False
 *
 * PARAMS:    p_string  -- string to check
 *          p_Address -- Array where IP values will be written
 *
 * NOTES:   Determines if the input string is a valid dot-notation IP address.
 *          If it is, then returns an array of 4 bytes for each of the values.
 *          IP address
 *****************************************************************************/

static tZGBool isIPAddress(tZGS8 *p_string, tZGU8 *p_Address)
{
    tZGU8 digIndex = 0;
    tZGU8 bufIndex = 0;
    tZGU8 dotCount = 0;
    tZGS8 buf[4];
    tZGU8 i;
    tZGU16 tmp;

    memset(buf, 0x00, sizeof(buf));
    for (i = 0; i < strlen((char *)p_string); ++i)
    {
        // if gathering digits
        if (isdigit(p_string[i]))
        {
            // store digit in buf, fail if user has more than 3 digits
            buf[bufIndex++] = p_string[i];
            if (bufIndex > 3u)
            {
                return kZGBoolFalse;
            }
        }
        // else encountered a dot
        else if (p_string[i] == (tZGS8)'.')
        {
            // keep track of dots and fail if we encounter too many of them
            ++dotCount;
            if (dotCount > 3u)
            {
                return kZGBoolFalse;
            }

            // convert the number we just pulled from the input string, fail if not a number
            if (!ConvertASCIIUnsignedDecimalToBinary(buf, &tmp))
            {
                return kZGBoolFalse;
            }
            // else a valid number
            else
            {
                // fail if greater than 255
                if ( tmp > 255u)
                {
                    return kZGBoolFalse;
                }

                 p_Address[digIndex] = (tZGU8) (tmp & 0xFF);

                // get ready for next number
                memset(buf, 0x00, sizeof(buf));
                bufIndex = 0;
                ++digIndex;
            }
        }
        // else got a character that is neither number nor dot
        else
        {
            return kZGBoolFalse;
        }

    }

    // fail if more than 3 dots
    if (dotCount != 3u)
    {
        return kZGBoolFalse;
    }

    // if made it here then make sure we have the last number
    if (buf[0] == 0)
    {
        return kZGBoolFalse;
    }

    // convert last number to binary, fail if we can't
    if (!ConvertASCIIUnsignedDecimalToBinary(buf, &tmp))
    {
        return kZGBoolFalse;
    }

    p_Address[digIndex] = (tZGU8) (tmp & 0xFF);

    // IP digits will be in p_Address[]
    return kZGBoolTrue;
}


/*****************************************************************************
 * FUNCTION: isMacAddress
 *
 * RETURNS: True if valid MAC address, else False
 *
 * PARAMS:    p_string  -- string to check
 *          p_Address -- Array where MAC values will be written
 *
 * NOTES:   Determines if the input string is a valid MAC address.
 *          If it is, then returns an array of 6 bytes for each of the values.
 *          MAC address must be in hex in the format xx:xx:xx:xx:xx:xx
 *****************************************************************************/
static tZGBool isMacAddress(tZGS8 *p_string, tZGU8 *p_Address)
{
    tZGU8 i;
    tZGU16 tmp;

    if (strlen((char *)p_string) != 17u)
    {
        return kZGBoolFalse;
    }

    // ensure the ':' is in the right place, and if so, set them to 0
    for (i = 2; i < 17u; i += 3)
    {
        if (p_string[i] == (tZGS8)':')
        {
            p_string[i] = '\0';
        }
        else
        {
            return kZGBoolFalse;
        }
    }

    // now extract each hex number string
    for (i = 0; i < 6u;  ++i)
    {
        if (!ConvertASCIIHexToBinary(&p_string[i * 3], &tmp))
        {
            return kZGBoolFalse;
        }

        p_Address[i] = (tZGU8) (tmp & 0xFF);

    }

    return kZGBoolTrue;
}

/*****************************************************************************
 * FUNCTION: IfconfigDisplayStatus
 *
 * RETURNS: None
 *
 * PARAMS:    None
 *
 * NOTES:   Responds to the user invoking ifconfig with no parameters
 *****************************************************************************/
static tZGVoidReturn IfconfigDisplayStatus(tZGVoidInput)
{
    tZGU8 *p_mac;

    sprintf( (char *) g_ConsoleContext.txBuf,
              "\tIP addr:  %d.%d.%d.%d\n\r", AppConfig.MyIPAddr.v[0],
                                           AppConfig.MyIPAddr.v[1],
                                           AppConfig.MyIPAddr.v[2],
                                           AppConfig.MyIPAddr.v[3] );

    ZG_PUTSUART( (char *) g_ConsoleContext.txBuf );


    p_mac = ZG_GET_MAC_ADDR();
    sprintf( (char *) g_ConsoleContext.txBuf,
             "\tMAC addr: %02X:%02X:%02X:%02X:%02X:%02X\n\r", p_mac[0], p_mac[1],
                                                            p_mac[2], p_mac[3],
                                                            p_mac[4], p_mac[5]);
    ZG_PUTSUART( (char *) g_ConsoleContext.txBuf );



    sprintf( (char *) g_ConsoleContext.txBuf,
              "\tNetmask:  %d.%d.%d.%d\n\r", AppConfig.MyMask.v[0],
                                           AppConfig.MyMask.v[1],
                                           AppConfig.MyMask.v[2],
                                           AppConfig.MyMask.v[3] );
    ZG_PUTSUART( (char *) g_ConsoleContext.txBuf );


    sprintf( (char *) g_ConsoleContext.txBuf,
              "\tGateway:  %d.%d.%d.%d\n\r", AppConfig.MyGateway.v[0],
                                           AppConfig.MyGateway.v[1],
                                           AppConfig.MyGateway.v[2],
                                           AppConfig.MyGateway.v[3] );
    ZG_PUTSUART( (char *) g_ConsoleContext.txBuf );




#ifdef ZG_CONFIG_DHCP
    if ( ZG_GET_DHCP_STATE() == DHCP_ENABLED)
       ZG_PUTRSUART("\tDHCP:     Started\n\r");
    else
       ZG_PUTRSUART("\tDHCP:     Stopped\n\r");
#endif

}


#endif /* ZG_CONFIG_CONSOLE */


