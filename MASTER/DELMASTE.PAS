{ DELMASTE.PAS - reconstructed source of DELMASTE.EXE (3 Oct 1993)      }
{                                                                       }
{ Resets the hall of fame of PROFESSIONAL MASTER MIND (MASTER.EXE) by   }
{ truncating MASTER.INI to zero records.                                }
{                                                                       }
{ The original source is lost. This file was reconstructed in October   }
{ 2026 from a disassembly of DELMASTE.EXE (Turbo Pascal 6.0 build) and  }
{ corrected in November 2026 after a compile check. Identifier names    }
{ were chosen freely; the file name, the record size (258 bytes) and    }
{ the call sequence are those of the executable. Verified: compiled     }
{ with Turbo Pascal 6.0 (TPC.EXE, no switches) this file gives an EXE   }
{ that is byte for byte identical to DELMASTE.EXE. For that it needs    }
{ what the EXE shows: the Crt unit, stack checking off, a 12-record     }
{ array before the file variable and a counter set to 1 that are never  }
{ used (leftovers of a hall-of-fame routine, see MASTER.PAS), and 524   }
{ more bytes of unused variables (Unbenutzt) of unknown type.           }

{$S-}
PROGRAM DelMaster;

USES CRT;

TYPE Eintrag = RECORD
                 Name   : STRING;      { 256 bytes }
                 Punkte : INTEGER;     {   2 bytes }
               END;                    { = 258 bytes per record }

VAR Liste     : ARRAY[1..12] OF Eintrag;   { unused }
    F         : FILE OF Eintrag;
    I         : INTEGER;                   { set, never read }
    Unbenutzt : ARRAY[1..524] OF BYTE;     { unused; type and name unknown }

BEGIN
  I := 1;
  Assign(F, 'MASTER.INI');
  {$I-} Rewrite(F); {$I+}
  IF IOResult <> 0 THEN Rewrite(F);
END.
