{ COMPTEST.PAS - reconstructed source of OLD\COMPTEST.EXE (14 Oct 1993) }
{                                                                       }
{ "HardwareTester 1.0", Michael Grossniklaus, Basel 1993. Text-mode     }
{ menu (MyObject windows, menu items read from MENU.DAT) with three     }
{ tests: system information (DOS version, date, time, disk C:, graphics }
{ driver and mode, resolution, palette size, mouse), a graphics demo    }
{ (random rectangles, circles, bars, lines, the palette, random pixels) }
{ and a mouse test that lights up the pressed button in a drawn mouse.  }
{                                                                       }
{ The original source is lost. This file was reconstructed in November  }
{ 2026 from a disassembly of OLD\COMPTEST.EXE (Turbo Pascal 6.0 build,  }
{ 33760 bytes). Everything that is in the binary is reproduced exactly; }
{ the names of the program, procedures and variables are invented.      }
{ Verified: compiled with Turbo Pascal 6.0 (TPC.EXE, no switches,       }
{ MYOBJECT and MOUSE from UNITS) this file gives an EXE                 }
{ that is byte for byte identical to OLD\COMPTEST.EXE. Unbenutzt1..3    }
{ and the local S of Anzeigen and Maustest exist only because the EXE   }
{ reserves space for variables it never uses. The only difference to    }
{ the build of 24 Oct 1993 (..\COMPTEST.PAS) is the mouse test: no      }
{ position display, no abort with Q, the right button (4) ends it.      }
{                                                                       }
{ Oddities kept as in the EXE: the BGI driver is loaded from A:\, the   }
{ window Fenster3 is set up but never drawn, and the number of colours  }
{ is taken from GetPaletteSize.                                         }
{                                                                       }
{ Units: GRAPH, CRT and DOS from Turbo Pascal 6.0, MOUSE and MYOBJECT   }
{ from the UNITS folder. MENU.DAT holds the four menu entries.          }

Program HardwareTester;
Uses Graph, Crt, Dos, Mouse, MyObject;

Var MausTasten, MausStatus    : Integer;
    MaxX, MaxY                : Integer;
    Unbenutzt1                : Integer;                { unused; type and name unknown }
    gd, gm                    : Integer;
    Unbenutzt2                : Array[1..10] of Byte;   { unused; type and name unknown }
    LoMode, HiMode            : Integer;
    MaxColor                  : Integer;
    Wahl                      : Integer;
    Taste                     : Char;
    Unbenutzt3                : Integer;                { unused; type and name unknown }
    Version                   : Word;
    Jahr, Monat, Tag, WTag    : Word;
    Std, Min, Sek, Hund       : Word;
    Fenster1, Fenster2,
    Fenster3, Menu            : Rahmen;
    Grund                     : HinterGrund;
    Frei, Groesse             : LongInt;
    Treiber, Modus, MausText  : String;

Procedure Titel;
Begin Grund.Draw(Blue);
      Write(' HardwareTester 1.0');
      GotoXY(3,25);
      Write('Copyright 1993 by Michael Grossniklaus, Basel');
      Fenster2.Draw(Black);
      TextColor(Red);
      GotoXY(31,10);
      Write('HardwareTester 1.0');
      TextColor(Black);
      GotoXY(39,12);
      Write('by');
      GotoXY(30,14);
      Write('Michael Grossniklaus');
      GotoXY(1,25);
      Taste:=ReadKey;
      Fenster2.Cancel(#176,Blue);
End;

Procedure Ermitteln;
Begin DetectGraph(gd,gm);
      InitGraph(gd,gm,'A:\');
      SetFillStyle(SolidFill,Red);
      SetTextJustify(CenterText,CenterText);
      SetTextStyle(SansSerifFont,HorizDir,0);
      Bar(170,210,470,280);
      Rectangle(171,211,469,279);
      Rectangle(173,214,467,277);
      OutTextXY(320,240,'BITTE WARTEN !');
      Version:=DosVersion;
      GetDate(Jahr,Monat,Tag,WTag);
      GetTime(Std,Min,Sek,Hund);
      Frei:=DiskFree(3);
      Groesse:=DiskSize(3);
      Treiber:=GetDriverName;
      GetModeRange(gd,LoMode,HiMode);
      Modus:=GetModeName(gm);
      MaxColor:=GetPaletteSize;
      MaxX:=GetMaxX;
      MaxY:=GetMaxY;
      FlagReset(MausStatus,MausTasten);
      If MausStatus=0 then MausText:='negativ'
                      else MausText:='positiv';
      Delay(5000);
      ClearDevice;
      CloseGraph;
End;

Procedure Anzeigen;
Var S : String;                       { unused; keeps the stack layout of the EXE }
Begin Grund.Draw(Blue);
      Write(' HardwareTester 1.0');
      GotoXY(3,25);
      Write('Copyright 1993 by Michael Grossniklaus, Basel');
      Fenster2.Draw(Black);
      Fenster1.Draw(Black);
      TextColor(White);
      GotoXY(3,3);  WriteLn(' MS-DOS Versionsnummer      : ',Lo(Version),'.',Hi(Version));
      GotoXY(3,5);  WriteLn(' Systemdatum                : ',Tag,'.',Monat,'.',Jahr);
      GotoXY(3,6);  WriteLn(' Systemzeit                 : ',Std:2,':',Min:2,':',Sek:2);
      GotoXY(3,8);  WriteLn(' Freier Speicher auf C:\    : ',Frei:10);
      GotoXY(3,9);  WriteLn(' Gr”sse des Laufwerks C:\   : ',Groesse:10);
      GotoXY(3,11); WriteLn(' Gesetzter Graphiktreiber   : ',Treiber);
      GotoXY(3,12); WriteLn(' Gesetzter Graphikmodus     : ',Modus);
      GotoXY(3,13); WriteLn(' Nummer des Graphiktreibers : ',gd);
      GotoXY(3,14); WriteLn(' Nummer des Graphikmodus    : ',gm);
      GotoXY(3,15); WriteLn(' M”gliche Graphikmodi       : ',LoMode,'-',HiMode);
      GotoXY(3,16); WriteLn(' Aufl”sung                  : ',MaxX,' x ',MaxY,' Pixel');
      GotoXY(3,17); WriteLn(' Anzahl Farben              : ',MaxColor);
      GotoXY(3,19); WriteLn(' Maustest                   : ',MausText);
      GotoXY(3,20); WriteLn(' Anzahl Maustasten          : ',MausTasten);
      GotoXY(1,25);
End;

Procedure Ueberschrift(Text : String);
Begin Rectangle(2,2,GetMaxX-2,GetMaxY-2);
      Line(2,GetMaxY DIV 30,GetMaxX-2,GetMaxY DIV 30);
      OutTextXY(GetMaxX DIV 2,GetMaxY DIV 30-GetMaxY DIV 60,Text);
End;

Procedure Maustest;
Var Pos, X, Y, Knopf, Status,
    Breite, Schritt, Anzahl   : Integer;
    S                         : String;   { unused; keeps the stack layout of the EXE }
Begin DetectGraph(gd,gm);
      InitGraph(gd,gm,'A:\');
      SetTextJustify(CenterText,CenterText);
      Ueberschrift('MouseTest');
      FlagReset(Status,Knopf);
      SetColor(White);
      SetTextStyle(SansSerifFont,HorizDir,0);
      If Status=0 then
         begin OutTextXY(GetMaxX DIV 2,GetMaxY DIV 2,'KEINE MAUS INSTALLIERT !');
               Delay(2500);
         end
      else
         begin Rectangle(GetMaxX DIV 7,GetMaxY DIV 7,GetMaxX DIV 3,GetMaxY DIV 2);
               Line(GetMaxX DIV 7,GetMaxY DIV 4,GetMaxX DIV 3,GetMaxY DIV 4);
               Breite:=GetMaxX DIV 3-GetMaxX DIV 7;
               Schritt:=Trunc(Breite/Knopf);
               Pos:=Schritt;
               Repeat
                     Line(GetMaxX DIV 7+Pos,GetMaxY DIV 7,GetMaxX DIV 7+Pos,GetMaxY DIV 4);
                     Inc(Pos,Schritt);
               Until Pos/Schritt>Knopf-1;
               Anzahl:=Knopf;
               Repeat
                     ShowCursor;
                     Repeat
                           GetPosBut(Knopf,X,Y);
                     Until Knopf in [1..4];
                     If Anzahl>2 then
                        If Knopf=1 then Knopf:=1
                        else If Knopf=2 then Knopf:=3
                        else If Knopf=3 then Knopf:=4
                        else If Knopf=4 then Knopf:=2;
                     If Knopf<=Anzahl then
                        begin HideCursor;
                              SetFillStyle(SolidFill,Red);
                              FloodFill(Knopf*Schritt+GetMaxX DIV 7-Schritt DIV 2,GetMaxY DIV 5,White);
                              Delay(1500);
                              SetFillStyle(SolidFill,Black);
                              FloodFill(Knopf*Schritt+GetMaxX DIV 7-Schritt DIV 2,GetMaxY DIV 5,White);
                        end;
               Until Knopf=4;
               CloseGraph;
         end;
End;

Procedure Graphiktest;
Var I, x1, x2, y1, y2, Breite, Pos, Farbe : Integer;
Begin DetectGraph(gd,gm);
      InitGraph(gd,gm,'A:\');
      SetTextStyle(DefaultFont,HorizDir,0);
      SetTextJustify(CenterText,CenterText);
      Ueberschrift('Random Rectangles');
      I:=0;
      Randomize;
      Repeat
            Inc(I);
            x1:=Random(GetMaxX DIV 2)+40;
            x2:=Random(GetMaxX DIV 2)+GetMaxX DIV 2-40;
            y1:=Random(GetMaxY DIV 2)+40;
            y2:=Random(GetMaxY DIV 2)+GetMaxY DIV 2-40;
            Farbe:=Random(GetPaletteSize);
            SetColor(Farbe);
            Rectangle(x1,y1,x2,y2);
            Delay(50);
      Until I>500;
      Delay(1000);
      SetColor(White);
      ClearDevice;
      Ueberschrift('Circle');
      I:=0;
      Repeat
            Inc(I);
            If I MOD 4=0 then Circle(GetMaxX DIV 2,GetMaxY DIV 2+10,I);
            Delay(50);
      Until I>GetMaxY DIV 2-GetMaxY DIV 30+1;
      Delay(1000);
      ClearDevice;
      Ueberschrift('Random Bars');
      I:=0;
      Repeat
            Inc(I);
            x1:=Random(GetMaxX DIV 2)+40;
            x2:=Random(GetMaxX DIV 2)+GetMaxX DIV 2-40;
            y1:=Random(GetMaxY DIV 2)+40;
            y2:=Random(GetMaxY DIV 2)+GetMaxY DIV 2-40;
            Farbe:=Random(GetPaletteSize);
            SetFillStyle(SolidFill,Farbe);
            Bar(x1,y1,x2,y2);
            Delay(50);
      Until I>500;
      ClearDevice;
      Ueberschrift('Random Lines');
      I:=0;
      Repeat
            Inc(I);
            x1:=Random(GetMaxX-80)+40;
            x2:=Random(GetMaxX-80)+40;
            y1:=Random(GetMaxY-80)+40;
            y2:=Random(GetMaxY-80)+40;
            Farbe:=Random(GetPaletteSize);
            SetColor(Farbe);
            Line(x1,y1,x2,y2);
            Delay(50);
      Until I>500;
      ClearDevice;
      SetColor(White);
      Ueberschrift('Colors');
      I:=0;
      Pos:=0;
      Breite:=GetMaxX DIV GetPaletteSize;
      Repeat
            SetFillStyle(SolidFill,I);
            Bar(Pos+6,GetMaxY DIV 30+3,Breite+Pos,GetMaxY-5);
            Inc(I);
            Inc(Pos,Breite);
      Until I>=GetPaletteSize;
      Delay(7500);
      ClearDevice;
      SetColor(White);
      Ueberschrift('Random Pixels');
      I:=0;
      Repeat
            Inc(I);
            x1:=Random(GetMaxX-80)+40;
            y1:=Random(GetMaxY-80)+40;
            Farbe:=Random(GetPaletteSize);
            PutPixel(x1,y1,Farbe);
            Delay(50);
      Until I>500;
      SetTextStyle(SansSerifFont,HorizDir,0);
      ClearDevice;
      SetColor(White);
      OutTextXY(GetMaxX DIV 2,GetMaxY DIV 3,'GAME OVER !');
      OutTextXY(GetMaxX DIV 2,GetMaxY DIV 2-GetMaxY DIV 15,'WAIT A MOMENT');
      Delay(10000);
      CloseGraph;
End;

Procedure Hauptmenue;
Begin Grund.Draw(Blue);
      Write(' HardwareTester 1.0');
      GotoXY(3,25);
      Write('Copyright 1993 by Michael Grossniklaus, Basel');
      Menu.Draw(Black);
      Repeat
            Wahl:=Menu.LightBar(LightGray,1);
            Case Wahl of
                 1 : begin Ermitteln;
                           Anzeigen;
                     end;
                 2 : Graphiktest;
                 3 : Maustest;
                 4 : begin TextBackground(Black);
                           TextColor(LightGray);
                           ClrScr;
                           Halt;
                     end;
            End;
      Until Wahl in [1..3];
End;

Begin ClrScr;
      Grund.Init(1,1,80,25,#176);
      Fenster2.Init(27,9,52,15,Cyan,True);
      Fenster1.Init(1,2,80,24,Blue,False);
      Fenster3.Init(27,10,53,12,Red,True);
      Menu.InitII(25,'MENU.DAT',Blue,True);
      Titel;
      Repeat
            Grund.Rebuild(1,2,80,24,Blue);
            Hauptmenue;
            If Wahl=1 then Taste:=ReadKey;
      Until Taste=#27;
      ClrScr;
End.
