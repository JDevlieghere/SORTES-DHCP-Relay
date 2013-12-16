# MPLAB IDE generated this makefile for use with GNU make.
# Project: TCPIP Demo App-C18.mcp
# Date: Tue Dec 08 14:08:20 2009
#heavily modified by ML for use with sdcc

AS = gpasm
CC = sdcc
CFLAGS= -c -mpic16 -p18f97j60  -o$@ 
LD = sdcc
LDFLAGS= -mpic16 -p18f97j60 -L/usr/local/lib/pic16 -llibio18f97j60.lib -llibdev18f97j60.lib -llibc18f.a
AR = ar
RM = rm

OBJECTS=Objects/MainDemo.o  Objects/Announce.o Objects/ARP.o Objects/Delay.o \
   Objects/DHCP.o Objects/DHCPs.o Objects/DNS.o  Objects/ETH97J60.o  \
   Objects/Hashes.o Objects/Helpers.o Objects/ICMP.o Objects/IP.o \
   Objects/LCDBlocking.o Objects/StackTsk.o Objects/UDPPerformanceTest.o \
   Objects/Tick.o Objects/UDP.o

SDCC_HEADERS=/usr/local/share/sdcc/include/string.h \
   /usr/local/share/sdcc/include/stdlib.h \
   /usr/local/share/sdcc/include/stdio.h \
   /usr/local/share/sdcc/include/stddef.h \
   /usr/local/share/sdcc/include/stdarg.h 

SDCC_PIC16_HEADERS=/usr/local/share/sdcc/include/pic16/pic18f97j60.h

TCPIP_HEADERS=Include/TCPIP_Stack/Helpers.h \
   Include/delays.h \
   Include/TCPIP_Stack/Tick.h \
   Include/TCPIP_Stack/MAC.h \
   Include/TCPIP_Stack/IP.h \
   Include/TCPIP_Stack/ARP.h \
   Include/TCPIP_Stack/Hashes.h \
   Include/TCPIP_Stack/XEEPROM.h \
   Include/TCPIP_Stack/UDP.h \
   Include/TCPIP_Stack/TCP.h \
   Include/TCPIP_Stack/BerkeleyAPI.h \
   Include/TCPIP_Stack/UART.h \
   Include/TCPIP_Stack/DHCP.h \
   Include/TCPIP_Stack/DNS.h \
   Include/TCPIP_Stack/DynDNS.h \
   Include/TCPIP_Stack/MPFS.h \
   Include/TCPIP_Stack/MPFS2.h \
   Include/TCPIP_Stack/HTTP2.h \
   Include/TCPIP_Stack/ICMP.h \
   Include/TCPIP_Stack/SNMP.h \
   Include/TCPIP_Stack/DynDNS.h \
   Include/TCPIP_Stack/SMTP.h \
   Include/TCPIP_Stack/TCPIP.h \
   Include/TCPIP_Stack/StackTsk.h \
   Include/TCPIP_Stack/Delay.h \
   Include/TCPIP_Stack/ETH97J60.h \
   Include/TCPIP_Stack/SPIFlash.h \
   Include/TCPIP_Stack/SPIRAM.h \
   Include/TCPIP_Stack/LCDBlocking.h \
   Include/TCPIP_Stack/UART2TCPBridge.h \
   Include/TCPIP_Stack/Announce.h \
   Include/TCPIP_Stack/NBNS.h \
   Include/TCPIP_Stack/Telnet.h \
   Include/TCPIP_Stack/Reboot.h \
   Include/TCPIP_Stack/SNTP.h \
   Include/TCPIP_Stack/TCPPerformanceTest.h \
   Include/TCPIP_Stack/UDPPerformanceTest.h \
   Include/TCPIP_Stack/Helpers.h \
   Include/TCPIP_Stack/BigInt.h \
   Include/TCPIP_Stack/SSL.h \
   Include/TCPIP_Stack/RSA.h \
   Include/TCPIP_Stack/ARCFOUR.h \
   Include/TCPIP_Stack/AutoIP.h \
   Include/TCPIP_Stack/Random.h \
   Include/TCPIP_Stack/FTP.h \
   Include/TCPIP_Stack/HTTP.h \
   Include/TCPIP_Stack/HTTP2.h \
   Include/TCPIP_Stack/SMTP.h \
   Include/TCPIP_Stack/TFTPc.h \

APP_HEADERS=Include/GenericTypeDefs.h \
   Include/Compiler.h \
   Include/HardwareProfile.h \
   Include/TCPIPConfig.h \
   Include/mib.h \
   Include/MainDemo.h

TCPIP_Demo : $(OBJECTS) 
	$(LD) $(LDFLAGS) $(OBJECTS)

Objects/MainDemo.o : MainDemo.c $(SDCC_HEADERS) $(SDCC_PIC16_HEADERS) \
   $(APP_HEADERS) $(TCPIP_HEADERS)
	$(CC) $(CFLAGS) MainDemo.c

Objects/CustomHTTPApp.o : TCPIP_Stack/CustomHTTPApp.c $(SDCC_HEADERS) \
   $(SDCC_PIC16_HEADERS) $(APP_HEADERS) $(TCPIP_HEADERS)
	$(CC) -c -mpic16 -p18f97j60  -o"Objects/CustomHTTPApp.o" \
   -L/usr/local/lib/pic16 TCPIP_Stack/CustomHTTPApp.c

Objects/TFTPc.o : TCPIP_Stack/TFTPc.c  $(SDCC_HEADERS)  \
   $(SDCC_PIC16_HEADERS) $(APP_HEADERS) $(TCPIP_HEADERS)
	$(CC) -c -mpic16 -p18f97j60  -o"Objects/TFTPc.o" \
   -L/usr/local/lib/pic16  TCPIP_Stack/TFTPc.c

Objects/Announce.o : TCPIP_Stack/Announce.c $(SDCC_HEADERS)  \
   $(SDCC_PIC16_HEADERS) $(APP_HEADERS) $(TCPIP_HEADERS)
	$(CC) -c -mpic16 -p18f97j60  -o"Objects/Announce.o" \
   -L/usr/local/lib/pic16  TCPIP_Stack/Announce.c

Objects/ARP.o : TCPIP_Stack/ARP.c $(SDCC_HEADERS)  \
   $(SDCC_PIC16_HEADERS) $(APP_HEADERS) $(TCPIP_HEADERS)
	$(CC) -c -mpic16 -p18f97j60  -o"Objects/ARP.o" \
   -L/usr/local/lib/pic16  TCPIP_Stack/ARP.c

Objects/Delay.o : TCPIP_Stack/Delay.c $(SDCC_HEADERS)  \
   $(SDCC_PIC16_HEADERS) $(APP_HEADERS) $(TCPIP_HEADERS)
	$(CC) -c -mpic16 -p18f97j60  -o"Objects/Delay.o" \
   -L/usr/local/lib/pic16  TCPIP_Stack/Delay.c

Objects/DHCP.o : TCPIP_Stack/DHCP.c  $(SDCC_HEADERS)  \
   $(SDCC_PIC16_HEADERS) $(APP_HEADERS) $(TCPIP_HEADERS)
	$(CC) -c -mpic16 -p18f97j60  -o"Objects/DHCP.o" \
   -L/usr/local/lib/pic16  TCPIP_Stack/DHCP.c

Objects/DHCPs.o : TCPIP_Stack/DHCPs.c  $(SDCC_HEADERS)  \
   $(SDCC_PIC16_HEADERS) $(APP_HEADERS) $(TCPIP_HEADERS)
	$(CC) -c -mpic16 -p18f97j60  -o"Objects/DHCPs.o" \
   -L/usr/local/lib/pic16  TCPIP_Stack/DHCPs.c

Objects/DNS.o : TCPIP_Stack/DNS.c  $(SDCC_HEADERS)  \
   $(SDCC_PIC16_HEADERS) $(APP_HEADERS) $(TCPIP_HEADERS)
	$(CC) -c -mpic16 -p18f97j60  -o"Objects/DNS.o" \
   -L/usr/local/lib/pic16  TCPIP_Stack/DNS.c

Objects/DynDNS.o : TCPIP_Stack/DynDNS.c  $(SDCC_HEADERS)  \
   $(SDCC_PIC16_HEADERS) $(APP_HEADERS) $(TCPIP_HEADERS)
	$(CC) -c -mpic16 -p18f97j60  -o"Objects/DynDNS.o" \
   -L/usr/local/lib/pic16  TCPIP_Stack/DynDNS.c

Objects/ENC28J60.o : TCPIP_Stack/ENC28J60.c $(SDCC_HEADERS)  \
   $(SDCC_PIC16_HEADERS) $(APP_HEADERS) $(TCPIP_HEADERS)
	$(CC) -c -mpic16 -p18f97j60  -o"Objects/ENC28J60.o" \
   -L/usr/local/lib/pic16  TCPIP_Stack/ENC28J60.c

Objects/ETH97J60.o : TCPIP_Stack/ETH97J60.c $(SDCC_HEADERS)  \
   $(SDCC_PIC16_HEADERS) $(APP_HEADERS) $(TCPIP_HEADERS)
	$(CC) -c -mpic16 -p18f97j60  -o"Objects/ETH97J60.o" \
   -L/usr/local/lib/pic16  TCPIP_Stack/ETH97J60.c

Objects/FTP.o : TCPIP_Stack/FTP.c $(SDCC_HEADERS)  \
   $(SDCC_PIC16_HEADERS) $(APP_HEADERS) $(TCPIP_HEADERS)
	$(CC) -c -mpic16 -p18f97j60  -o"Objects/FTP.o" \
   -L/usr/local/lib/pic16  TCPIP_Stack/FTP.c

Objects/Hashes.o : TCPIP_Stack/Hashes.c $(SDCC_HEADERS)  \
   $(SDCC_PIC16_HEADERS) $(APP_HEADERS) $(TCPIP_HEADERS)
	$(CC) -c -mpic16 -p18f97j60  -o"Objects/Hashes.o" \
   -L/usr/local/lib/pic16  TCPIP_Stack/Hashes.c

Objects/Helpers.o : TCPIP_Stack/Helpers.c $(SDCC_HEADERS)  \
   $(SDCC_PIC16_HEADERS) $(APP_HEADERS) $(TCPIP_HEADERS)
	$(CC) -c -mpic16 -p18f97j60  -o"Objects/Helpers.o" \
   -L/usr/local/lib/pic16  TCPIP_Stack/Helpers.c

Objects/HTTP2.o : TCPIP_Stack/HTTP2.c  $(SDCC_HEADERS)  \
   $(SDCC_PIC16_HEADERS) $(APP_HEADERS) $(TCPIP_HEADERS)
	$(CC) -c -mpic16 -p18f97j60  -o"Objects/HTTP2.o" \
   -L/usr/local/lib/pic16  TCPIP_Stack/HTTP2.c

Objects/HTTP.o : TCPIP_Stack/HTTP.c $(SDCC_HEADERS)  \
   $(SDCC_PIC16_HEADERS) $(APP_HEADERS) $(TCPIP_HEADERS)
	$(CC) -c -mpic16 -p18f97j60  -o"Objects/HTTP.o" \
   -L/usr/local/lib/pic16  TCPIP_Stack/HTTP.c

Objects/ICMP.o : TCPIP_Stack/ICMP.c $(SDCC_HEADERS)  \
   $(SDCC_PIC16_HEADERS) $(APP_HEADERS) $(TCPIP_HEADERS)
	$(CC) -c -mpic16 -p18f97j60  -o"Objects/ICMP.o" -L/usr/local/lib/pic16  TCPIP_Stack/ICMP.c

Objects/IP.o : TCPIP_Stack/IP.c  $(SDCC_HEADERS)  \
   $(SDCC_PIC16_HEADERS) $(APP_HEADERS) $(TCPIP_HEADERS)
	$(CC) -c -mpic16 -p18f97j60  -o"Objects/IP.o" -L/usr/local/lib/pic16  TCPIP_Stack/IP.c

Objects/LCDBlocking.o : TCPIP_Stack/LCDBlocking.c $(SDCC_HEADERS)  \
   $(SDCC_PIC16_HEADERS) $(APP_HEADERS) $(TCPIP_HEADERS)
	$(CC) -c -mpic16 -p18f97j60  -o"Objects/LCDBlocking.o" -L/usr/local/lib/pic16  TCPIP_Stack/LCDBlocking.c

Objects/MPFS2.o : TCPIP_Stack/MPFS2.c $(SDCC_HEADERS)  \
   $(SDCC_PIC16_HEADERS) $(APP_HEADERS) $(TCPIP_HEADERS)
	$(CC) -c -mpic16 -p18f97j60  -o"Objects/MPFS2.o" -L/usr/local/lib/pic16  TCPIP_Stack/MPFS2.c

Objects/MPFS.o : TCPIP_Stack/MPFS.c $(SDCC_HEADERS)  \
   $(SDCC_PIC16_HEADERS) $(APP_HEADERS) $(TCPIP_HEADERS)
	$(CC) -c -mpic16 -p18f97j60  -o"Objects/MPFS.o" -L/usr/local/lib/pic16  TCPIP_Stack/MPFS.c

Objects/NBNS.o : TCPIP_Stack/NBNS.c $(SDCC_HEADERS)  \
   $(SDCC_PIC16_HEADERS) $(APP_HEADERS) $(TCPIP_HEADERS)
	$(CC) -c -mpic16 -p18f97j60  -o"Objects/NBNS.o" -L/usr/local/lib/pic16  TCPIP_Stack/NBNS.c

Objects/Reboot.o : TCPIP_Stack/Reboot.c $(SDCC_HEADERS)  \
   $(SDCC_PIC16_HEADERS) $(APP_HEADERS) $(TCPIP_HEADERS)
	$(CC) -c -mpic16 -p18f97j60  -o"Objects/Reboot.o" -L/usr/local/lib/pic16  TCPIP_Stack/Reboot.c

Objects/SMTP.o : TCPIP_Stack/SMTP.c $(SDCC_HEADERS)  \
   $(SDCC_PIC16_HEADERS) $(APP_HEADERS) $(TCPIP_HEADERS)
	$(CC) -c -mpic16 -p18f97j60  -o"Objects/SMTP.o" -L/usr/local/lib/pic16  TCPIP_Stack/SMTP.c

Objects/SNMP.o : TCPIP_Stack/SNMP.c  $(SDCC_HEADERS)  \
   $(SDCC_PIC16_HEADERS) $(APP_HEADERS) $(TCPIP_HEADERS)
	$(CC) -c -mpic16 -p18f97j60  -o"Objects/SNMP.o" -L/usr/local/lib/pic16  TCPIP_Stack/SNMP.c

Objects/SNTP.o : TCPIP_Stack/SNTP.c $(SDCC_HEADERS)  \
   $(SDCC_PIC16_HEADERS) $(APP_HEADERS) $(TCPIP_HEADERS)
	$(CC) -c -mpic16 -p18f97j60  -o"Objects/SNTP.o" -L/usr/local/lib/pic16  TCPIP_Stack/SNTP.c

Objects/SPIEEPROM.o : TCPIP_Stack/SPIEEPROM.c  $(SDCC_HEADERS)  \
   $(SDCC_PIC16_HEADERS) $(APP_HEADERS) $(TCPIP_HEADERS)
	$(CC) -c -mpic16 -p18f97j60  -o"Objects/SPIEEPROM.o" -L/usr/local/lib/pic16  TCPIP_Stack/SPIRRPROM.c

Objects/SPIFlash.o : TCPIP_Stack/SPIFlash.c  $(SDCC_HEADERS)  \
   $(SDCC_PIC16_HEADERS) $(APP_HEADERS) $(TCPIP_HEADERS)
	$(CC) -c -mpic16 -p18f97j60  -o"Objects/SPIFlash.o" -L/usr/local/lib/pic16  TCPIP_Stack/SPIFlash.c

Objects/SPIRAM.o : TCPIP_Stack/SPIRAM.c $(SDCC_HEADERS)  \
   $(SDCC_PIC16_HEADERS) $(APP_HEADERS) $(TCPIP_HEADERS)
	$(CC) -c -mpic16 -p18f97j60  -o"Objects/SPIRAM.o" -L/usr/local/lib/pic16  TCPIP_Stack/SPIRAM.c

Objects/StackTsk.o : TCPIP_Stack/StackTsk.c $(SDCC_HEADERS)  \
   $(SDCC_PIC16_HEADERS) $(APP_HEADERS) $(TCPIP_HEADERS)
	$(CC) -c -mpic16 -p18f97j60  -o"Objects/StackTsk.o" -L/usr/local/lib/pic16  TCPIP_Stack/StackTsk.c

Objects/TCP.o : TCPIP_Stack/TCP.c $(SDCC_HEADERS)  \
   $(SDCC_PIC16_HEADERS) $(APP_HEADERS) $(TCPIP_HEADERS)
	$(CC) -c -mpic16 -p18f97j60  -o"Objects/TCP.o" -L/usr/local/lib/pic16  TCPIP_Stack/TCP.c

Objects/TCPPerformanceTest.o : TCPIP_Stack/TCPPerformanceTest.c $(SDCC_HEADERS)\
   $(SDCC_PIC16_HEADERS) $(APP_HEADERS) $(TCPIP_HEADERS) $(SDCC_HEADERS)  \
   $(SDCC_PIC16_HEADERS) $(APP_HEADERS) $(TCPIP_HEADERS)
	$(CC) -c -mpic16 -p18f97j60  -o"Objects/TCPPerformanceTest.o" -L/usr/local/lib/pic16  TCPIP_Stack/TCPPerformanceTest.c

Objects/Telnet.o : TCPIP_Stack/Telnet.c  $(SDCC_HEADERS)  \
   $(SDCC_PIC16_HEADERS) $(APP_HEADERS) $(TCPIP_HEADERS)
	$(CC) -c -mpic16 -p18f97j60  -o"Objects/Telnet.o" -L/usr/local/lib/pic16  TCPIP_Stack/Telnet.c

Objects/UDPPerformanceTest.o : TCPIP_Stack/UDPPerformanceTest.c $(SDCC_HEADERS)\
   $(SDCC_PIC16_HEADERS) $(APP_HEADERS) $(TCPIP_HEADERS)
	$(CC) -c -mpic16 -p18f97j60  -o"Objects/UDPPerformanceTest.o" -L/usr/local/lib/pic16  TCPIP_Stack/UDPPerformanceTest.c

Objects/Tick.o : TCPIP_Stack/Tick.c  $(SDCC_HEADERS)  \
   $(SDCC_PIC16_HEADERS) $(APP_HEADERS) $(TCPIP_HEADERS)
	$(CC) -c -mpic16 -p18f97j60  -o"Objects/Tick.o" -L/usr/local/lib/pic16  TCPIP_Stack/Tick.c

Objects/UART2TCPBridge.o : TCPIP_Stack/UART2TCPBridge.c  $(SDCC_HEADERS)  \
   $(SDCC_PIC16_HEADERS) $(APP_HEADERS) $(TCPIP_HEADERS)
	$(CC) -c -mpic16 -p18f97j60  -o"Objects/UART2TCPBridge.o" -L/usr/local/lib/pic16  TCPIP_Stack/UART2TCPBridge.c

Objects/UART.o : TCPIP_Stack/UART.c  $(SDCC_HEADERS)  \
   $(SDCC_PIC16_HEADERS) $(APP_HEADERS) $(TCPIP_HEADERS)
	$(CC) -c -mpic16 -p18f97j60  -o"Objects/UART.o" -L/usr/local/lib/pic16  TCPIP_Stack/UART.c

Objects/UDP.o : TCPIP_Stack/UDP.c $(SDCC_HEADERS)  \
   $(SDCC_PIC16_HEADERS) $(APP_HEADERS) $(TCPIP_HEADERS)
	$(CC) -c -mpic16 -p18f97j60  -o"Objects/UDP.o" -L/usr/local/lib/pic16  TCPIP_Stack/UDP.c

Objects/MPFSImg.o : MPFSImg.c  $(SDCC_HEADERS)  \
   $(SDCC_PIC16_HEADERS) $(APP_HEADERS) $(TCPIP_HEADERS)
	$(CC) -c -mpic16 -p18f97j60  -o"Objects/MPFSImg.o" -L/usr/local/lib/pic16  TCPIP_Stack/MPFSImg.c

Objects/MPFSImg2.o : MPFSImg2.c $(SDCC_HEADERS)  \
   $(SDCC_PIC16_HEADERS) $(APP_HEADERS) $(TCPIP_HEADERS)
	$(CC) -c -mpic16 -p18f97j60  -o"Objects/MPFSImg2.o" -L/usr/local/lib/pic16  TCPIP_Stack/MPFSImg2.c

Objects/LegacyHTTPApp.o : LegacyHTTPApp.c $(SDCC_HEADERS)  \
   $(SDCC_PIC16_HEADERS) $(APP_HEADERS) $(TCPIP_HEADERS)
	$(CC) -c -mpic16 -p18f97j60  -o"Objects/LegacyHTTPApp.o" -L/usr/local/lib/pic16  TCPIP_Stack/LegacyHTTPApp.c

Objects/PingDemo.o : PingDemo.c $(SDCC_HEADERS)  \
   $(SDCC_PIC16_HEADERS) $(APP_HEADERS) $(TCPIP_HEADERS)
	$(CC) -c -mpic16 -p18f97j60  -o"Objects/PingDemo.o" -L/usr/local/lib/pic16  PingDemo.c

Objects/SMTPDemo.o : SMTPDemo.c  $(SDCC_HEADERS)  \
   $(SDCC_PIC16_HEADERS) $(APP_HEADERS) $(TCPIP_HEADERS)
	$(CC) -c -mpic16 -p18f97j60  -o"Objects/SMTPDemo.o" -L/usr/local/lib/pic16  SMTPDemo.c

Objects/UARTConfig.o : UARTConfig.c  $(SDCC_HEADERS)  \
   $(SDCC_PIC16_HEADERS) $(APP_HEADERS) $(TCPIP_HEADERS)
	$(CC) -c -mpic16 -p18f97j60  -o"Objects/UARTConfig.o" -L/usr/local/lib/pic16  UARTConfig.c

Objects/GenericTCPClient.o : GenericTCPClient.c  $(SDCC_HEADERS)  \
   $(SDCC_PIC16_HEADERS) $(APP_HEADERS) $(TCPIP_HEADERS)
	$(CC) -c -mpic16 -p18f97j60  -o"Objects/GenericTCPClient.o" -L/usr/local/lib/pic16  GenericTCPClient.c

Objects/GenericTCPServer.o : GenericTCPServer.c  $(SDCC_HEADERS)  \
   $(SDCC_PIC16_HEADERS) $(APP_HEADERS) $(TCPIP_HEADERS)
	$(CC) -c -mpic16 -p18f97j60  -o"Objects/GenericTCPServer.o" -L/usr/local/lib/pic16  GenericTCPServer.c

Objects/CustomSNMPApp.o : CustomSNMPApp.c  $(SDCC_HEADERS)  \
   $(SDCC_PIC16_HEADERS) $(APP_HEADERS) $(TCPIP_HEADERS)
	$(CC) -c -mpic16 -p18f97j60  -o"Objects/CustomSNMPApp.o" -L/usr/local/lib/pic16  CustomSNMPApp.c

Objects/BerkeleyUDPClientDemo.o : BerkeleyUDPClientDemo.c  $(SDCC_HEADERS)  \
   $(SDCC_PIC16_HEADERS) $(APP_HEADERS) $(TCPIP_HEADERS)
	$(CC) -c -mpic16 -p18f97j60  -o"Objects/BerkeleyUDPClientDemo.o" -L/usr/local/lib/pic16  BerkeleyUDPClientDemo.c

Objects/BerkeleyTCPClientDemo.o : BerkeleyTCPClientDemo.c  $(SDCC_HEADERS)  \
   $(SDCC_PIC16_HEADERS) $(APP_HEADERS) $(TCPIP_HEADERS)
	$(CC) -c -mpic16 -p18f97j60  -o"Objects/BerkeleyTCPClientDemo.o" -L/usr/local/lib/pic16  BerkeleyTCPClientDemo.c

Objects/BerkeleyTCPServerDemo.o : BerkeleyTCPServerDemo.c  $(SDCC_HEADERS)  \
   $(SDCC_PIC16_HEADERS) $(APP_HEADERS) $(TCPIP_HEADERS)
	$(CC) -c -mpic16 -p18f97j60  -o"Objects/BerkeleyTCPServerDemo.o" -L/usr/local/lib/pic16  BerkeleyTCPServerDemo.c

Objects/BerkeleyAPI.o : TCPIP_Stack/BerkeleyAPI.c  $(SDCC_HEADERS)  \
   $(SDCC_PIC16_HEADERS) $(APP_HEADERS) $(TCPIP_HEADERS)
	$(CC) -c -mpic16 -p18f97j60  -o"Objects/BerkeleyAPI.o" -L/usr/local/lib/pic16  TCPIP_Stack/BerkeleyAPI.c

Objects/ENCX24J600.o : TCPIP_Stack/ENCX24J600.c  $(SDCC_HEADERS)  \
   $(SDCC_PIC16_HEADERS) $(APP_HEADERS) $(TCPIP_HEADERS)
	$(CC) -c -mpic16 -p18f97j60  -o"Objects/ENCX24J600.o" -L/usr/local/lib/pic16  TCPIP_Stack/ENCX24J600.c

Objects/ARCFOUR.o : TCPIP_Stack/ARCFOUR.c  $(SDCC_HEADERS)  \
   $(SDCC_PIC16_HEADERS) $(APP_HEADERS)
	$(CC) -c -mpic16 -p18f97j60  -o"Objects/ARCFOUR.o" -L/usr/local/lib/pic16  TCPIP_Stack/ARCFOUR.c

Objects/BigInt.o : TCPIP_Stack/BigInt.c  $(SDCC_HEADERS)  \
   $(SDCC_PIC16_HEADERS) $(APP_HEADERS)
	$(CC) -c -mpic16 -p18f97j60  -o"Objects/BigInt.o" -L/usr/local/lib/pic16  TCPIP_Stack/BigInt.c

Objects/Random.o : TCPIP_Stack/Random.c  $(SDCC_HEADERS)  \
   $(SDCC_PIC16_HEADERS) $(APP_HEADERS)
	$(CC) -c -mpic16 -p18f97j60  -o"Objects/Random.o" -L/usr/local/lib/pic16  TCPIP_Stack/Random.c

Objects/RSA.o : TCPIP_Stack/RSA.c  $(SDCC_HEADERS)  \
   $(SDCC_PIC16_HEADERS) $(APP_HEADERS)
	$(CC) -c -mpic16 -p18f97j60  -o"Objects/RSA.o" -L/usr/local/lib/pic16  TCPIP_Stack/RSA.c

Objects/SSL.o : TCPIP_Stack/SSL.c  $(SDCC_HEADERS)  \
   $(SDCC_PIC16_HEADERS) $(APP_HEADERS)
	$(CC) -c -mpic16 -p18f97j60  -o"Objects/SSL.o" -L/usr/local/lib/pic16  TCPIP_Stack/SSL.c

Objects/CustomSSLCert.o : CustomSSLCert.c $(SDCC_HEADERS)  \
   $(SDCC_PIC16_HEADERS) $(APP_HEADERS)
	$(CC) -c -mpic16 -p18f97j60  -o"Objects/CustomSSLCert.o" -L/usr/local/lib/pic16  TCPIP_Stack/CustomSSLCert.c

clean : 
	$(RM) $(OBJECTS)

