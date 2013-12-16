/*******************************************************************************

 File:
        ZGAccessSys.c

 Description:
        Microchip C file for the System Services.

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

 DO NOT DELETE THIS LEGAL NOTICE:
  2006, 2007, 2008 © ZeroG Wireless, Inc.  All Rights Reserved.
  Confidential and proprietary software of ZeroG Wireless, Inc.
  Do no copy, forward or distribute.

Author               Date       Comment
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Zero G              Sep 2008    Initial version
KO                  31 Oct 2008 Port to PIC24F and PIC32 for TCP/IP stack v4.52

*******************************************************************************/

#include "HardwareProfile.h"
#if defined(ZG_CS_TRIS)

#include "TCPIP Stack/TCPIP.h"
#include "TCPIP Stack/ZG2100.h"

/*****************************************************************************
 * FUNCTION: MCHPSysAssert
 *
 * RETURNS: void
 *
 * PARAMS: tZGU16 tag - a tag value used to identify the assert.
 *          tZGTextPtr string - a char array to provide some useful message
 *          that describes the assert.
 *
 * NOTES: Used to indicate when a known error condition has occurred. This
 *  function prints out the tag value and the string using standard printf.
 *  This function is intended to be used by the ZGDriver macro:
 *  ZGSYS_DRIVER_ASSERT.
 *
 * Using external Microchip routines to convert integer to string.
*****************************************************************************/
//extern void putsUART(const char *data);       // outputs variable strings stored in RAM
//extern void putrsUART(const ROM char *data);  // outputs constant strings stored in ROM

tZGVoidReturn MCHPSysAssert(tZGU16 tag, tZGTextPtr string)
{
    ZG_PUTRSUART("ASSERTION!!: ");
    ZG_PUTRSUART("  ");
    ZG_PUTRSUART(string);
    ZG_PUTRSUART("\r\n");

    while(1);
}

#else
// dummy func to keep compiler happy when module has no executeable code
void MCHP_AccessSys_EmptyFunc(void)
{
}


#endif /* ZG_CS_TRIS */
