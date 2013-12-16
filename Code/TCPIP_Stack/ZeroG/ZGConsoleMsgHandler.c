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
/*        ZGConsoleMsgHandler.c                                               */
/*                                                                            */
/* Description:                                                               */
/*      Handles serial messages sent from PC or user at the console.          */
/*                                                                            */
/* DO NOT DELETE THIS LEGAL NOTICE:                                           */
/*  2008 © ZeroG Wireless, Inc.  All Rights Reserved.                         */
/*  Confidential and proprietary software of ZeroG Wireless, Inc.             */
/*  Do no copy, forward or distribute.                                        */
/*                                                                            */
/******************************************************************************/
#include "TCPIP Stack/TCPIP.h"

#if defined(ZG_CS_TRIS) && defined ( ZG_CONFIG_CONSOLE )

//---------
// Includes
//---------
#include <stdio.h>
#include <string.h>
#include <ctype.h>

#include "TCPIP Stack/ZGConsoleIfconfig.h"
#include "TCPIP Stack/ZGConsoleIwconfig.h"
#include "TCPIP Stack/ZGConsoleIwpriv.h"
#include "TCPIP Stack/ZGDriverConstants.h"
#include "TCPIP Stack/ZGConsole.h"
#include "TCPIP Stack/ZGConsoleShared.h"
#include "TCPIP Stack/ZGConsoleMsgHandler.h"


typedef struct dataStructDescriptor
{
    tZGU16  dataFormat;
    void *  p_validateFunc;
    void *  p_dest;
} tDataStructDescriptor;


#define kZGValidateWithU8               (0)
#define kZGValidateWithU16              (1)
#define kZGValidateWithS8               (2)
#define kZGValidateWithX8               (3)


//============================================================================
// Function Prototypes
//============================================================================

static tZGBool CheckForAppSpecificCommand(tZGS8 *p_cmd);
static tZGVoidReturn    do_help_msg(tZGVoidInput);
static tZGVoidReturn    do_get_zg2100_version_cmd(tZGVoidInput);
static tZGVoidReturn    do_cls_cmd(tZGVoidInput);



/*****************************************************************************
 * FUNCTION: process_cmd
 *
 * RETURNS: None
 *
 * PARAMS:  None
 *
 * NOTES:   Determines which command has been received and processes it.
 *****************************************************************************/
tZGVoidReturn process_cmd(tZGVoidInput)
{
    tZGBool new_arg;
    tZGU8 i;


    g_ConsoleContext.argc = 0;
    new_arg = kZGBoolTrue;

    // Get pointers to each token in the command string
    TokenizeCmdLine(g_ConsoleContext.rxBuf);

    // if command line nothing but white kZGSpace or a linefeed
    if ( g_ConsoleContext.argc == 0u )
    {
        return;   // nothing to do
    }

    // change the command itself (token[0]) to lower case
    for (i = 0; i < strlen((char *)g_ConsoleContext.argv[0]); ++i)
    {
        g_ConsoleContext.argv[0][i] = tolower(g_ConsoleContext.argv[0][i]);
    }


    if ( IS_ECHO_ON() )
    {
        ZG_PUTRSUART("\n\r");
    }

    switch (GetCmdId())
    {

        case HELP_MSG:
            do_help_msg();
            break;

        case GET_ZG2100_VERSION_MSG:
            do_get_zg2100_version_cmd();
            break;

        case RESET_HOST:
            Reset();
            break;

        case CLEAR_SCREEN_MSG:
            do_cls_cmd();
            break;

        case IFCONFIG_MSG:
            do_ifconfig_cmd();
            break;

        case IWCONFIG_MSG:
            do_iwconfig_cmd();
            break;

        case IWPRIV_MSG:
            do_iwpriv_cmd();
            break;

        default:
            // if we don't match one of the built-in command strings, check to
            // see if we match one of the application-defined command strings
            if (CheckForAppSpecificCommand(g_ConsoleContext.argv[0]))
            {
                ; // nothing else to do
            }
            else
            {

               sprintf((char *) g_ConsoleContext.txBuf, "Unknown cmd: %s\n\r", ARGV[0]);
               ZG_PUTSUART( (char *) g_ConsoleContext.txBuf );

            }
            break;
    }
}

static tZGBool CheckForAppSpecificCommand(tZGS8 *p_cmd)
{
    tZGU8 i;

    for (i = 0; i < g_ConsoleContext.numCmdStrings; ++i)
    {
        // if we find a match
        if (   strcmppgm2ram((char *)p_cmd, (ROM FAR char*) g_ConsoleContext.p_cmdStrings[i]) == 0)
        {
            // Set flag to let user state machine know that they have received a serial message
            ZGConsoleSetMsgFlag();
            return kZGBoolTrue;
        }
    }

    return kZGBoolFalse;

}


tZGBool ExtractandValidateRfChannelAll( tZGS8 *p_string )
{

    if (strcmppgm2ram((char *)p_string, (ROM FAR char *) kZGAll ) == 0)
    {
        return kZGBoolTrue;
    }

    return kZGBoolFalse;
}


tZGBool ExtractandValidateRfChannelList(tZGS8  *p_string, tZGU8 *p_rfchan)
{
    tZGS8 *p1, *p2;
    tZGU8  index =0;
    tZGU16  temp;

    if ( strlen( (char*) p_string) == 0u ) return kZGBoolFalse;

    p1 = p2 = p_string;

    do
    {

       if ( (p2 = (tZGS8 *) strchr( (const char *) p1, (int) ',')) != NULL )
       {
          *p2='\0';
          p2++;
       }

       if( !ConvertASCIIUnsignedDecimalToBinary(p1, &temp) )
          return  kZGBoolFalse;

       p1 = p2;
       p_string[index] = (tZGU8) temp;
       index++;

    } while (  p2 != NULL );



    *p_rfchan = index;
    return kZGBoolTrue;
}

tZGBool ExtractandValidateRts(tZGS8 *p_string, tZGU16 *p_rts)
{
    // extract RTS
    if (!ConvertASCIIUnsignedDecimalToBinary(p_string, p_rts))
    {
        sprintf( (char *) g_ConsoleContext.txBuf,
                  "   Unable to parse RTS");
        ZG_PUTSUART( (char *) g_ConsoleContext.txBuf );
        return kZGBoolFalse;
    }

    if ((*p_rts < 256u) || (*p_rts > 2347u))
    {
        sprintf( (char *) g_ConsoleContext.txBuf,
                 "   RTS out of range");

        ZG_PUTSUART( (char *) g_ConsoleContext.txBuf );

        return kZGBoolFalse;
    }

    return kZGBoolTrue;
}

tZGBool convertAsciiToHexInPlace( tZGS8 *p_string, tZGU8 expectedHexBinSize )
{

    tZGS8  ascii_buffer[3];
    tZGU8  hex_binary_index = 0;
    tZGS8  *hex_string_start = p_string;
    tZGU16 hex_buffer = 0;

    /* gobble up any hex prefix */
    if ( memcmppgm2ram (hex_string_start, (const ROM FAR char*) "0x", 2) == 0 )
         hex_string_start+=2;

   if ( strlen( (char *) hex_string_start) != (expectedHexBinSize*2) )
      return kZGBoolFalse;

    while ( hex_binary_index < expectedHexBinSize )
    {

      memcpy ( ascii_buffer, (const char*) hex_string_start, 2 );
      ascii_buffer[2] = '\0';

      /* convert the hex string to a machine hex value */
      if ( !ConvertASCIIHexToBinary( ascii_buffer,&hex_buffer) )
        return kZGBoolFalse;

      p_string[hex_binary_index++] = (tZGU8) hex_buffer;

      hex_string_start +=2;

    }

    return kZGBoolTrue;

}

tZGBool ExtractWpaStrStart(tZGS8 *p_string)
{
    tZGU8 subStrLen;

    if ( *p_string == (tZGS8)'"' )
    {
       /* remove the null inserted by tokenizer */
       subStrLen = strlen( (char *) p_string);
       p_string += subStrLen;
       *p_string = ' ';

       return kZGBoolTrue;
    }
    else
       return kZGBoolFalse;

}

tZGBool ExtractWpaStrEnd(tZGS8 *p_string)
{
    tZGU8 subStrLen = strlen( (char *) p_string);

    p_string += subStrLen;

    if ( *(p_string-1) == (tZGS8)('"') )
    {
       *(p_string-1) = '\0';
       return kZGBoolFalse;
    }
    else
    {
       /* remove the tokenization */
       *p_string = ' ';
       return kZGBoolTrue;
    }
}

tZGBool ValidateWpaStr(tZGS8 **p_string, tZGU8 *p_len)
{
    /* check to make sure the passphrase is within limits */

    *p_len = strlen( (char *) *p_string);

     if ( (*p_len > (tZGU8)kZGMaxPhraseLen) || (*p_len < 8u) )
     {
        return kZGBoolFalse;
     }

     return kZGBoolTrue;

}

tZGBool ExtractandValidateEncType(tZGS8 *p_string, tZGU8 *enc_type)
{

   if (strcmppgm2ram((char *)p_string, (ROM FAR char *) ZG_GET_ENC_STRING(kKeyTypeNone)) == 0)
    {
        *enc_type =  kKeyTypeNone;
    }
    else if (strcmppgm2ram((char *)p_string, (ROM FAR char *) ZG_GET_ENC_STRING(kKeyTypeWep) ) == 0)
    {
        *enc_type =  kKeyTypeWep;
    }
    else if (strcmppgm2ram((char *)p_string, (ROM FAR char *) ZG_GET_ENC_STRING(kKeyTypePsk)) == 0)
    {
        *enc_type =  kKeyTypePsk;
    }
    else if (strcmppgm2ram((char *)p_string, (ROM FAR char *) ZG_GET_ENC_STRING(kKeyTypeCalcPsk)) == 0)
    {
        *enc_type =  kKeyTypeCalcPsk;
    }
    else
        return kZGBoolFalse;

    return kZGBoolTrue;
}


tZGBool ExtractandValidateAuthType(tZGS8 *p_string, tZGU8 *auth_type)
{

    if (strcmppgm2ram((char *)p_string, (ROM FAR char *) ZG_GET_AUTH_STRING(kZGAuthAlgOpen)) == 0)
    {
        *auth_type =  kZGAuthAlgOpen;
    }
    else if (strcmppgm2ram((char *)p_string, (ROM FAR char *) ZG_GET_AUTH_STRING(kZGAuthAlgShared)) == 0)
    {
        *auth_type =  kZGAuthAlgShared;
    }
    else
      return kZGBoolFalse;


    return kZGBoolTrue;
}


tZGBool ExtractandValidateWepIndex(tZGS8 *p_string, tZGU8 *key_index)
{

   if (strcmppgm2ram((char *)p_string, (ROM FAR char *) kZGWepKeyOne) == 0)
   {
       *key_index = tZGWepKeyOne;
   }
   else if (strcmppgm2ram((char *)p_string, (ROM FAR char *) kZGWepKeyTwo) == 0)
   {
       *key_index = tZGWepKeyTwo;
   }
   else if (strcmppgm2ram((char *)p_string,  (ROM FAR char *) kZGWepKeyThree) == 0)
   {
       *key_index = tZGWepKeyThree;
   }
   else if (strcmppgm2ram((char *)p_string, (ROM FAR char *) kZGWepKeyFour) == 0)
   {
       *key_index = tZGWepKeyFour;
   }
   else
      return kZGBoolFalse;

   return kZGBoolTrue;
}

tZGBool ExtractandValidateMode(tZGS8 *p_string, tZGU8 *p_mode)
{

    if (strcmppgm2ram((char *)p_string, (ROM FAR char *) kZGIdleModeString) == 0)
    {
        *p_mode = kZGLMNetworkModeIdle;
    }


#if !defined (ZG_CONFIG_NO_ADHOCMGRII)
    else if (strcmppgm2ram((char *)p_string, (ROM FAR char *) kZGAdHocModeString) == 0)
    {
        *p_mode = kZGLMNetworkModeAdhoc;
    }
#endif

#if !defined (ZG_CONFIG_NO_WIFIMGRII)
    else if (strcmppgm2ram((char *)p_string, (ROM FAR char *) kZGManagedModeString) == 0)
    {
        *p_mode = kZGLMNetworkModeInfrastructure;
    }
#endif

    else
    {
        return kZGBoolFalse;
    }

    return kZGBoolTrue;
}

tZGBool ExtractandValidatePower(tZGS8 *p_string, tZGBool *p_pwr)
{
    if (strcmppgm2ram((char *)p_string, (ROM FAR char *) kZGEnabled) == 0)
    {
        *p_pwr = kZGBoolTrue;
    }
    else if (strcmppgm2ram((char *)p_string, (ROM FAR char *) kZGDisabled) == 0)
    {
        *p_pwr = kZGBoolFalse;
    }
    else
    {
        return kZGBoolFalse;
    }

    return kZGBoolTrue;
}

tZGBool ExtractandValidateDTIM(tZGS8 *p_string, tZGBool *p_rxDTIM)
{

    if (strcmppgm2ram((char *)p_string, (ROM FAR char *) kZGUnicast) == 0)
    {
        *p_rxDTIM = kZGBoolFalse;
    }
    else if (strcmppgm2ram((char *)p_string, (ROM FAR char *) kZGAll) == 0)
    {
        *p_rxDTIM = kZGBoolTrue;
    }
    else
    {
        return kZGBoolFalse;
    }

    return kZGBoolTrue;
}



tZGBool ExtractandValidateSSID(tZGS8 *p_string, tZGU8 *p_len)
{

    if ( (*p_len = strlen((char *)p_string)) > (tZGU8)kZGMaxSsidLen )
      return  kZGBoolFalse;

    return kZGBoolTrue;
}


tZGBool ExtractandValidateDomain(tZGS8 *pDomainStr, tZGU8 *pDomain)
{
    tZGU8 i=0;

    // search list of domain name strings until we find a match

    while ( g_DomainStrings[i] != NULL )
    {
        if (strcmppgm2ram((char *)pDomainStr, (ROM FAR char *) g_DomainStrings[i]) == 0)
        {
            *pDomain = i;
            return kZGBoolTrue;
        }
        i++;
    }
    sprintf( (char *) g_ConsoleContext.txBuf,
            "   Invalid domain");
    ZG_PUTSUART( (char *) g_ConsoleContext.txBuf );

    return kZGBoolFalse;
}

#ifdef ZG_CONFIG_DHCP
tZGBool ExtractandValidateDHCP(tZGS8 *p_string, tZGU8 *p_dhcp)
{
    if (strcmppgm2ram((char *)p_string, (ROM FAR char *)kZGDHCPStart) == 0)
    {
        *p_dhcp = DHCP_ENABLED;
    }
    else if (strcmppgm2ram((char *)p_string, (ROM FAR char *)kZGDHCPDrop) == 0)
    {
        *p_dhcp = DHCP_DISABLED;
    }
    else
    {
        sprintf( (char *) g_ConsoleContext.txBuf,
                "   Invalid dhcp param");

        ZG_PUTSUART( (char *) g_ConsoleContext.txBuf );

        return kZGBoolFalse;
    }

    return kZGBoolTrue;
}
#endif



static tZGVoidReturn do_cls_cmd(tZGVoidInput)
{
    Output_Monitor_Hdr();
}


static tZGVoidReturn do_help_msg(tZGVoidInput)
{
    tZGU8 i;

    ZG_PUTRSUART("\n\r");
    for (i = 0; i < g_numCmds; ++i)
    {
        ZG_PUTRSUART( (ROM FAR char *) g_consoleCmd[i].p_cmdName);
        ZG_PUTRSUART("\r\t\t");
        ZG_PUTRSUART( (ROM FAR char*) g_consoleCmd[i].p_cmdHelp);
        ZG_PUTRSUART("\n\r");
    }

}

/*****************************************************************************
 * FUNCTION: consoleGetVerComplete
 *
 * RETURNS: None
 *
 * PARAMS:  None
 *
 * NOTES:   Displays version information as part of a complete callback from
 *          the library layer.
 *****************************************************************************/

tZGVoidReturn
consoleGetVerComplete(tZGU8 type, tZGDataPtr fourByteHeader, tZGDataPtr pBuf,
                      tZGU16 len, tZGVoidInput *appOpaquePtr)

{
   tZGU8 result = fourByteHeader[0];
   tZGU8 chipVersion[2] = {0,0};

   if( result == (tZGU8)kZGResultSuccess )
   {
        ZGLibLoadConfirmBuffer(pBuf, sizeof(tZGU8)*2, 0);
        chipVersion[0] = pBuf[kZGGetMACParamCnfSZ];
        chipVersion[1] = pBuf[kZGGetMACParamCnfSZ+1];
   }

   sprintf( (char *) g_ConsoleContext.txBuf,
            "Firmware version   0x%02X%02X\n\r",
            chipVersion[0],
            chipVersion[1]);
   ZG_PUTSUART( (char *) g_ConsoleContext.txBuf );


   sprintf( (char *) g_ConsoleContext.txBuf,
#if defined( __18CXX)
            "SDK version        %HS\n\r",
#else
            "SDK version        %s\n\r",
#endif
             (ROM FAR char*) ZG_GET_SDK_VERSION());

   ZG_PUTSUART( (char *) g_ConsoleContext.txBuf );

}

/*****************************************************************************
 * FUNCTION: do_get_zg2100_version_cmd
 *
 * RETURNS: None
 *
 * PARAMS:  None
 *
 * NOTES:   Processes get ZG2100 version
 *****************************************************************************/

static tZGVoidReturn do_get_zg2100_version_cmd(tZGVoidInput)
{


    if ( DISPATCH_ZGLIB( ZG_LIB_FUNC(ZGLibGetChipVersion),
                         kNULL,
                         ZG_COMP_FUNC(consoleGetVerComplete),
                         kNULL ) != kZGSuccess )
    {
        ZG_PUTRSUART("Device busy, try again...\n\r");
    }
}

#endif /* ZG_CONFIG_CONSOLE */









