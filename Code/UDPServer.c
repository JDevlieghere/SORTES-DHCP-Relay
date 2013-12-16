#define __18F97J60
#define __SDCC__

#define GIADD 24 
#define DHCP_TYPE_OFFSET 241
#define PKT_SIZE 128  //Packet size
#define SPORT (67u)    //Server port
#define CPORT (68u)    //Client port
#define RELAY_SERVER_IP 0x3C61A8C0 //IP: 192.168.97.60 netmask: 255.255.255.0
#define DHCP_SERVER_IP 0x0A000001  //IP: 10.0.0.1 netmask: 255.255.255.0 chosen arbitrarily.
#define DHCP_SERVER_MAC1 0xFF
#define DHCP_SERVER_MAC2 0xFF
#define DHCP_SERVER_MAC3 0xFF
#define DHCP_SERVER_MAC4 0xFF
#define DHCP_SERVER_MAC5 0xFF
#define DHCP_SERVER_MAC6 0xFF //DHCP server MAC adres, also chosen arbitrarily


#include <pic18f97j60.h>

#include "Include/TCPIPConfig.h"
#include "Include/TCPIP_Stack/TCPIP.h"
#include "Include/MainDemo.h"
#include "Include/TCPIP_Stack/DHCP.h"

typedef struct{
        BYTE *pdata1;
        BYTE *pdata2;
        BYTE *pdata3;
        BYTE *pdata4;
}packet;

NODE_INFO server_info;
BYTE pkt_data11[PKT_SIZE];
BYTE pkt_data12[PKT_SIZE];
BYTE pkt_data13[PKT_SIZE];
BYTE pkt_data14[PKT_SIZE];


BYTE pkt_data21[PKT_SIZE];
BYTE pkt_data22[PKT_SIZE];
BYTE pkt_data23[PKT_SIZE];
BYTE pkt_data24[PKT_SIZE];

UDP_SOCKET server_socket, client_socket;


enum _UDPServerState
{
     SM_OPEN = 0,
     SM_WAIT_FOR_DATA,
} UDPServerState = SM_OPEN;
packet pkt_c,pkt_s;

void send_packet(packet *pkt,int size1,int size2,int size3,int size4,UDP_SOCKET socket); 
int read_packet(packet *pkt,int* size1p,int* size2p,int* size3p,int* size4p,UDP_SOCKET socket); 

//number of bytes each packet buffer is filled with.	    
int size21=0, size22=0, size23=0, size24=0;
int size11=0, size12=0, size13=0, size14=0;
int client_received=0, server_received=0;

void UDPServer()
{ 
  switch (UDPServerState)
  {
      case SM_OPEN:
        
	  server_info.IPAddr.Val = DHCP_SERVER_IP;
	  server_info.MACAddr.v[0] = DHCP_SERVER_MAC1;
	  server_info.MACAddr.v[1] = DHCP_SERVER_MAC2;
	  server_info.MACAddr.v[2] = DHCP_SERVER_MAC3;
	  server_info.MACAddr.v[3] = DHCP_SERVER_MAC4;
	  server_info.MACAddr.v[4] = DHCP_SERVER_MAC5;
	  server_info.MACAddr.v[5] = DHCP_SERVER_MAC6;
//open server socket given DHCP server node info. This socket is for //receiving reply (server) packets and relaying processed request 
//(client) packets to server, so local port is CPORT and remote port is //SPORT.
        server_socket = UDPOpen(CPORT,&(server_info),SPORT);
//open client socket. This socket is for receiving request packets and //relaying reply packets to a client. In this implementation reply
//packets are broadcast to all clients;clients can determine whether //they're the intended recipient by comparing their hardware address to //the CHADDR field. 
	  client_socket= UDPOpen(SPORT,NULL,CPORT);
	  if((server_socket == INVALID_UDP_SOCKET)||(client_socket==         	      INVALID_UDP_SOCKET))
                 return;
        else
            UDPServerState = SM_WAIT_FOR_DATA;
//initialize packet buffers for server_socket and client_socket.
	  pkt_c.pdata1 = &pkt_data11[0];
        pkt_c.pdata2 = &pkt_data12[0];
        pkt_c.pdata3 = &pkt_data13[0];
        pkt_c.pdata4 = &pkt_data14[0];

	  pkt_s.pdata1 = &pkt_data21[0];
        pkt_s.pdata2 = &pkt_data22[0];
        pkt_s.pdata3 = &pkt_data23[0];
        pkt_s.pdata4 = &pkt_data24[0];
        break;

      case SM_WAIT_FOR_DATA:
	    
//number of bytes each packet buffer is filled with.	    
	    size21=size22=size23=size24=0;
	    size11=size12=size13=size14=0;
	    client_received=server_received=0;
	    
	    client_received=read_packet(&(pkt_c),&size11,&size12,&size13,&size14,client_socket);
	  
	    server_received=read_packet(&(pkt_s),&size21,&size22,&size23,&size24,server_socket);
 
//process and relay request package
	    if(client_received){
//Check if packet has a valid message type and if 
//so set the GIADDR field to the IP address of the relay server 
		  *(pkt_c.pdata1+GIADD)=RELAY_SERVER_IP; //GIADD
		  send_packet(&(pkt_c),size11,size12,size13,size14,server_socket);
                
	    }
//relay reply package
	    if (server_received){
		 send_packet(&(pkt_s),size21,size22,size23,size24,client_socket);
	    }
        	 				
    }
}

  void send_packet(packet* pkt,int size1,int size2,int size3,int size4,UDP_SOCKET socket){
  		  if(UDPIsPutReady(socket)){
		    UDPPutArray(pkt->pdata1, size1);
		    UDPPutArray(pkt->pdata2, size2);
		    UDPPutArray(pkt->pdata3, size3);
		    UDPPutArray(pkt->pdata4, size4);
		    UDPFlush();
		  }
  }

  int read_packet(packet* pkt,int* size1p,int* size2p,int* size3p,int* size4p,UDP_SOCKET socket){
  	int bytes_to_rx=UDPIsGetReady(socket);
	  
	  if(bytes_to_rx < 4*PKT_SIZE){
	      if(bytes_to_rx){
		if(bytes_to_rx > PKT_SIZE){
		  *size1p = UDPGetArray(pkt->pdata1, PKT_SIZE);
		}
		else{
		  *size1p = UDPGetArray(pkt->pdata1, bytes_to_rx);
		}
		bytes_to_rx -= *size1p;
	      }
	      
	      if(bytes_to_rx){
		if(bytes_to_rx > PKT_SIZE){
		  *size2p = UDPGetArray(pkt->pdata2, PKT_SIZE);
		}
		else{
		   *size2p = UDPGetArray(pkt->pdata2, bytes_to_rx);
		}
		bytes_to_rx -= *size2p;
	      }

	      if(bytes_to_rx){
		if(bytes_to_rx > PKT_SIZE){
		  *size3p = UDPGetArray(pkt->pdata3, PKT_SIZE);
		}
		else{
		  *size3p = UDPGetArray(pkt->pdata3, bytes_to_rx);
		}
		bytes_to_rx -= *size3p;
	      }

	      if(bytes_to_rx){
		if(bytes_to_rx > PKT_SIZE){
		  *size4p = UDPGetArray(pkt->pdata4, PKT_SIZE);
		}
		else{
		  *size4p = UDPGetArray(pkt->pdata4, bytes_to_rx);
		}
		//bytes_to_rx -= size24;
	      }
	      return 1;
	    }
	    else{
		UDPDiscard();
		return 0;
	    }
	
  } 
	


