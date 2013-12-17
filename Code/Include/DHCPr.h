#ifndef __DHCPR_H
#define __DHCPR_H

#if defined(STACK_USE_DHCP_RELAY)

// UDP client port for DHCP Client transactions
#define DHCP_CLIENT_PORT                (68u)
// UDP listening port for DHCP Server messages
#define DHCP_SERVER_PORT                (67u)

// Duration of our DHCP Lease in seconds.  This is extrememly short so
// the client won't use our IP for long if we inadvertantly
// provide a lease on a network that has a more authoratative DHCP server.
#define DHCP_LEASE_DURATION				60ul
/// Ignore: #define DHCP_MAX_LEASES					2		// Not implemented

// DHCP Control Block.  Lease IP address is derived from index into DCB array.
typedef struct _DHCP_CONTROL_BLOCK
{
	TICK 		LeaseExpires;	// Expiration time for this lease
	MAC_ADDR	ClientMAC;		// Client's MAC address.  Multicase bit is used to determine if a lease is given out or not
	enum
	{
		LEASE_UNUSED = 0,
		LEASE_REQUESTED,
		LEASE_GRANTED
	} smLease;					// Status of this lease
} DHCP_CONTROL_BLOCK;

static UDP_SOCKET			MySocket;		// Socket used by DHCP Server
static IP_ADDR				DHCPNextLease;	// IP Address to provide for next lease
/// Ignore: static DHCP_CONTROL_BLOCK	DCB[DHCP_MAX_LEASES];	// Not Implmented
BOOL 						bDHCPRelayEnabled = TRUE;	// Whether or not the DHCP server is enabled

void DHCPRelayTask(void);
static void DHCPReplyToDiscovery(BOOTP_HEADER *Header);
static void DHCPReplyToRequest(BOOTP_HEADER *Header, BOOL bAccept);
#endif
#endif
