{ MMLOGO.PAS - the two "MasterMind" logos of MMIND.EXE (reconstruction) }
{                                                                       }
{ Second of the two bitmap units of MMIND.EXE, see MMTEXT.PAS for the   }
{ details. Rebuild the object files with                                }
{                                                                       }
{   BINOBJ MMGROSS.TPP MMGROSS.OBJ MMGross                              }
{   BINOBJ MMKLEIN.TPP MMKLEIN.OBJ MMKlein                              }

Unit MMLogo;

Interface

Procedure MMGross;        { "MasterMind" for the title screen  519 x 86 }
Procedure MMKlein;        { "MasterMind" above the board       389 x 65 }

Implementation

{$L MMGROSS.OBJ}
Procedure MMGross; external;

{$L MMKLEIN.OBJ}
Procedure MMKlein; external;

End.
