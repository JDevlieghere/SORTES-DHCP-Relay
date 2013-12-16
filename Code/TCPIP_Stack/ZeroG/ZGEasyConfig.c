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
 *  Easy Config implementation functions.
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
 * distribute, and port the Software driver source files ZGEasyConfig.c
 * and ZGEasyConfig.h when used in conjunction with the ZeroG ZG2100 for
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
 * SCC                  12/12/08
********************************************************************/
#include "HardwareProfile.h"
#include "TCPIPConfig.h"

#if defined(ZG_CS_TRIS)

#include <string.h> /* for memcpy */   //SCC2????

#include "TCPIP Stack/ZGEasyConfig.h"
#include "TCPIP Stack/ZGLinkMgrII.h"
#include "TCPIP Stack/ZGConsole.h"
#include "TCPIP Stack/ZGCommon.h"

#if defined(STACK_USE_EZ_CONFIG)
/* Easy Config Globals */
tZGEasyConfigCtx g_easyConfigCtx;

/* Easy Config Private Functions */
static int ZGEasyConfigProcess(void);

void ZGEasyConfigInit()
{
    CFGCXT.ssid[0] = 0;
    CFGCXT.security = sec_max;
    CFGCXT.key[0] = 0;
    CFGCXT.defaultWepKey = ZG_WEP_KEY_INVALID;
    CFGCXT.type = net_max;
    CFGCXT.cfg_state = cfg_stopped;
    CFGCXT.isWifiNeedToConfigure = 0;
    CFGCXT.isWifiDoneConfigure = 0;

    return;
}

void ZGEasyConfigMgr()
{
    if (CFGCXT.isWifiNeedToConfigure) {
        if (ZGEasyConfigProcess()) {
            //Has been configured, clear flag
            CFGCXT.isWifiNeedToConfigure = 0;
            CFGCXT.isWifiDoneConfigure = 1;
            LED0_IO = 0;  //Turn off LED
        }
    }
    return;
}

static int ZGEasyConfigProcess(void)
{
    /* Idle network before making the requested changes */
    if (CFGCXT.cfg_state == cfg_stopped) {
        ZG_SETNEXT_MODE(kZGLMNetworkModeIdle);
        CFGCXT.cfg_state = cfg_wait_idle_complete;
        return 0; 
    }

    /* Check to see if link manager has achieved idle status */
    if ((CFGCXT.cfg_state == cfg_wait_idle_complete) && 
      (ZG_GET_MODE() != kZGLMNetworkModeIdle)) {
        /* Still not IDLE, bail out */
        return 0;
    }

    /* Device has now been idled, we can set config now */

    /* Set SSID... */
    if (CFGCXT.ssid)
        ZG_SET_SSID((tZGS8*)CFGCXT.ssid, (tZGU8)strlen(CFGCXT.ssid));

    /* Now deal with security... */
    switch ((BYTE)CFGCXT.security) {
        case sec_open: /* No security */
            ZG_SET_ENC_TYPE(kKeyTypeNone);
            break; 
        case sec_wpa_passphrase:
            if (CFGCXT.key)
                ZG_SET_WPA_PASSPHRASE((tZGS8Ptr)CFGCXT.key, strlen((char *)CFGCXT.key));
            break;
        case sec_wpa_pskcalc:
            if (CFGCXT.key)
                ZG_SET_WPAPSK(CFGCXT.key);
            break;
        case sec_wep64:
            if (CFGCXT.key) {
                ZG_SET_WEP_KEY_SHORT(CFGCXT.key, CFGCXT.defaultWepKey);
                ZG_SET_WEP_ACTIVE_INDEX(CFGCXT.defaultWepKey);
            }
            break;
        case sec_wep128:
            if (CFGCXT.key) {
                ZG_SET_WEP_KEY_LONG(CFGCXT.key, CFGCXT.defaultWepKey);
                ZG_SET_WEP_ACTIVE_INDEX(CFGCXT.defaultWepKey);
            }
            break;
    }
 
    /* Set wlan mode, PUT LAST in config pecking order */
#if !defined (ZG_CONFIG_NO_WIFIMGRII)
    if (CFGCXT.type == net_infra)
        ZG_SETNEXT_MODE(kZGLMNetworkModeInfrastructure);
#endif
#if !defined (ZG_CONFIG_NO_ADHOCMGRII)
    if (CFGCXT.type == net_adhoc)
        ZG_SETNEXT_MODE(kZGLMNetworkModeAdhoc);
#endif

    /* Change state and return TRUE to show we are done! */
    CFGCXT.cfg_state = cfg_stopped;
    return 1;
}
#endif /* STACK_USE_EZ_CONFIG */

#if defined ( EZ_CONFIG_SCAN )
tZGBool
startDynamicScan()
{
   /* If scan already in progress bail out */
   if (IS_ANY_SCAN_INPROGRESS(APPCXT.scanStatus))
       return false;

#if !defined (ZG_CONFIG_NO_ADHOCMGRII)
   if (ZG_GET_MODE() == kZGLMNetworkModeAdhoc) {
       ZG_PUTRSUART( "Can not do scan in adhoc\n\r");
       return false;
   }
#endif

   SET_USER_SCAN_INPROGRESS(APPCXT.scanStatus);
   return true;
}

extern tZGVoidReturn

ZGUserScanMgr(tZGVoidInput)

{
    tZGU32   time = ZGSYS_MODULE_GET_MSEC_TICK_COUNT();

    if (IS_USER_SCAN_INPROGRESS(APPCXT.scanStatus))  {
        if ((time - APPCXT.scanTime) > TIME_BETWEEN_SCAN) {
            if ( DISPATCH_ZGLIB( ZG_LIB_FUNC(ZGLibScan),
                                 ZG_REQ_FUNC(ZG_SCAN),
                                 ZG_COMP_FUNC(genericScanComplete),
                                 APPCXT.scanList ) != kZGSuccess )
            {
                /* If we get here no sweat we will come back and try */
                ZG_PUTRSUART( "Device busy, try again...\n\r");
            }
        }     
    }

    return;
}


extern
tZGVoidReturn  buildScanList(tZGBssDescPtr ptr)
{
    int i;

    if (APPCXT.scanListCount > ZG_MAX_SCAN_LIST)
        return;

    /* Filter hidden SSIDs here */
    for (i=0; i < ptr->ssidLen; i++)
        if (ptr->ssid[i] == 0)
            break;

    if (i < ptr->ssidLen)
        return;

    ptr->ssid[ptr->ssidLen] = 0; /* Terminate SSID before saving it */
    memcpy( (void *) &APPCXT.scanList[APPCXT.scanListCount], (const void *) ptr, kZGBssDescSZ);

    /* These U16 need byte swap for little endian host  */
    APPCXT.scanList[APPCXT.scanListCount].beaconPeriod = ZGSTOHS( APPCXT.scanList[APPCXT.scanListCount].beaconPeriod );
    APPCXT.scanList[APPCXT.scanListCount].atimWindow = ZGSTOHS( APPCXT.scanList[APPCXT.scanListCount].atimWindow );
    APPCXT.scanListCount++;

    return;
}
#endif /* EZ_CONFIG_SCAN */

#if defined ( ZG_CONFIG_CONSOLE ) && defined ( EZ_CONFIG_SCAN ) 
extern
tZGVoidReturn  DisplayScanList()
{
    int i;
    tZGBssDesc* pBssDesc;

    for (i=0; i < APPCXT.scanListCount; i++) {

        pBssDesc = &APPCXT.scanList[i];

        sprintf( (char *) g_ConsoleContext.txBuf,
                  "    [%u] bssid = %02X:%02X:%02X:%02X:%02X:%02X\n\r",
                  i,
                  pBssDesc->bssid[0],
                  pBssDesc->bssid[1],
                  pBssDesc->bssid[2],
                  pBssDesc->bssid[3],
                  pBssDesc->bssid[4],
                  pBssDesc->bssid[5]);

        ZG_PUTSUART( (char *) g_ConsoleContext.txBuf );

        DisplaySignalStrength(pBssDesc->rssi);

        sprintf( (char *) g_ConsoleContext.txBuf,
                "    indicator = %d\n\r", pBssDesc->rssi);

        ZG_PUTSUART( (char *) g_ConsoleContext.txBuf );

        if ( pBssDesc->ssidLen < kZGMaxSsidLen )
        {
            pBssDesc->ssid[pBssDesc->ssidLen] = '\0';
            sprintf( (char *) g_ConsoleContext.txBuf,
                     "    ssid = %s \n\r", (char *) pBssDesc->ssid);
            ZG_PUTSUART( (char *) g_ConsoleContext.txBuf );
        }

        sprintf( (char *) g_ConsoleContext.txBuf,
                 "    channel = %u\n\r", pBssDesc->channel);
        ZG_PUTSUART( (char *) g_ConsoleContext.txBuf );
    }
    ZG_PUTRSUART( "\n\r");
    return;
}
#endif /* ZG_CONFIG_CONSOLE */

#endif /* ZG_CS_TRIS */

