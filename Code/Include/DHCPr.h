#ifndef __DHCP_RELAY_H
#define __DHCP_RELAY_H

#if defined(STACK_USE_DHCP_RELAY)

// UDP client port for DHCP Client transactions
#define DHCP_CLIENT_PORT                (68u)
// UDP listening port for DHCP Server messages
#define DHCP_SERVER_PORT                (67u)

void DHCPRelayTask(void);

#endif
#endif