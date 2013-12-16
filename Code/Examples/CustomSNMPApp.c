/*********************************************************************
 *
 *  Application to Demo SNMP Server
 *  Support for SNMP module in Microchip TCP/IP Stack
 *	 - Implements the SNMP application
 *
 *********************************************************************
 * FileName:        CustomSNMPApp.c
 * Dependencies:    TCP/IP stack
 * Processor:       PIC18, PIC24F, PIC24H, dsPIC30F, dsPIC33F, PIC32
 * Compiler:        Microchip C32 v1.05 or higher
 *					Microchip C30 v3.12 or higher
 *					Microchip C18 v3.30 or higher
 *					HI-TECH PICC-18 PRO 9.63PL2 or higher
 * Company:         Microchip Technology, Inc.
 *
 * Software License Agreement
 *
 * Copyright (C) 2002-2009 Microchip Technology Inc.  All rights
 * reserved.
 *
 * Microchip licenses to you the right to use, modify, copy, and
 * distribute:
 * (i)  the Software when embedded on a Microchip microcontroller or
 *      digital signal controller product ("Device") which is
 *      integrated into Licensee's product; or
 * (ii) ONLY the Software driver source files ENC28J60.c, ENC28J60.h,
 *		ENCX24J600.c and ENCX24J600.h ported to a non-Microchip device
 *		used in conjunction with a Microchip ethernet controller for
 *		the sole purpose of interfacing with the ethernet controller.
 *
 * You should refer to the license agreement accompanying this
 * Software for additional information regarding your rights and
 * obligations.
 *
 * THE SOFTWARE AND DOCUMENTATION ARE PROVIDED "AS IS" WITHOUT
 * WARRANTY OF ANY KIND, EITHER EXPRESS OR IMPLIED, INCLUDING WITHOUT
 * LIMITATION, ANY WARRANTY OF MERCHANTABILITY, FITNESS FOR A
 * PARTICULAR PURPOSE, TITLE AND NON-INFRINGEMENT. IN NO EVENT SHALL
 * MICROCHIP BE LIABLE FOR ANY INCIDENTAL, SPECIAL, INDIRECT OR
 * CONSEQUENTIAL DAMAGES, LOST PROFITS OR LOST DATA, COST OF
 * PROCUREMENT OF SUBSTITUTE GOODS, TECHNOLOGY OR SERVICES, ANY CLAIMS
 * BY THIRD PARTIES (INCLUDING BUT NOT LIMITED TO ANY DEFENSE
 * THEREOF), ANY CLAIMS FOR INDEMNITY OR CONTRIBUTION, OR OTHER
 * SIMILAR COSTS, WHETHER ASSERTED ON THE BASIS OF CONTRACT, TORT
 * (INCLUDING NEGLIGENCE), BREACH OF WARRANTY, OR OTHERWISE.
 *
 *
 * Author               Date      Comment
 *~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 * E. Wood     			4/26/08	  Moved from MainDemo.c
 * Amit Shirbhate 		09/24/08  SNMPv2c Support added.	
 ********************************************************************/
#define __CUSTOMSNMPAPP_C

#include "TCPIPConfig.h"

#if defined(STACK_USE_SNMP_SERVER)

#include "TCPIP Stack/TCPIP.h"
#include "MainDemo.h"



/****************************************************************************
  Section:
	Global Variables
  ***************************************************************************/

BYTE gSendTrapFlag=FALSE;//global flag to send Trap
BYTE gOIDCorrespondingSnmpMibID=MICROCHIP;
BYTE gGenericTrapNotification=ENTERPRISE_SPECIFIC;
BYTE gSpecificTrapNotification=VENDOR_TRAP_DEFAULT; // Vendor specific trap code


/*Initialize trap table with no entries.*/
TRAP_INFO trapInfo = { TRAP_TABLE_SIZE };

static DWORD SNMPGetTimeStamp(void);


/****************************************************************************
  ===========================================================================
  Section:
	SNMP Routines
  ===========================================================================
  ***************************************************************************/



#if !defined(SNMP_TRAP_DISABLED)
/****************************************************************************
  Function:
 	 BOOL SendNotification(BYTE receiverIndex, SNMP_ID var, SNMP_VAL val)
 
  Summary:			
	Prepare, validate remote node which will receive trap and send trap pdu.
 	  	  
  Description:		
    This routine prepares the trap notification pdu, sends ARP and get
	remote device MAC address to which notification to sent, sends
	the notification. 
	
  PreCondition:
	SNMPTrapDemo() is called.
 	
  parameters:
     receiverIndex - The index to array where remote ip address is stored.  
     var		   - SNMP var ID that is to be used in notification
	 val           - Value of var. Only value of BYTE, WORD or DWORD can be sent.
	 
  Return Values:          
 	 TRUE	-	If notification send is successful.
 	 FALSE	-	If send notification failed.
 	 
  Remarks:
     None.
 *************************************************************************/
static BOOL SendNotification(BYTE receiverIndex, SNMP_ID var, SNMP_VAL val)
{
    static enum { SM_PREPARE, SM_NOTIFY_WAIT } smState = SM_PREPARE;
    IP_ADDR IPAddress;

    // Convert local to network order.
    IPAddress.v[0] = trapInfo.table[receiverIndex].IPAddress.v[3];
    IPAddress.v[1] = trapInfo.table[receiverIndex].IPAddress.v[2];
    IPAddress.v[2] = trapInfo.table[receiverIndex].IPAddress.v[1];
    IPAddress.v[3] = trapInfo.table[receiverIndex].IPAddress.v[0];

    switch(smState)
    {
	    case SM_PREPARE:
	        SNMPNotifyPrepare(&IPAddress,
	                          trapInfo.table[receiverIndex].community,
	                          trapInfo.table[receiverIndex].communityLen,
	                          MICROCHIP,            	   // Agent ID Var
	                          gSpecificTrapNotification,   // Specifc Trap notification code
	                          SNMPGetTimeStamp());
	        smState = SM_NOTIFY_WAIT;
	
	        break;
	
	    case SM_NOTIFY_WAIT:
	        if ( SNMPIsNotifyReady(&IPAddress) )
	        {
	            smState = SM_PREPARE;
	            SNMPNotify(var, val, 0);
	            return TRUE;
	        }
    }
    return FALSE;
}


/**************************************************************************
  Function:
 	void SNMPTrapDemo(void)
 
  Summary:	
  	Send trap pdu demo application.
 	  	  
  Description:		
	This routine sends a trap pdu for the predefined ip addresses with the
	agent. The "event" to generate this trap pdu is "BUTTON_PUSH_EVENT". Whenever
	there occurs a specific button push, this routine is called and sends
	a trap containing PUSH_BUTTON mib var OID and notification type 
	as authentication failure. 
       
  PreCondition:
 	Application defined event occurs to send the trap.
 	
  parameters:
     None.
 
  Returns:          
 	 None.
 
  Remarks:
    This routine guides how to build a event generated trap notification.
    The application should make use of SNMPSendTrap() routine to generate 
    and send trap.
 *************************************************************************/
void SNMPTrapDemo(void)
{
	static BOOL analogPotNotify = FALSE,buttonPushNotify=FALSE;
	static BYTE anaPotNotfyCntr=0,buttonPushNotfyCntr=0;
	static SNMP_VAL buttonPushval,analogPotVal;
	static BYTE potReadLock=FALSE,buttonLock=FALSE;
	static TICK TimerRead;
	static BYTE timeLock=FALSE;

	if(timeLock==(BYTE)FALSE)
	{
		TimerRead=TickGet();
		timeLock=TRUE;
	}

	#if 1
	if(anaPotNotfyCntr > trapInfo.Size)
	{
		anaPotNotfyCntr = 0;
		potReadLock=FALSE;
		//analogPotNotify = FALSE;
		analogPotNotify = TRUE;
	}
	#endif
	
	if(!analogPotNotify)
	{
		//Read POT reading once and send trap to all configured recipient
		if(potReadLock ==(BYTE)FALSE)
		{
			#if defined(__18CXX)
				// Wait until A/D conversion is done
				ADCON0bits.GO = 1;
				while(ADCON0bits.GO);

				// Convert 10-bit value into ASCII string
				analogPotVal.word= (WORD)ADRES;
			#else
				analogPotVal.word= (WORD)ADC1BUF0;
			#endif
			
			//Avoids Reading POT for every iteration unless trap sent to each configured recipients 
			potReadLock=TRUE; 
		}
		if(trapInfo.table[anaPotNotfyCntr].Flags.bEnabled)
		{
			if(analogPotVal.word >512u)
			{
				gSpecificTrapNotification=POT_READING_MORE_512;
				gGenericTrapNotification=ENTERPRISE_SPECIFIC;
				if(SendNotification(anaPotNotfyCntr, ANALOG_POT0, analogPotVal))
					anaPotNotfyCntr++;
				else
					return ;
			}
		}
		else
			anaPotNotfyCntr++;
			
	}


	if(buttonPushNotfyCntr==trapInfo.Size)
	{
		buttonPushNotfyCntr = 0;
		buttonLock=FALSE;
		buttonPushNotify = FALSE;
	}


	if(buttonLock == (BYTE)FALSE)
	{
		if(BUTTON3_IO == 0u)
		{
			buttonPushNotify = TRUE;
			buttonLock =TRUE;
		}
	}

	if(buttonPushNotify)
	{			  
		buttonPushval.byte = 0;
		if ( trapInfo.table[buttonPushNotfyCntr].Flags.bEnabled )
		{
			gSpecificTrapNotification=BUTTON_PUSH_EVENT;
			gGenericTrapNotification=ENTERPRISE_SPECIFIC;
			if(SendNotification(buttonPushNotfyCntr, PUSH_BUTTON, buttonPushval))
				buttonPushNotfyCntr++;
		}
		else
			buttonPushNotfyCntr++;
	}

	//Try for max 5 seconds to send TRAP, do not get block in while()
	if((TickGet()-TimerRead)>(5*TICK_SECOND))
	{
		UDPDiscard();
		buttonPushNotfyCntr = 0;
		buttonLock=FALSE;
		buttonPushNotify = FALSE;
		anaPotNotfyCntr = 0;
		potReadLock=FALSE;
		analogPotNotify = FALSE;
		timeLock=FALSE;
		gSpecificTrapNotification=VENDOR_TRAP_DEFAULT;
		gGenericTrapNotification=ENTERPRISE_SPECIFIC;
		return;
	}

}


/**************************************************************************
  Function:
 	void SNMPSendTrap(void)
 
  Summary:	
  	 Prepare, validate remote node which will receive trap and send trap pdu.
 	 	  
  Description:		
     This function is used to send trap notification to previously 
     configured ip address if trap notification is enabled. There are
     different trap notification code. The current implementation
     sends trap for authentication failure (4).
  
  PreCondition:
 	 If application defined event occurs to send the trap.
 
  parameters:
     None.
 
  Returns:          
 	 None.
 
  Remarks:
     This is a callback function called by the application on certain 
     predefined events. This routine only implemented to send a 
     authentication failure Notification-type macro with PUSH_BUTTON
     oid stored in MPFS. If the ARP is no resolved i.e. if 
     SNMPIsNotifyReady() returns FALSE, this routine times 
     out in 5 seconds. This routine should be modified according to 
     event occured and should update corrsponding OID and notification
     type to the trap pdu.
 *************************************************************************/
void SNMPSendTrap(void)
{
	static BYTE timeLock=FALSE;
	static BYTE receiverIndex=0; ///is application specific
	IP_ADDR remHostIPAddress,* remHostIpAddrPtr;
	SNMP_VAL val;
	static TICK TimerRead;

	static enum 
	{
		SM_PREPARE,
		SM_NOTIFY_WAIT 
	} smState = SM_PREPARE;



	if(trapInfo.table[receiverIndex].Flags.bEnabled)
	{
		remHostIPAddress.v[0] = trapInfo.table[receiverIndex].IPAddress.v[3];
		remHostIPAddress.v[1] = trapInfo.table[receiverIndex].IPAddress.v[2];
		remHostIPAddress.v[2] = trapInfo.table[receiverIndex].IPAddress.v[1];
		remHostIPAddress.v[3] = trapInfo.table[receiverIndex].IPAddress.v[0];
		remHostIpAddrPtr = &remHostIPAddress;
		if(timeLock==(BYTE)FALSE)
		{
			TimerRead=TickGet();
			timeLock=TRUE;
		}
	}	
	else
	{
		receiverIndex++;
		if((receiverIndex == (BYTE)TRAP_TABLE_SIZE))
		{
			receiverIndex=0;
			timeLock=FALSE;
			gSendTrapFlag=FALSE;	
			UDPDiscard();
		}
		return;
		
	}
		
	switch(smState)
	{
	
		case SM_PREPARE:

			SNMPNotifyPrepare(remHostIpAddrPtr,trapInfo.table[receiverIndex].community,
						trapInfo.table[receiverIndex].communityLen,
						MICROCHIP,			  // Agent ID Var
						gSpecificTrapNotification,					  // Notification code.
						SNMPGetTimeStamp());
			smState++;
			break;
			
		case SM_NOTIFY_WAIT:
			if(SNMPIsNotifyReady(remHostIpAddrPtr))
			{
				smState = SM_PREPARE;
		 		val.byte = 0;
				receiverIndex++;

				//application has to decide on which SNMP var OID to send. Ex. PUSH_BUTTON	
				SNMPNotify(gOIDCorrespondingSnmpMibID, val, 0);
            	smState = SM_PREPARE;
				UDPDiscard();
				break;
			}
	}	
		
	//Try for max 5 seconds to send TRAP, do not get block in while()
	if((TickGet()-TimerRead)>(5*TICK_SECOND)|| (receiverIndex == (BYTE)TRAP_TABLE_SIZE))
	{
		UDPDiscard();
		smState = SM_PREPARE;
		receiverIndex=0;
		timeLock=FALSE;
		gSendTrapFlag=FALSE;
		return;
	}

}

#endif

/*********************************************************************
  Function:
 	 BYTE SNMPValidateCommunity(BYTE* community)
 
  Summary:			
 	 Validates community name for access control. 
 
  Description:		
     This function validates the community name for the mib access to NMS.
 	 The snmp community name received in the request pdu is validated for
 	 read and write community names. The agent gives an access to the mib
 	 variables only if the community matches with the predefined values.
  	 This routine also sets a gloabal flag to send trap if authentication
 	 failure occurs.
  
  PreCondition:
 	 SNMPInit is already called.
 
  parameters:
     community - Pointer to community string as sent by NMS.
 
  Returns:          
 	 This routine returns the community validation result as 
  	 READ_COMMUNITY or WRITE_COMMUNITY or INVALID_COMMUNITY	
 
  Remarks:
     This is a callback function called by module. User application must 
  	 implement this function and verify that community matches with 
 	 predefined value. This validation occurs for each NMS request.
 ********************************************************************/
BYTE SNMPValidateCommunity(BYTE * community)
{
	BYTE i;
	BYTE *ptr;
	
	/*
	If the community name is encrypted in the request from the Manager,
	agent required to decrypt it to match with the community it is
	configured for. The response from the agent should contain encrypted community 
	name using the same encryption algorithm which Manager used while
	making the request.
	*/ 		

	// Validate that community string is a legal size
	if(strlen((char*)community) <= SNMP_COMMUNITY_MAX_LEN)
	{
		// Search to see if this is a write community.  This is done before 
		// searching read communities so that full read/write access is 
		// granted if a read and write community name happen to be the same.
		for(i = 0; i < SNMP_MAX_COMMUNITY_SUPPORT; i++)
		{
			ptr = AppConfig.writeCommunity[i];
			if(ptr == NULL)
				continue;
			if(*ptr == 0x00u)
				continue;
			if(strncmp((char*)community, (char*)ptr, SNMP_COMMUNITY_MAX_LEN) == 0)
				return WRITE_COMMUNITY;
		}
		
		// Did not find in write communities, search read communities
		for(i = 0; i < SNMP_MAX_COMMUNITY_SUPPORT; i++)
		{
			ptr = AppConfig.readCommunity[i];
			if(ptr == NULL)
				continue;
			if(*ptr == 0x00u)
				continue;
			if(strncmp((char*)community, (char*)ptr, SNMP_COMMUNITY_MAX_LEN) == 0)
				return READ_COMMUNITY;
		}
	}
	
	// Could not find any matching community, set up to send a trap
	gSpecificTrapNotification=VENDOR_TRAP_DEFAULT;
	gGenericTrapNotification=AUTH_FAILURE;
	gSendTrapFlag=TRUE;
	return INVALID_COMMUNITY;
	
}

/*********************************************************************
  Function:
  	BOOL SNMPIsValidSetLen(SNMP_ID var, BYTE len)

  Summary: 	
	Validates the set variable data length to data type.
	
  Description:
  	This routine is used to validate the dyanmic variable data length
  	to the variable data type. It is used when SET request is processed.
  	This is a callback function called by module. User application
  	must implement this function.
  	
  PreCondition:
  	ProcessSetVar() is called.
 
  Parameters:  
  	var	-	Variable id whose value is to be set
  	len	-	Length value that is to be validated.
 
  Return Values:  
  	TRUE  - if given var can be set to given len
    FALSE - if otherwise.
 
  Remarks:
  	This function will be called for only dynamic variables that are
  	defined as ASCII_STRING and OCTET_STRING (i.e. data length greater
  	than 4 bytes)
 ********************************************************************/
BOOL SNMPIsValidSetLen(SNMP_ID var, BYTE len)
{
    switch(var)
    {
    case TRAP_COMMUNITY:
        if ( len < (BYTE)TRAP_COMMUNITY_MAX_LEN+1 )
            return TRUE;
        break;

#if defined(USE_LCD)
    case LCD_DISPLAY:
        if ( len < sizeof(LCDText)+1 )
            return TRUE;
        break;
#endif
    }
    return FALSE;
}

/*********************************************************************
  Function:  
 	BOOL SNMPSetVar(SNMP_ID var, SNMP_INDEX index,
                                   BYTE ref, SNMP_VAL val)
 
  Summary:
  	This routine Set the mib variable with the requested value.
 
  Description:
  	This is a callback function called by module for the snmp
  	SET request.User application must modify this function 
 	for the new variables address.

  Precondition:
 	ProcessVariables() is called.
 	
  Parameters:        
    var	-	Variable id whose value is to be set

    ref -   Variable reference used to transfer multi-byte data
            0 if first byte is set otherwise nonzero value to indicate
            corresponding byte being set.
            
    val -   Up to 4 byte data value.
            If var data type is BYTE, variable
               value is in val->byte
            If var data type is WORD, variable
               value is in val->word
            If var data type is DWORD, variable
               value is in val->dword.
            If var data type is IP_ADDRESS, COUNTER32,
               or GAUGE32, value is in val->dword
            If var data type is OCTET_STRING, ASCII_STRING
               value is in val->byte; multi-byte transfer
               will be performed to transfer remaining
               bytes of data.
 
  Return Values:  
  	TRUE	-	if it is OK to set more byte(s).
    FALSE	-	if otherwise.
 
  Remarks: 
  	This function may get called more than once depending on number 
	of bytes in a specific set request for given variable.
	only dynamic read-write variables needs to be handled.
********************************************************************/
BOOL SNMPSetVar(SNMP_ID var, SNMP_INDEX index, BYTE ref, SNMP_VAL val)
{
    switch(var)
    {
    case LED_D5:
        LED2_IO = val.byte;
        return TRUE;

    case LED_D6:
        LED1_IO = val.byte;
        return TRUE;

    case TRAP_RECEIVER_IP:
        // Make sure that index is within our range.
        if ( index < trapInfo.Size )
        {
            // This is just an update to an existing entry.
            trapInfo.table[index].IPAddress.Val = val.dword;
            return TRUE;
        }
        else if ( index < (BYTE)TRAP_TABLE_SIZE )
        {
            // This is an addition to table.
            trapInfo.table[index].IPAddress.Val = val.dword;
            trapInfo.table[index].communityLen = 0;
            trapInfo.Size++;
            return TRUE;
        }
        break;

    case TRAP_RECEIVER_ENABLED:
        // Make sure that index is within our range.
        if ( index < trapInfo.Size )
        {
            // Value of '1' means Enabled".
            if ( val.byte == 1u )
                trapInfo.table[index].Flags.bEnabled = 1;
            // Value of '0' means "Disabled.
            else if ( val.byte == 0u )
                trapInfo.table[index].Flags.bEnabled = 0;
            else
                // This is unknown value.
                return FALSE;
            return TRUE;
        }
        // Given index is more than our current table size.
        // If it is within our range, treat it as an addition to table.
        else if ( index < (BYTE)TRAP_TABLE_SIZE )
        {
            // Treat this as an addition to table.
            trapInfo.Size++;
            trapInfo.table[index].communityLen = 0;
        }

        break;

    case TRAP_COMMUNITY:
        // Since this is a ASCII_STRING data type, SNMP will call with
        // SNMP_END_OF_VAR to indicate no more bytes.
        // Use this information to determine if we just added new row
        // or updated an existing one.
        if ( ref ==  SNMP_END_OF_VAR )
        {
            // Index equal to table size means that we have new row.
            if ( index == trapInfo.Size )
                trapInfo.Size++;

            // Length of string is one more than index.
            trapInfo.table[index].communityLen++;

            return TRUE;
        }

        // Make sure that index is within our range.
        if ( index < trapInfo.Size )
        {
            // Copy given value into local buffer.
            trapInfo.table[index].community[ref] = val.byte;
            // Keep track of length too.
            // This may not be NULL terminate string.
            trapInfo.table[index].communityLen = (BYTE)ref;
            return TRUE;
        }
        break;

#if defined(USE_LCD)
    case LCD_DISPLAY:
        // Copy all bytes until all bytes are transferred
        if ( ref != SNMP_END_OF_VAR )
        {
            LCDText[ref] = val.byte;
            LCDText[ref+1] = 0;
        }
        else
        {
			LCDUpdate();
        }

        return TRUE;
#endif

    }

    return FALSE;
}



/*********************************************************************
  Function:        
  	BOOL SNMPGetNextIndex(SNMP_ID var,SNMP_INDEX* index)

  Summary:
  	To search for next index node in case of a Sequence variable.
	
  Description:    
  	This is a callback function called by SNMP module.
    SNMP user must implement this function in user application and 
    provide appropriate data when called.  This function will only
    be called for OID variable of type sequence.
    
  PreCondition: 
  	None
 
  Parameters:
  	var		-	Variable id whose value is to be returned
  	index   -	Next Index of variable that should be transferred
 
  Return Values:
  	TRUE	-	 If a next index value exists for given variable at given
                 index and index parameter contains next valid index.
    FALSE	-	 Otherwise.
 
  Remarks:
	  Only sequence index needs to be handled in this function.
 ********************************************************************/
BOOL SNMPGetNextIndex(SNMP_ID var, SNMP_INDEX* index)
{
    SNMP_INDEX tempIndex;

    tempIndex = *index;

    switch(var)
    {
    case TRAP_RECEIVER_ID:
        // There is no next possible index if table itself is empty.
        if ( trapInfo.Size == 0u )
            return FALSE;

        // INDEX_INVALID means start with first index.
        if ( tempIndex == (BYTE)SNMP_INDEX_INVALID )
        {
            *index = 0;
            return TRUE;
        }
        else if ( tempIndex < (trapInfo.Size-1) )
        {
            *index = tempIndex+1;
            return TRUE;
        }
        break;
    }
    return FALSE;
}


/*********************************************************************
  Function:
  	BOOL SNMPGetVar(SNMP_ID var, SNMP_INDEX index,BYTE* ref, SNMP_VAL* val)
                                   
  Summary:
  	Used to Get/collect OID variable information.

  Description:
 	This is a callback function called by SNMP module. SNMP user must 
 	implement this function in user application and provide appropriate
 	data when called.
   	
  PreCondition:
  	None
 
  parameters:
  	var		-	Variable id whose value is to be returned
    index   -	Index of variable that should be transferred
    ref     -   Variable reference used to transfer
              	multi-byte data
                It is always SNMP_START_OF_VAR when very
                first byte is requested.
                Otherwise, use this as a reference to
                keep track of multi-byte transfers.
    val     -	Pointer to up to 4 byte buffer.
                If var data type is BYTE, transfer data
                  in val->byte
                If var data type is WORD, transfer data in
                  val->word
                If var data type is DWORD, transfer data in
                  val->dword
                If var data type is IP_ADDRESS, transfer data
                  in val->v[] or val->dword
                If var data type is COUNTER32, TIME_TICKS or
                  GAUGE32, transfer data in val->dword
                If var data type is ASCII_STRING or OCTET_STRING
                  transfer data in val->byte using multi-byte
                  transfer mechanism.
 
  Return Values:
  	TRUE	-	If a value exists for given variable at given index.
    FALSE 	-	Otherwise.
 
  Remarks:
 	None.
 ********************************************************************/
BOOL SNMPGetVar(SNMP_ID var, SNMP_INDEX index, BYTE* ref, SNMP_VAL* val)
{
    BYTE myRef;
 	DWORD_VAL dwvHigh, dwvLow;
    DWORD dw;
    DWORD dw10msTicks;

    myRef = *ref;

    switch(var)
    {
    case SYS_UP_TIME:
    {
	 
	    
	    // Get all 48 bits of the internal Tick timer
	    do
	   	{
		   	dwvHigh.Val = TickGetDiv64K();
		   	dwvLow.Val = TickGet();
		} while(dwvHigh.w[0] != dwvLow.w[1]);
	    dwvHigh.Val = dwvHigh.w[1];
	    
		// Find total contribution from lower DWORD
	    dw = dwvLow.Val/(DWORD)TICK_SECOND;
	    dw10msTicks = dw*100ul;
	    dw = (dwvLow.Val - dw*(DWORD)TICK_SECOND)*100ul;		// Find fractional seconds and convert to 10ms ticks
	    dw10msTicks += (dw+((DWORD)TICK_SECOND/2ul))/(DWORD)TICK_SECOND;

		// Itteratively add in the contribution from upper WORD
		while(dwvHigh.Val >= 0x1000ul)
		{
			dw10msTicks += (0x100000000000ull*100ull+(TICK_SECOND/2ull))/TICK_SECOND;
			dwvHigh.Val -= 0x1000;
		}	
		while(dwvHigh.Val >= 0x100ul)
		{
			dw10msTicks += (0x010000000000ull*100ull+(TICK_SECOND/2ull))/TICK_SECOND;
			dwvHigh.Val -= 0x100;
		}	
		while(dwvHigh.Val >= 0x10ul)
		{
			dw10msTicks += (0x001000000000ull*100ull+(TICK_SECOND/2ull))/TICK_SECOND;
			dwvHigh.Val -= 0x10;
		}	
		while(dwvHigh.Val)
		{
			dw10msTicks += (0x000100000000ull*100ull+(TICK_SECOND/2ull))/TICK_SECOND;
			dwvHigh.Val--;
		}
	    
        val->dword = dw10msTicks;
        return TRUE;
    }    

    case LED_D5:
        val->byte = LED2_IO;
        return TRUE;

    case LED_D6:
        val->byte = LED1_IO;
        return TRUE;

    case PUSH_BUTTON:
        // There is only one button - meaning only index of 0 is allowed.
        val->byte = BUTTON0_IO;
        return TRUE;

    case ANALOG_POT0:
        val->word = atoi((char*)AN0String);
        return TRUE;

    case TRAP_RECEIVER_ID:
        if ( index < trapInfo.Size )
        {
            val->byte = index;
            return TRUE;
        }
        break;

    case TRAP_RECEIVER_ENABLED:
        if ( index < trapInfo.Size )
        {
            val->byte = trapInfo.table[index].Flags.bEnabled;
            return TRUE;
        }
        break;

    case TRAP_RECEIVER_IP:
        if ( index < trapInfo.Size )
        {
            val->dword = trapInfo.table[index].IPAddress.Val;
            return TRUE;
        }
        break;

    case TRAP_COMMUNITY:
        if ( index < trapInfo.Size )
        {
            if ( trapInfo.table[index].communityLen == 0u )
                *ref = SNMP_END_OF_VAR;
            else
            {
                val->byte = trapInfo.table[index].community[myRef];

                myRef++;

                if ( myRef == trapInfo.table[index].communityLen )
                    *ref = SNMP_END_OF_VAR;
                else
                    *ref = myRef;
            }
            return TRUE;
        }
        break;

#if defined(USE_LCD)
    case LCD_DISPLAY:
        if ( LCDText[0] == 0u )
            myRef = SNMP_END_OF_VAR;
        else
        {
            val->byte = LCDText[myRef++];
            if ( LCDText[myRef] == 0u )
                myRef = SNMP_END_OF_VAR;
        }

        *ref = myRef;
        return TRUE;
#endif
    }

    return FALSE;
}


static DWORD SNMPGetTimeStamp(void)
{

	DWORD_VAL dwvHigh, dwvLow;
    DWORD dw;
    DWORD timeStamp;
	
	//TimeStamp
	// Get all 48 bits of the internal Tick timer
    do
   	{
	   	dwvHigh.Val = TickGetDiv64K();
	   	dwvLow.Val = TickGet();
	} while(dwvHigh.w[0] != dwvLow.w[1]);
    dwvHigh.Val = dwvHigh.w[1];
    
	// Find total contribution from lower DWORD
    dw = dwvLow.Val/(DWORD)TICK_SECOND;
    timeStamp = dw*100ul;
    dw = (dwvLow.Val - dw*(DWORD)TICK_SECOND)*100ul;		// Find fractional seconds and convert to 10ms ticks
    timeStamp += (dw+((DWORD)TICK_SECOND/2ul))/(DWORD)TICK_SECOND;

	// Itteratively add in the contribution from upper WORD
	while(dwvHigh.Val >= 0x1000ul)
	{
		timeStamp += (0x100000000000ull*100ull+(TICK_SECOND/2ull))/TICK_SECOND;
		dwvHigh.Val -= 0x1000;
	}	
	while(dwvHigh.Val >= 0x100ul)
	{
		timeStamp += (0x010000000000ull*100ull+(TICK_SECOND/2ull))/TICK_SECOND;
		dwvHigh.Val -= 0x100;
	}	
	while(dwvHigh.Val >= 0x10ul)
	{
		timeStamp += (0x001000000000ull*100ull+(TICK_SECOND/2ull))/TICK_SECOND;
		dwvHigh.Val -= 0x10;
	}	
	while(dwvHigh.Val)
	{
		timeStamp += (0x000100000000ull*100ull+(TICK_SECOND/2ull))/TICK_SECOND;
		dwvHigh.Val--;
	}
    
    return timeStamp;
}

#endif	//#if defined(STACK_USE_SNMP_SERVER)
