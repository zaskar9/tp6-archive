{ MASTER.PAS - reconstructed source of MASTER.EXE (31 Oct 1993)         }
{                                                                       }
{ PROFESSIONAL MASTER MIND, Michael Grossniklaus, Basel 1993.           }
{                                                                       }
{ The original source is lost. This file was reconstructed in October   }
{ 2026 from a disassembly of MASTER.EXE (Turbo Pascal 6.0 build, 32384  }
{ bytes). Everything that is in the binary is reproduced exactly: all   }
{ string constants, coordinates, colours, delays, the record layout of  }
{ the hall of fame, the control flow of every routine, the number and   }
{ order of parameters and the order of the global variables in the data }
{ segment. What the binary does not contain had to be invented: the     }
{ names of procedures, variables and types, comments and formatting.    }
{ Three oddities of the original are kept on purpose and marked with    }
{ "sic": Pos(S, ' ') with the arguments swapped, a copy-and-paste slip  }
{ in the last case of the evaluation, and the 673 in SetViewPort.       }
{                                                                       }
{ Units: CRT, DOS and GRAPH from Turbo Pascal 6.0, MOUSE and WRITING    }
{ from the UNITS folder of this archive. Needs the BGI drivers in       }
{ C:\TP\BGI and a VGA card. Scores are kept in MASTER.INI.              }

Program MasterMind;
Uses Crt, Dos, Graph, Mouse, Writing;

Type Eintrag = Record
                 Name   : String;      { 256 bytes }
                 Punkte : Integer;     {   2 bytes, record = 258 bytes }
               End;

Var GraphDriver, GraphMode     : Integer;
    Button, X, Y               : Integer;  { mouse }
    Zug                        : Integer;  { current move, 1..10; 13 = given up }
    Anz                        : Integer;  { pegs placed in the current move }
    N                          : Integer;  { peg counter in LeseZug }
    MaxX, MaxY                 : Integer;
    Taste                      : Char;
    Taste2                     : Char;     { unused; keeps the data layout of the EXE }
    Farbe                      : Integer;  { colour chosen with the mouse }
    Ergebnis                   : String;   { evaluation, e.g. '221' }
    ZugStr                     : String[5];
    Code                       : String[5];
    Start, Ende                : LongInt;  { seconds since midnight }
    Gewonnen                   : Boolean;
    Dummy                      : Boolean;  { unused; keeps the data layout of the EXE }
    Liste                      : Array[0..100] of Eintrag;  { [0] is the swap buffer }
    Datei                      : File of Eintrag;

{ ---------------------------------------------------------------- }
{ Title screen with the animated "MASTER MIND"                      }
{ ---------------------------------------------------------------- }
Procedure Titel;
Var I : Integer;
Begin ClearDevice;
      Rectangle(1,1,639,479);
      Rectangle(3,3,637,477);
      SetViewPort(3,3,673,477,ClipOn);                  { sic: 673 }
      SetTextStyle(SansSerifFont,HorizDir,7);
      SetTextJustify(CenterText,CenterText);
      OutTextXY(320,90,'PROFESSIONAL');
      SetTextStyle(SansSerifFont,HorizDir,9);
      SetTextJustify(LeftText,BottomText);
      SetColor(White);
      For I:=0 to 80 do
          If I mod 5 = 0 then Line(5,I+175,635,I+175);
      SetWriteMode(XORPut);
      For I:=0 to 420 do
          If I mod 2 = 0 then
             begin If I<400 then
                      begin OutTextXY(450-I,151,'MASTER');
                            OutTextXY(I,151,'MIND');
                      end;
                   Delay(5);
                   OutTextXY(450-I,151,'MASTER');
                   OutTextXY(I,151,'MIND');
             end;
      SetWriteMode(CopyPut);
      SetTextStyle(TriplexFont,HorizDir,0);
      SetTextJustify(CenterText,CenterText);
      OutTextXY(320,300,'by');
      OutTextXY(320,350,'Michael Grossniklaus');
      SetTextStyle(DefaultFont,HorizDir,0);
      SetTextJustify(LeftText,BottomText);
      OutTextXY(380,460,'All Rights Reserved, Basel 1993');
      Taste:=ReadKey;
      ClearDevice;
End;

{ ---------------------------------------------------------------- }
{ The board: 10 columns of 4 holes, feedback strip above, palette   }
{ of six colours below                                              }
{ ---------------------------------------------------------------- }
Procedure Spielfeld;
Var I, J : Integer;
Begin J:=0; I:=0;
      Rectangle(1,1,GetMaxX,GetMaxY);
      Rectangle(3,3,GetMaxX-2,GetMaxY-2);
      SetTextStyle(SansSerifFont,HorizDir,7);
      OutTextXY(130,10,'MASTER MIND');
      Rectangle(78,108,562,352);
      SetFillStyle(SolidFill,Brown);
      Rectangle(80,110,560,150);
      Bar(81,111,560,350);
      Rectangle(80,150,560,350);
      Rectangle(78,398,562,452);
      Rectangle(80,400,560,450);
      SetFillStyle(SolidFill,Brown);
      For I:=1 to 480 do
          begin If I mod 80 = 0 then Line(I+80,400,I+80,450);
                If I mod 48 = 0 then Line(I+80,110,I+80,350);
                If I mod 48 = 0 then
                   begin Repeat
                               SetColor(Black);
                               SetFillStyle(SolidFill,Black);
                               Circle(I+55,J+25+150,10);
                               FloodFill(I+55,J+175,Black);
                               J:=J+50;
                               SetColor(White);
                         Until J>150;
                         J:=0;
                   end;
          end;
      SetFillStyle(SolidFill,DarkGray);  FloodFill( 85,405,White);
      SetFillStyle(SolidFill,White);     FloodFill(165,405,White);
      SetFillStyle(SolidFill,Red);       FloodFill(245,405,White);
      SetFillStyle(SolidFill,Yellow);    FloodFill(325,405,White);
      SetFillStyle(SolidFill,Green);     FloodFill(405,405,White);
      SetFillStyle(SolidFill,Blue);      FloodFill(485,405,White);
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
               begin If (X>= 80) and (X<=160) then Farbe:=DarkGray
                     else If (X>=160) and (X<=240) then Farbe:=White
                     else If (X>=240) and (X<=320) then Farbe:=Red
                     else If (X>=320) and (X<=400) then Farbe:=Yellow
                     else If (X>=400) and (X<=480) then Farbe:=Green
                     else If (X>=480) and (X<=560) then Farbe:=Blue;
               end;
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
                        begin If (Y>=150) and (Y<=200) then
                                 begin FloodFill(Zug*48-24+80,175,Brown); A:=1; end
                              else If (Y>=200) and (Y<=250) then
                                 begin FloodFill(Zug*48-24+80,225,Brown); B:=1; end
                              else If (Y>=250) and (Y<=300) then
                                 begin FloodFill(Zug*48-24+80,275,Brown); C:=1; end
                              else If (Y>=300) and (Y<=350) then
                                 begin FloodFill(Zug*48-24+80,325,Brown); D:=1; end;
                        end
                     else Dec(Anz);
               end;
            ShowCursor;
      Until ((Anz>=4) and (A=1) and (B=1) and (C=1) and (D=1)) or (Zug>10);
End;

{ ---------------------------------------------------------------- }
{ Read the four pegs of the current column back from the screen     }
{ ---------------------------------------------------------------- }
Function LeseZug : String;
Var PX, PY, L, P, C : Integer;
    S               : String;
Begin P:=1;
      While P<>0 do
            begin N:=0;
                  S:='';
                  Repeat
                        PX:=48*Zug+80-24;
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
{ '1' for every right colour in the wrong place                     }
{ ---------------------------------------------------------------- }
Function Bewertung(Geheim, Versuch : String) : String;
Var A, B                : String;
    B1, B2, B3, B4      : String;
    Erg                 : String;
    A1, A2, A3, A4      : String;
    FA1, FA2, FA3, FA4,
    FB1, FB2, FB3, FB4  : Byte;
Begin A:=Geheim;
      B:=Versuch;
      Erg:='';
      B1:=Copy(B,1,1); B2:=Copy(B,2,1); B3:=Copy(B,3,1); B4:=Copy(B,4,1);
      A1:=Copy(A,1,1); A2:=Copy(A,2,1); A3:=Copy(A,3,1); A4:=Copy(A,4,1);
      FA1:=0; FB1:=0; FA2:=0; FB2:=0; FA3:=0; FB3:=0; FA4:=0; FB4:=0;
      If A1=B1 then begin Erg:=Erg+'2'; FA1:=1; FB1:=1; end;
      If A2=B2 then begin Erg:=Erg+'2'; FA2:=1; FB2:=1; end;
      If A3=B3 then begin Erg:=Erg+'2'; FA3:=1; FB3:=1; end;
      If A4=B4 then begin Erg:=Erg+'2'; FA4:=1; FB4:=1; end;
      If (FB2=0) and (FA1=0) and (B2=A1) then begin Erg:=Erg+'1'; FA1:=1; FB2:=1; end;
      If (FB3=0) and (FA1=0) and (B3=A1) then begin Erg:=Erg+'1'; FA1:=1; FB3:=1; end;
      If (FB4=0) and (FA1=0) and (B4=A1) then begin Erg:=Erg+'1'; FA1:=1; FB4:=1; end;
      If (FB1=0) and (FA2=0) and (B1=A2) then begin Erg:=Erg+'1'; FA2:=1; FB1:=1; end;
      If (FB3=0) and (FA2=0) and (B3=A2) then begin Erg:=Erg+'1'; FA2:=1; FB3:=1; end;
      If (FB4=0) and (FA2=0) and (B4=A2) then begin Erg:=Erg+'1'; FA2:=1; FB4:=1; end;
      If (FB1=0) and (FA3=0) and (B1=A3) then begin Erg:=Erg+'1'; FA3:=1; FB1:=1; end;
      If (FB2=0) and (FA3=0) and (B2=A3) then begin Erg:=Erg+'1'; FA3:=1; FB2:=1; end;
      If (FB4=0) and (FA3=0) and (B4=A3) then begin Erg:=Erg+'1'; FA3:=1; FB4:=1; end;
      If (FB1=0) and (FA4=0) and (B1=A4) then begin Erg:=Erg+'1'; FA4:=1; FB1:=1; end;
      If (FB2=0) and (FA4=0) and (B2=A4) then begin Erg:=Erg+'1'; FA4:=1; FB2:=1; end;
      If (FB3=0) and (FA4=0) and (B3=A4) then begin Erg:=Erg+'1'; FA3:=1; FB4:=1; end;  { sic }
      Bewertung:=Erg;
End;

{ ---------------------------------------------------------------- }
{ Show the evaluation as small black/white pegs above the column    }
{ ---------------------------------------------------------------- }
Procedure ZeigeBewertung(Erg : String);
Var E              : String;
    E1, E2, E3, E4 : String;
Begin E:=Erg;
      E1:=Copy(E,1,1); E2:=Copy(E,2,1); E3:=Copy(E,3,1); E4:=Copy(E,4,1);
      SetColor(Black);
      HideCursor;
      Circle((Zug-1)*48+80+12,120,5);
      Circle((Zug-1)*48+80+12,140,5);
      Circle((Zug-1)*48+80+36,120,5);
      Circle((Zug-1)*48+80+36,140,5);
      If E1='2' then begin SetFillStyle(SolidFill,Black); FloodFill((Zug-1)*48+80+12,120,Black); end
      else If E1='1' then begin SetFillStyle(SolidFill,White); FloodFill((Zug-1)*48+80+12,120,Black); end;
      If E2='2' then begin SetFillStyle(SolidFill,Black); FloodFill((Zug-1)*48+80+12,140,Black); end
      else If E2='1' then begin SetFillStyle(SolidFill,White); FloodFill((Zug-1)*48+80+12,140,Black); end;
      If E3='2' then begin SetFillStyle(SolidFill,Black); FloodFill((Zug-1)*48+80+36,120,Black); end
      else If E3='1' then begin SetFillStyle(SolidFill,White); FloodFill((Zug-1)*48+80+36,120,Black); end;
      If E4='2' then begin SetFillStyle(SolidFill,Black); FloodFill((Zug-1)*48+80+36,140,Black); end
      else If E4='1' then begin SetFillStyle(SolidFill,White); FloodFill((Zug-1)*48+80+36,140,Black); end;
      ShowCursor;
End;

{ ---------------------------------------------------------------- }
{ Letter of the code -> colour                                      }
{ ---------------------------------------------------------------- }
Function FarbeVon(C : String) : Integer;
Var F : Integer;
    S : String;
Begin S:=C;
      If S='A' then F:=DarkGray;
      If S='G' then F:=Green;
      If S='B' then F:=Blue;
      If S='R' then F:=Red;
      If S='Y' then F:=Yellow;
      If S='W' then F:=White;
      FarbeVon:=F;
End;

{ ---------------------------------------------------------------- }
{ Reveal the secret code on the right, one peg every 2.5 seconds    }
{ ---------------------------------------------------------------- }
Procedure ZeigeCode(C : String);
Var S              : String;
    C1, C2, C3, C4 : String;
    I, Nr, F       : Integer;
Begin S:=C;
      C1:=Copy(S,1,1); C2:=Copy(S,2,1); C3:=Copy(S,3,1); C4:=Copy(S,4,1);
      Nr:=0;
      SetFillStyle(SolidFill,Brown);
      Bar(575,150,619,350);
      SetColor(White);
      Rectangle(575,150,619,350);
      Rectangle(573,148,621,352);
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
                   FloodFill(597,I+125,Brown);
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
{ Hall of fame: MASTER.INI, 10 records of 258 bytes                 }
{ Punkte = 1000 - Spielzeit in Sekunden - 20 * Zuege                }
{ ---------------------------------------------------------------- }
Procedure HallOfFame(Start, Ende : LongInt; Zuege : Integer; Gewonnen : Boolean);
Var I, Punkte, Anzahl, J, K, W : Integer;
    Drin                       : Boolean;
    Name, S                    : String;
Begin Drin:=False;
      Punkte:=1000-(Ende-Start)-20*Zuege;
      If Punkte<0 then Punkte:=0;
      Assign(Datei,'MASTER.INI');
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
      Close(Datei);
      If Anzahl<=30 then
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
               Rectangle(1,1,639,479);
               Rectangle(3,3,637,477);
               SetTextStyle(SansSerifFont,HorizDir,4);
               SetTextJustify(LeftText,BottomText);
               ReadStringXY(100,220,'ENTER YOUR NAME: ',Name);
               Liste[Anzahl].Name:=Name;
               Liste[Anzahl].Punkte:=Punkte;
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
                           Until K=Anzahl;
                     end;
         end;
      ClearDevice;
      Rectangle(1,1,639,479);
      Rectangle(3,3,637,477);
      SetTextJustify(CenterText,CenterText);
      SetTextStyle(SansSerifFont,HorizDir,7);
      OutTextXY(320,50,'HALL OF FAME');
      SetTextJustify(LeftText,BottomText);
      SetTextStyle(SansSerifFont,HorizDir,4);
      For I:=1 to 10 do
          begin OutTextXY(50,I*35+70,Liste[I].Name);
                Str(Liste[I].Punkte,S);
                W:=TextWidth(S);
                OutTextXY(600-W,I*35+70,S);
          end;
      Assign(Datei,'MASTER.INI');
      Rewrite(Datei);
      For I:=1 to 10 do Write(Datei,Liste[I]);
      Close(Datei);
      Repeat Until KeyPressed;
End;

{ ---------------------------------------------------------------- }
Begin Randomize;
      Start:=0; Ende:=0;
      DetectGraph(GraphDriver,GraphMode);
      If GraphDriver<>VGA then
         begin Write(#7);
               InitGraph(GraphDriver,GraphMode,'C:\tp\bgi');
               MaxX:=GetMaxX;
               MaxY:=GetMaxY;
               CloseGraph;
               TextColor(Red+Blink);
               GotoXY(2,2);  Write('Falsche Graphikkarte');
               TextColor(White);
               GotoXY(5,4);  Write('Systemanforderungen:');
               GotoXY(6,6);  Write('ú VGA-Graphikkarte');
               GotoXY(6,7);  Write('ú Minimale Aufl”sung von 640x480 Pixels');
               GotoXY(5,9);  Write('Ihr System:');
               GotoXY(6,11); Write('ú ',GetDriverName);
               GotoXY(6,12); Write('ú ',MaxX,'x',MaxY);
               TextColor(LightGray);
               GotoXY(1,25);
               Taste:=ReadKey;
         end
      else
         begin InitGraph(GraphDriver,GraphMode,'C:\tp\bgi');
               SetHorizontalLimits(0,GetMaxX);
               SetVerticalLimits(0,GetMaxY);
               ClearDevice;
               SetColor(White);
               Titel;
               Repeat
                     Zug:=1;
                     Anz:=0;
                     Gewonnen:=True;
                     SetTextJustify(LeftText,BottomText);
                     Code:=MacheCode;
                     Spielfeld;
                     Zeit(Start);
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
                     If Ergebnis<>'2222' then Zug:=13;
                     If Zug>12 then Gewonnen:=False;
                     Zeit(Ende);
                     HideCursor;
                     ZeigeCode(Code);
                     SetTextStyle(SansSerifFont,HorizDir,4);
                     SetTextJustify(CenterText,CenterText);
                     SetColor(White);
                     If Ergebnis='2222' then OutTextXY(320,370,'YOU BROKE THE HIDDEN CODE !');
                     HideCursor;
                     Taste:=ReadKey;
                     HallOfFame(Start,Ende,Zug,Gewonnen);
                     ClearDevice;
                     Rectangle(1,1,639,479);
                     Rectangle(3,3,637,477);
                     SetTextJustify(CenterText,CenterText);
                     SetColor(White);
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
