# Router Configuration

## Setup

Our testing setup contains the following devices:

 * The PIC
 * The Router
 * The DHCP Server
 * The Client

The PIC runs the relay software. The internal DHCP server of the router should be disabled in favor of the external server. The real DHCP server is connected to the WAN port of the router. The relay and the client(s) are connected to the LAN ports.

## Default Configuration

The router has one WAN port and four LAN ports. The WAN port acts as a DHCP client to obtain an IP address. The devices connected to the LAN ports obtain an address from the internal DHCP server. NAT is activated between the WAN and LAN ports.

## Testing Configuration

Testing the DHCP relay requires some changes.

 * Change the WAN IP address to a fixed value
 * Change the LAN port address of addresses.
 * Deactive NAT
 * Deactivate the DHCP server on the router.

Before deactivating NAT, the computer on the LAN side should be able to ping the computer connected to the WAN port. But not the other way around.

After deactivating, both computers should be able to ping each other. Once the internal DHCP server is disabled the computers connected to the LAN ports should be able to obtain an IP through the relay.
