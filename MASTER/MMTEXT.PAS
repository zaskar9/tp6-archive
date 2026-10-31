{ MMTEXT.PAS - lettering of MMIND.EXE as bitmaps (reconstruction)       }
{                                                                       }
{ MMIND.EXE has five pictures linked into it, in two code segments of   }
{ their own, i.e. two units that contain nothing but external          }
{ procedures made with BINOBJ from the picture files. This unit is the  }
{ first of them. The pictures are in the format of GetImage/PutImage   }
{ (word width-1, word height-1, then per row the four EGA/VGA planes),  }
{ the .TPP format of PCXTOOLS\PCX_PAS.PAS. Dark grey lettering on light }
{ grey, "Mind" in light blue. The .TPP files were cut out of MMIND.EXE  }
{ in October 2026 with the lengths they have in the EXE. Rebuild the    }
{ object files with                                                     }
{                                                                       }
{   BINOBJ PROFESS.TPP  PROFESS.OBJ  Professional                       }
{   BINOBJ AUTOR.TPP    AUTOR.OBJ    Autor                              }
{   BINOBJ HALLFAME.TPP HALLFAME.OBJ HallFame                           }

Unit MMText;

Interface

Procedure Professional;   { "professional"             279 x  56 }
Procedure Autor;          { "by Michael Grossniklaus"  499 x 101 }
Procedure HallFame;       { "Hall of Fame"             384 x  61 }

Implementation

{$L PROFESS.OBJ}
Procedure Professional; external;

{$L AUTOR.OBJ}
Procedure Autor; external;

{$L HALLFAME.OBJ}
Procedure HallFame; external;

End.
