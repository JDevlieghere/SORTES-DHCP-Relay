/*******************************************************************************

ZeroG Driver File for the Microchip TCP/IP Stack

Copyright © 2009 Microchip Technology Inc.  All rights reserved.

Microchip licenses to you the right to use, modify, copy and distribute
Software only when embedded on a Microchip microcontroller or digital signal
controller that is integrated into your product or third party product
(pursuant to the sublicense terms in the accompanying license agreement).

You should refer to the license agreement accompanying this Software for
additional information regarding your rights and obligations.

SOFTWARE AND DOCUMENTATION ARE PROVIDED “AS IS” WITHOUT WARRANTY OF ANY KIND,
EITHER EXPRESS OR IMPLIED, INCLUDING WITHOUT LIMITATION, ANY WARRANTY OF
MERCHANTABILITY, TITLE, NON-INFRINGEMENT AND FITNESS FOR A PARTICULAR PURPOSE.
IN NO EVENT SHALL MICROCHIP OR ITS LICENSORS BE LIABLE OR OBLIGATED UNDER
CONTRACT, NEGLIGENCE, STRICT LIABILITY, CONTRIBUTION, BREACH OF WARRANTY, OR
OTHER LEGAL EQUITABLE THEORY ANY DIRECT OR INDIRECT DAMAGES OR EXPENSES
INCLUDING BUT NOT LIMITED TO ANY INCIDENTAL, SPECIAL, INDIRECT, PUNITIVE OR
CONSEQUENTIAL DAMAGES, LOST PROFITS OR LOST DATA, COST OF PROCUREMENT OF
SUBSTITUTE GOODS, TECHNOLOGY, SERVICES, OR ANY CLAIMS BY THIRD PARTIES
(INCLUDING BUT NOT LIMITED TO ANY DEFENSE THEREOF), OR OTHER SIMILAR COSTS.

*******************************************************************************/

#define __ZGCONSOLE_C

/******************************************************************************/
/*                                                                            */
/* File:                                                                      */
/*      ZGConsole.c                                                            */
/*                                                                            */
/* Description:                                                               */
/*      C file implenting a CLI application.                              */
/*                                                                            */
/* DO NOT DELETE THIS LEGAL NOTICE:                                           */
/*  2008 © ZeroG Wireless, Inc.  All Rights Reserved.                         */
/*  Confidential and proprietary software of ZeroG Wireless, Inc.             */
/*  Do no copy, forward or distribute.                                        */
/*                                                                            */
/******************************************************************************/

//============================================================================
// Includes
//============================================================================
#include <string.h>
#include <stdio.h>
#include <stdarg.h>
#include <ctype.h>

#include "TCPIP Stack/TCPIP.h"
#include "TCPIP Stack/ZGConsole.h"


#if defined(ZG_CS_TRIS) && defined ( ZG_CONFIG_CONSOLE )

//============================================================================
// Constants
//============================================================================

// This define determines the number of command lines that are stored in the history
// buffer.  Setting this define to 0 will remove the command line history feature by
// eliminating history code and buffers, thereby saving memory.
#define  kZGNumHistoryEntries   (1)

// states for ZGConsoleProcess() state machine
enum
{
    kSTWaitForChar,
    kSTWaitForEscSeqSecondChar,
    kSTWaitForEscSeqThirdChar
};

// ASCII control keys


#define kZGTab             ('\t')
#define kZGNewLine         ('\n')
#define kZGBackspace       ('\b')
#define kZGCR              ('\r')
#define kZGSpace           (' ')
#define kZGEscape          (0x1b)
#define kZGDelete          (0x7f)   /* not supported on hyperterminal unless in VT100 mode */
#define kZGEnter           (0x0d)
#define kZGCtrl_B          (0x02)
#define kZGCtrl_C          (0x03)
#define kZGCtrl_D          (0x04)
#define kZGCtrl_E          (0x05)   /* used to turns off console echo */
#define kZGCtrl_H          (0x08)
#define kZGCtrl_I          (0x09)
#define kZGCtrl_O          (0x0f)
#define kZGCtrl_X          (0x18)

// total number of commands to and from Host Bridge
#define kZGNumCmdsToHostBridge    (sizeof(MsgsToHB) / sizeof(MSGS))
#define kZGNumCmdsFromHostBridge  (sizeof(MsgsFromHB) / sizeof(MSGS))

#define  kZGNextHistory          (0)
#define  kZGPrevHistory          (1)

#define kZGMaxInputEscapeSequence  (5)

//============================================================================
// Macros
//============================================================================
#define SET_RX_STATE(state)     g_ConsoleContext.rxState = state
#define GET_RX_STATE()          g_ConsoleContext.rxState
#define SET_CURSOR(index)       g_ConsoleContext.cursorIndex = index
#define GET_CURSOR()            g_ConsoleContext.cursorIndex

#define GET_LEN_RX_CMD_STRING()        ( strlen( (char *) g_ConsoleContext.rxBuf))

//============================================================================
// TypeDefs
//============================================================================

#if (kZGNumHistoryEntries > 0)
typedef struct history_struct
{
    tZGS8   buf[kZGNumHistoryEntries][kConsoleMaxMsgSize + 1];  // N lines of history
    tZGU8   index;
    tZGBool seeded;
    tZGS8   recallIndex;
} tZGHistory;
#endif

//============================================================================
// Local Globals
//============================================================================
#if (kZGNumHistoryEntries > 0)
static tZGHistory history;
#endif


static ROM tZGS8 gCmdLinePrompt[] = "> ";
static  tZGU8 gCmdLinePromptLength = 2;
static  tZGS8 gTmpCmdLine[kConsoleMaxMsgSize];


//============================================================================
// Constant Local Globals
//============================================================================

// VT100 escapse sequences that are output to the terminal
static ROM tZGS8 cursorLeftEscapeSequence[]           = {kZGEscape, '[', '1', 'D', 0x00};
static ROM tZGS8 cursorRightEscapeSequence[]          = {kZGEscape, '[', '1', 'C', 0x00};
static ROM tZGS8 cursorHomeEscapeSequence[]           = {kZGEscape, '[', 'f', 0x00};
static ROM tZGS8 eraseToEndOfLineEscapeSequence[]     = {kZGEscape, '[', 'K', 0x00};
static ROM tZGS8 saveCursorPositionEscapeSequence[]   = {kZGEscape, '7', 0x00};
static ROM tZGS8 restoreCursorPositionSequence[]      = {kZGEscape, '8', 0x00};
static ROM tZGS8 eraseEntireLineEscapeSequence[]      = {kZGEscape, '[', '2', 'K', 0x00};
static ROM tZGS8 eraseEntireScreenEscapeSequence[]    = {kZGEscape, '[', '2', 'J', 0x00};
static ROM tZGS8 underlineModeEscapeSequence[]        = {kZGEscape, '[', '4', 'm', 0x00};
static ROM tZGS8 normalModeEscapeSequence[]           = {kZGEscape, '[', 'm', 0x00};
static ROM tZGS8 highlightModeEscapeSequence[]        = {kZGEscape, '[', '1', 'm', 0x00};
static ROM tZGS8 inverseVideoEscapeSequence[]         = {kZGEscape, '[', '7', 'm', 0x00};

// VT100 escape sequences that are input from the terminal
// (note, if we ever use a longer sequence, update kZGMaxInputEscapeSequence)
static ROM tZGS8 upArrowEscapeSequence[]     = {kZGEscape, 0x5b, 'A', 0x00};
static ROM tZGS8 downArrowEscapeSequence[]   = {kZGEscape, 0x5b, 'B', 0x00};
static ROM tZGS8 rightArrowEscapeSequence[]  = {kZGEscape, 0x5b, 'C', 0x00};
static ROM tZGS8 leftArrowEscapeSequence[]   = {kZGEscape, 0x5b, 'D', 0x00};
static ROM tZGS8 homeKeyEscapeSequence[]     = {kZGEscape, 0x5b, 'H', 0x00};
static ROM tZGS8 endKeyEscapeSequence[]      = {kZGEscape, 0x5b, 'K', 0x00};



//============================================================================
// Globals
//============================================================================
#ifdef __18CXX
#pragma udata zgcli_section
#endif

    tConsoleContext g_ConsoleContext;

#ifdef __18CXX
#pragma udata
#endif

//============================================================================
// Local Function Prototypes
//============================================================================
#if 0   /* add back if needed */
static tZGBool          isCtrlCharacter(tZGS8 c);
static tZGVoidReturn    NormalMode(tZGVoidInput);
static tZGVoidReturn    UnderlineMode(tZGVoidInput);
#endif

static tZGBool          isPrintableCharacter(tZGS8 c);
static tZGBool          isCmdLineOnlyWhitespace(tZGVoidInput);
static tZGVoidReturn    InsertCharacter(tZGS8 c);
static tZGVoidReturn    Delete(tZGVoidInput);
static tZGVoidReturn    Backspace(tZGVoidInput);
static tZGVoidReturn    EchoCharacter(tZGS8 new_char);

#if 0 /* add back if you need this feature */
static tZGVoidReturn    EraseEntireScreen(tZGVoidInput);
#endif

static tZGVoidReturn    EraseEntireLine(tZGVoidInput);
static tZGVoidReturn    CursorRight(tZGVoidInput);
static tZGVoidReturn    CursorRight_N(tZGU8 n);
static tZGVoidReturn    CursorLeft(tZGVoidInput);
static tZGVoidReturn    CursorLeft_N(tZGU8 n);
static tZGVoidReturn    CursorHome(tZGVoidInput);
static tZGVoidReturn    CursorEnd(tZGVoidInput);


static tZGVoidReturn    OutputLine(tZGS8 lineChar, tZGU8 count);
static tZGVoidReturn    Enter(tZGVoidInput);
static tZGVoidReturn    ProcessEscapeSequence(tZGS8 *p_escape_sequence);
static tZGVoidReturn    OutputCommandPrompt(tZGVoidInput);

#if (kZGNumHistoryEntries > 0)
static tZGVoidReturn    InitHistory(tZGVoidInput);
static tZGVoidReturn    AddCmdToHistory(tZGVoidInput);
static tZGVoidReturn    DisplayHistoryEntry(tZGU8 action);
#endif




/*****************************************************************************
 * FUNCTION: ZGConsoleInit
 *
 * RETURNS: None
 *
 * PARAMS:  p_cmdStrings  -- pointer to array of application-specific command strings
 *          numCmdStrings -- number of strings in p_cmdStrings
 *
 * NOTES:   Initialization for console thread
 *
 *****************************************************************************/
tZGVoidReturn ZGConsoleInit( ROM tZGU8 **p_cmdStrings, tZGU8 numCmdStrings)
{
    SET_RX_STATE(kSTWaitForChar);
    SET_CURSOR(0);

    // zero out command line buffer
    memset(g_ConsoleContext.rxBuf, 0x00, sizeof(g_ConsoleContext.rxBuf));

    g_ConsoleContext.bStateMachineLoop = kZGBoolTrue;
    g_ConsoleContext.firstChar         = kZGBoolFalse;
    g_ConsoleContext.p_cmdStrings      = p_cmdStrings;
    g_ConsoleContext.numCmdStrings     = numCmdStrings;
    g_ConsoleContext.appConsoleMsgRx   = kZGBoolFalse;
    SET_ECHO_ON();
#if (kZGNumHistoryEntries > 0)
    InitHistory();
#endif

}


/*****************************************************************************
 * FUNCTION: ZGConsoleProcess
 *
 * RETURNS: None
 *
 * PARAMS:  None
 *
 * NOTES:   State machine called from main loop of app.  Handles serial input.
 *
 *****************************************************************************/
tZGVoidReturn ZGConsoleProcess(tZGVoidInput)
{
    //tZGU8 *pStart = &(cmdline[0]);
    tZGU16 rc;
    tZGS8  c;
    static tZGS8 escape_sequence[kZGMaxInputEscapeSequence];
    static tZGS8 esc_seq_index;

    // if this state machine has been disabled
    if (g_ConsoleContext.bStateMachineLoop == kZGBoolFalse)
    {
        return;
    }


    // if a command was entered that is application=specific
    if (g_ConsoleContext.appConsoleMsgRx == kZGBoolTrue)
    {
        return;  // wait until app done before processing further characters
    }

    // if no character(s) received
    if ( (rc = ZGSYS_UART_GETC_COUNT() ) == 0u )
    {
        return;
    }

    // get the character
    c = (tZGS8) ZGSYS_UART_GETC();

    // if this is the very first character received by this state machine
    if (g_ConsoleContext.firstChar == kZGBoolFalse)
    {
        Output_Monitor_Hdr();
        g_ConsoleContext.firstChar = kZGBoolTrue;
    }

    switch( GET_RX_STATE() )
    {
        //------------------------------------------
        case kSTWaitForChar:
        //------------------------------------------
            // if a 'normal' printable character
            if (isPrintableCharacter(c))
            {
                InsertCharacter(c);
            }
            // else if Delete key
            else if (c == kZGDelete)
            {
                Delete();
            }
            // else if Backspace key
            else if (c == (tZGS8)kZGBackspace)
            {
                Backspace();
            }
            // else if Enter key
            else if (c == kZGEnter)
            {
                Enter();
            }
            // else if Escape key
            else if (c == kZGEscape)
            {
                /* zero out escape buffer, init with ESC */
                memset(escape_sequence, 0x00, sizeof(escape_sequence));
                escape_sequence[0] = kZGEscape;
                esc_seq_index = 1;
                SET_RX_STATE(kSTWaitForEscSeqSecondChar);
            }
            // else if Ctrl C
            else if (c == kZGCtrl_C)
            {
               OutputCommandPrompt();
            }
            else {
                // Enter();
            }
            break;

        //------------------------------------------
        case kSTWaitForEscSeqSecondChar:
        //------------------------------------------
            /* if an arrow key, home, or end key (which is all that this state machine handles) */
            if (c == 0x5b)
            {
               escape_sequence[1] = c;
               SET_RX_STATE(kSTWaitForEscSeqThirdChar);
            }
            // else if user pressed escape followed by any printable character
            else if (isPrintableCharacter(c))
            {
                InsertCharacter(c);
                SET_RX_STATE(kSTWaitForChar);
            }
            // start this command line over
            else // anything else
            {
                OutputCommandPrompt();
                SET_RX_STATE(kSTWaitForChar);
            }
            break;

        //------------------------------------------
        case kSTWaitForEscSeqThirdChar:
        //------------------------------------------
            escape_sequence[2] = c;
            ProcessEscapeSequence(escape_sequence);
            SET_RX_STATE(kSTWaitForChar);
            break;


    } // end switch
}



tZGS8 ** ZGConsoleGetCmdLineTokens(tZGU8 *p_argc)
{
    *p_argc = g_ConsoleContext.argc;

    return g_ConsoleContext.argv;

}

/*****************************************************************************
 * FUNCTION: ProcessEscapeSequence
 *
 * RETURNS: None
 *
 * PARAMS:  pEscapeSequence -- escape sequence string to be processed.
 *
 * NOTES:   Processes an escape sequence received by the state machine
 *
 *****************************************************************************/
static tZGVoidReturn ProcessEscapeSequence(tZGS8 *pEscapeSequence)
{

   /* if a Left Arrow Key */
   if (strcmppgm2ram( (const char *) pEscapeSequence, (ROM FAR char*) leftArrowEscapeSequence) == 0)
   {
      CursorLeft();
   }
   /* else if Right Arrow Key */
   else if (strcmppgm2ram( (const char *) pEscapeSequence, (ROM FAR char*) rightArrowEscapeSequence) == 0)
   {
      CursorRight();
   }
#if (kZGNumHistoryEntries > 0)
   /* else if Up Arrow Key */
   else if (strcmppgm2ram( (const char *) pEscapeSequence, (ROM FAR char*) upArrowEscapeSequence) == 0)
   {

      DisplayHistoryEntry(kZGPrevHistory);
   }
   /* else if Down Arrow Key */
   else if (strcmppgm2ram( (const char *) pEscapeSequence, (ROM FAR char*) downArrowEscapeSequence) == 0)
   {
      DisplayHistoryEntry(kZGNextHistory);
   }
#endif
   /* else if Home Key */
   else if (strcmppgm2ram( (const char *) pEscapeSequence, (ROM FAR char*) homeKeyEscapeSequence) == 0)
   {
      CursorHome();
   }
   /* else if End Key */
   else if (strcmppgm2ram( (const char *) pEscapeSequence, (ROM FAR char*) endKeyEscapeSequence) == 0)
   {
      CursorEnd();
   }
}

/*= Output_Monitor_Hdr =======================================================
Purpose: After clearing screen, outputs to terminal the header block of text.

Inputs:  None

Returns: None
============================================================================*/
tZGVoidReturn Output_Monitor_Hdr(tZGVoidInput)
{
    // KS:
    // EraseEntireScreen();

    ZG_PUTRSUART("\n\r");
    OutputLine('=', 79);
    ZG_PUTRSUART("* ZeroG Host Interface Monitor\n\r");
    ZG_PUTRSUART("* (c) 2008 -- ZeroG, Inc.\n\r");
    ZG_PUTRSUART("*\n\r* Type 'help' to get a list of commands.\n\r");
    OutputLine('=', 79);
    OutputCommandPrompt();

}

/*= OutputLine ===============================================================
Purpose: Outputs a line of the specified character

Inputs:  lineChar -- character the comprises the line
         count    -- number of characters in the line

Returns: None
============================================================================*/
static tZGVoidReturn OutputLine(tZGS8 lineChar, tZGU8 count)
{
#if defined( STACK_USE_UART )
    tZGU8 i;

    for (i = 0; i < count; ++i)
    {
        while(BusyUART());
        putcUART(lineChar);
    }
    ZG_PUTRSUART("\n\r");
#endif
}


/*= is_Printable_Character ===================================================
Purpose: Determines if the input character can be output to the screen

Inputs:  c  -- char to test

Returns: True if printable, else False
============================================================================*/
static tZGBool isPrintableCharacter(tZGS8 c)
{
   if ( ((isalpha(c))   ||
        (isdigit(c))    ||
        (isspace(c))    ||
        (ispunct(c)))

            &&

        (c != (tZGS8)kZGEnter) && (c != (tZGS8)kZGTab)

      )
   {
      return kZGBoolTrue;
   }
   else
   {
      return kZGBoolFalse;
   }
}

/*= InsertCharacter =========================================================
Purpose: Inserts and echoes an printable character into the command line at the
         cursor location.

Inputs:  c  -- char to insert

Returns: none
============================================================================*/
static tZGVoidReturn InsertCharacter(tZGS8 c)
{
   tZGU8 len;

   tZGU8 i;
   tZGU8 orig_cursor_index = GET_CURSOR();
   tZGU8 count;

   /* throw away characters if exceeded cmd line length */
   if (GET_LEN_RX_CMD_STRING() >= sizeof(g_ConsoleContext.rxBuf)-1)
   {
      return;
   }

   len = GET_LEN_RX_CMD_STRING() + gCmdLinePromptLength;

   /* if inserting a character at end of cmd line */
   if (GET_CURSOR() == len)
   {
      g_ConsoleContext.rxBuf[GET_CURSOR() - gCmdLinePromptLength] = c;
      SET_CURSOR(GET_CURSOR() + 1);
      EchoCharacter(c);
   }
   /* inserting a character somewhere before the end of command line */
   else
   {
      /* Null out tmp cmd line */
      memset(gTmpCmdLine, 0x00, sizeof(gTmpCmdLine));

      /* copy up to the point of insertion */
      strncpy( (char *) gTmpCmdLine, (const char *) g_ConsoleContext.rxBuf, GET_CURSOR() - gCmdLinePromptLength);

      /* insert the new character */
      gTmpCmdLine[GET_CURSOR() - gCmdLinePromptLength] = c;

      /* copy the chars after the new character */
      strncpy( (char *) &gTmpCmdLine[GET_CURSOR() - gCmdLinePromptLength + 1],
               (const char *) &g_ConsoleContext.rxBuf[GET_CURSOR() - gCmdLinePromptLength],
               len - GET_CURSOR());

      /* put the first part of new string in the cmd line buffer */
      strcpy( (char *) g_ConsoleContext.rxBuf, (const char *) gTmpCmdLine);

      /* erase entire line, put the cursor at index 0 */
      EraseEntireLine();

      /* output the prompt */
      ZG_PUTRSUART( (ROM FAR char *) gCmdLinePrompt);

      /* Output the updated command line */
      ZG_PUTSUART( (char *) &g_ConsoleContext.rxBuf[0]);

      /* move the cursor to the next insert location */
      count = (len + 1) - orig_cursor_index - 1;
      for (i = 0; i < count; ++i)
      {
         ZG_PUTRSUART( (ROM FAR char *) cursorLeftEscapeSequence);
      }

      SET_CURSOR(orig_cursor_index + 1);
   }
}

/*= Delete ==================================================================
Purpose: Deletes the character at the cursor index

Inputs:  none

Returns: none
============================================================================*/

static tZGVoidReturn Delete(tZGVoidInput)
{
   unsigned int num_chars;
   unsigned int orig_index = GET_CURSOR();

   /* if cursor is not at the end of the line */
   if (GET_CURSOR() != GET_LEN_RX_CMD_STRING() + gCmdLinePromptLength)
   {
      /* Null out tmp cmd line */
      memset(gTmpCmdLine, 0x00, sizeof(gTmpCmdLine));

      /* get characters before the deleted key */
      num_chars = GET_CURSOR() - gCmdLinePromptLength;
      strncpy( (char *) gTmpCmdLine, (const char *) g_ConsoleContext.rxBuf, num_chars);

      /* append characters after the deleted char (if there are any) */
      if (strlen( (char *) g_ConsoleContext.rxBuf) - 1 > 0u)
      {
         strcpy( (char *) &gTmpCmdLine[num_chars], (const char *) &g_ConsoleContext.rxBuf[num_chars + 1]);
      }

      EraseEntireLine();               /* leaves g_ConsoleContext.cursorIndex at 0 */
      ZG_PUTRSUART( (ROM FAR char *) gCmdLinePrompt);

      strcpy( (char *) g_ConsoleContext.rxBuf, (const char *) gTmpCmdLine);


      ZG_PUTSUART( (char *) g_ConsoleContext.rxBuf );
      SET_CURSOR(gCmdLinePromptLength + GET_LEN_RX_CMD_STRING());
      CursorHome(); /* to first character after prompt */


      /* move cursor to point of delete */
      CursorRight_N(orig_index - gCmdLinePromptLength);
   }
}

/*= EchoCharacter ===========================================================
Purpose: Echoes a character to the terminal.

Inputs:  new_char -- character to echo

Returns: none
============================================================================*/
static tZGVoidReturn EchoCharacter(tZGS8 c)
{
    if (IS_ECHO_ON())
    {
       /* output cr then lf for lf */
       if (c == (tZGS8)'\n')
       {
          ZGSYS_UART_PUTC(kStdoutPort, '\r');
       }

       ZGSYS_UART_PUTC(kStdoutPort, c);
    }
}

/*= Enter ====================================================================
Purpose: Enter key processing

Inputs:  None

Returns: none
============================================================================*/
static tZGVoidReturn Enter(tZGVoidInput)
{
   tZGBool cmd_flag = kZGBoolFalse;


   if ( IS_ECHO_ON() )
   {
       /* if the command line has any characters in it and it is not just white space */
       if ( (GET_LEN_RX_CMD_STRING() > 0u)  &&  (!isCmdLineOnlyWhitespace() ) )
       {
#if (kZGNumHistoryEntries > 0)
          AddCmdToHistory();
#endif
          cmd_flag = kZGBoolTrue;
       }
   }
   // else talking to PC app, presume it only sends valid commands
   else
   {
       cmd_flag = kZGBoolTrue;
   }

   // Process command
   if (cmd_flag == kZGBoolTrue)
   {
       process_cmd();
   }

   // if we got an app-specific command,
   if (g_ConsoleContext.appConsoleMsgRx == kZGBoolFalse)
   {
       /* linefeed and output prompt */
       OutputCommandPrompt();
   }

   // don't output command prompt, which also clears rx buf, until app processes it's command

}

#if (kZGNumHistoryEntries > 0)

/*****************************************************************************
 * FUNCTION: InitHistory
 *
 * RETURNS: None
 *
 * PARAMS:  None
 *
 * NOTES:   Initialize command line history states.
 *
 *****************************************************************************/
static tZGVoidReturn InitHistory(tZGVoidInput)
{
    history.index       = 0;
    history.seeded      = kZGBoolFalse;
    history.recallIndex = 0;
}

/*****************************************************************************
 * FUNCTION: AddCmdToHistory
 *
 * RETURNS: None
 *
 * PARAMS:  None
 *
 * NOTES:   Adds latest command to history buffer
 *
 *****************************************************************************/
static tZGVoidReturn AddCmdToHistory(tZGVoidInput)
{
    // zero out current command at this location
    memset((void *)&history.buf[history.index], 0x00, sizeof(history.buf[history.index]));

    // copy new command to buffer
    memcpy( (void *) &history.buf[history.index], (void *) g_ConsoleContext.rxBuf, strlen( (char *) g_ConsoleContext.rxBuf));

    // bump index to next line in history buffer
    history.index = (history.index + 1) % kZGNumHistoryEntries;

    // put the recall index one command in advance of the command we just added
    history.recallIndex = history.index;

    // at least one entry in history buffer
    history.seeded = kZGBoolTrue;
}

/*****************************************************************************
 * FUNCTION: DisplayHistoryEntry
 *
 * RETURNS: None
 *
 * PARAMS:  action -- PREV_HISTORY or NEXT_HISTORY
 *
 * NOTES:   In response to the user pressing up or down arrow key, display
 *          corresponding entry in history buffer.
 *
 *****************************************************************************/
static tZGVoidReturn DisplayHistoryEntry(tZGU8 action)
{

   tZGBool foundEntry = kZGBoolFalse;

   // if nothing in history buffer
   if (history.seeded == kZGBoolFalse)
   {
      return;
   }

   if (action == (tZGU8)kZGPrevHistory)
   {
      --history.recallIndex;
      if (history.recallIndex < 0)
      {
         history.recallIndex = kZGNumHistoryEntries - 1;
      }

      /* search until found a history entry or searched all entries */
      while (foundEntry == kZGBoolFalse)
      {
         /* if found a history entry */
         if (history.buf[history.recallIndex][0] != 0)
         {
            foundEntry = kZGBoolTrue;
         }
         else
         {
            --history.recallIndex;
            if (history.recallIndex < 0)
            {
               history.recallIndex = kZGNumHistoryEntries  - 1;
            }
         }
      }
   }
   else /* action == kZGNextHistory */
   {
      history.recallIndex = (history.recallIndex + 1) % kZGNumHistoryEntries;

      /* search until found a history entry or searched all entries */
      while (foundEntry == kZGBoolFalse)
      {
         /* if found a history entry */
         if (history.buf[history.recallIndex][0] != 0)
         {
            foundEntry = kZGBoolTrue;
         }
         else
         {
            history.recallIndex = (history.recallIndex + 1) % kZGNumHistoryEntries;
         }
      }
   }

   if (foundEntry)
   {
      // erase line on screen and output command from history
      EraseEntireLine();          /* leaves Cursor_Index at 0 */
      ZG_PUTRSUART( (ROM FAR char *) gCmdLinePrompt );
      ZG_PUTSUART( (char *) history.buf[history.recallIndex]);

      // copy history command to console buffer (so they match) and put cursor
      // at end of line
      memset(g_ConsoleContext.rxBuf, 0x00, GET_LEN_RX_CMD_STRING() );
      strcpy( (char *) g_ConsoleContext.rxBuf, (const char *) history.buf[history.recallIndex]);
      SET_CURSOR(gCmdLinePromptLength + strlen( (char *) history.buf[history.recallIndex]));
   }

}
#endif  /* (kZGNumHistoryEntries > 0) */


/*= Backspace ================================================================
Purpose: Performs a backspace operation on the command line

Inputs:  none

Returns: none
============================================================================*/
static tZGVoidReturn Backspace(tZGVoidInput)
{
   tZGU8 num_chars;
   tZGU8 orig_index = GET_CURSOR();

   /* if cursor is not at the left-most position */
   if (GET_CURSOR() != gCmdLinePromptLength)
   {
      /* Null out tmp cmd line */
      memset(gTmpCmdLine, 0x00, sizeof(gTmpCmdLine));

      /* get characters before the backspace */
      num_chars = GET_CURSOR() - gCmdLinePromptLength - 1;
      strncpy( (char *) gTmpCmdLine, (const char *) g_ConsoleContext.rxBuf, num_chars);

      /* append characters after the deleted char (if there are any) */
      if ( (GET_LEN_RX_CMD_STRING() - 1) > 0u)
      {
         strcpy( (char *) &gTmpCmdLine[num_chars], (const char *) &g_ConsoleContext.rxBuf[num_chars + 1]);
      }

      EraseEntireLine();  /* leaves g_ConsoleContext.cursorIndex at 0 */

      strcpy( (char *) g_ConsoleContext.rxBuf, (const char *) gTmpCmdLine);

      ZG_PUTRSUART( (ROM FAR char *) gCmdLinePrompt);
      ZG_PUTSUART( (char *) g_ConsoleContext.rxBuf);
      SET_CURSOR(gCmdLinePromptLength + GET_LEN_RX_CMD_STRING());

      CursorHome(); /* to first character after prompt */


      /* move cursor to point of backspace */
      CursorRight_N(orig_index - 1 - gCmdLinePromptLength);
   }
}




static void EraseEntireLine()
{
   // int i;
   ZG_PUTRSUART( (ROM FAR char*) eraseEntireLineEscapeSequence);
   CursorLeft_N(GET_CURSOR());
   SET_CURSOR(0);
}

#if 0  /* add back if you want this feature */
static void EraseEntireScreen()
{
   ZG_PUTRSUART( (ROM FAR char*) eraseEntireScreenEscapeSequence);
}
#endif

static tZGVoidReturn OutputCommandPrompt(tZGVoidInput)
{
    if ( IS_ECHO_ON() )
    {
     ZG_PUTRSUART("\n\r");
     ZG_PUTRSUART((ROM FAR char*) gCmdLinePrompt);
    }
    SET_CURSOR(gCmdLinePromptLength);
    memset(g_ConsoleContext.rxBuf, 0x00, sizeof(g_ConsoleContext.rxBuf));

}

/*= CursorRight =============================================================
Purpose: Moves the cursor right by one character

Inputs:  none

Returns: none
============================================================================*/
tZGVoidReturn CursorRight(tZGVoidInput)
{
   /* if cursor is not already at the right-most position */
   if (GET_CURSOR() < GET_LEN_RX_CMD_STRING() + gCmdLinePromptLength)
   {
      SET_CURSOR( GET_CURSOR() + 1);
      ZG_PUTRSUART( (ROM FAR char*) cursorRightEscapeSequence);
   }
}


/*= CursorRight_N ==============================================================
Purpose: Moves the cursor left N characters to the right

Inputs:  n -- number of characters to move the cursor to the left

         Note: This sequence only takes a single digit of length, so may need to
               do the move in steps


Returns: none
============================================================================*/
tZGVoidReturn CursorRight_N(tZGU8 n)
{
   tZGS8 sequence_string[sizeof(cursorRightEscapeSequence) + 2];  /* null and extra digit */

//   ASSERT(n <= (strlen(g_ConsoleContext.buf) + CMD_LINE_PROMPT_LENGTH));

   if (n > 0u)
   {
      SET_CURSOR( GET_CURSOR() + n );
      sequence_string[0] = cursorRightEscapeSequence[0]; /* ESC */
      sequence_string[1] = cursorRightEscapeSequence[1];  /* '[' */

      if (n < 10u)
      {
         sequence_string[2] = n + '0';  /* ascii digit */
         sequence_string[3] = cursorRightEscapeSequence[3];    /* 'C' */
         sequence_string[4] = '\0';
      }
      else
      {
         sequence_string[2] = (n / 10) + '0';  /* first ascii digit  */
         sequence_string[3] = (n % 10) + '0';  /* second ascii digit */
         sequence_string[4] = cursorRightEscapeSequence[3];    /* 'C' */
         sequence_string[5] = '\0';

      }

      ZG_PUTSUART( (char *) sequence_string);
   }
}

/*= CursorLeft ==============================================================
Purpose: Moves the cursor left by one character

Inputs:  none

Returns: none
============================================================================*/
tZGVoidReturn CursorLeft(tZGVoidInput)
{
   /* if cursor is not already at the left-most position */
   if (GET_CURSOR() > strlenpgm( (ROM FAR char *) gCmdLinePrompt))
   {
      SET_CURSOR( GET_CURSOR() - 1);
      ZG_PUTRSUART( (ROM FAR char *) cursorLeftEscapeSequence);
   }
}


/*= CursorLeft_N ==============================================================
Purpose: Moves the cursor left N characters to the left

Inputs:  n -- number of characters to move the cursor to the left

         Note: This sequence only takes a single digit of length, so may need to
               do the move in steps


Returns: none
============================================================================*/
tZGVoidReturn CursorLeft_N(tZGU8 n)
{
   tZGS8 sequence_string[sizeof(cursorLeftEscapeSequence) + 2];  /* null and extra digit */

//   ASSERT(n <= g_ConsoleContext.cursorIndex + CMD_LINE_PROMPT_LENGTH);

   if (n > 0u)
   {
      SET_CURSOR( GET_CURSOR() - n );

      sequence_string[0] = cursorLeftEscapeSequence[0];  /* ESC */
      sequence_string[1] = cursorLeftEscapeSequence[1];  /* '[' */

      if (n < 10u)
      {
         sequence_string[2] = n + '0';  /* ascii digit */
         sequence_string[3] = cursorLeftEscapeSequence[3];    /* 'D' */
         sequence_string[4] = '\0';
      }
      else
      {
         sequence_string[2] = (n / 10) + '0';  /* first ascii digit  */
         sequence_string[3] = (n % 10) + '0';  /* second ascii digit */
         sequence_string[4] = cursorLeftEscapeSequence[3];    /* 'D' */
         sequence_string[5] = '\0';

      }

      ZG_PUTSUART( (char *) sequence_string);
   }
}


/*= CursorHome ==============================================================
Purpose: Moves the cursor to the left-most position of the command line (just
         in front of the prompt).

Inputs:  none

Returns: none
============================================================================*/
static tZGVoidReturn CursorHome(tZGVoidInput)
{
   /* if cursor not at start of command line */
   if (GET_CURSOR() != gCmdLinePromptLength)
   {
      /* move it to start of command line */
      CursorLeft_N(GET_CURSOR() - gCmdLinePromptLength);
   }
}

static tZGVoidReturn CursorEnd(tZGVoidInput)
{
   tZGU8 len;

   if ( (GET_LEN_RX_CMD_STRING() + gCmdLinePromptLength) != GET_CURSOR())
   {
      len = GET_LEN_RX_CMD_STRING() - GET_CURSOR() + gCmdLinePromptLength;
      CursorRight_N(len);
   }
}


static tZGBool isCmdLineOnlyWhitespace(tZGVoidInput)
{
   tZGU8 i;
   tZGU8 len = GET_LEN_RX_CMD_STRING();

   for (i = 0; i < len; ++i)
   {
      if ( !isspace(g_ConsoleContext.rxBuf[i]) )
      {
         return kZGBoolFalse;
      }
   }

   return kZGBoolTrue;
}

#if 0   /* Add back if you need this func */

static tZGVoidReturn UnderlineMode(tZGVoidInput)
{
    ZG_PUTRSUART(inverseVideoEscapeSequence);
}

static tZGVoidReturn NormalMode(tZGVoidInput)
{
    ZG_PUTRSUART(normalModeEscapeSequence);
}


/*****************************************************************************
 * FUNCTION: isCtrlCharacter
 *
 * RETURNS: true if input is a ctrl character, else false
 *          REG_OK_16_BIT_REG -- valid 16-bit register
 *          REG_UNKNOWN       -- unknown register ID
 *          REG_VAL_TOO_LARGE -- reg value to large for an 8-bit register
 *
 * PARAMS:  None
 *
 * NOTES:   Called by do_writereg_cmd and do_readreg_cmd to verify if accessing
 *          a legal register.  In the case of write, function verifies that
 *          write value doesn't overflow an 8-bit register.
 *
 *****************************************************************************/
static tZGBool isCtrlCharacter(tZGS8 c)
{
    if (isprint(c))
    {
        return kZGBoolFalse;
    }
    else
    {
        return kZGBoolTrue;
    }
}
#endif

tZGVoidReturn ZGConsoleSetMsgFlag(tZGVoidInput)
{
    g_ConsoleContext.appConsoleMsgRx = kZGBoolTrue;
}

tZGVoidReturn ZGConsoleReleaseConsoleMsg(tZGVoidInput)
{
    /* linefeed and output prompt */
    OutputCommandPrompt();

    g_ConsoleContext.appConsoleMsgRx = kZGBoolFalse;
}

tZGBool ZGConsoleIsConsoleMsgReceived(tZGVoidInput)
{

    return g_ConsoleContext.appConsoleMsgRx;
}


#endif /* ZG_CONFIG_CONSOLE */
