{ DARK.PAS - reconstructed source of DARK.EXE (20 Mar 1994)             }
{                                                                       }
{ Usage: DARK <DOS command>                                             }
{ Switches the VGA display off, runs the command through COMMAND.COM,   }
{ clears the screen and switches the display back on.                   }
{                                                                       }
{ The original source is lost. This file was reconstructed in October   }
{ 2026 from a disassembly of DARK.EXE (Turbo Pascal 6.0 build) and      }
{ corrected in November 2026 after a compile check: the display is      }
{ switched with VGA_Aus and VGA_Ein from the MyUtil unit (UNITS), which }
{ is why Graph is linked into the EXE. Names are not in the binary and  }
{ were chosen freely; the call sequence and the string constants are    }
{ those of the executable. Verified: compiled with Turbo Pascal 6.0     }
{ (TPC.EXE, no switches, MYUTIL from UNITS) this file gives an EXE that }
{ is byte for byte identical to DARK.EXE. The four bytes of Unbenutzt   }
{ exist only because the EXE has four unused bytes of variables there.  }
{ The EXE header shows a 4000 byte stack and no heap at all ($M below): }
{ the program gives its memory up so that COMMAND.COM can run.          }

{$M 4000,0,0}
PROGRAM Dark;
USES Crt, Graph, Dos, MyUtil;

VAR Unbenutzt : ARRAY[1..4] OF BYTE;   { unused; type and name unknown }
    Befehl    : STRING;

BEGIN
  Befehl := ParamStr(1);
  VGA_Aus;
  SwapVectors;
  Exec(GetEnv('COMSPEC'), '/C ' + Befehl);
  SwapVectors;
  ClrScr;
  VGA_Ein;
  GotoXY(1, 1);
END.
