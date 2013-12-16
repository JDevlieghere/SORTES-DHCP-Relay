# Assignment

The purpose of the project is to design and implement a DHCP Relay on a 
PIC board.

Tasks 

 - Understand DHCP Relay and what it does.
 - Represent its behavior is ASG.
 - Program and test the DHCP Relay on the PIC.

# Documentation

## DHCP Relay

### Wikipedia

[DHCP Relaying](http://en.wikipedia.org/wiki/Dynamic_Host_Configuration_Protocol#DHCP_relaying)

In small networks, where only one IP subnet is being managed, DHCP clients communicate directly with DHCP servers. However, DHCP servers can also provide IP addresses for multiple subnets. In this case, a DHCP client that has not yet acquired an IP address cannot communicate directly with the DHCP server using IP routing, because it doesn't have a routable IP address, nor does it know the IP address of a router. 

In order to allow DHCP clients on subnets not directly served by DHCP servers to communicate with DHCP servers, DHCP relay agents can be installed on these subnets. The DHCP client broadcasts on the local link; the relay agent receives the broadcast and transmits it to one or more DHCP servers using unicast. The relay agent stores its own IP address in the GIADDR field of the DHCP packet. The DHCP server uses the GIADDR to determine the subnet on which the relay agent received the broadcast, and allocates an IP address on that subnet. When the DHCP server replies to the client, it sends the reply to the GIADDR address, again using unicast. The relay agent then retransmits the response on the local network. 

### IETF

[Dynamic Host Configuration Protocol (RFC2131)](http://tools.ietf.org/html/rfc2131)

## Compiler, PIC & TCP/IP

 - [Undestanding PIC WEB Boards](https://www.olimex.com/Products/PIC/_resources/Understanding-PIC-WEB-boards.pdf)
 - [Microship PIC18F97J60](http://www.microchip.com/wwwproducts/Devices.aspx?dDocName=en026439)
 - [SDCC](http://sdcc.sourceforge.net/doc/sdccman.pdf)