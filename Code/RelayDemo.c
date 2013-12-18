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


// HDCP Server at 	192.168.97.3
// 					c0.a8.61.03
#define DHCP_SERVER_IP	0x0202A8C0
#define BROADCAST 		0xFFFFFFFF

static 	UDP_SOCKET	ClientSocket;
static 	UDP_SOCKET 	ServerSocket;
static 	NODE_INFO 	DHCPServer;

IP_ADDR ReqIP;
int reqIPnonNull = 0;

BOOL 	bDHCPRelayEnabled = TRUE;

static int Arp();
static void RelayToServer(BOOTP_HEADER *Header, int type);
static void RelayToClient(BOOTP_HEADER *Header, int type);
void Log(char *top, char *bottom);
void LogMac(int pos, BOOTP_HEADER *Header);

void DHCPRelayTask(void)
{
	BYTE 				i;
	BYTE				Option, Len;
	BOOTP_HEADER		BOOTPHeader;
	DWORD        dw;
	int ClientReady, ServerReady;

	static enum
	{
		DHCP_OPEN_SOCKET,
		DHCP_LISTEN
	} smDHCPRelay = DHCP_OPEN_SOCKET;

	DHCPServer.IPAddr.Val = DHCP_SERVER_IP;

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
				Log("Socket error","Unable to open");
				break;
			}else{
				Log("Socket success","");
				smDHCPRelay++;
			}
		case DHCP_LISTEN:
			// Check to see if a valid DHCP packet has arrived

			ClientReady = UDPIsGetReady(ClientSocket);
			ServerReady = UDPIsGetReady(ServerSocket);

			if(ClientReady < 241u && ServerReady < 241u)
				break;

			// Retrieve the BOOTP header
			UDPGetArray((BYTE*)&BOOTPHeader, sizeof(BOOTPHeader));

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
								Log("DISCOVER","");
								RelayToServer(&BOOTPHeader, i);
								break;
							case DHCP_OFFER_MESSAGE:
								Log("OFFER","");
								RelayToClient(&BOOTPHeader, i);
								break;
							case DHCP_REQUEST_MESSAGE:
								Log("REQUEST","");
								RelayToServer(&BOOTPHeader, i);
								break;
							case DHCP_ACK_MESSAGE:
								Log("ACK","");
								RelayToClient(&BOOTPHeader, i);
								break;
							case DHCP_RELEASE_MESSAGE:
								Log("RELEASE","");
								break;
							case DHCP_DECLINE_MESSAGE:
								Log("DECLINE","");
								break;
							default:
								Log("Default","");
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

static int Arp(){
	ARPResolve(&DHCPServer.IPAddr);
	return ARPIsResolved(&DHCPServer.IPAddr,&DHCPServer.MACAddr);
}

/**
 * Relay the DHCP Packet to the Client
 *
 * @param Header The UDP Header
 * @param type   The DHCP Type
 */
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
	p->remoteNode.IPAddr.Val = BROADCAST;
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
	UDPPutArray((BYTE*)&(AppConfig.MyIPAddr), sizeof(AppConfig.MyIPAddr));
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

	DisplayString(BOT, "R2C:");
	LogMac(BOT + 5, Header);
}

/**
 * Relay the DHCP Packet to the DHCP Server
 *
 * @param Header The UDP Header
 * @param type   The DHCP Type
 */
static void RelayToServer(BOOTP_HEADER *Header, int type){
	BYTE a;
	UDP_SOCKET_INFO *p;

	if(!Arp()){
		DisplayString(BOT, "ARP failed");
		return;
	}

	// Set the correct socket to active and ensure that
	// enough space is available.
	if(UDPIsPutReady(ServerSocket) < 300u)
		return;

	while(UDPIsGetReady(ServerSocket)){
		BYTE Option, Len;

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
			// Get the requested IP address.
			UDPGetArray((BYTE*)&ReqIP, 4);
			reqIPnonNull = 1;
			break;
		}

		// Remove the unprocessed bytes that we don't care about
		while(Len--)
		{
			UDPGet(&a);
		}
	}

	p = &UDPSocketInfo[activeUDPSocket];
	p->remoteNode.IPAddr.Val = DHCPServer.IPAddr.Val;

	UDPIsPutReady(ServerSocket);

	//Copy of the header to forward it!
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
	UDPPutArray((BYTE*)&(AppConfig.MyIPAddr), sizeof(AppConfig.MyIPAddr));
	UDPPutArray((BYTE*)&(Header->ClientMAC), sizeof(Header->ClientMAC));

	// Set chaddr[6..15], sname and file as zeros.
	for (a = 0; a < 202u; a++ ) UDPPut(0);

	// Magic Cookie
	UDPPut(0x63);				// Magic Cookie: 0x63538263
	UDPPut(0x82);				// Magic Cookie: 0x63538263
	UDPPut(0x53);				// Magic Cookie: 0x63538263
	UDPPut(0x63);				// Magic Cookie: 0x63538263


	// Set message type
	UDPPut(DHCP_MESSAGE_TYPE);
	UDPPut(DHCP_MESSAGE_TYPE_LEN);
	UDPPut(type);

	// Set Server Identifier
	UDPPut(DHCP_SERVER_IDENTIFIER);
	UDPPut(sizeof(IP_ADDR));
	UDPPutArray((BYTE*)&AppConfig.MyIPAddr, sizeof(IP_ADDR));

	// Set Router
	UDPPut(DHCP_ROUTER);
	UDPPut(sizeof(IP_ADDR));
	UDPPutArray((BYTE*)&AppConfig.MyIPAddr, sizeof(IP_ADDR));


	if (reqIPnonNull == 1){
		UDPPut(DHCP_PARAM_REQUEST_IP_ADDRESS);
		UDPPut(DHCP_PARAM_REQUEST_IP_ADDRESS_LEN);
		UDPPutArray((BYTE*)&ReqIP, sizeof(IP_ADDR));
		reqIPnonNull = 0;
	}

	UDPPut(DHCP_END_OPTION);

	while(UDPTxCount < 300u)
		UDPPut(0);

	UDPIsPutReady(ServerSocket);

	for(a = 0; a < 6; a++){
		p->remoteNode.MACAddr.v[a] = DHCPServer.MACAddr.v[a];
	}
	UDPFlush();

	DisplayString(BOT, "R2S:");
	LogMac(BOT + 5, Header);
}

/**
 * Log strings to the LCD
 * @param top    String on the top line
 * @param bottom String on the bottom line
 */
void Log(char *top, char *bottom){
	LCDErase();
	DisplayString(TOP, top);
	DisplayString(BOT, bottom);
}

/**
 * Display MAC-address on the LCD
 * @param pos    Start position
 * @param Header Header containing the MAC-address
 */
void LogMac(int pos, BOOTP_HEADER *Header){
	DisplayWORD(pos, Header->ClientMAC.v[4]);
	DisplayWORD(pos+4, Header->ClientMAC.v[5]);
}


#endif	//#if defined(STACK_USE_DHCP_RELAY)
