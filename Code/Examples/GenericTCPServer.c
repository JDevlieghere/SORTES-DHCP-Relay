/*********************************************************************
 *
 *	Generic TCP Server Example Application
 *  Module for Microchip TCP/IP Stack
 *   -Implements an example "ToUpper" TCP server on port 9760 and 
 *	  should be used as a basis for creating new TCP server 
 *    applications
 *	 -Reference: None.  Hopefully AN833 in the future.
 *
 *********************************************************************
 * FileName:        GenericTCPServer.c
 * Dependencies:    TCP
 * Processor:       PIC18, PIC24F, PIC24H, dsPIC30F, dsPIC33F, PIC32
 * Compiler:        Microchip C32 v1.05 or higher
 *					Microchip C30 v3.12 or higher
 *					Microchip C18 v3.30 or higher
 *					HI-TECH PICC-18 PRO 9.63PL2 or higher
 * Company:         Microchip Technology, Inc.
 *
 * Software License Agreement
 *
 * Copyright (C) 2002-2009 Microchip Technology Inc.  All rights
 * reserved.
 *
 * Microchip licenses to you the right to use, modify, copy, and
 * distribute:
 * (i)  the Software when embedded on a Microchip microcontroller or
 *      digital signal controller product ("Device") which is
 *      integrated into Licensee's product; or
 * (ii) ONLY the Software driver source files ENC28J60.c, ENC28J60.h,
 *		ENCX24J600.c and ENCX24J600.h ported to a non-Microchip device
 *		used in conjunction with a Microchip ethernet controller for
 *		the sole purpose of interfacing with the ethernet controller.
 *
 * You should refer to the license agreement accompanying this
 * Software for additional information regarding your rights and
 * obligations.
 *
 * THE SOFTWARE AND DOCUMENTATION ARE PROVIDED "AS IS" WITHOUT
 * WARRANTY OF ANY KIND, EITHER EXPRESS OR IMPLIED, INCLUDING WITHOUT
 * LIMITATION, ANY WARRANTY OF MERCHANTABILITY, FITNESS FOR A
 * PARTICULAR PURPOSE, TITLE AND NON-INFRINGEMENT. IN NO EVENT SHALL
 * MICROCHIP BE LIABLE FOR ANY INCIDENTAL, SPECIAL, INDIRECT OR
 * CONSEQUENTIAL DAMAGES, LOST PROFITS OR LOST DATA, COST OF
 * PROCUREMENT OF SUBSTITUTE GOODS, TECHNOLOGY OR SERVICES, ANY CLAIMS
 * BY THIRD PARTIES (INCLUDING BUT NOT LIMITED TO ANY DEFENSE
 * THEREOF), ANY CLAIMS FOR INDEMNITY OR CONTRIBUTION, OR OTHER
 * SIMILAR COSTS, WHETHER ASSERTED ON THE BASIS OF CONTRACT, TORT
 * (INCLUDING NEGLIGENCE), BREACH OF WARRANTY, OR OTHERWISE.
 *
 *
 * Author               Date    	Comment
 *~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 * Howard Schlunder     10/19/06	Original
 ********************************************************************/
#define __GENERICTCPSERVER_C

#include "TCPIPConfig.h"

#if defined(STACK_USE_GENERIC_TCP_SERVER_EXAMPLE)

#include "TCPIP Stack/TCPIP.h"


// Defines which port the server will listen on
#define SERVER_PORT	9760


/*****************************************************************************
  Function:
	void GenericTCPServer(void)

  Summary:
	Implements a simple ToUpper TCP Server.

  Description:
	This function implements a simple TCP server.  The function is invoked
	periodically by the stack to listen for incoming connections.  When a 
	connection is made, the server reads all incoming data, transforms it
	to uppercase, and echos it back.
	
	This example can be used as a model for many TCP server applications.

  Precondition:
	TCP is initialized.

  Parameters:
	None

  Returns:
  	None
  ***************************************************************************/
void GenericTCPServer(void)
{
	BYTE i;
	WORD w, w2;
	BYTE AppBuffer[32];
	WORD wMaxGet, wMaxPut, wCurrentChunk;
	static TCP_SOCKET	MySocket;
	static enum _TCPServerState
	{
		SM_HOME = 0,
		SM_LISTENING,
	} TCPServerState = SM_HOME;

	switch(TCPServerState)
	{
		case SM_HOME:
			// Allocate a socket for this server to listen and accept connections on
			MySocket = TCPOpen(0, TCP_OPEN_SERVER, SERVER_PORT, TCP_PURPOSE_GENERIC_TCP_SERVER);
			if(MySocket == INVALID_SOCKET)
				return;

			TCPServerState = SM_LISTENING;
			break;

		case SM_LISTENING:
			// See if anyone is connected to us
			if(!TCPIsConnected(MySocket))
				return;


			// Figure out how many bytes have been received and how many we can transmit.
			wMaxGet = TCPIsGetReady(MySocket);	// Get TCP RX FIFO byte count
			wMaxPut = TCPIsPutReady(MySocket);	// Get TCP TX FIFO free space

			// Make sure we don't take more bytes out of the RX FIFO than we can put into the TX FIFO
			if(wMaxPut < wMaxGet)
				wMaxGet = wMaxPut;

			// Process all bytes that we can
			// This is implemented as a loop, processing up to sizeof(AppBuffer) bytes at a time.  
			// This limits memory usage while maximizing performance.  Single byte Gets and Puts are a lot slower than multibyte GetArrays and PutArrays.
			wCurrentChunk = sizeof(AppBuffer);
			for(w = 0; w < wMaxGet; w += sizeof(AppBuffer))
			{
				// Make sure the last chunk, which will likely be smaller than sizeof(AppBuffer), is treated correctly.
				if(w + sizeof(AppBuffer) > wMaxGet)
					wCurrentChunk = wMaxGet - w;

				// Transfer the data out of the TCP RX FIFO and into our local processing buffer.
				TCPGetArray(MySocket, AppBuffer, wCurrentChunk);
				
				// Perform the "ToUpper" operation on each data byte
				for(w2 = 0; w2 < wCurrentChunk; w2++)
				{
					i = AppBuffer[w2];
					if(i >= 'a' && i <= 'z')
					{
						i -= ('a' - 'A');
						AppBuffer[w2] = i;
					}
				}
				
				// Transfer the data out of our local processing buffer and into the TCP TX FIFO.
				TCPPutArray(MySocket, AppBuffer, wCurrentChunk);
			}

			// No need to perform any flush.  TCP data in TX FIFO will automatically transmit itself after it accumulates for a while.  If you want to decrease latency (at the expense of wasting network bandwidth on TCP overhead), perform and explicit flush via the TCPFlush() API.

			break;
	}
}

#endif //#if defined(STACK_USE_GENERIC_TCP_SERVER_EXAMPLE)
