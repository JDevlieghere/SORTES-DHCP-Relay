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
 *  Messages exchanged between PC and Host Bridge.  Also a few functions
 *  shared by PC and Host Bridge.
 *
 *   - Describes the UART messages exchanged between the PC and Host Bridge
 *   -Reference: None
 *
 *********************************************************************
 * FileName:        ZGConsoleMsgs.c
 * Dependencies:    None
 * Processor:       PC
 * Compiler:        Visual Studio 2005, Visual C++ 2005
 * Company:         ZeroG Wireless, Inc.
 *
 * Software License Agreement
 *
 * Copyright © 2008 ZeroG Wireless Inc.  All rights
 * reserved.
 *
 * ZeroG licenses to you the right to use, modify, copy,
 * distribute, and port the Software driver source files ZGConsoleMsgs.c
 * and ZGConsoleMsgs.h when used in conjunction with the ZeroG ZG2100 for
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
 * SG                  12/12/08     Ported from eval SDK
********************************************************************/

#include "TCPIP Stack/TCPIP.h"

#if defined(ZG_CS_TRIS) && defined ( ZG_CONFIG_CONSOLE )


#include <string.h>
#include <ctype.h>

/* includes needed by Host Bridge Firmware */
#include "TCPIP Stack/ZGDriverTypes.h"
#include "TCPIP Stack/ZGDriverConstants.h"
#include "TCPIP Stack/ZGConsole.h"

//---------------------
// token parsing states
//---------------------
enum
{
    kZGWaitingForStartOfToken,
    kZGWaitingForEndOfToken
};

//----------------
// Command strings
//----------------
ROM tZGS8 helpCmd[]      = "help";
ROM tZGS8 helpHelp[]     = "Lists all commands";

ROM tZGS8 getzgverCmd[]  = "getzgver";
ROM tZGS8 getzgverHelp[] = "Gets ZG2100 version";

ROM tZGS8 resetCmd[]     = "reset";
ROM tZGS8 resetHelp[]    = "Reset host MCU";

ROM tZGS8 clsCmd[]       = "cls";
ROM tZGS8 clsHelp[]      = "Clears screen";

ROM tZGS8 ifConfigCmd[]  = "ifconfig";
ROM tZGS8 iwConfigCmd[]  = "iwconfig";
ROM tZGS8 iwPrivCmd[]    = "iwpriv";
ROM tZGS8 seeDocHelp[]      = "see documentation";


//----------------------
// Console Command Table
//-----------------------
const tZGCmd g_consoleCmd[] = {

    {helpCmd,                      // cmd name
     helpHelp,                     // cmd description
     2},                           // max tokens

    {getzgverCmd,                  // [1]
     getzgverHelp,
     1},

    {resetCmd,                     // [2]
     resetHelp,
     1},

    {clsCmd,                       // [3]
     clsHelp,
     1},

    {ifConfigCmd,                  // [4]
     seeDocHelp,
     12},

    {iwConfigCmd,                  // [5]
     seeDocHelp,
     12},

    {iwPrivCmd,                    // [6]
     seeDocHelp,
     12}

};

const tZGU8 g_numCmds   = sizeof(g_consoleCmd) / sizeof(tZGCmd);


/*****************************************************************************
 * FUNCTION: TokenizeCmdLine
 *
 * RETURNS: None
 *
 * PARAMS:  p_line -- pointer to the null terminated command line
 *
 * NOTES: Converts the input string into tokens separated by '\0'.
  *****************************************************************************/
tZGVoidReturn TokenizeCmdLine(tZGS8 *p_line)
{
    tZGU8 state = kZGWaitingForStartOfToken;
    tZGU8 index = 0;

    ARGC = 0;

    //---------------------------
    // while not at end of string
    //---------------------------
    while (p_line[index] != (tZGS8)'\0')
    {

        //----------------------------------------
        if (state == (tZGU8)kZGWaitingForStartOfToken)
        //----------------------------------------
        {
            // if hit non whitespace
            if (!isspace((int)p_line[index]))
            {
               // argument string starts here
               ARGV[ARGC++] = (tZGS8 *)(&(p_line[index]));
               if (ARGC >= (tZGU8)kZGMaxTokensPerCmd)
               {
                   return;  // truncate because too many tokens
               }
               state = kZGWaitingForEndOfToken;
            }
            ++index;

        }
        //----------------------------------------
        else if (state == (tZGU8)kZGWaitingForEndOfToken)
        //----------------------------------------
        {
            // if white space, then end of token
            if (isspace((int)p_line[index]))
            {
                // string terminate the token
                p_line[index] = '\0';
                state = kZGWaitingForStartOfToken;
            }
            ++index;
        }
    }
}


/*****************************************************************************
 * FUNCTION: GetCmdId
 *
 * RETURNS: None
 *
 * PARAMS:  tZGVoidInput
 *
 * NOTES: Determines index of cmd in CMD struct
  *****************************************************************************/
tZGU8 GetCmdId(tZGVoidInput)
{
    tZGU8 i;
    const tZGCmd  *p_msgList;
    tZGU16  msgCount;

    p_msgList = g_consoleCmd;
    msgCount  = g_numCmds;

    for (i = 0; i < msgCount; ++i)
    {
        if ( strcmppgm2ram( (FAR char *)ARGV[0], (FAR ROM char *) p_msgList[i].p_cmdName) == 0)
        {
            return i;
        }
    }

    return INVALID_CMD;
}



/*****************************************************************************
 * FUNCTION: ConvertASCIIHexToBinary
 *
 * RETURNS: true if conversion successful, else false
 *
 * PARAMS:  p_ascii   -- ascii string to be converted
 *          p_binary  -- binary value if conversion successful
 *
 * NOTES:   Converts an input ascii hex string to binary value (up to 32-bit value)
 *****************************************************************************/
tZGBool ConvertASCIIHexToBinary(tZGS8 *p_ascii, tZGU16 *p_binary)
{
    tZGS8  i;
    tZGU32 multiplier = 1;

    *p_binary = 0;

    // not allowed to have a string of more than 4 nibbles
    if (strlen((char*)p_ascii) > 8u)
    {
        return kZGBoolFalse;
    }

    // first, ensure all characters are a hex digit
    for (i = (tZGU8)strlen((char *)p_ascii) - 1; i >= 0 ; --i)
    {
        if (!isxdigit(p_ascii[i]))
        {
            return kZGBoolFalse;
        }
        *p_binary += multiplier * HexToBin(p_ascii[i]);
        multiplier *= 16;
    }

    return kZGBoolTrue;
}

/*****************************************************************************
 * FUNCTION: ConvertASCIIUnsignedDecimalToBinary
 *
 * RETURNS: true if conversion successful, else false
 *
 * PARAMS:  p_ascii   -- ascii string to be converted
 *          p_binary  -- binary value if conversion successful
 *
 * NOTES:   Converts an input ascii decimal string to binary value
 *****************************************************************************/
tZGBool ConvertASCIIUnsignedDecimalToBinary(tZGS8 *p_ascii, tZGU16 *p_binary)
{
    tZGS8  i;
    tZGU32 multiplier = 1;
    tZGS8 len;

    *p_binary = 0;
    len = (tZGS8)strlen((char *)p_ascii);

    // should not be any numbers greater than 6 digits
    if ((len > 5) || (len == 0))
    {
        return kZGBoolFalse;
    }

    // first, ensure all characters are a decimal digit
    for (i = len - 1; i >= 0 ; --i)
    {
        if (!isdigit(p_ascii[i]))
        {
            return kZGBoolFalse;
        }
        *p_binary += multiplier * (p_ascii[i] - '0');
        multiplier *= 10;
    }

    return kZGBoolTrue;
}

/*****************************************************************************
 * FUNCTION: ConvertASCIISignedDecimalToBinary
 *
 * RETURNS: true if conversion successful, else false
 *
 * PARAMS:  p_ascii   -- ascii string to be converted
 *          p_binary  -- binary value if conversion successful
 *
 * NOTES:   Converts an input ascii signed decimal string to binary value
 *****************************************************************************/
tZGBool ConvertASCIISignedDecimalToBinary(tZGS8 *p_ascii, tZGS16 *p_binary)
{
    tZGS8   i;
    tZGU32  multiplier = 1;
    tZGBool negFlag = kZGBoolFalse;
    tZGS8   endIndex = 0;
    tZGS8  len;

    *p_binary = 0;
    len = (tZGS8)strlen((char *)p_ascii);

    // should not be any numbers greater than 5 digits (with -)
    if (len > 6)
    {
        return kZGBoolFalse;
    }

    if (p_ascii[0] == (tZGS8)'-')
    {
        negFlag = kZGBoolTrue;
        endIndex = 1;
    }


    // first, ensure all characters are a decimal digit

    for (i = len - 1; i >= endIndex ; --i)
    {
        if (!isdigit(p_ascii[i]))
        {
            return kZGBoolFalse;
        }
        *p_binary += multiplier * (p_ascii[i] - '0');
        multiplier *= 10;
    }

    if (negFlag == kZGBoolTrue)
    {
        *p_binary *= -1;
    }

    return kZGBoolTrue;
}

/*****************************************************************************
 * FUNCTION: HexToBin
 *
 * RETURNS: binary value associated with ASCII hex input value
 *
 * PARAMS:  hexChar -- ASCII hex character
 *
 * NOTES:   Converts an input ascii hex character to its binary value.  Function
 *          does not error check; it assumes only hex characters are passed in.
 *****************************************************************************/
tZGU8 HexToBin(tZGU8 hexChar)
{
    if ((hexChar >= 'a') && (hexChar <= 'f'))
    {
        return (0x0a + (hexChar - 'a'));
    }
    else if ((hexChar >= 'A') && (hexChar <= 'F'))
    {
        return (0x0a + (hexChar - 'A'));
    }
    else //  ((hexChar >= '0') && (hexChar <= '9'))
    {
        return (0x00 + (hexChar - '0'));
    }

}

tZGBool ExtractandValidateU16Range(tZGS8 *p_string, tZGU16 *pValue, tZGU16 minValue, tZGU16 maxValue)
{
    /* extract next parameter as an unsigned short integer */
    if (!ConvertASCIIUnsignedDecimalToBinary(p_string, pValue))
    {
        /* ZGConsolePrintf("   Unable to parse paramter value"); */
        return kZGBoolFalse;
    }

    if ((*pValue < minValue) || (*pValue > maxValue))
    {
        /* ZGConsolePrintf("   parameter value out of range"); */
        return kZGBoolFalse;
    }

    return kZGBoolTrue;
}

#endif /* ZG_CONFIG_CONSOLE */






