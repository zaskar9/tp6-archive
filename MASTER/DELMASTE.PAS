{ DELMASTE.PAS - reconstructed source of DELMASTE.EXE (3 Oct 1993)      }
{                                                                       }
{ The original source is lost. This file was reconstructed in October   }
{ 2026 from a disassembly of DELMASTE.EXE (Turbo Pascal 6.0 build).     }
{ Identifier names were chosen freely; the file name, the record size   }
{ (258 bytes) and the call sequence are those of the executable.        }
{                                                                       }
{ Resets the hall of fame of PROFESSIONAL MASTER MIND (MASTER.EXE) by   }
{ truncating MASTER.INI to zero records.                                }

PROGRAM DelMaster;

TYPE Eintrag = RECORD
                 Name   : STRING;      { 256 bytes }
                 Punkte : INTEGER;     {   2 bytes }
               END;                    { = 258 bytes per record }

VAR F : FILE OF Eintrag;

BEGIN
  Assign(F, 'MASTER.INI');
  {$I-} Rewrite(F); {$I+}
  IF IOResult <> 0 THEN Rewrite(F);
END.
