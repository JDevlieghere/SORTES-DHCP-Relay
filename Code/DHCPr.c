#define __PINGDEMO_C
#define __18F97J60
#define __SDCC__
#include <pic18f97j60.h> //ML

#include "Include/TCPIPConfig.h"
#include "Include/TCPIP_Stack/TCPIP.h"

#if defined(STACK_USE_DHCP_RELAY)

#include "Include/MainDemo.h"
#define DHCP_LEASE_DURATION				60ul

/*****************************************************************************
  Function:
	void DHCPRelayTask(void)

  Summary:
	Performs periodic DHCP server tasks.

  Description:
	This function performs any periodic tasks requied by the DHCP server
	module, such as processing DHCP requests and distributing IP addresses.

  Precondition:
	None

  Parameters:
	None

  Returns:
  	None
  ***************************************************************************/
void DHCPRelayTask(void)
{
	BYTE 				i;
	BYTE				Option, Len;
	BOOTP_HEADER		BOOTPHeader;
	DWORD				dw;
	BOOL				bAccept;
	static enum
	{
		DHCP_OPEN_SOCKET,
		DHCP_LISTEN
	} smDHCPRelay = DHCP_OPEN_SOCKET;

#if defined(STACK_USE_DHCP_CLIENT)
	// Make sure we don't clobber anyone else's DHCP server
	if(DHCPIsServerDetected(0))
		return;
#endif

	if(!bDHCPRelayEnabled)
		return;

	switch(smDHCPRelay)
	{
		case DHCP_OPEN_SOCKET:
			// Obtain a UDP socket to listen/transmit on
			MySocket = UDPOpen(DHCP_SERVER_PORT, NULL, DHCP_CLIENT_PORT);
			if(MySocket == INVALID_UDP_SOCKET)
				break;


			// Decide which address to lease out
			// Note that this needs to be changed if we are to
			// support more than one lease
			DHCPNextLease.Val = (AppConfig.MyIPAddr.Val & AppConfig.MyMask.Val) + 0x02000000;
			if(DHCPNextLease.v[3] == 255u)
				DHCPNextLease.v[3] += 0x03;
			if(DHCPNextLease.v[3] == 0u)
				DHCPNextLease.v[3] += 0x02;

			smDHCPRelay++;

		case DHCP_LISTEN:
			// Check to see if a valid DHCP packet has arrived
			if(UDPIsGetReady(MySocket) < 241u)
				break;

			// Retrieve the BOOTP header
			UDPGetArray((BYTE*)&BOOTPHeader, sizeof(BOOTPHeader));

			bAccept = (BOOTPHeader.ClientIP.Val == DHCPNextLease.Val) || (BOOTPHeader.ClientIP.Val == 0x00000000u);

			// Validate first three fields
			if(BOOTPHeader.MessageType != 1u)
				break;
			if(BOOTPHeader.HardwareType != 1u)
				break;
			if(BOOTPHeader.HardwareLen != 6u)
				break;

			// Throw away 10 unused bytes of hardware address,
			// server host name, and boot file name -- unsupported/not needed.
			for(i = 0; i < 64+128+(16-sizeof(MAC_ADDR)); i++)
				UDPGet(&Option);

			// Obtain Magic Cookie and verify
			UDPGetArray((BYTE*)&dw, sizeof(DWORD));
			if(dw != 0x63538263ul)
				break;

			// Obtain options
			while(1)
			{
				// Get option type
				if(!UDPGet(&Option))
					break;
				if(Option == DHCP_END_OPTION)
					break;

				// Get option length
				UDPGet(&Len);

				// Process option
				switch(Option)
				{
					case DHCP_MESSAGE_TYPE:
						UDPGet(&i);
						switch(i)
						{
							case DHCP_DISCOVER_MESSAGE:
								DHCPReplyToDiscovery(&BOOTPHeader);
								break;

							case DHCP_REQUEST_MESSAGE:
								DHCPReplyToRequest(&BOOTPHeader, bAccept);
								break;

							// Need to handle these if supporting more than one DHCP lease
							case DHCP_RELEASE_MESSAGE:
							case DHCP_DECLINE_MESSAGE:
								break;
						}
						break;

					case DHCP_PARAM_REQUEST_IP_ADDRESS:
						if(Len == 4u)
						{
							// Get the requested IP address and see if it is the one we have on offer.
							UDPGetArray((BYTE*)&dw, 4);
							Len -= 4;
							bAccept = (dw == DHCPNextLease.Val);
						}
						break;

					case DHCP_END_OPTION:
						UDPDiscard();
						return;
				}

				// Remove any unprocessed bytes that we don't care about
				while(Len--)
				{
					UDPGet(&i);
				}
			}

			UDPDiscard();
			break;
	}
}


/*****************************************************************************
  Function:
	static void DHCPReplyToDiscovery(BOOTP_HEADER *Header)

  Summary:
	Replies to a DHCP Discover message.

  Description:
	This function replies to a DHCP Discover message by sending out a
	DHCP Offer message.

  Precondition:
	None

  Parameters:
	Header - the BootP header this is in response to.

  Returns:
  	None
  ***************************************************************************/
static void DHCPReplyToDiscovery(BOOTP_HEADER *Header)
{
	DisplayString(0,"DHCPReplyToDiscovery");
	BYTE i;

	// Set the correct socket to active and ensure that
	// enough space is available to generate the DHCP response
	if(UDPIsPutReady(MySocket) < 300u)
		return;

	// Begin putting the BOOTP Header and DHCP options
	UDPPut(BOOT_REPLY);			// Message Type: 2 (BOOTP Reply)
	// Reply with the same Hardware Type, Hardware Address Length, Hops, and Transaction ID fields
	UDPPutArray((BYTE*)&(Header->HardwareType), 7);
	UDPPut(0x00);				// Seconds Elapsed: 0 (Not used)
	UDPPut(0x00);				// Seconds Elapsed: 0 (Not used)
	UDPPutArray((BYTE*)&(Header->BootpFlags), sizeof(Header->BootpFlags));
	UDPPut(0x00);				// Your (client) IP Address: 0.0.0.0 (none yet assigned)
	UDPPut(0x00);				// Your (client) IP Address: 0.0.0.0 (none yet assigned)
	UDPPut(0x00);				// Your (client) IP Address: 0.0.0.0 (none yet assigned)
	UDPPut(0x00);				// Your (client) IP Address: 0.0.0.0 (none yet assigned)
	UDPPutArray((BYTE*)&DHCPNextLease, sizeof(IP_ADDR));	// Lease IP address to give out
	UDPPut(0x00);				// Next Server IP Address: 0.0.0.0 (not used)
	UDPPut(0x00);				// Next Server IP Address: 0.0.0.0 (not used)
	UDPPut(0x00);				// Next Server IP Address: 0.0.0.0 (not used)
	UDPPut(0x00);				// Next Server IP Address: 0.0.0.0 (not used)
	UDPPut(0x00);				// Relay Agent IP Address: 0.0.0.0 (not used)
	UDPPut(0x00);				// Relay Agent IP Address: 0.0.0.0 (not used)
	UDPPut(0x00);				// Relay Agent IP Address: 0.0.0.0 (not used)
	UDPPut(0x00);				// Relay Agent IP Address: 0.0.0.0 (not used)
	UDPPutArray((BYTE*)&(Header->ClientMAC), sizeof(MAC_ADDR));	// Client MAC address: Same as given by client
	for(i = 0; i < 64+128+(16-sizeof(MAC_ADDR)); i++)	// Remaining 10 bytes of client hardware address, server host name: Null string (not used)
		UDPPut(0x00);									// Boot filename: Null string (not used)
	UDPPut(0x63);				// Magic Cookie: 0x63538263
	UDPPut(0x82);				// Magic Cookie: 0x63538263
	UDPPut(0x53);				// Magic Cookie: 0x63538263
	UDPPut(0x63);				// Magic Cookie: 0x63538263

	// Options: DHCP Offer
	UDPPut(DHCP_MESSAGE_TYPE);
	UDPPut(1);
	UDPPut(DHCP_OFFER_MESSAGE);

	// Option: Subnet Mask
	UDPPut(DHCP_SUBNET_MASK);
	UDPPut(sizeof(IP_ADDR));
	UDPPutArray((BYTE*)&AppConfig.MyMask, sizeof(IP_ADDR));

	// Option: Lease duration
	UDPPut(DHCP_IP_LEASE_TIME);
	UDPPut(4);
	UDPPut((DHCP_LEASE_DURATION>>24) & 0xFF);
	UDPPut((DHCP_LEASE_DURATION>>16) & 0xFF);
	UDPPut((DHCP_LEASE_DURATION>>8) & 0xFF);
	UDPPut((DHCP_LEASE_DURATION) & 0xFF);

	// Option: Server identifier
	UDPPut(DHCP_SERVER_IDENTIFIER);
	UDPPut(sizeof(IP_ADDR));
	UDPPutArray((BYTE*)&AppConfig.MyIPAddr, sizeof(IP_ADDR));

	// Option: Router/Gateway address
	UDPPut(DHCP_ROUTER);
	UDPPut(sizeof(IP_ADDR));
	UDPPutArray((BYTE*)&AppConfig.MyIPAddr, sizeof(IP_ADDR));

	// No more options, mark ending
	UDPPut(DHCP_END_OPTION);

	// Add zero padding to ensure compatibility with old BOOTP relays that discard small packets (<300 UDP octets)
	while(UDPTxCount < 300u)
		UDPPut(0);

	// Transmit the packet
	UDPFlush();
}


/*****************************************************************************
  Function:
	static void DHCPReplyToRequest(BOOTP_HEADER *Header, BOOL bAccept)

  Summary:
	Replies to a DHCP Request message.

  Description:
	This function replies to a DHCP Request message by sending out a
	DHCP Acknowledge message.

  Precondition:
	None

  Parameters:
	Header - the BootP header this is in response to.
	bAccept - whether or not we've accepted this request

  Returns:
  	None

  Internal:
	Needs to support more than one simultaneous lease in the future.
  ***************************************************************************/
static void DHCPReplyToRequest(BOOTP_HEADER *Header, BOOL bAccept)
{
	DisplayString(0,"DHCPReplyToRequest");
	BYTE i;

	// Set the correct socket to active and ensure that
	// enough space is available to generate the DHCP response
	if(UDPIsPutReady(MySocket) < 300u)
		return;

	// Search through all remaining options and look for the Requested IP address field
	// Obtain options
	while(UDPIsGetReady(MySocket))
	{
		BYTE Option, Len;
		DWORD dw;

		// Get option type
		if(!UDPGet(&Option))
			break;
		if(Option == DHCP_END_OPTION)
			break;

		// Get option length
		UDPGet(&Len);

		// Process option
		if((Option == DHCP_PARAM_REQUEST_IP_ADDRESS) && (Len == 4u))
		{
			// Get the requested IP address and see if it is the one we have on offer.  If not, we should send back a NAK, but since there could be some other DHCP server offering this address, we'll just silently ignore this request.
			UDPGetArray((BYTE*)&dw, 4);
			Len -= 4;
			if(dw != DHCPNextLease.Val)
			{
				bAccept = FALSE;
			}
			break;
		}

		// Remove the unprocessed bytes that we don't care about
		while(Len--)
		{
			UDPGet(&i);
		}
	}

	// Begin putting the BOOTP Header and DHCP options
	UDPPut(BOOT_REPLY);			// Message Type: 2 (BOOTP Reply)
	// Reply with the same Hardware Type, Hardware Address Length, Hops, and Transaction ID fields
	UDPPutArray((BYTE*)&(Header->HardwareType), 7);
	UDPPut(0x00);				// Seconds Elapsed: 0 (Not used)
	UDPPut(0x00);				// Seconds Elapsed: 0 (Not used)
	UDPPutArray((BYTE*)&(Header->BootpFlags), sizeof(Header->BootpFlags));
	UDPPutArray((BYTE*)&(Header->ClientIP), sizeof(IP_ADDR));// Your (client) IP Address:
	UDPPutArray((BYTE*)&DHCPNextLease, sizeof(IP_ADDR));	// Lease IP address to give out
	UDPPut(0x00);				// Next Server IP Address: 0.0.0.0 (not used)
	UDPPut(0x00);				// Next Server IP Address: 0.0.0.0 (not used)
	UDPPut(0x00);				// Next Server IP Address: 0.0.0.0 (not used)
	UDPPut(0x00);				// Next Server IP Address: 0.0.0.0 (not used)
	UDPPut(0x00);				// Relay Agent IP Address: 0.0.0.0 (not used)
	UDPPut(0x00);				// Relay Agent IP Address: 0.0.0.0 (not used)
	UDPPut(0x00);				// Relay Agent IP Address: 0.0.0.0 (not used)
	UDPPut(0x00);				// Relay Agent IP Address: 0.0.0.0 (not used)
	UDPPutArray((BYTE*)&(Header->ClientMAC), sizeof(MAC_ADDR));	// Client MAC address: Same as given by client
	for(i = 0; i < 64+128+(16-sizeof(MAC_ADDR)); i++)	// Remaining 10 bytes of client hardware address, server host name: Null string (not used)
		UDPPut(0x00);									// Boot filename: Null string (not used)
	UDPPut(0x63);				// Magic Cookie: 0x63538263
	UDPPut(0x82);				// Magic Cookie: 0x63538263
	UDPPut(0x53);				// Magic Cookie: 0x63538263
	UDPPut(0x63);				// Magic Cookie: 0x63538263

	// Options: DHCP lease ACKnowledge
	if(bAccept)
	{
		UDPPut(DHCP_OPTION_ACK_MESSAGE);
		UDPPut(1);
		UDPPut(DHCP_ACK_MESSAGE);
	}
	else	// Send a NACK
	{
		UDPPut(DHCP_OPTION_ACK_MESSAGE);
		UDPPut(1);
		UDPPut(DHCP_NAK_MESSAGE);
	}

	// Option: Lease duration
	UDPPut(DHCP_IP_LEASE_TIME);
	UDPPut(4);
	UDPPut((DHCP_LEASE_DURATION>>24) & 0xFF);
	UDPPut((DHCP_LEASE_DURATION>>16) & 0xFF);
	UDPPut((DHCP_LEASE_DURATION>>8) & 0xFF);
	UDPPut((DHCP_LEASE_DURATION) & 0xFF);

	// Option: Server identifier
	UDPPut(DHCP_SERVER_IDENTIFIER);
	UDPPut(sizeof(IP_ADDR));
	UDPPutArray((BYTE*)&AppConfig.MyIPAddr, sizeof(IP_ADDR));

	// Option: Subnet Mask
	UDPPut(DHCP_SUBNET_MASK);
	UDPPut(sizeof(IP_ADDR));
	UDPPutArray((BYTE*)&AppConfig.MyMask, sizeof(IP_ADDR));

	// Option: Router/Gateway address
	UDPPut(DHCP_ROUTER);
	UDPPut(sizeof(IP_ADDR));
	UDPPutArray((BYTE*)&AppConfig.MyIPAddr, sizeof(IP_ADDR));

	// No more options, mark ending
	UDPPut(DHCP_END_OPTION);

	// Add zero padding to ensure compatibility with old BOOTP relays that discard small packets (<300 UDP octets)
	while(UDPTxCount < 300u)
		UDPPut(0);

	// Transmit the packet
	UDPFlush();
}
#endif //#if defined(STACK_USE_DHCP_RELAY)
