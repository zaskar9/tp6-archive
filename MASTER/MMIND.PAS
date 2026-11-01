{ MMIND.PAS - reconstructed source of MMIND.EXE (9 Apr 1994)            }
{                                                                       }
{ MASTER MIND, Michael Grossniklaus, Basel 1993/1994. Second version of }
{ the game in MASTER.EXE (see MASTER.PAS), rebuilt in April 1994 on top }
{ of the MyUtil unit: grey 3D panels (procedure Rahmen) instead of the  }
{ white frames, the lettering as bitmaps linked into the EXE, the       }
{ screen switched off while a screen is drawn, Bewertung with arrays,   }
{ range checking on, a different score formula and MASTER.SCR as score  }
{ file.                                                                 }
{                                                                       }
{ The original source is lost. This file was reconstructed in October   }
{ 2026 from a disassembly of MMIND.EXE (Turbo Pascal 6.0 build, 113376  }
{ bytes), starting from MASTER.PAS. Everything that is in the binary is }
{ reproduced exactly: all string constants, coordinates, colours,       }
{ delays, the record layout of the hall of fame, the control flow of    }
{ every routine, the number and order of parameters, the order of the   }
{ local variables and of the global variables in the data segment.      }
{ What the binary does not contain had to be invented: the names of     }
{ procedures, variables, types and units, comments and formatting.      }
{ Oddities of the original are kept on purpose and marked with "sic".   }
{                                                                       }
{ Verified: compiled with Turbo Pascal 6.0 (TPC.EXE, no switches, the   }
{ MYUTIL unit from UNITS, the object files from BINOBJ) this file gives }
{ an EXE that is byte for byte identical to MMIND.EXE. Dummy0 and       }
{ Unbenutzt exist only because the EXE has unused bytes there.          }
{                                                                       }
{ Units: CRT, DOS and GRAPH from Turbo Pascal 6.0, MyUtil from the      }
{ UNITS folder of this archive (version of Feb 1994), MMLogo and MMText }
{ (the bitmaps, see MMLOGO.PAS and MMTEXT.PAS). The BGI driver is       }
{ loaded from the current directory. Needs a VGA card. Scores are kept  }
{ in MASTER.SCR.                                                        }

{$R+}
Program MasterMind;
Uses Crt, Graph, Dos, MyUtil, MMLogo, MMText;

Type Eintrag = Record
                 Name   : String;      { 256 bytes }
                 Punkte : Integer;     {   2 bytes, record = 258 bytes }
               End;
     PByte   = ^Byte;                  { to pass a linked bitmap to PutImage }

Var Dummy0                     : Integer;  { unused; keeps the data layout of the EXE }
    GraphDriver, GraphMode     : Integer;
    Button, X, Y               : Integer;  { mouse }
    Zug                        : Integer;  { current move, 1..10; 0 = code broken }
    Anz                        : Integer;  { pegs placed in the current move }
    N                          : Integer;  { peg counter in LeseZug }
    MaxX, MaxY                 : Integer;
    Taste                      : Char;     { Farbe follows at the next even address ($A+) }
    Farbe                      : Word;     { colour chosen with the mouse }
    Ergebnis                   : String;   { evaluation, e.g. '221' }
    ZugStr                     : String[5];
    Code                       : String[5];
    Start, Ende                : LongInt;  { seconds since midnight }
    Gewonnen                   : Boolean;  { Liste follows at the next even address ($A+) }
    Liste                      : Array[0..100] of Eintrag;  { [0] is the swap buffer }
    Datei                      : File of Eintrag;
    Unbenutzt                  : Array[1..1310] of Byte;  { unused; the EXE has 1310 more bytes of }
                                                          { global variables here, type unknown     }

{ ---------------------------------------------------------------- }
{ Filled panel with a 2 pixel 3D border: light on top and left,     }
{ dark at the bottom and right when Erhaben (raised), else reversed }
{ ---------------------------------------------------------------- }
Procedure Rahmen(x1, y1, x2, y2 : Integer; Erhaben : Boolean; Farbe : Word);
Begin SetFillStyle(SolidFill,Farbe);
      Bar(x1,y1,x2,y2);
      If Erhaben then SetColor(DarkGray) else SetColor(White);
      Line(x2,y1,x2,y2);
      Line(x2-1,y1+1,x2-1,y2);
      Line(x1+1,y2,x2,y2);
      Line(x1+2,y2-1,x2,y2-1);
      If Erhaben then SetColor(White) else SetColor(DarkGray);
      Line(x1,y1,x2-1,y1);
      Line(x1,y1+1,x2-2,y1+1);
      Line(x1,y1,x1,y2);
      Line(x1+1,y1,x1+1,y2-1);
End;

{ ---------------------------------------------------------------- }
{ Title screen: two raised panels with the bitmaps                  }
{ ---------------------------------------------------------------- }
Procedure Titel;
Var I : Integer;                                     { unused; keeps the stack layout }
Begin VGA_Aus;
      Rahmen(1,1,639,479,False,LightGray);
      Rahmen(55,85,585,240,True,LightGray);
      Rahmen(55,290,585,410,True,LightGray);
      PutImage(62,90,PByte(@Professional)^,NormalPut);
      PutImage(60,150,PByte(@MMGross)^,NormalPut);
      PutImage(70,300,PByte(@Autor)^,NormalPut);
      SetColor(LightGray);                           { covers the last row of each bitmap }
      Line(60,145,580,145);
      Line(60,235,580,235);
      Line(60,400,580,400);
      SetTextStyle(DefaultFont,HorizDir,0);
      SetTextJustify(LeftText,TopText);
      SetColor(Black);
      OutTextXY(388,468,'All Rights Reserved, Basel 1993');
      VGA_Ein;
      Taste:=ReadKey;
      ClearDevice;
End;

{ ---------------------------------------------------------------- }
{ The board: 10 columns of 4 holes, feedback strip above, palette   }
{ of six colours below, all on grey panels                          }
{ ---------------------------------------------------------------- }
Procedure Spielfeld;
Var I, J : Integer;
Begin I:=0; J:=0;
      VGA_Aus;
      Rahmen(1,1,639,479,True,LightGray);
      Rahmen(125,20,517,87,True,Black);
      PutImage(127,22,PByte(@MMKlein)^,NormalPut);
      Rahmen(79,108,561,352,True,LightGray);
      Rahmen(78,398,561,452,True,LightGray);
      For I:=1 to 480 do
          begin If I mod 48 = 0 then
                   begin SetColor(DarkGray);
                         Line(I+80,110,I+80,350);
                         Line(I+33,149,I+80,149);
                         SetColor(White);
                         If I<480 then Line(I+81,110,I+81,350);
                         Line(I+34,150,I+79,150);
                   end;
                If I mod 48 = 0 then
                   begin Repeat
                               SetColor(Black);
                               SetFillStyle(SolidFill,Black);
                               Circle(I+55,J+175,10);
                               FloodFill(I+55,J+175,Black);
                               Inc(J,50);
                         Until J>150;
                         J:=0;
                   end;
          end;
      SetFillStyle(SolidFill,DarkGray);  Bar( 80,400,160,450);
      SetFillStyle(SolidFill,White);     Bar(161,400,240,450);
      SetFillStyle(SolidFill,Red);       Bar(241,400,320,450);
      SetFillStyle(SolidFill,Yellow);    Bar(321,400,400,450);
      SetFillStyle(SolidFill,Green);     Bar(401,400,480,450);
      SetFillStyle(SolidFill,Blue);      Bar(481,400,559,450);
      VGA_Ein;
      ShowCursor;
End;

{ ---------------------------------------------------------------- }
{ Secret code: four letters out of A G B R Y W                      }
{ (Anthrazit, Gruen, Blau, Rot, Yellow, Weiss)                      }
{ ---------------------------------------------------------------- }
Function MacheCode : String;
Var Z, L : Integer;
    S    : String;
Begin S:='';
      Repeat
            Z:=Random(6)+1;
            Case Z of
                 1 : S:=S+'A';
                 2 : S:=S+'G';
                 3 : S:=S+'B';
                 4 : S:=S+'R';
                 5 : S:=S+'Y';
                 6 : S:=S+'W';
            End;
            L:=Length(S);
      Until L>=4;
      MacheCode:=S;
End;

{ ---------------------------------------------------------------- }
{ Wait for a click on the palette; both buttons = give up           }
{ ---------------------------------------------------------------- }
Procedure WahlFarbe;
Begin Farbe:=100;
      Repeat
            Repeat
                  GetPosBut(Button,X,Y);
                  If Button=3 then
                     begin Zug:=13;
                           Exit;
                     end;
            Until Button=1;
            Delay(500);
            If (Y>=400) and (Y<=450) then
               Case X of
                     80..160 : Farbe:=DarkGray;
                    161..240 : Farbe:=White;
                    241..320 : Farbe:=Red;
                    321..400 : Farbe:=Yellow;
                    401..480 : Farbe:=Green;
                    481..560 : Farbe:=Blue;
               End;
      Until Farbe in [0..15];
End;

{ ---------------------------------------------------------------- }
{ One move: choose a colour, click a hole in the current column,    }
{ until all four holes of the column are filled                     }
{ ---------------------------------------------------------------- }
Procedure SetzeStein;
Var A, B, C, D : Byte;
Begin A:=0; B:=0; C:=0; D:=0;
      Repeat
            WahlFarbe;
            If Zug<=10 then
               begin Delay(100);
                     Button:=0;
                     Repeat GetPosBut(Button,X,Y) Until Button=1;
                     Delay(500);
                     Inc(Anz);
                     HideCursor;
                     SetFillStyle(SolidFill,Farbe);
                     If ((Zug-1)*48+80<=X) and (Zug*48+80>=X) then
                        Case Y of
                             150..200 : begin FloodFill(Zug*48-24+80,175,LightGray); A:=1; end;
                             201..250 : begin FloodFill(Zug*48-24+80,225,LightGray); B:=1; end;
                             251..300 : begin FloodFill(Zug*48-24+80,275,LightGray); C:=1; end;
                             301..350 : begin FloodFill(Zug*48-24+80,325,LightGray); D:=1; end;
                        End
                     else Dec(Anz);
               end;
            ShowCursor;
      Until ((Anz>=4) and (A=1) and (B=1) and (C=1) and (D=1)) or (Zug>10);
End;

{ ---------------------------------------------------------------- }
{ Read the four pegs of the current column back from the screen     }
{ ---------------------------------------------------------------- }
Function LeseZug : String;
Var PX, PY, L, P : Integer;
    C            : Word;
    S            : String;
Begin P:=1;
      While P<>0 do
            begin N:=0;
                  S:='';
                  PX:=48*Zug+80-24;
                  Repeat
                        PY:=50*N+175;
                        Inc(N);
                        HideCursor;
                        C:=GetPixel(PX,PY);
                        ShowCursor;
                        If C=DarkGray then S:=S+'A';
                        If C=White    then S:=S+'W';
                        If C=Red      then S:=S+'R';
                        If C=Yellow   then S:=S+'Y';
                        If C=Green    then S:=S+'G';
                        If C=Blue     then S:=S+'B';
                        L:=Length(S);
                        P:=Pos(S,' ');                   { sic: arguments swapped, always 0 }
                        If (P>0) and (P<5) then Write(#7);
                  Until (N>4) or (L>4);
            end;
      LeseZug:=S;
End;

{ ---------------------------------------------------------------- }
{ Evaluate a guess: '2' for every right colour in the right place,  }
{ '1' for every right colour in the wrong place. Same logic as in   }
{ MASTER.PAS, now with arrays; the last three cases set the wrong   }
{ flags (sic), MASTER.EXE only had the slip in the very last one.   }
{ ---------------------------------------------------------------- }
Function Bewertung(Geheim, Versuch : String) : String;
Var B1, A1 : Array[1..4] of String;
    Erg    : String;
    FA, FB : Array[1..4] of Byte;
    I      : Integer;
Begin Erg:='';
      For I:=1 to 4 do
          begin B1[I]:=Copy(Versuch,I,1);
                A1[I]:=Copy(Geheim,I,1);
                FA[I]:=0;
                FB[I]:=0;
          end;
      If A1[1]=B1[1] then begin Erg:=Erg+'2'; FA[1]:=1; FB[1]:=1; end;
      If A1[2]=B1[2] then begin Erg:=Erg+'2'; FA[2]:=1; FB[2]:=1; end;
      If A1[3]=B1[3] then begin Erg:=Erg+'2'; FA[3]:=1; FB[3]:=1; end;
      If A1[4]=B1[4] then begin Erg:=Erg+'2'; FA[4]:=1; FB[4]:=1; end;
      If (FB[2]=0) and (FA[1]=0) and (B1[2]=A1[1]) then begin Erg:=Erg+'1'; FA[1]:=1; FB[2]:=1; end;
      If (FB[3]=0) and (FA[1]=0) and (B1[3]=A1[1]) then begin Erg:=Erg+'1'; FA[1]:=1; FB[3]:=1; end;
      If (FB[4]=0) and (FA[1]=0) and (B1[4]=A1[1]) then begin Erg:=Erg+'1'; FA[1]:=1; FB[4]:=1; end;
      If (FB[1]=0) and (FA[2]=0) and (B1[1]=A1[2]) then begin Erg:=Erg+'1'; FA[2]:=1; FB[1]:=1; end;
      If (FB[3]=0) and (FA[2]=0) and (B1[3]=A1[2]) then begin Erg:=Erg+'1'; FA[2]:=1; FB[3]:=1; end;
      If (FB[4]=0) and (FA[2]=0) and (B1[4]=A1[2]) then begin Erg:=Erg+'1'; FA[2]:=1; FB[4]:=1; end;
      If (FB[1]=0) and (FA[3]=0) and (B1[1]=A1[3]) then begin Erg:=Erg+'1'; FA[3]:=1; FB[1]:=1; end;
      If (FB[2]=0) and (FA[3]=0) and (B1[2]=A1[3]) then begin Erg:=Erg+'1'; FA[3]:=1; FB[2]:=1; end;
      If (FB[4]=0) and (FA[3]=0) and (B1[4]=A1[3]) then begin Erg:=Erg+'1'; FA[3]:=1; FB[4]:=1; end;
      If (FB[1]=0) and (FA[4]=0) and (B1[1]=A1[4]) then begin Erg:=Erg+'1'; FA[1]:=1; FB[4]:=1; end;  { sic }
      If (FB[2]=0) and (FA[4]=0) and (B1[2]=A1[4]) then begin Erg:=Erg+'1'; FA[2]:=1; FB[4]:=1; end;  { sic }
      If (FB[3]=0) and (FA[4]=0) and (B1[3]=A1[4]) then begin Erg:=Erg+'1'; FA[3]:=1; FB[4]:=1; end;  { sic }
      Bewertung:=Erg;
End;

{ ---------------------------------------------------------------- }
{ Show the evaluation as small black/white pegs above the column    }
{ ---------------------------------------------------------------- }
Procedure ZeigeBewertung(Erg : String);
Var E1              : Array[1..4] of String;
    I, X, Y, DX, DY : Integer;
Begin E1[1]:=Copy(Erg,1,1); E1[2]:=Copy(Erg,2,1); E1[3]:=Copy(Erg,3,1); E1[4]:=Copy(Erg,4,1);
      SetColor(Black);
      HideCursor;
      Circle((Zug-1)*48+80+12,120,5);
      Circle((Zug-1)*48+80+12,140,5);
      Circle((Zug-1)*48+80+36,120,5);
      Circle((Zug-1)*48+80+36,140,5);
      For I:=1 to 4 do
          begin If I<3 then DX:=12 else DX:=36;
                If (I=1) or (I=3) then DY:=20 else DY:=40;
                X:=(Zug-1)*48+80+DX;
                Y:=DY+100;
                If E1[I]='2' then begin SetFillStyle(SolidFill,Black); FloodFill(X,Y,Black); end
                else If E1[I]='1' then begin SetFillStyle(SolidFill,White); FloodFill(X,Y,Black); end;
          end;
      ShowCursor;
End;

{ ---------------------------------------------------------------- }
{ Letter of the code -> colour                                      }
{ ---------------------------------------------------------------- }
Function FarbeVon(C : String) : Word;
Begin If C='A' then FarbeVon:=DarkGray;
      If C='G' then FarbeVon:=Green;
      If C='B' then FarbeVon:=Blue;
      If C='R' then FarbeVon:=Red;
      If C='Y' then FarbeVon:=Yellow;
      If C='W' then FarbeVon:=White;
End;

{ ---------------------------------------------------------------- }
{ Reveal the secret code on the right, one peg every 2.5 seconds.   }
{ The brown bar is painted over at once by the grey panel (sic).    }
{ ---------------------------------------------------------------- }
Procedure ZeigeCode(C : String);
Var C1, C2, C3, C4 : String;
    I, Nr          : Integer;
    F              : Word;
Begin C1:=Copy(C,1,1); C2:=Copy(C,2,1); C3:=Copy(C,3,1); C4:=Copy(C,4,1);
      Nr:=0;
      SetFillStyle(SolidFill,Brown);
      Bar(575,150,619,350);
      SetColor(White);
      Rahmen(573,148,621,352,False,LightGray);
      SetColor(Black);
      SetFillStyle(SolidFill,Black);
      For I:=1 to 200 do
          If I mod 50 = 0 then
             begin Circle(597,I+125,10);
                   FloodFill(597,I+125,Black);
             end;
      For I:=1 to 200 do
          If I mod 50 = 0 then
             begin Inc(Nr);
                   Case Nr of
                        1 : F:=FarbeVon(C1);
                        2 : F:=FarbeVon(C2);
                        3 : F:=FarbeVon(C3);
                        4 : F:=FarbeVon(C4);
                   End;
                   SetFillStyle(SolidFill,F);
                   FloodFill(597,I+124,LightGray);
                   Delay(2500);
             end;
End;

{ ---------------------------------------------------------------- }
{ Time of day in seconds (Word arithmetic, as in the original)      }
{ ---------------------------------------------------------------- }
Procedure Zeit(Var T : LongInt);
Var Sek, Min, Std, Hund : Word;
Begin GetTime(Std,Min,Sek,Hund);
      Std:=Std*3600;
      Min:=Min*60;
      T:=Std+Min+Sek;
End;

{ ---------------------------------------------------------------- }
{ Hall of fame: MASTER.SCR, 10 records of 258 bytes                 }
{ Punkte = 1000 - 10 * Spielzeit in Sekunden - 50 * Zuege           }
{ (Zuege is 0 when the code was broken, see the main program)       }
{ ---------------------------------------------------------------- }
Procedure HallOfFame(Start, Ende : LongInt; Zuege : Integer; Gewonnen : Boolean);
Var I, Punkte, Anzahl, J, K, W : Integer;
    Drin                       : Boolean;
    Name, S                    : String;
Begin Drin:=False;
      Punkte:=1000-(Ende-Start)*10-50*Zuege;
      If Punkte<0 then Punkte:=0;
      Assign(Datei,'MASTER.SCR');
      {$I-} Reset(Datei); {$I+}
      If IOResult<>0 then Rewrite(Datei);
      For I:=0 to 30 do
          begin Liste[I].Name:='-';
                Liste[I].Punkte:=0;
          end;
      I:=1;
      While not Eof(Datei) do
            begin Read(Datei,Liste[I]);
                  Inc(I);
            end;
      Anzahl:=I;
      If Anzahl>30 then Anzahl:=25;
      Close(Datei);
      For I:=Anzahl to 30 do
          begin Liste[I].Name:='-';
                Liste[I].Punkte:=0;
          end;
      I:=1;
      If Anzahl<10 then Drin:=True
      else Repeat
                 If Liste[I].Punkte<Punkte then Drin:=True;
                 Inc(I);
           Until I>Anzahl;
      If not Gewonnen then Drin:=False;
      If Drin then
         begin Inc(Anzahl);
               ClearDevice;
               Rahmen(1,1,639,479,True,LightGray);
               SetColor(Black);
               SetTextJustify(LeftText,TopText);
               SetTextStyle(SansSerifFont,HorizDir,4);
               InTextXY(100,220,'ENTER YOUR NAME: ',Name,15);
               Liste[Anzahl].Name:=Name;
               Liste[Anzahl].Punkte:=Punkte;
         end;
      J:=0;
      While Anzahl-1>J do
            begin Inc(J);
                  K:=J;
                  Repeat
                        Inc(K);
                        If Liste[J].Punkte<Liste[K].Punkte then
                           begin Liste[0]:=Liste[J];
                                 Liste[J]:=Liste[K];
                                 Liste[K]:=Liste[0];
                           end;
                  Until K>=Anzahl;
            end;
      ClearDevice;
      VGA_Aus;
      Rahmen(1,1,639,479,True,LightGray);
      Rahmen(126,20,513,83,True,Black);
      Rahmen(20,100,619,464,False,LightGray);
      PutImage(128,22,PByte(@HallFame)^,NormalPut);
      SetTextJustify(LeftText,TopText);
      SetTextStyle(SansSerifFont,HorizDir,4);
      I:=1;
      SetColor(Black);
      Repeat
            OutTextXY(50,I*35+70,Liste[I].Name);
            Str(Liste[I].Punkte,S);
            W:=TextWidth(S);
            OutTextXY(600-W,I*35+70,S);
            Inc(I);
      Until I>10;
      Assign(Datei,'MASTER.SCR');
      Rewrite(Datei);
      I:=1;
      Repeat
            Write(Datei,Liste[I]);
            Inc(I);
      Until I>10;
      Close(Datei);
      VGA_Ein;
      Repeat Until KeyPressed;
End;

{ ---------------------------------------------------------------- }
Begin Randomize;
      Start:=0; Ende:=0;
      DetectGraph(GraphDriver,GraphMode);
      If GraphDriver<>VGA then
         begin Write(#7);
               InitGraph(GraphDriver,GraphMode,'');
               MaxX:=GetMaxX;
               MaxY:=GetMaxY;
               CloseGraph;
               TextColor(Red+Blink);
               GotoXY(2,2);  Write('Falsche Graphikkarte');
               TextColor(White);
               GotoXY(5,4);  Write('Systemanforderungen:');
               GotoXY(6,6);  Write('ú VGA-Graphikadapter');
               GotoXY(6,7);  Write('ú Minimale Aufl”sung von 640x480 Pixels');
               GotoXY(5,9);  Write('Ihr System:');
               GotoXY(6,11); Write('ú ',GetDriverName);
               GotoXY(6,12); Write('ú ',MaxX,'x',MaxY);
               TextColor(LightGray);
               GotoXY(1,25);
               Taste:=ReadKey;
         end
      else
         begin InitGraph(GraphDriver,GraphMode,'');
               SetHorizontalLimits(0,GetMaxX);
               SetVerticalLimits(0,GetMaxY);
               ClearDevice;
               SetColor(White);
               Titel;
               Repeat
                     Zug:=1;
                     Anz:=0;
                     Gewonnen:=True;
                     SetTextJustify(LeftText,TopText);
                     Code:=MacheCode;
                     Spielfeld;
                     Zeit(Start);
                     Ergebnis:='0000';
                     Repeat
                           Anz:=0;
                           SetzeStein;
                           If Zug<=10 then
                              begin ZugStr:=LeseZug;
                                    Ergebnis:=Bewertung(Code,ZugStr);
                                    ZeigeBewertung(Ergebnis);
                                    Inc(Zug);
                              end;
                     Until (Zug>10) or (Ergebnis='2222');
                     If Ergebnis='2222' then Zug:=0;
                     If Zug>0 then Gewonnen:=False;
                     Zeit(Ende);
                     HideCursor;
                     ZeigeCode(Code);
                     SetTextStyle(SansSerifFont,HorizDir,4);
                     SetTextJustify(CenterText,CenterText);
                     SetColor(Black);
                     If Ergebnis='2222' then OutTextXY(320,370,'YOU BROKE THE HIDDEN CODE !');
                     HideCursor;
                     Taste:=ReadKey;
                     HallOfFame(Start,Ende,Zug,Gewonnen);
                     ClearDevice;
                     Rahmen(1,1,639,479,True,LightGray);
                     Rahmen(50,225,590,268,False,LightGray);
                     SetTextJustify(CenterText,CenterText);
                     SetColor(Black);
                     Repeat
                           OutTextXY(320,240,'DO YOU TRY AGAIN ? (Y/N)');
                           Taste:=ReadKey;
                     Until (UpCase(Taste)='N') or (UpCase(Taste)='Y');
                     ShowCursor;
               Until UpCase(Taste)='N';
               HideCursor;
               ClearDevice;
               CloseGraph;
         end;
End.
