/*******************************************************************************

 File:
        ZGDriverIFace.c

 Description:
        Zero G Driver Appliation Interface C file.

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

#include "TCPIP Stack/ZG2100.h"

/*****************************************************************************
 * FUNCTION: SendManagementMsg
 *
 * RETURNS: kZGSuccess or kZGFailure
 *
 * PARAMS:
 *      tZGU16 len - the length in bytes of pBuf.
 *      tZGU8 type - indicates the type of management request.
 *      tZGU8 info - optional value for additional information.
 *
 *
 *  NOTES: Called internally by all management request functions to
 *      schedule the request on the drivers management queue. Signals the
 *      driver if necessary.
 *****************************************************************************/
tZGReturnStatus SendManagementMsg(tZGU16 len, tZGU8 type, tZGU8 info)
{
    tZGU8 preambleBuf[2];

   // tZGReturnStatus status = kZGFailure;
   tZGReturnStatus status = kZGSuccess;

    /* fill out 2 byte preamble of management message (data filled in before this call) */
    preambleBuf[0] = kZGMACTypeMgmtReq;     // indicate this is a mgmt msg
    preambleBuf[1] = type;                  // e.g. set param, get param, etc.
                                            //  Not always used.
    // set raw index to index 0 in mgmt tx msg
    ZGRawSetIndex(kTxPipeRAW, 0);

    // write out preamble to raw tx mgmt msg (data bytes have already been written)
    ZGRawSetByte(kTxPipeRAW, preambleBuf, sizeof(preambleBuf));



    // if msg type is set/get param
    if ((type == kZGMSGGetParam) || (type == kZGMSGSetParam))
    {
        RWCXT.len = 4 + len;  // total msg length is 4 byte preamble + data length
    }
    // else any other kind of mgmt msg total msg length is 2 byte preamble + data length
    else
    {
        RWCXT.len = 2 + len;
    }

    RWCXT.dir = kZGDirWrite;
    MACCXT.pendingMgmtConfirm = type;
    MACCXT.bMgmtTxMsgReady = kZGBoolTrue;

    return status;
}

/*****************************************************************************
 * FUNCTION: ZGSignalDriver
 *
 * RETURNS: kZGSuccess or kZGFailure
 *
 * PARAMS:
 *      N/A.
 *
 *
 *  NOTES: Can be used by other system code to signal/wake-up our driver in
 *      systems where the driver can actually block on a signal.  In a
 *      round-robin single threaded system this function would not be used.
 *****************************************************************************/
tZGReturnStatus ZGSignalDriver(tZGVoidInput)
{
    ZGSYS_SIGNAL_SET();
    return kZGSuccess;  // ZGSYS_SIGNAL_SET() is not implemented
}

/*****************************************************************************
 * FUNCTION: ZGInit
 *
 * RETURNS: kZGSuccess or kZGFailure
 *
 * PARAMS:
 *      N/A.
 *
 *
 *  NOTES: This function must be called once prior to calling any other ZG...
 *          functions.  This function initializes the ZG Driver internal State.
 *          It also verifies functionality of the lower level SPI driver and
 *          connected hardware.
 *****************************************************************************/
tZGReturnStatus ZGInit(tZGVoidInput)
{
    ZGPrvMacInit();
    return kZGSuccess;  // ZGPrvMacInit() is a void function
}


/*****************************************************************************
 * FUNCTION: ZGScan
 *
 * RETURNS: kZSuccess or kZGFailure
 *
 * PARAMS:
 *      tZGScanReq* pReq - Input parameters that define the scan
 *                                  request.
 *
 *  NOTES: Invokes a Scan operation by the ZeroG chip.  The caller supplies
 *      input parameters with the tZGScanReq.  The memory used to hold the
 *      tZGMACScanReq will be used to transfer the information to the ZeroG
 *      chip.  This function will return after the transmission has completed.
 *      If the transmission completed successfully the function will return
 *      kZGSuccess. Otherwise it will return kZGFailure.  The Scan
 *      results will be returned by the ZeroG Driver asynchronously using
 *      a call to ZGAPP_HANDLE_MGMTCONFIRM(...)
 *****************************************************************************/
tZGReturnStatus ZGScan(tZGVoidInput)
{
    return SendManagementMsg(kZGScanReqSZ, kZGMSGScan, 0);
}


/*****************************************************************************
 * FUNCTION: ZGJoin
 *
 * RETURNS: kZGMACSuccess or kZGMACFailure
 *
 * PARAMS:
 *      None
 *
 *  NOTES: Used to join to an infrastructure network. The success of the
 *      operation will be returned by the driver asynchronously with a
 *      call to ZGAPP_HANDLE_MGMTCONFIRM macro.
 *****************************************************************************/
tZGReturnStatus ZGJoin(tZGVoidInput)
{
    return SendManagementMsg(kZGJoinReqSZ, kZGMSGJoin, 0);
}

/*****************************************************************************
 * FUNCTION: ZGAuth
 *
 * RETURNS: kZGMACSuccess or kZGMACFailure
 *
 * PARAMS:
 *      None
 *
 *  NOTES: Used to authenticate with an infrastructure network. Will do
 *      either open authentication or shared key authentication. The success
 *      of the operation will be returned by the driver asynchronously with a
 *      call to ZGAPP_HANDLE_MGMTCONFIRM macro.
 *****************************************************************************/
tZGReturnStatus ZGAuth(tZGVoidInput)
{
    return SendManagementMsg(kZGAuthReqSZ, kZGMSGAuth, 0);
}

/*****************************************************************************
 * FUNCTION: ZGAssoc
 *
 * RETURNS: kZGMACSuccess or kZGMACFailure
 *
 * PARAMS:
 *      None
 *
 *  NOTES: Used to associate with an infrastructure network. Will also
 *      perform supplicant exchange as required provided the PSK key is
 *      pre-installed. The success of the
 *      operation will be returned by the driver asynchronously with a
 *      call to ZGAPP_HANDLE_MGMTCONFIRM macro.
 *****************************************************************************/
tZGReturnStatus ZGAssoc(tZGVoidInput)
{
    return SendManagementMsg(kZGAssocReqSZ, kZGMSGAssoc, 0);
}

/*****************************************************************************
 * FUNCTION: ZGAdhocStart
 *
 * RETURNS: kZGMACSuccess or kZGMACFailure
 *
 * PARAMS:
 *          None
 *
 *  NOTES: Used to start a new ad-hoc network.  The g2100 creates a bssid and
 *      a beacon and begins transmitting the beacon according to the parameters
 *      of the request. The success of the
 *      operation will be returned by the driver asynchronously with a
 *      call to ZGAPP_HANDLE_MGMTCONFIRM macro.
 *****************************************************************************/
tZGReturnStatus ZGAdhocStart(tZGVoidInput)
{
    return SendManagementMsg(kZGAdhocStartReqSZ, kZGMSGAdhocStart, 0);
}

/*****************************************************************************
 * FUNCTION: ZGAdhocConnect
 *
 * RETURNS: kZGMACSuccess or kZGMACFailure
 *
 * PARAMS:
 *      tZGAdhocConnectReqPtr pReq - the request object for the operation.
 *
 *  NOTES: Used to connect to an existing ad-hoc network.  The g2100 will
 *      search for the beacon and on success adopt the beacon parameters.
 *      The success of the
 *      operation will be returned by the driver asynchronously with a
 *      call to ZGAPP_HANDLE_MGMTCONFIRM macro.
 *****************************************************************************/
tZGReturnStatus ZGAdhocConnect(tZGVoidInput)
{
    return SendManagementMsg(kZGAdhocConnectReqSZ, kZGMSGAdhocConnect, 0);
}


/*****************************************************************************
 * FUNCTION: ZGDisconnect
 *
 * RETURNS: kZGMACSuccess or kZGMACFailure
 *
 * PARAMS:
 *      tZGDisconnectReqPtr pReq - the request object for the operation.
 *
 *  NOTES: Used to disconnect the g2100 from the current network.  The result
 *      will be returned asynchronously when the driver calls the
 *      ZGAPP_HANDLE_MGMTCONFIRM macro.
 *****************************************************************************/
tZGReturnStatus ZGDisconnect(tZGVoidInput)
{
    return SendManagementMsg(kZGDisconnectReqSZ, kZGMSGDisconnect, 0);
}

/*****************************************************************************
 * FUNCTION: ZGGetParam
 *
 * RETURNS: kZGMACSuccess or kZGMACFailure
 *
 * PARAMS:
 *      tZGParam type - identifies the parameter.
 *
 *  NOTES: Used to get a parameter value from the G2100.  The result will be
 *      returned asynchronously when the driver calls the
 *      ZGAPP_HANDLE_MGMTCONFIRM macro.
 *****************************************************************************/
tZGReturnStatus ZGGetParam(tZGParam type)
{
    tZGU8 preambleBuf[2];

    /* msg bytes 2 and 3 of Set Param messages contain the parameter ID bytes.  This is where the input */
    /* 'type' is stored (also known as info byte).                                                      */

    preambleBuf[0] = 0;                     // upper 8 bits of parameter ID, not used
    preambleBuf[1] = type;                  // in set param, get param, used to identify specific parameter

    ZGRawSetIndex(kTxPipeRAW, 2);           // index to byte 2 in Raw Tx mgmt msg
    ZGRawSetByte(kTxPipeRAW, preambleBuf, sizeof(preambleBuf));


    return SendManagementMsg(0, kZGMSGGetParam, type);
}

/*****************************************************************************
 * FUNCTION: ZGSetParam
 *
 * RETURNS: kZGMACSuccess or kZGMACFailure
 *
 * PARAMS:
 *      tZGParam type - identifies the parameter whose value will be set
 *      tZGDataPtr pBuf - points to the data containing the new value for
 *          the parameter.
 *      tZGU16 len - the number of bytes that should be taken from pBuf and
 *          written to the chip.
 *
 *  NOTES: Used to set a parameter value on the G2100.  pBuf contains the
 *      new value of the parameter. len identifies the length in bytes
 *      for pBuf and type indicates the type of parameter to be set.
 *****************************************************************************/
tZGReturnStatus ZGSetParam(tZGParam type, tZGU16 len)
{
    tZGU8 preambleBuf[2];
    tZGU8 dataByte = 0xff;

    if(type == kZGParamOnOffRadio)
    {
        /* read the on/off byte */
        ZGRawSetIndex(kTxPipeRAW, kRawSetParamMsgStartIndex);
        ZGRawGetByte(kTxPipeRAW, &dataByte, 1);

        // configure low power mode
        ZGPrvComSetLowPowerMode(((dataByte == (tZGU8)kZGRFStateOff)? kZGBoolFalse : kZGBoolTrue));
    }

    /* msg bytes 2 and 3 of Set Param messages contain the parameter ID bytes.  This is where the input */
    /* 'type' is stored (also known as info byte).                                                      */

    preambleBuf[0] = 0;                     // upper 8 bits of parameter ID, not used
    preambleBuf[1] = type;                  // in set param, get param, used to identify specific parameter

    ZGRawSetIndex(kTxPipeRAW, 2);           // index to byte 2 in Raw Tx mgmt msg
    ZGRawSetByte(kTxPipeRAW, preambleBuf, sizeof(preambleBuf));


    return SendManagementMsg(len, kZGMSGSetParam, type);
}




/*****************************************************************************
 * FUNCTION: ZGMACIFSetPMKKey
 *
 * RETURNS: kZGMACSuccess or kZGMACFailure
 *
 * PARAMS:
 *          None
 *
 *  NOTES: Used to Set a Pairwise Master Key (PMK) that can be used by
 *      the Zero G chip to establish a security association.  The key data
 *      is expected to be exactly 32 bytes long.  The ssid is between 1 and
 *      32 bytes long.
 *****************************************************************************/
tZGReturnStatus ZGSetPMKKey(tZGVoidInput)
{
    return SendManagementMsg(kZGPMKKeyReqSZ, kZGMSGPMKKey, 0);
}

/*****************************************************************************
 * FUNCTION: ZGSetWEPKeys
 *
 * RETURNS: kZGMACSuccess or kZGMACFailure
 *
 * PARAMS:
 *      tZGWEPKeyReqPtr pReq - the request structure for the operation.
 *
 *
 *  NOTES: Used to set the WEP keys for later WEP encryption.
 *****************************************************************************/
tZGReturnStatus ZGSetWEPKeys(tZGVoidInput)
{
    return SendManagementMsg(kZGWEPKeyReqSZ, kZGMSGWEPKey, 0);
}

/*****************************************************************************
 * FUNCTION: ZGMACIFSetPowerSaveMode
 *
 * RETURNS: kZGMACSuccess or kZGMACFailure
 *
 * PARAMS:
 *      tZGMACPsPwrMode mode - The desired power save mode to use on the ZG
 *          chip.
 *
 *
 *  NOTES: 802.11 chipsets have 2 well known operational power modes.  Active
 *      power mode is defined as the radio always on either transmitting or
 *      receiving, meaning that when it isn't transmitting then it is trying
 *      to receive.  Power save mode is defined as operating with the radio
 *      turned off when there is nothing to transmit and only turning the
 *      radio receiver on when required.  The power save mode is a mode that
 *      requires interaction with an Access Point.  The access point is
 *      notified via a packet from the Station that it is entering into
 *      power save mode. As a result the access point is required to buffer
 *      any packets that are destined for the Station until the Station
 *      announces that it is ready to once again receive packets.  The duration
 *      that a Station is allowed to remain in this mode is limited and is
 *      typically 10 times the beacon interval of the Access point.  If the
 *      host is expecting packets from the network it should operate in Active
 *      mode.  If however power saving is critical and packets are not expected
 *      then the host should consider operating in power save mode.  Due to
 *      the nature of Access points not all behaving the same, there is the
 *      possibility that an Access point will invalidate a Stations connection
 *      if it has not heard from the Station over a given time period. For this
 *      reason power save mode should be used with caution.
 *****************************************************************************/
tZGReturnStatus ZGSetPowerSaveMode(tZGPwrModeReqPtr pReq)
{
    ZGPrvComSetLowPowerMode(((pReq->mode == (tZGU8)kZGPsPwrModeSave)? kZGBoolTrue : kZGBoolFalse));

    return SendManagementMsg(kZGPwrModeReqSZ, kZGMSGSetPwrMode, 0);
}

/*****************************************************************************
 * FUNCTION: ZGCalcPSK
 *
 * RETURNS: kZGSuccess or kZGFailure
 *
 * PARAMS:
 *      tZGPSKCalcReq* pReq -
 *
 *
 *  NOTES: With the advent of WPA and WPA2 802.11 connections are made secure
 *      using schemes that can require a Pre-shared key.  This key is
 *      calculated using the SSID network name combined with a secret
 *      passphrase that is user readable.  These two strings are used as
 *      input into a computationally expensive calculation which generates
 *      a 32 byte key.  The ZG chip is able to perform this calcuation
 *      when given the SSID and passphrase. ZGMACIFCalcPSK provides the
 *      interface for Host software to request such a calculation.  Be
 *      warned that the ZG chip can require 60 seconds or more to complete
 *      the calculation. Following successful completion of the calculation
 *      the host can then submit the PSK using the ZGMACIFSetPMKKey function.
 *****************************************************************************/
tZGReturnStatus ZGCalcPSK(tZGVoidInput)
{
    return SendManagementMsg(kZGPskCalcReqSZ, kZGMSGCalcPSK, 0);
}

tZGReturnStatus
ZGDataSendUntampered(tZGTxUntamperedFrameReqPtr pReq, tZGU16 len)
{
	return ZGRawSendUntamperedData((tZGU8 *)pReq, len);
}

#else
// dummy func to keep compiler happy when module has no executeable code
void ZGDriverIFace_EmptyFunc(void)
{
}
#endif /* ZG_CS_TRIS */

/* EOF */
