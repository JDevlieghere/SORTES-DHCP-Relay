/*******************************************************************************

 File:
        ZGDriverCom.c

 Description:
        Zero G Driver COM layer C file.

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

/* COM state machine states */
#define kComStIdle              (1u)
#define kComStIntService        (2u)
#define kComStReadOperation     (3u)
#define kComStWriteOperation    (4u)
#define kComStWriteWaitFifoDone (5u)
#define kComStReadWaitFifoDone  (6u)


extern Boolean gHostRAWDataPacketReceived;


/* local prototypes */
static tZGVoidReturn InitiateSpiReadRegister(tZGU8 reg, tZGU8 len);
static tZGVoidReturn InitiateSpiWriteRegister(tZGU8 reg, tZGU8 len);



/*****************************************************************************
 * FUNCTION: ReadChipInfoBlock
 *
 * RETURNS: N/A
 *
 * PARAMS:
 *      N/A
 *
 *
 *  NOTES: The G2100 maintains a block of data that can be read via the
 *      kZGCOMRegSysInfoData register.  Within this Block are useful parameters
 *      namely the system version number, Rx packet Header size, the
 *      Rx buffer size.  This function reads those parameters from the Block
 *      and stores them in as part of the COMCXT so that they can be used
 *      later.
 *****************************************************************************/

static tZGVoidReturn ReadChipInfoBlock(tZGVoidInput)
{

    tZGU8 i;
    tZGU8 val;

    /* read the status register to determine when it is safe to modify. */
    /* read kernel module number */
    for(i=0 ; i < kZGCOMSysInfoLenVersionNumber ; i++)
    {
        val = Read8BitZGRegister(kZGCOMRegSysInfoData);

        if(i==0u)
            COMCXT.versionNumber = val << 8u;
        else
            COMCXT.versionNumber |= val & 0xff;
    }

    Write16BitZGRegister(kZGCOMRegSysInfoIndex, (tZGU16)kZGCOMSysInfoOffsetRxHeaderSize);
}

/*****************************************************************************
 * FUNCTION: ChangeLowPowerMode
 *
 * RETURNS: N/A
 *
 * PARAMS:
 *      tZGBool bEnable - 1: low power mode to be enabled on the G2100.
 *                        0: low power mode is disabled.
 *
 *
 *  NOTES: Used to enable/disable low power mode on the G2100.  Once enabled
 *      The Host should disable low power mode prior to any other SPI
 *      interaction with the G2100.
 *****************************************************************************/
tZGVoidReturn ChangeLowPowerMode(tZGBool bEnable)
{
    tZGU16 regValue;
    tZGU16 lowPowerStatusRegValue;

    COMCXT.bInitDevice = kZGBoolTrue;

    /* Modify the power bit to enable/disable low power
     * mode on the G2100 */
    regValue = (bEnable == kZGBoolTrue)? kZGCOMRegEnableLoPwrMask : 0x00;
    Write16BitZGRegister(kZGCOMRegLoPwrCtrlReg, regValue);

    if(bEnable == kZGBoolFalse)
    {
        /* poll the response bit that indicates when the G2100
         * has come out of low power mode */
        do
        {
            /* set the index register to the register we wish to read (kZGCOMRegLoPwrStatusReg) */
            Write16BitZGRegister(kZGCOMRegIndexAddrReg, kZGCOMRegLoPwrStatusReg);
            lowPowerStatusRegValue = Read16BitZGRegister(kZGCOMRegIndexDataReg);

        } while(lowPowerStatusRegValue & (tZGU16)kZGCOMRegEnableLoPwrMask);
    }


    COMCXT.bInitDevice = kZGBoolFalse;
    COMCXT.bLowPowerModeActive = bEnable;
}

/*****************************************************************************
 * FUNCTION: Read8BitZGRegister
 *
 * RETURNS: register value
 *
 * PARAMS:
 *      regId -- ID of 8-bit register being read
 *
 *  NOTES: Reads ZG 8-bit register
 *****************************************************************************/
tZGU8 Read8BitZGRegister(tZGU8 regId)
{
    InitiateSpiReadRegister(regId, 1);
    zgHALSpiTxRx();

    return COMCXT.regBuf[0];
}

/*****************************************************************************
 * FUNCTION: Read16BitZGRegister
 *
 * RETURNS: register value
 *
 * PARAMS:
 *      regId -- ID of 16-bit register being read
 *
 *  NOTES: Reads ZG 16-bit register
 *****************************************************************************/
tZGU16 Read16BitZGRegister(tZGU8 regId)
{
    InitiateSpiReadRegister(regId, 2);
    zgHALSpiTxRx();

    return (((tZGU16)COMCXT.regBuf[0]) << 8) | (tZGU16)COMCXT.regBuf[1];
}



/*****************************************************************************
 * FUNCTION: ReadZGArray
 *
 * RETURNS: None
 *
 * PARAMS:
 *      regId  -- Raw register being read from
 *      pBuf   -- pointer where to write out bytes
 *      length -- number of bytes to read
 *
 *  NOTES: Reads a block of data from a raw register
 *****************************************************************************/
tZGVoidReturn ReadZGArray(tZGU8  regId, tZGU8 *pBuf, tZGU16 length)
{
    tZGU8 cmdBuffer[3];
    tZGU8 statusBuffer[3];

    cmdBuffer[0] = regId | kZGCOMCmdReadRegister;
    ZGHAL_SPI_CONTEXT_SET_TX_PRE_BUF_PTR(cmdBuffer);
    ZGHAL_SPI_CONTEXT_SET_TX_PRE_LEN(1);
    ZGHAL_SPI_CONTEXT_SET_TX_BUF_PTR(kZGDataPtrNULL);
    ZGHAL_SPI_CONTEXT_SET_TX_LEN(0);
    ZGHAL_SPI_CONTEXT_SET_RX_PRE_BUF_PTR(statusBuffer);
    ZGHAL_SPI_CONTEXT_SET_RX_PRE_LEN(1);
    ZGHAL_SPI_CONTEXT_SET_RX_BUF_PTR(pBuf);
    ZGHAL_SPI_CONTEXT_SET_RX_LEN(length);
    ZGHAL_SPI_CONTEXT_SET_RX_EXCESS_LEN(0);
    ZGHAL_SPI_CONTEXT_SET_SUPPRESS_DONE_HANDLER_CALL(kZGBoolTrue);
    zgHALSpiTxRx();
}



/*****************************************************************************
 * FUNCTION: Write8BitZGRegister
 *
 * RETURNS: None
 *
 * PARAMS:
 *      regId -- ID of 8-bit register being written to
 *      value -- value to write
 *
 *  NOTES: Writes ZG 8-bit register
 *****************************************************************************/
tZGVoidReturn Write8BitZGRegister(tZGU8 regId, tZGU8 value)
{
    COMCXT.spiCmdBuf[0] = regId | kZGCOMCmdWriteRegister;   /* register being written to */
    COMCXT.regBuf[0] = value;                               /* byte being written        */
    InitiateSpiWriteRegister(regId, 1);
    zgHALSpiTxRx();
}

/*****************************************************************************
 * FUNCTION: Write16BitZGRegister
 *
 * RETURNS: None
 *
 * PARAMS:
 *      regId -- ID of 16-bit register being written to
 *      value -- value to write
 *
 *  NOTES: Writes ZG 16-bit register
 *****************************************************************************/
tZGVoidReturn Write16BitZGRegister(tZGU8 regId, tZGU16 value)
{
    COMCXT.spiCmdBuf[0] = regId | kZGCOMCmdWriteRegister;   /* register being written to */
    COMCXT.regBuf[0] = (tZGU8)(value >> 8);                 /* MS byte being written     */
    COMCXT.regBuf[1] = (tZGU8)(value & 0x00ff);             /* LS byte being written     */
    InitiateSpiWriteRegister(regId, 2);
    zgHALSpiTxRx();
}

/*****************************************************************************
 * FUNCTION: WriteZGArray
 *
 * RETURNS: None
 *
 * PARAMS:
 *      regId  -- Raw register being written to
 *      pBuf   -- pointer to array of bytes being written
 *      length -- number of bytes in pBuf
 *
 *  NOTES: Writes a data block to specified raw register
 *****************************************************************************/
tZGVoidReturn WriteZGArray(tZGU8 regId, tZGU8 *pBuf, tZGU16 length)
{
    tZGU8 cmdBuffer[3];
    tZGU8 statusBuffer[3];

    cmdBuffer[0] = regId;
    ZGHAL_SPI_CONTEXT_SET_TX_PRE_BUF_PTR(cmdBuffer);
    ZGHAL_SPI_CONTEXT_SET_TX_PRE_LEN(1);
    ZGHAL_SPI_CONTEXT_SET_TX_BUF_PTR(pBuf);
    ZGHAL_SPI_CONTEXT_SET_TX_LEN(length);
    ZGHAL_SPI_CONTEXT_SET_RX_PRE_BUF_PTR(statusBuffer);
    ZGHAL_SPI_CONTEXT_SET_RX_PRE_LEN(1);
    ZGHAL_SPI_CONTEXT_SET_RX_BUF_PTR(kZGDataPtrNULL);
    ZGHAL_SPI_CONTEXT_SET_RX_LEN(0);
    ZGHAL_SPI_CONTEXT_SET_RX_EXCESS_LEN(0);
    ZGHAL_SPI_CONTEXT_SET_SUPPRESS_DONE_HANDLER_CALL(kZGBoolTrue);
    zgHALSpiTxRx();
}

/*****************************************************************************
 * FUNCTION: WriteZGROMArray
 *
 * RETURNS: None
 *
 * PARAMS:
 *      regId  -- Raw register being written to
 *      pBuf   -- pointer to array of bytes being written
 *      length -- number of bytes in pBuf
 *
 *  NOTES: Writes a data block (in ROM) to specified raw register
 *****************************************************************************/
tZGVoidReturn WriteZGROMArray(tZGU8 regId, ROM tZGU8 *pBuf, tZGU16 length)
{
    tZGU8 cmdBuffer[3];
    tZGU8 statusBuffer[3];

    cmdBuffer[0] = regId;
    ZGHAL_SPI_CONTEXT_SET_TX_PRE_BUF_PTR(cmdBuffer);
    ZGHAL_SPI_CONTEXT_SET_TX_PRE_LEN(1);
    ZGHAL_SPI_CONTEXT_SET_TX_ROM_BUF_PTR(pBuf);
    ZGHAL_SPI_CONTEXT_SET_TX_LEN(length);
    ZGHAL_SPI_CONTEXT_SET_RX_PRE_BUF_PTR(statusBuffer);
    ZGHAL_SPI_CONTEXT_SET_RX_PRE_LEN(1);
    ZGHAL_SPI_CONTEXT_SET_RX_BUF_PTR(kZGDataPtrNULL);
    ZGHAL_SPI_CONTEXT_SET_RX_LEN(0);
    ZGHAL_SPI_CONTEXT_SET_RX_EXCESS_LEN(0);
    ZGHAL_SPI_CONTEXT_SET_SUPPRESS_DONE_HANDLER_CALL(kZGBoolTrue);
    zgHALSpiTxRx();
}



/*****************************************************************************
 * FUNCTION: InitiateSpiReadRegister
 *
 * RETURNS: N/A
 *
 * PARAMS:
 *      tZGU8 reg - the G2100 register id that is the target of the read
 *          operation.
 *      tZGU8 len - The length in bytes of the data to be read.
 *
 *  NOTES: Used to read a G2100 register using the SPI interface.  The
 *      read value will be stored in COMCXT.regBuf.
 *****************************************************************************/
static tZGVoidReturn InitiateSpiReadRegister(tZGU8 reg, tZGU8 len)
{
    COMCXT.spiCmdBuf[0] = reg | kZGCOMCmdReadRegister;
    ZGHAL_SPI_CONTEXT_SET_TX_PRE_BUF_PTR(COMCXT.spiCmdBuf);
    ZGHAL_SPI_CONTEXT_SET_TX_PRE_LEN(kZGCOMCmdLen);
    ZGHAL_SPI_CONTEXT_SET_TX_BUF_PTR(kZGDataPtrNULL);
    ZGHAL_SPI_CONTEXT_SET_TX_LEN(0);
    ZGHAL_SPI_CONTEXT_SET_RX_PRE_BUF_PTR(COMCXT.statusBuf);
    ZGHAL_SPI_CONTEXT_SET_RX_PRE_LEN(kZGCOMStatusLen);
    ZGHAL_SPI_CONTEXT_SET_RX_BUF_PTR(COMCXT.regBuf);
    ZGHAL_SPI_CONTEXT_SET_RX_LEN(len);
    ZGHAL_SPI_CONTEXT_SET_RX_EXCESS_LEN(0);
}


/*****************************************************************************
 * FUNCTION: InitiateSpiWriteRegister
 *
 * RETURNS: N/A
 *
 * PARAMS:
 *      tZGU8 reg - the G2100 register id that is the target of the write
 *          operation.
 *      tZGU8 len - The length in bytes of the data to be written.
 *
 *  NOTES: Used to write a G2100 register using the SPI interface.  The
 *      new value must be stored in COMCXT.regBuf.
 *****************************************************************************/
static tZGVoidReturn InitiateSpiWriteRegister(tZGU8 reg, tZGU8 len)
{
    COMCXT.spiCmdBuf[0] = reg | kZGCOMCmdWriteRegister;
    ZGHAL_SPI_CONTEXT_SET_TX_PRE_BUF_PTR(COMCXT.spiCmdBuf);
    ZGHAL_SPI_CONTEXT_SET_TX_PRE_LEN(kZGCOMCmdLen);
    ZGHAL_SPI_CONTEXT_SET_TX_BUF_PTR(COMCXT.regBuf);
    ZGHAL_SPI_CONTEXT_SET_TX_LEN(len);
    ZGHAL_SPI_CONTEXT_SET_RX_PRE_BUF_PTR(COMCXT.statusBuf);
    ZGHAL_SPI_CONTEXT_SET_RX_PRE_LEN(kZGCOMStatusLen);
    ZGHAL_SPI_CONTEXT_SET_RX_BUF_PTR(kZGDataPtrNULL);
    ZGHAL_SPI_CONTEXT_SET_RX_LEN(0);
    ZGHAL_SPI_CONTEXT_SET_RX_EXCESS_LEN(0);
}




/*****************************************************************************
 * FUNCTION: ProcessInterruptServiceResult
 *
 * RETURNS: N/A
 *
 * PARAMS:
 *      N/A
 *
 *
 *  NOTES: Implements the step by step logic required to process an interrupt
 *      from the G2100.  This function is called by the main COM state machine
 *      only when it is determined that the SPI operation has completed.
 *      This function then processes the result of the SPI operation.
 *      Processing a G2100 interrupt requires a minimum of 3 SPI operations.
 *      Operation 1) read the host interrupt register and the host interrupt
 *      Mask register.
 *      Operation 2) Write the Host Interrupt register to clear the appropriate
 *      interrupt bits.
 *      Operation 3) Read the appropriate control register that corresponds
 *      to the interrupt that fired. Example, if the read Fifo0 theshold
 *      interrupt fired, then the read Fifo 0 byte count register must be
 *      read to determine how many bytes are in the awaiting message.
 *
 *      Called by ZGPrvComStateMachine().
 *****************************************************************************/
static tZGVoidReturn ProcessInterruptServiceResult(tZGVoidInput)
{
    //tZGU16 numBytes;
    tZGU8  hostIntRegValue;
    tZGU8  hostIntMaskRegValue;
    tZGU8  hostInt;

    /* read hostInt register and hostIntMask register to determine cause of interrupt */
    hostIntRegValue      = Read8BitZGRegister(kZGCOMRegHostInt);
    hostIntMaskRegValue  = Read8BitZGRegister(kZGCOMRegHostIntMask);

    // AND the two registers together to determine which active, enabled interrupt has occurred
    hostInt = hostIntRegValue & hostIntMaskRegValue;

    // if received a level 2 interrupt
    if((hostInt & kZGCOMRegHostIntMaskInt2) == kZGCOMRegHostIntMaskInt2)
    {
        /* read the 16 bit interrupt register */
        /* CURRENTLY unhandled interrupt */
        ZGSYS_DRIVER_ASSERT(1, (ROM char *)"16-bit Interrupt in COM\n");
        COMCXT.state = kComStIdle;
        zgHALEintEnable();
    }
    // else if got a FIFO 1 Threshold interrupt (Management Fifo)
    else if((hostInt & kZGCOMRegHostIntMaskFifo1Thresh) == kZGCOMRegHostIntMaskFifo1Thresh)
    {
        /* clear this interrupt */
        Write8BitZGRegister(kZGCOMRegHostInt, kZGCOMRegHostIntMaskFifo1Thresh);
        // notify MAC state machine that management message needs to be processed
        ZGPrvMacReadReady();
        COMCXT.state = kComStIdle;
    }
    // else if got a FIFO 0 Threshold Interrupt (Data Fifo)
    else if((hostInt & kZGCOMRegHostIntMaskFifo0Thresh) == kZGCOMRegHostIntMaskFifo0Thresh)
    {
        /* clear this interrupt */
        Write8BitZGRegister(kZGCOMRegHostInt, kZGCOMRegHostIntMaskFifo0Thresh);

        gHostRAWDataPacketReceived = true;  /* this global flag is used in MACGetHeader() to determine a received data packet */
        COMCXT.state = kComStIdle;

        /* if the chip is in low power mode then it must first be
         * brought out of low power before attempting a write
         * operation. */
        if(COMCXT.bLowPowerModeActive)
        {
            ChangeLowPowerMode(kZGBoolFalse);
        }

    }
    // else got a Host interrupt that we don't handle
    else if(hostInt)
    {
        /* unhandled interrupt */
        ZGSYS_DRIVER_ASSERT(1, (tZGTextPtr)"unhandled interrupt in COM\n");
        COMCXT.state = kComStIdle;
        zgHALEintEnable();
    }
    // we got a spurious interrupt (no bits set in register)
    else
    {
        /* spurious interrupt */
        COMCXT.state = kComStIdle;
        zgHALEintEnable();
    }
}


/*****************************************************************************
 * FUNCTION: ChipReset
 *
 * RETURNS: N/A
 *
 * PARAMS:
 *      N/A
 *
 *
 *  NOTES: Performs the necessary SPI operations to cause the G2100 to reset.
 *      This function also implements a delay so that it will not return until
 *      the G2100 is ready to receive messages again.  The delay time will
 *      vary depending on the amount of code that must be loaded from serial
 *      flash.
 *****************************************************************************/
static tZGVoidReturn ChipReset(tZGVoidInput)
{
    tZGU8 loop = 0;
    tZGU16 value;

    // needed for Microchip PICTail (chip enable active low)
    XCEN33_TRIS = 0;  // Configure line as ouput
    XCEN33_IO   = 0;  // Set low to enable regulator

    ZG_RST_TRIS = 0;  // configure the I/O as an output
    ZG_RST_IO   = 1;  // take ZG2100 out of reset

    /* first clear the power bit to disable low power mode on the G2100 */
    Write16BitZGRegister(kZGCOMRegLoPwrCtrlReg, 0x0000);

    /* this loop writes the necessary G2100 registers to
     * start a Hard reset. */
    do
    {
        Write16BitZGRegister(kZGCOMRegIndexAddrReg, (tZGU16)kZGCOMRegConfigCtrl0Reg);

        value = (loop == 0u) ? (0x80) : (0x0f);
        value = (value << 8u) | 0xff;
        Write16BitZGRegister(kZGCOMRegIndexDataReg, value);

    } while(loop++ < 1u);

    /* after reset is started the host should poll a register
     * that indicates when the HW reset is complete. This
     * next loop performs that operation. */
    do
    {
        /* read the status reg to determine when the
         * G2100 is nolonger in reset. */
        Write16BitZGRegister(kZGCOMRegIndexAddrReg, (tZGU16)kZGCOMRegAnalogStatusReg);

        value = Read16BitZGRegister(kZGCOMRegIndexDataReg);

    } while((value & (tZGU16)kZGCOMRegNotInResetMask) == 0u);

    /* After the G2100 comes out of reset the chip must complete
     * its initialization.  the following loop reads the Write
     * fifo byte count register which will be non-zero when
     * the G2100 initialization has finished. */
    do
    {
        value = Read16BitZGRegister(kZGCOMRegWrtFifo0ByteCnt);

    } while(value == 0u);
}



/*****************************************************************************
 * FUNCTION: HostInterrupt2RegInit
 *
 * RETURNS: N/A
 *
 * PARAMS:
 *      tZGU8 hostIntrMaskRegMask - The bit mask to be modified.
 *      tZGU8 state -  one of kZGCOMIntDisable, kZGCOMIntEnable where
 *          Disable implies clearing the bits and enable sets the bits.
 *
 *
 *  NOTES: Initializes the 16-bit Host Interrupt register on the g2100 with the
 *      specified mask value either setting or clearing the mask register
 *      as determined by the input parameter state.  The process requires
 *      2 spi operations which are performed in a blocking fashion.  The
 *      function does not return until both spi operations have completed.
 *      The function makes use of ZGHAL_SPI_PROCESS if the spi driver is
 *      not interrupt driven. The operation is a Read-Modify-Write where the
 *      Read is the first SPI operation and the Write is the second spi
 *      operation.
 *****************************************************************************/
static tZGVoidReturn HostInterrupt2RegInit(tZGU16 hostIntrMaskRegMask,
                                           tZGU8 state)
{
    //tZGU16 hostIntRegValue;
    tZGU16 HostInt2MaskRegValue;

    /* read current state of int2 mask */
    HostInt2MaskRegValue = Read16BitZGRegister(kZGCOMRegHostInt2Mask);

    // write out input mask to int2 reg */
    Write16BitZGRegister(kZGCOMRegHostInt2, hostIntrMaskRegMask);

    /* set or clear bits in int2 mask based on whether interrupts enabled or disabled */
    if (state == kZGCOMIntDisable)
    {
        HostInt2MaskRegValue &= ~hostIntrMaskRegMask;
    }
    else
    {
        HostInt2MaskRegValue |= hostIntrMaskRegMask;
    }
    Write16BitZGRegister(kZGCOMRegHostInt2Mask, HostInt2MaskRegValue);
}

/*****************************************************************************
 * FUNCTION: HostInterruptRegInit
 *
 * RETURNS: N/A
 *
 * PARAMS:
 *      tZGU8 hostIntrMaskRegMask - The bit mask to be modified.
 *      tZGU8 state -  one of kZGCOMIntDisable, kZGCOMIntEnable where
 *          Disable implies clearing the bits and enable sets the bits.
 *
 *
 *  NOTES: Initializes the 8-bit Host Interrupt register on the g2100 with the
 *      specified mask value either setting or clearing the mask register
 *      as determined by the input parameter state.  The process requires
 *      2 spi operations which are performed in a blocking fashion.  The
 *      function does not return until both spi operations have completed.
 *      The function makes use of ZGHAL_SPI_PROCESS if the spi driver is
 *      not interrupt driven. The operation is a Read-Modify-Write where the
 *      Read is the first SPI operation and the Write is the second spi
 *      operation.
 *****************************************************************************/
static tZGVoidReturn HostInterruptRegInit(tZGU8 hostIntrMaskRegMask,
                                          tZGU8 state)
{
    //tZGU8 hostIntValue;
    tZGU8 hostIntMaskValue;

    /* Host Int Register used to activate which events will cause a bit to be set in  */
    /* status register (which can be polled if not using interrupts)                  */

    /* Host Int Mask Register used to enable those events activated in Host Int Register */
    /* to cause an interrupt to the host                                                 */


    /* read current state of Host Interrupt Mask register */
    hostIntMaskValue = Read8BitZGRegister(kZGCOMRegHostIntMask);

    // if disabling the interrupts in the input mask
    if (state == kZGCOMIntDisable)
    {
        // clear those interrupt bits
        hostIntMaskValue = (hostIntMaskValue & ~hostIntrMaskRegMask);
    }
    // else enabling interrupts in the input mask
    else
    {
        // set those interrupt bits
        hostIntMaskValue = (hostIntMaskValue & ~hostIntrMaskRegMask) | hostIntrMaskRegMask;
    }

    // write updated Host Int Mask value back to register
    Write8BitZGRegister(kZGCOMRegHostIntMask, hostIntMaskValue);

    // update Host Int register
    Write8BitZGRegister(kZGCOMRegHostInt, hostIntrMaskRegMask);
}

/*****************************************************************************
 * FUNCTION: ZGPrvComFifoOperation
 *
 * RETURNS: N/A
 *
 * PARAMS:
 *      N/A
 *
 *
 *  NOTES: Called by the MAC layer to signal the presense of a FIFO job for
 *      the COM layer.
 *****************************************************************************/
tZGVoidReturn ZGPrvComFifoOperation(tZGVoidInput)
{
    COMCXT.bRdWtReady = kZGBoolTrue;
}

/*****************************************************************************
 * FUNCTION: zgDriverEintHandler
 *
 * RETURNS: N/A
 *
 * PARAMS:
 *      N/A
 *
 *
 *  NOTES: This function must be called once, each time an external interrupt
 *      is received from the ZeroG device.   The ZG Driver will schedule any
 *      subsequent SPI communication to process the interrupt.
 *****************************************************************************/
tZGVoidReturn zgDriverEintHandler(tZGVoidInput)
{
    /* Disable the Interrupt and re-enable after processing is complete */
    zgHALEintDisable();
    COMCXT.bIntServiceReq = kZGBoolTrue;
    
    ZGSYS_SIGNAL_SET();
}

/*****************************************************************************
 * FUNCTION: zgDriverSpiTxRxDoneHandler
 *
 * RETURNS: N/A
 *
 * PARAMS:
 *      N/A
 *
 *
 *  NOTES: This function must be called once, each time the SPI driver
 *      completes an SPI operation.  The ZG Driver will, upon receiving this
 *      function call, schedule a new SPI operation to the driver if one
 *      is pending.
 *****************************************************************************/
tZGVoidReturn zgDriverSpiTxRxDoneHandler(tZGVoidInput)
{
    if(COMCXT.bInitDevice == kZGBoolFalse)
        ZGSYS_SIGNAL_SET();
}

/*****************************************************************************
 * FUNCTION: ZGPrvComInit
 *
 * RETURNS: N/A
 *
 * PARAMS:
 *      N/A
 *
 *
 *  NOTES: Used to initialize the COM layer of this driver as well as to
 *      initialize the G2100 hardware.  Function manages the call order of
 *      several other functions to clear the hw interrupt registers, reset
 *      the chip, enable the external interrupt driver and initialize the
 *      hw interrupt registers.
 *****************************************************************************/
tZGVoidReturn ZGPrvComInit(tZGVoidInput)
{
    COMCXT.state = kComStIdle;
    COMCXT.bRdWtReady = kZGBoolFalse;
    COMCXT.bIntServiceReq = kZGBoolFalse;
    COMCXT.bLowPowerModeActive = kZGBoolFalse;
    COMCXT.bLowPowerModeDesired = kZGBoolFalse;

    /* set the bInitDevice to true so that
     * the following functions capture the SPI
     * done and prevent it from signaling the
     * driver. */
    COMCXT.bInitDevice = kZGBoolTrue;

    /* initialize the SPI next so that it can
     * be used by the ZGDriver to reset the
     * G2100 and initialize the G2100 interrupt
     * control registers. */
    zgHALSpiInit();
    
    /* Call function to - Reset the G2100 here */
    ChipReset();
    
    /* disable the interrupts gated by the 16-bit host int register */
    HostInterrupt2RegInit(kZGCOMRegHost2IntMaskAllInt, kZGCOMIntDisable);
    /* disable the interrupts gate the by main 8-bit host int register */
    HostInterruptRegInit(kZGCOMRegHostIntMaskAllInt, kZGCOMIntDisable);
    /* Now initialize the External Interrupt for
     * the G2100 allowing the G2100 to interrupt
     * the Host from this point forward. */
    zgHALEintInit();
    zgHALEintEnable();
    /* enable the 2 read fifo interrupts for this driver */
    HostInterruptRegInit(kZGCOMRegHostIntMaskFifo1Thresh | kZGCOMRegHostIntMaskFifo0Thresh,
                            kZGCOMIntEnable);
    /* NOTE: This is where additional host interrupts would be enabled */

    /* Set the power mode active as last step of Init operation */
    ChangeLowPowerMode(kZGBoolFalse);
    /* read the G2100 Info Block */
    ReadChipInfoBlock();

    /* clear the bInitDevice so that announcements
     * from the SPI driver will behave normally. */
    COMCXT.bInitDevice = kZGBoolFalse;
}


/*****************************************************************************
 * FUNCTION: ZGPrvComStateMachine
 *
 * RETURNS: N/A
 *
 * PARAMS:
 *      N/A
 *
 *
 *  NOTES: Represents the State machine for the COM layer of the ZG Driver.
 *      The responsibility of the COM layer is to schedule SPI operations
 *      and act as a receiver of interrupt notifications from the G2100.
 *      Essentially read and write fifo operations are submitted from the
 *      MAC layer 1 at a time and separately an interrupt can be received
 *      from the G2100 the meaning of which needs to be determined.  The
 *      State machine initially starts in the idle state and waits for one
 *      of these 2 events with priority going to the interrupt event however
 *      once an operation is started in cannot be pre-empted.  Interrupt
 *      processing requires reading and writing several chip registers to
 *      learn the meaning of the interrupt and clear the interrupt.  With
 *      the results being routed to the MAC layer for further processing.
 *      Fifo operation is either a read or write operation which involves
 *      several SPI steps that must be scheduled
 *****************************************************************************/
 tZGVoidReturn ZGPrvComStateMachine(tZGVoidInput)
{
    tZGU8 bLoop = 0;
    tZGU16 len;
    tZGBool res;

    do
    {
        if(COMCXT.state == kComStIdle)
        {
            //-----------------------------------------
            // if there is an EINT interrupt to process
            //-----------------------------------------
            if(COMCXT.bIntServiceReq == kZGBoolTrue)
            {
                COMCXT.bIntServiceReq = kZGBoolFalse;
                COMCXT.state = kComStIntService;
            }
            //--------------------------------------------
            // if there is management msg to read or write
            //--------------------------------------------
            else if(COMCXT.bRdWtReady == kZGBoolTrue)
            {
                /* if the chip is in low power mode then it must first be
                 * brought out of low power before attempting a write
                 * operation. */
                if(COMCXT.bLowPowerModeActive)
                {
                    ChangeLowPowerMode(kZGBoolFalse);
                }

                COMCXT.state = (RWCXT.dir == kZGDirWrite)? kComStWriteOperation : kComStReadOperation;

                //----------------------------
                // if doing a management write
                //----------------------------
                if (RWCXT.dir == kZGDirWrite)
                {
                    res = ZGSendRAWManagementFrame(RWCXT.len);
                    if (res == kZGBoolFalse)
                    {
                        ZG_PUTRSUART("Mgmt Send Failed\r\n");
                        while(1);
                    }    
                    COMCXT.bRdWtReady = kZGBoolFalse;
                    ZGPrvMacOpComplete();
                    COMCXT.state = kComStIdle;

                }
                //-----------------------------
                // else doing a management read
                //-----------------------------
                else
                {
                    // if the Raw Rx buffer is available, or only has the scratch mounted, then mount it so
                    // we can process received Mgmt message.  Otherwise, stay in this state and keep checking
                    // until we can mount the Raw Rx buffer and get the management message.  Once the Raw Rx
                    // is acquired, rx data packets are held off until we finish processing mgmt message.
                    if ( ZGRawGetMgmtRxBuffer(&len) )
                    {
                        // handle received managment message
                        COMCXT.bRdWtReady = kZGBoolFalse;
                        ZGPrvMacOpComplete();
                        COMCXT.state = kComStIdle;
                        // reenable interrupts
                        zgHALEintEnable();
                    }
                }
            }
            //-------------------------------------------------------------
            // else no manangement tx or rx to do, so check for other stuff
            //-------------------------------------------------------------
            else
            {
                bLoop = 0;

                /* manage low power control of g2100 */
                if(COMCXT.bLowPowerModeDesired == kZGBoolTrue &&
                    COMCXT.bLowPowerModeActive == kZGBoolFalse &&
                    MACCXT.bMgmtTxMsgReady == kZGBoolTrue)
                {
                    ChangeLowPowerMode(kZGBoolTrue);
                }
            }
        }
        //--------------------------
        // else COMCXT.state != IDLE
        //--------------------------
        else
        {
                bLoop = 1;
                switch(COMCXT.state)
                {

                case kComStIntService: /* use spi to determine device interrupt reason */
                    ProcessInterruptServiceResult();
                    break;

                case kComStReadOperation: /* spi fifo read operation in progress */
                    COMCXT.state = kComStReadWaitFifoDone;
                    ZGPrvMacOpComplete();
                    break;

                case kComStWriteOperation: /* spi fifo write operation in progress */
                    COMCXT.state = kComStWriteWaitFifoDone;
                    ZGPrvMacOpComplete();
                    break;

                case kComStReadWaitFifoDone:
                    COMCXT.state = kComStIdle;
                    break;

                case kComStWriteWaitFifoDone: /* complete the fifo operation */
                    COMCXT.state = kComStIdle;
                    break;
                }
            }
    } while(bLoop);
}


tZGVoidReturn ZGPrvComSetLowPowerMode(tZGBool bEnable)
{
    COMCXT.bLowPowerModeDesired = bEnable;
}

#else
// dummy func to keep compiler happy when module has no executeable code
void ZGDriverCom_EmptyFunc(void)
{
}
#endif /* ZG_CS_TRIS */
