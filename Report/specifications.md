
# DHCP Relay 

   >  A BOOTP relay agent or relay agent is an Internet host or router
   >  that passes DHCP messages between DHCP clients and DHCP servers.
   >  DHCP is designed to use the same relay agent behavior as specified
   >  in the BOOTP protocol specification.

## DHCP Technical Details

### General
DHCP usese UDP as transport protocol. 
Sever port 67
Client port 68

#### DHCP Message Format

0                   1                   2                   3
0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
|     op (1)    |   htype (1)   |   hlen (1)    |   hops (1)    |
+---------------+---------------+---------------+---------------+
|                            xid (4)                            |
+-------------------------------+-------------------------------+
|           secs (2)            |           flags (2)           |
+-------------------------------+-------------------------------+
|                          ciaddr  (4)                          |
+---------------------------------------------------------------+
|                          yiaddr  (4)                          |
+---------------------------------------------------------------+
|                          siaddr  (4)                          |
+---------------------------------------------------------------+
|                          giaddr  (4)                          |
+---------------------------------------------------------------+
|                                                               |
|                          chaddr  (16)                         |
|                                                               |
|                                                               |
+---------------------------------------------------------------+
|                                                               |
|                          sname   (64)                         |
+---------------------------------------------------------------+
|                                                               |
|                          file    (128)                        |
+---------------------------------------------------------------+
|                                                               |
|                          options (variable)                   |
+---------------------------------------------------------------+

 FIELD      OCTETS       DESCRIPTION
   -----      ------       -----------

   op            1  Message op code / message type.
                    1 = BOOTREQUEST, 2 = BOOTREPLY
   htype         1  Hardware address type, see ARP section in "Assigned
                    Numbers" RFC; e.g., '1' = 10mb ethernet.
   hlen          1  Hardware address length (e.g.  '6' for 10mb
                    ethernet).
   hops          1  Client sets to zero, optionally used by relay agents
                    when booting via a relay agent.
   xid           4  Transaction ID, a random number chosen by the
                    client, used by the client and server to associate
                    messages and responses between a client and a
                    server.
   secs          2  Filled in by client, seconds elapsed since client
                    began address acquisition or renewal process.
   flags         2  Flags (see figure 2).
   ciaddr        4  Client IP address; only filled in if client is in
                    BOUND, RENEW or REBINDING state and can respond
                    to ARP requests.
   yiaddr        4  'your' (client) IP address.
   siaddr        4  IP address of next server to use in bootstrap;
                    returned in DHCPOFFER, DHCPACK by server.
   giaddr        4  Relay agent IP address, used in booting via a
                    relay agent.
   chaddr       16  Client hardware address.
   sname        64  Optional server host name, null terminated string.
   file        128  Boot file name, null terminated string; "generic"
                    name or null in DHCPDISCOVER, fully qualified
                    directory-path name in DHCPOFFER.
   options     var  Optional parameters field.  See the options
                    documents for a list of defined options.

Flag Field specification: 

		    1 1 1 1 1 1
0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
|B|             MBZ             |
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+

B:  BROADCAST flag

MBZ:  MUST BE ZERO (reserved for future use). Should be ignored by Relay Agent.

#### Messaging Rules.
Normally BOOTP relay agents attempt to deliver DHCPOFFER, DHCPACK and DHCPNAK messages directly to the client using unicast delivery.
For each message send directly to a DHCP client the **BROADCAST** bit (in the 'flags' field) should be examined.

* bit = 1:
 * DHCP message SHOULD be send as IP broadcast message.
 * IP destination address = 0xffffffff
 * Link-layer destination address (Ethernet) = FF:FF:FF:FF:FF:FF
* bit = 0:
 * DHCP message SHOULD be send as IP unicast message.
 * IP destination address = 'yiaddr' field of inc message.
 * Link-layer destination address = 'chaddr' field of inc message. 
 * !!!! IF UNICAST IS NOT POSSIBLE !!!!
  * act as if BROADCAST bit is 1.

### Discovery

The client broadcasts an UDP Packet with destination `255.255.255.255`.

	UDP Src=0.0.0.0 sPort=68
	Dest=255.255.255.255 dPort=67

The DHCP Relay is listening to port 68 and 67 for respectively client requests 
and server replies.

Although the relay knows the DHCP servers IP address. (and ARP request is 
needed to obtain its MAC address?) The relay replaces the `GIADDR` with its own 
IP  address. It then forwards the request, using UDP unicast to the DHCP server.

	UDP Src=GIADDR sPort=68
	Dest=192.168.1.1 dPort=67	

### Offer

The handles the DHCP request using its `GIADDR` to determine the subnet of the
new client. After allocating an IP address it replies with an DHCP Offer to the
relay, using this gateway IP address.

	UDP Src=192.168.1.1 sPort=67
	Dest=GIADDR dPort=68

### Request

The client responds to the DHCP offer with a DHCP request. This message is 
again broadcasted and intercepted by the relay. 

#### DHCPREQUEST generated during RENEWING state: 
No DHCP relay will be involved since the message will be unicast.



##DHCP RELAY SERVER TASK

 1. Open UDP Sockets. *(include TCPIP.c and TCPIPConfig.c , example how to do that DHCPs.c)*
 2. Listen on port 67/68 for udp frame to relay TO the DHCP server. (two threads)

     1. Extract data from the frame.
        2. Send new frame. (whith other socket?) 
	   
	           1. Use other subnet than the one from which it was recieved.
		           2. and follow messaging rules specified above.  
 3. Do 2.  
