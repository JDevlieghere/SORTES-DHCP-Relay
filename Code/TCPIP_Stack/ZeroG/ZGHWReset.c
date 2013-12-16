/*******************************************************************************

 File:
        ZGHWReset.c

 Description:
        Microchip C file implenting a hardware reset of the ZG2100

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
 * FUNCTION: MCHPHardwareResetZG2100
 *
 * RETURNS: Boolean -- True if hardware reset takes place in this function, else False
 *
 * PARAMS:  None
 *
 * NOTES:   Used by the Zero G driver to perform a hardware reset on the ZG2100
 *          device.  If the specific application does not support a hardware
 *          reset, simply have the the function return false.  If an actual
 *          hardware reset does take place in this function, it should return
 *          true.
 * This function maps to the Zero G Driver Macro ZGHAL_ZG100_HW_RESET_CALL
 *****************************************************************************/
tZGBool MCHPHardwareResetZG2100(tZGVoidInput)
{


    return kZGBoolFalse; // Do soft reset

#if 0
    // Enable regulator
    XCEN33_TRIS = 0;  // Configure line as ouput
    XCEN33_IO   = 0;  // Set low to enable regulator

    // take ZG2100 out of reset
    ZG_RST_IO   = 0;  // put the line in reset state
    ZG_RST_TRIS = 0;  // configure the I/O as an output
    DelayMs(10);      // wait a little
    ZG_RST_IO   = 1;  // take ZG2100 out of reset
    DelayMs(10);      // wait a little

    return true;
#endif
}

#else
// dummy func to keep compiler happy when module has no executeable code
void MCHP_HWReset_EmptyFunc(void)
{
}
#endif /* ZG_CS_TRIS */
