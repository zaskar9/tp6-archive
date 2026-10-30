{ DARK.PAS - reconstructed source of DARK.EXE (20 Mar 1994)            }
{                                                                       }
{ The original source is lost. This file was reconstructed in October   }
{ 2026 from a disassembly of DARK.EXE (Turbo Pascal 6.0 build).         }
{ Names of variables and procedures are not in the binary and were      }
{ chosen freely. The call sequence, the port accesses and the string    }
{ constants are exactly those of the executable.                        }
{                                                                       }
{ Usage: DARK <DOS command>                                             }
{ Switches the VGA display off, runs the command through COMMAND.COM,   }
{ clears the screen and switches the display back on.                   }

PROGRAM Dark;
USES Crt, Dos, Graph;   { Graph is linked in the EXE but never used }

VAR Befehl : STRING;

PROCEDURE ScreenOn;
VAR Dummy : BYTE;
BEGIN
  Dummy := Port[$3DA];        { reset attribute controller flip-flop }
  Dummy := Port[$3C0];
  Port[$3C0] := $20;          { palette address source = display on }
END;

PROCEDURE ScreenOff;
VAR Dummy : BYTE;
BEGIN
  Dummy := Port[$3DA];
  Dummy := Port[$3C0];
  Port[$3C0] := $00;          { display off }
END;

BEGIN
  Befehl := ParamStr(1);
  ScreenOff;
  SwapVectors;
  Exec(GetEnv('COMSPEC'), '/C ' + Befehl);
  SwapVectors;
  ClrScr;                     { a Crt call without arguments }
  ScreenOn;
  GotoXY(1, 1);
END.
