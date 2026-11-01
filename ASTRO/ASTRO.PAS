{ ASTRO.PAS - reconstructed source of ASTRO.EXE (1 Sep 1993)             }
{                                                                       }
{ PC Astro 1.0, Michael Grossniklaus (Syntax) and Fabian Kristmann      }
{ (Idee), 1993. Text mode: asks for the birth date and time and prints  }
{ the zodiac sign and the ascendant. ASTROGR.PAS (13 Oct 1993) is the   }
{ graphical successor; its include file STARZEIC.INC is the same        }
{ procedure as the one below with the text output replaced by graphics. }
{                                                                       }
{ The original source is lost. This file was reconstructed in November  }
{ 2026 from a disassembly of ASTRO.EXE (Turbo Pascal 6.0 build, 15024   }
{ bytes) with ASTROGR.PAS and STARZEIC.INC as the template. Everything  }
{ that is in the binary is reproduced exactly; the names come from      }
{ the successor, the program name is its name too. Verified: compiled   }
{ with Turbo Pascal 6.0 as  TPC /$A- /B ASTRO.PAS  (MYOBJECT and MOUSE  }
{ from UNITS) this file gives an EXE that is byte for byte identical to }
{ ASTRO.EXE. The EXE was built with byte alignment of data ($A-), which }
{ the switch applies to the units as well; with the default word        }
{ alignment the variables land one byte off.                            }
{                                                                       }
{ Units: CRT from Turbo Pascal 6.0, MYOBJECT (and through it MOUSE)     }
{ from the UNITS folder of this archive.                                }

{$A-}
PROGRAM Aszendent;

USES CRT, MYOBJECT;

CONST Sternzeichen: ARRAY[1..12] OF STRING =
                    ('Widder','Stier','Zwillinge','Krebs','L”we','Jungfrau','Waage',
                    'Skorpion','Schtze','Steinbock','Wassermann','Fische');

VAR Grund            : AstroGround;
    Rahmen           : MyObject.Rahmen;
    Copyr            : MyObject.Rahmen;
    I                : INTEGER;
    Taste            : CHAR;

PROCEDURE Sternzeichen_bestimmen;

VAR Datum, Mon, Tg, Zt, Std, Min, YZ, ZY                          : STRING;
    I, Position, Zahl, Monat, Tag, Fehler, Stu, Miu, AnzahlStd,
    yx, Zeichen, SZ, Asz                                          : INTEGER;
    Zeit                                                          : REAL;
    XY, Ask                                                       : STRING;

BEGIN
     Zahl:=1;
     Rahmen.Init(10,7,70,14,lightgray,false);
     Repeat
           Rahmen.Draw(black);
           GotoXY(11,8);
           Write('Geben Sie Ihr Geburtsdatum ein (Tag.Monat): ');
           ReadLn(Datum);
           Position:=Pos('.',Datum);
           If Position>2 THEN Zahl:=2
                         ELSE Zahl:=1;
           Tg:=Copy(Datum,1,Zahl);
           Mon:=Copy(Datum,Position+1,2);
           Val(Mon,Monat,Fehler);
           Val(Tg,Tag,Fehler);
     Until Fehler=0;
     CASE Monat OF
     1  : IF Tag IN[1..20] THEN Zeichen:=10
                           ELSE Zeichen:=11;
     2  : IF Tag IN[1..19] THEN Zeichen:=11
                           ELSE Zeichen:=12;
     3  : IF Tag IN[1..20] THEN Zeichen:=12
                           ELSE Zeichen:=1;
     4  : IF Tag IN[1..20] THEN Zeichen:=1
                           ELSE Zeichen:=2;
     5  : IF Tag IN[1..21] THEN Zeichen:=2
                           ELSE Zeichen:=3;
     6  : IF Tag IN[1..21] THEN Zeichen:=3
                           ELSE Zeichen:=4;
     7  : IF Tag IN[1..22] THEN Zeichen:=4
                           ELSE Zeichen:=5;
     8  : IF Tag IN[1..23] THEN Zeichen:=5
                           ELSE Zeichen:=6;
     9  : IF Tag IN[1..23] THEN Zeichen:=6
                           ELSE Zeichen:=7;
     10 : IF Tag IN[1..23] THEN Zeichen:=7
                           ELSE Zeichen:=8;
     11 : IF Tag IN[1..22] THEN Zeichen:=8
                           ELSE Zeichen:=9;
     12 : IF Tag IN[1..21] THEN Zeichen:=9
                           ELSE Zeichen:=10;
     END;
     SZ:=Zeichen;
     Repeat
           GotoXY(11,9);
           Write('Geben Sie Ihre Geburtszeit ein (Std.Min)  : ');
           ReadLn(Zt);
           Position:=Pos('.',Zt);
           If Position>2 THEN Zahl:=2
                         ELSE Zahl:=1;
           Std:=Copy(Zt,1,Zahl);
           Min:=Copy(Zt,Position+1,2);
           Val(Std,Stu,Fehler);
           Val(Min,Miu,Fehler);
     Until Fehler=0;
     IF Stu<=6 THEN Stu:=Stu+24;
     IF Miu>=30 THEN Stu:=Stu+1;
     AnzahlStd:=(Stu-6) DIV 2;
     I:=0;
     Asz:=AnzahlStd+Zeichen;
     Repeat
           IF Asz>12 THEN Asz:=Asz-12;
     Until Asz<=12;
     GotoXY(11,11);
     Write('Ihr Sternzeichen: '+Sternzeichen[SZ]);
     GotoXY(11,12);
     Write('Ihr Aszendent   : '+Sternzeichen[Asz]);
     GotoXY(1,25);
END;

BEGIN
     TextBackGround(Black);
     ClrScr;
     I:=0;
     Grund.Init(1,1,80,24);
     Grund.Draw;
     Copyr.Init(20,7,60,14,cyan,true);
     Copyr.Draw(black);
     TextColor(red+blink);
     GotoXY(34,8);
     Write('PC Astro 1.0');
     TextColor(black);
     GotoXY(39,10);
     Write('by');
     GotoXY(27,12);
     Write('Michael Gossniklaus (Syntax)');
     GotoXY(29,13);
     Write('Fabian Kristmann  (Idee)');
     GotoXY(1,25);
     Taste:=ReadKey;
     Repeat
           Sternzeichen_bestimmen;
           Taste:=ReadKey;
     Until Taste=#27;
     TextColor(lightgray);
     TextBackGround(Black);
     ClrScr;
END.
