/*******************************************************************************

 File:
        ZGEint.c

 Description:
        Microchip Zero G Driver external interrupt C file.

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

    /*NOTE: This code may need to be modified for other hardware configurations */

    #if defined( __C30__ )
        //============================================================================
        #if defined( ZG2100_IN_SPI2 )
        void __attribute__((interrupt, auto_psv)) _INT3Interrupt(void)
        #else
        void __attribute__((interrupt, auto_psv)) _INT1Interrupt(void)
        #endif
        //============================================================================
        {
            // clear EINT
            if (ZG_EINT_IF && ZG_EINT_IE)
            {
                ZG_EINT_IF = 0;
                ZG_EINT_IE = 0;         // disable external interrupt
                // invoke handler
                zgDriverEintHandler();
            }
        }


        //============================================================================
        tZGVoidReturn zgHALEintEnable(tZGVoidInput)
        // satisfies ZG Driver function Hook
        //============================================================================
        {
            // if interrupt line is low, then we may have missed a falling edge
            // while the interrupt was disabled.
            if ( ZG_EINT_IO == 0 )
            {
                // if the interrupt pin is active
                // then the ZG2100 has another event that needs to be serviced.
                // This means that the ZG2100 will never generate another falling edge
                // required to trigger the interrupt... So, we must force an interrupt.
                // force the EINT
                ZG_EINT_IF = 1;
            }

            /* enable the external interrupt */
            ZG_EINT_IE = 1;
        }


        //============================================================================
        // satisfies ZG Driver function Hook
        tZGVoidReturn zgHALEintDisable(tZGVoidInput)
        //============================================================================
        {
            /* disable the external interrupt */
            ZG_EINT_IE = 0;
        }

        //============================================================================
        //* satisfies ZG Driver function Hook
        tZGVoidReturn zgHALEintInit(tZGVoidInput)
        //============================================================================
        {
            /* disable the external interrupt */
            ZG_EINT_IE = 0;

            /* configure IO pin as input and External Interrupt pin*/
            /* set the I/O high since we do not have pull-ups */
            ZG_EINT_IO   = 1;
            ZG_EINT_TRIS = 1;
            ZG_EINT_EDGE = 1;   /* falling edge triggered */

            /* clear and enable the interrupt */
            ZG_EINT_IF = 0;
            ZG_EINT_IE = 1;
        }

    #elif defined( __PIC32MX__ )

        //============================================================================
        #if defined( ZG2100_IN_SPI2 )
        void __attribute((interrupt(ipl3), vector(_EXTERNAL_3_VECTOR), nomips16)) _ZGInterrupt(void)
        #else
        void __attribute((interrupt(ipl3), vector(_EXTERNAL_1_VECTOR), nomips16)) _ZGInterrupt(void)
        #endif
        //============================================================================
        {
            // clear EINT
            if (ZG_EINT_IF && ZG_EINT_IE)
            {
                ZG_EINT_IF_CLEAR = ZG_EINT_BIT;
                ZG_EINT_IE_CLEAR = ZG_EINT_BIT;         // disable external interrupt
                // invoke handler
                zgDriverEintHandler();
            }
        }


        //============================================================================
        tZGVoidReturn zgHALEintEnable(tZGVoidInput)
        // satisfies ZG Driver function Hook
        //============================================================================
        {
            // if interrupt line is low, then we may have missed a falling edge
            // while the interrupt was disabled.
            if ( ZG_EINT_IO == 0 )
            {
                // if the interrupt pin is active
                // then the ZG2100 has another event that needs to be serviced.
                // This means that the ZG2100 will never generate another falling edge
                // required to trigger the interrupt... So, we must force an interrupt.
                // force the EINT
                ZG_EINT_IF_SET = ZG_EINT_BIT;
            }

            /* enable the external interrupt */
            ZG_EINT_IE_SET = ZG_EINT_BIT;
        }


        //============================================================================
        // satisfies ZG Driver function Hook
        tZGVoidReturn zgHALEintDisable(tZGVoidInput)
        //============================================================================
        {
            /* disable the external interrupt */
            ZG_EINT_IE_CLEAR = ZG_EINT_BIT;
        }

        //============================================================================
        //* satisfies ZG Driver function Hook
        tZGVoidReturn zgHALEintInit(tZGVoidInput)
        //============================================================================
        {
            /* disable the external interrupt */
            ZG_EINT_IE_CLEAR = ZG_EINT_BIT;

            /* configure IO pin as input and External Interrupt pin*/
            /* set the I/O high since we do not have pull-ups */
            ZG_EINT_IO   = 1;
            ZG_EINT_TRIS = 1;
            ZG_EINT_EDGE = 0;   /* falling edge triggered */

            /* clear and enable the interrupt */
            ZG_EINT_IF_CLEAR    = ZG_EINT_BIT;
            ZG_EINT_IPCCLR      = ZG_EINT_IPC_MASK;
            ZG_EINT_IPCSET      = ZG_EINT_IPC_VALUE;
            ZG_EINT_IE_SET      = ZG_EINT_BIT;
        }

    #elif defined( __18CXX )
        //============================================================================
        tZGVoidReturn zgEintISR(tZGVoidInput)
        // Called from LowISR() in MainDemo.c
        //============================================================================
        {
            // if EINT enabled
            if ( ZG_EINT_IE == 1u )
            {
                // if EINT event occurred
                if ( ZG_EINT_IF == 1u )
                {
                    // clear EINT
                    ZG_EINT_IF = 0;
                    ZG_EINT_IE = 0;         // disable external interrupt

                    // invoke handler
                    zgDriverEintHandler();
                }
            }
        }


        //============================================================================
        tZGVoidReturn zgHALEintEnable(tZGVoidInput)
        // satisfies ZG Driver function Hook
        //============================================================================
        {
        //    tZGU8  eIntLineState;

            // if interrupt line is low, then we may have missed a falling edge
            // while the interrupt was disabled.
            if ( ZG_EINT_IO == 0u )
            {
                // if the interrupt pin is active
                // then the ZG2100 has another event that needs to be serviced.
                // This means that the ZG2100 will never generate another falling edge
                // required to trigger the interrupt... So, we must force an interrupt.
                // force the EINT
                ZG_EINT_IF = 1;
            }

            /* enable the external interrupt */
            ZG_EINT_IE = 1;
        }


        //============================================================================
        // satisfies ZG Driver function Hook
        tZGVoidReturn zgHALEintDisable(tZGVoidInput)
        //============================================================================
        {
            /* disable the external interrupt */
            ZG_EINT_IE = 0;
        }

        //============================================================================
        //* satisfies ZG Driver function Hook
        tZGVoidReturn zgHALEintInit(tZGVoidInput)
        //============================================================================
        {
            /* disable the external interrupt */
            ZG_EINT_IE = 0;
        //  ZG_EINT_IP = 0;

            /* configure IO pin as input and External Interrupt pin*/
            /* assume port b pullups were enabled before entry */
            ZG_EINT_TRIS = 1;
            ZG_EINT_EDGE = 0;   /* falling edge triggered */

            /* clear and enable the interrupt */
            ZG_EINT_IF = 0;
            ZG_EINT_IE = 1;
        }
    #endif
#else
    // dummy func to keep compiler happy when module has no executeable code
    void MCHP_Eint_EmptyFunc(void)
    {
    }
#endif /* ZG_CS_TRIS */
