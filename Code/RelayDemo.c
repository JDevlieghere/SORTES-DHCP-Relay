#define __RELAYDEMO_C
#define __18F97J60
#define __SDCC__
#include <pic18f97j60.h> //ML

#include "Include/TCPIPConfig.h"
#include "Include/TCPIP_Stack/TCPIP.h"



#if defined(STACK_USE_DHCP_RELAY)

#include "Include/TCPIP_Stack/TCPIP.h"
#include "Include/MainDemo.h"

// Application specific defines

#define DHCP_LEASE_DURATION	60ul
#define TOP	0
#define BOT 16

static 	UDP_SOCKET	ClientSocket;
static 	UDP_SOCKET 	ServerSocket;
static 	IP_ADDR		DHCPNextLease;

BOOL 	bDHCPRelayEnabled = TRUE;

static void RelayToServer(BOOTP_HEADER *Header, int type);
static void RelayToClient(BOOTP_HEADER *Header, int type);
void Log(char *top, char *bottom);

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
			ClientSocket = UDPOpen(DHCP_SERVER_PORT, NULL, DHCP_CLIENT_PORT);
			ServerSocket = UDPOpen(DHCP_CLIENT_PORT, NULL, DHCP_SERVER_PORT);

			if(ClientSocket == INVALID_UDP_SOCKET || ServerSocket == INVALID_UDP_SOCKET){
				DisplayString(TOP, "Socket error");
				break;
			}else{
				DisplayString(TOP, "Socket success");
				smDHCPRelay++;
			}

		case DHCP_LISTEN:
			// Check to see if a valid DHCP packet has arrived
			if(UDPIsGetReady(ClientSocket) < 241u)
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
								Log("DHCP Message","DISCOVER");
								break;
							case DHCP_REQUEST_MESSAGE:
								Log("DHCP Message","REQUEST");
								break;
							case DHCP_OFFER_MESSAGE:
								Log("DHCP Message","OFFER");
								break;
							case DHCP_ACK_MESSAGE:
								Log("DHCP Message","ACK");
								break;
							case DHCP_RELEASE_MESSAGE:
								Log("DHCP Message","RELEASE");
								break;
							case DHCP_DECLINE_MESSAGE:
								Log("DHCP Message","DECLINE");
								break;
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

static void RelayToClient(BOOTP_HEADER *Header, int type){
	BYTE i;
	UDP_SOCKET_INFO *p;

	// Set the correct socket to active and ensure that
	// enough space is available.
	if(UDPIsPutReady(ClientSocket) < 300u)
		return;

	// Get socket info
	p = &UDPSocketInfo[activeUDPSocket];

	// Set as broadcast packet to DHCP Client Port
	// p->remoteNode.IPAddr.Val = AppConfig.Br.Val;
	p->remotePort = DHCP_CLIENT_PORT;

	// Copy the MAC address of the client (from CHADDR field)
	for(i=0;i<6u;i++){
		p->remoteNode.MACAddr.v[i] = Header->ClientMAC.v[i];
	}

	// Copy header
	UDPPutArray((BYTE*)&(Header->MessageType), sizeof(Header->MessageType));
	UDPPutArray((BYTE*)&(Header->HardwareType), sizeof(Header->HardwareType));
	UDPPutArray((BYTE*)&(Header->HardwareLen), sizeof(Header->HardwareLen));
	UDPPutArray((BYTE*)&(Header->Hops), sizeof(Header->Hops));
	UDPPutArray((BYTE*)&(Header->TransactionID), sizeof(Header->TransactionID));
	UDPPutArray((BYTE*)&(Header->SecondsElapsed), sizeof(Header->SecondsElapsed));
	UDPPutArray((BYTE*)&(Header->BootpFlags), sizeof(Header->BootpFlags));
	UDPPutArray((BYTE*)&(Header->ClientIP), sizeof(Header->ClientIP));
	UDPPutArray((BYTE*)&(Header->YourIP), sizeof(Header->YourIP));
	UDPPutArray((BYTE*)&(Header->NextServerIP), sizeof(Header->NextServerIP));
	UDPPutArray((BYTE*)&(AppConfig.PrimaryDNSServer), sizeof(AppConfig.PrimaryDNSServer));
	UDPPutArray((BYTE*)&(Header->ClientMAC), sizeof(Header->ClientMAC));

	// Everything is else is zero
	for ( i = 0; i < 202u; i++ ) UDPPut(0);

	// Magic Cookie
	UDPPut(99);
	UDPPut(130);
	UDPPut(83);
	UDPPut(99);

	// Set message type
	UDPPut(DHCP_MESSAGE_TYPE);
	UDPPut(DHCP_MESSAGE_TYPE_LEN);
	UDPPut(type);

	// Set Server Identifier
	UDPPut(DHCP_SERVER_IDENTIFIER);
	UDPPut(sizeof(IP_ADDR)); UDPPutArray((BYTE*)&AppConfig.MyIPAddr, sizeof(IP_ADDR));

	// Set Router
	UDPPut(DHCP_ROUTER);
	UDPPut(sizeof(IP_ADDR)); UDPPutArray((BYTE*)&AppConfig.MyIPAddr, sizeof(IP_ADDR));

	// Pad with zeros
	while(UDPTxCount < 300u)
		UDPPut(0);

	UDPFlush();
}

static void RelayToServer(BOOTP_HEADER *Header, int type){
	// TODO: Implement
}


void Log(char *top, char *bottom){
	LCDErase();
	DisplayString(TOP, top);
	DisplayString(BOT, bottom);
}


// static void DHCPReplyToDiscovery(BOOTP_HEADER *Header)
// {
// 	BYTE i;
// 	DisplayString(TOP,"DHCPReplyToDiscovery");

// 	// Set the correct socket to active and ensure that
// 	// enough space is available to generate the DHCP response
// 	if(UDPIsPutReady(ClientSocket) < 300u)
// 		return;

// 	// Begin putting the BOOTP Header and DHCP options
// 	UDPPut(BOOT_REPLY);			// Message Type: 2 (BOOTP Reply)
// 	// Reply with the same Hardware Type, Hardware Address Length, Hops, and Transaction ID fields
// 	UDPPutArray((BYTE*)&(Header->HardwareType), 7);
// 	UDPPut(0x00);				// Seconds Elapsed: 0 (Not used)
// 	UDPPut(0x00);				// Seconds Elapsed: 0 (Not used)
// 	UDPPutArray((BYTE*)&(Header->BootpFlags), sizeof(Header->BootpFlags));
// 	UDPPut(0x00);				// Your (client) IP Address: 0.0.0.0 (none yet assigned)
// 	UDPPut(0x00);				// Your (client) IP Address: 0.0.0.0 (none yet assigned)
// 	UDPPut(0x00);				// Your (client) IP Address: 0.0.0.0 (none yet assigned)
// 	UDPPut(0x00);				// Your (client) IP Address: 0.0.0.0 (none yet assigned)
// 	UDPPutArray((BYTE*)&DHCPNextLease, sizeof(IP_ADDR));	// Lease IP address to give out
// 	UDPPut(0x00);				// Next Server IP Address: 0.0.0.0 (not used)
// 	UDPPut(0x00);				// Next Server IP Address: 0.0.0.0 (not used)
// 	UDPPut(0x00);				// Next Server IP Address: 0.0.0.0 (not used)
// 	UDPPut(0x00);				// Next Server IP Address: 0.0.0.0 (not used)
// 	UDPPut(0x00);				// Relay Agent IP Address: 0.0.0.0 (not used)
// 	UDPPut(0x00);				// Relay Agent IP Address: 0.0.0.0 (not used)
// 	UDPPut(0x00);				// Relay Agent IP Address: 0.0.0.0 (not used)
// 	UDPPut(0x00);				// Relay Agent IP Address: 0.0.0.0 (not used)
// 	UDPPutArray((BYTE*)&(Header->ClientMAC), sizeof(MAC_ADDR));	// Client MAC address: Same as given by client
// 	for(i = 0; i < 64+128+(16-sizeof(MAC_ADDR)); i++)	// Remaining 10 bytes of client hardware address, server host name: Null string (not used)
// 		UDPPut(0x00);									// Boot filename: Null string (not used)
// 	UDPPut(0x63);				// Magic Cookie: 0x63538263
// 	UDPPut(0x82);				// Magic Cookie: 0x63538263
// 	UDPPut(0x53);				// Magic Cookie: 0x63538263
// 	UDPPut(0x63);				// Magic Cookie: 0x63538263

// 	// Options: DHCP Offer
// 	UDPPut(DHCP_MESSAGE_TYPE);
// 	UDPPut(1);
// 	UDPPut(DHCP_OFFER_MESSAGE);

// 	// Option: Subnet Mask
// 	UDPPut(DHCP_SUBNET_MASK);
// 	UDPPut(sizeof(IP_ADDR));
// 	UDPPutArray((BYTE*)&AppConfig.MyMask, sizeof(IP_ADDR));

// 	// Option: Lease duration
// 	UDPPut(DHCP_IP_LEASE_TIME);
// 	UDPPut(4);
// 	UDPPut((DHCP_LEASE_DURATION>>24) & 0xFF);
// 	UDPPut((DHCP_LEASE_DURATION>>16) & 0xFF);
// 	UDPPut((DHCP_LEASE_DURATION>>8) & 0xFF);
// 	UDPPut((DHCP_LEASE_DURATION) & 0xFF);

// 	// Option: Server identifier
// 	UDPPut(DHCP_SERVER_IDENTIFIER);
// 	UDPPut(sizeof(IP_ADDR));
// 	UDPPutArray((BYTE*)&AppConfig.MyIPAddr, sizeof(IP_ADDR));

// 	// Option: Router/Gateway address
// 	UDPPut(DHCP_ROUTER);
// 	UDPPut(sizeof(IP_ADDR));
// 	UDPPutArray((BYTE*)&AppConfig.MyIPAddr, sizeof(IP_ADDR));

// 	// No more options, mark ending
// 	UDPPut(DHCP_END_OPTION);

// 	// Add zero padding to ensure compatibility with old BOOTP relays that discard small packets (<300 UDP octets)
// 	while(UDPTxCount < 300u)
// 		UDPPut(0);

// 	// Transmit the packet
// 	UDPFlush();
// }

// static void DHCPReplyToRequest(BOOTP_HEADER *Header, BOOL bAccept)
// {
// 	BYTE i;
// 	DisplayString(TOP,"DHCPReplyToRequest");

// 	// Set the correct socket to active and ensure that
// 	// enough space is available to generate the DHCP response
// 	if(UDPIsPutReady(ClientSocket) < 300u)
// 		return;

// 	// Search through all remaining options and look for the Requested IP address field
// 	// Obtain options
// 	while(UDPIsGetReady(ClientSocket))
// 	{
// 		BYTE Option, Len;
// 		DWORD dw;

// 		// Get option type
// 		if(!UDPGet(&Option))
// 			break;
// 		if(Option == DHCP_END_OPTION)
// 			break;

// 		// Get option length
// 		UDPGet(&Len);

// 		// Process option
// 		if((Option == DHCP_PARAM_REQUEST_IP_ADDRESS) && (Len == 4u))
// 		{
// 			// Get the requested IP address and see if it is the one we have on offer.  If not, we should send back a NAK, but since there could be some other DHCP server offering this address, we'll just silently ignore this request.
// 			UDPGetArray((BYTE*)&dw, 4);
// 			Len -= 4;
// 			if(dw != DHCPNextLease.Val)
// 			{
// 				bAccept = FALSE;
// 			}
// 			break;
// 		}

// 		// Remove the unprocessed bytes that we don't care about
// 		while(Len--)
// 		{
// 			UDPGet(&i);
// 		}
// 	}

// 	// Begin putting the BOOTP Header and DHCP options
// 	UDPPut(BOOT_REPLY);			// Message Type: 2 (BOOTP Reply)
// 	// Reply with the same Hardware Type, Hardware Address Length, Hops, and Transaction ID fields
// 	UDPPutArray((BYTE*)&(Header->HardwareType), 7);
// 	UDPPut(0x00);				// Seconds Elapsed: 0 (Not used)
// 	UDPPut(0x00);				// Seconds Elapsed: 0 (Not used)
// 	UDPPutArray((BYTE*)&(Header->BootpFlags), sizeof(Header->BootpFlags));
// 	UDPPutArray((BYTE*)&(Header->ClientIP), sizeof(IP_ADDR));// Your (client) IP Address:
// 	UDPPutArray((BYTE*)&DHCPNextLease, sizeof(IP_ADDR));	// Lease IP address to give out
// 	UDPPut(0x00);				// Next Server IP Address: 0.0.0.0 (not used)
// 	UDPPut(0x00);				// Next Server IP Address: 0.0.0.0 (not used)
// 	UDPPut(0x00);				// Next Server IP Address: 0.0.0.0 (not used)
// 	UDPPut(0x00);				// Next Server IP Address: 0.0.0.0 (not used)
// 	UDPPut(0x00);				// Relay Agent IP Address: 0.0.0.0 (not used)
// 	UDPPut(0x00);				// Relay Agent IP Address: 0.0.0.0 (not used)
// 	UDPPut(0x00);				// Relay Agent IP Address: 0.0.0.0 (not used)
// 	UDPPut(0x00);				// Relay Agent IP Address: 0.0.0.0 (not used)
// 	UDPPutArray((BYTE*)&(Header->ClientMAC), sizeof(MAC_ADDR));	// Client MAC address: Same as given by client
// 	for(i = 0; i < 64+128+(16-sizeof(MAC_ADDR)); i++)	// Remaining 10 bytes of client hardware address, server host name: Null string (not used)
// 		UDPPut(0x00);									// Boot filename: Null string (not used)
// 	UDPPut(0x63);				// Magic Cookie: 0x63538263
// 	UDPPut(0x82);				// Magic Cookie: 0x63538263
// 	UDPPut(0x53);				// Magic Cookie: 0x63538263
// 	UDPPut(0x63);				// Magic Cookie: 0x63538263

// 	// Options: DHCP lease ACKnowledge
// 	if(bAccept)
// 	{
// 		UDPPut(DHCP_OPTION_ACK_MESSAGE);
// 		UDPPut(1);
// 		UDPPut(DHCP_ACK_MESSAGE);
// 	}
// 	else	// Send a NACK
// 	{
// 		UDPPut(DHCP_OPTION_ACK_MESSAGE);
// 		UDPPut(1);
// 		UDPPut(DHCP_NAK_MESSAGE);
// 	}

// 	// Option: Lease duration
// 	UDPPut(DHCP_IP_LEASE_TIME);
// 	UDPPut(4);
// 	UDPPut((DHCP_LEASE_DURATION>>24) & 0xFF);
// 	UDPPut((DHCP_LEASE_DURATION>>16) & 0xFF);
// 	UDPPut((DHCP_LEASE_DURATION>>8) & 0xFF);
// 	UDPPut((DHCP_LEASE_DURATION) & 0xFF);

// 	// Option: Server identifier
// 	UDPPut(DHCP_SERVER_IDENTIFIER);
// 	UDPPut(sizeof(IP_ADDR));
// 	UDPPutArray((BYTE*)&AppConfig.MyIPAddr, sizeof(IP_ADDR));

// 	// Option: Subnet Mask
// 	UDPPut(DHCP_SUBNET_MASK);
// 	UDPPut(sizeof(IP_ADDR));
// 	UDPPutArray((BYTE*)&AppConfig.MyMask, sizeof(IP_ADDR));

// 	// Option: Router/Gateway address
// 	UDPPut(DHCP_ROUTER);
// 	UDPPut(sizeof(IP_ADDR));
// 	UDPPutArray((BYTE*)&AppConfig.MyIPAddr, sizeof(IP_ADDR));

// 	// No more options, mark ending
// 	UDPPut(DHCP_END_OPTION);

// 	// Add zero padding to ensure compatibility with old BOOTP relays that discard small packets (<300 UDP octets)
// 	while(UDPTxCount < 300u)
// 		UDPPut(0);

// 	// Transmit the packet
// 	UDPFlush();
// }

#endif	//#if defined(STACK_USE_DHCP_RELAY)
