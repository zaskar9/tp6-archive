{$A+,B-,D+,E+,F-,G-,I+,L+,N-,O-,R-,S+,V+,X-}
{$M 16384,0,655360}
Program ProfessionalTetris;
Uses Dos, Crt, Graph;

Const fl=135;
      f : ARRAY[0..135]of Word=
      (659,1000,587,1000,494,500,523,500,587,1000,523,500,494,500,440,500,329,
       500,440,500,523,500,659,1000,587,500,523,500,494,750,523,250,587,500,
       659,500,523,500,440,500,25000,56,440,1000,25000,250,587,500,699,250,880,500,
       784,250,699,250,659,750,523,250,659,500,587,250,523,250,494,750,523,250,
       587,500,659,500,523,500,440,500,25000,56,440,1000,25000,56,440,2000,415,2000,
       440,1000,523,1000,659,1000,329,1000,25000,250,587,500,699,250,880,500,784,
       250,699,250,659,750,523,250,659,500,587,250,523,250,494,750,523,250,587,
       500,659,500,523,500,440,500,25000,56,440,250,25000,250);

Var tl, gd, gm, Zahl, I, R, XElm, YElm, nr, OldX, OldY,
    Punkte, Points, Lines, Level                          : Integer;
    Kuppel, Tetris, Score, Gameov, Copyr, HGrund          : Pointer;
    GrCopy,GrKup,GrTet,GrSco,Grgam,farbe,Mi,GrGrund       : Word;
    Spielfeld                                             : Array[0..11,1..15] OF Boolean;
    W, Z, S, B, T, L, J, ElementName                      : Array[1..4] of String[8];
    Taste,Dummy                                           : Char;
    TurnAl1, TurnAl2, Ende, XChangeLeft, XChangeRight,
    Musik                                                 : Boolean;
    Hstr, PoiStr, LiStr, LeStr                            : String;
    IntSave                                               : Procedure;

{$I PCXGRAPH.INC}
{$I TETRBUGS.INC}
{$I TETRINIT.INC}
{$I TETCOPYR.INC}
{$I TETRISCR.INC}
{$I TETRFELD.INC}
{$I TETRDRAW.INC}
{$I TEZUFALL.INC}
{$I TETSOUND.INC}
{$I TETMUSIK.INC}
{$I TETTASTE.INC}
{$I TEDREHEN.INC}
{$I TETPOINT.INC}



Begin ClrScr;
      {Musik_Ein;}
      Musik:=false;
      Init;
      GrundBild;
      Tetrisfeld;
      Copyright;
      Randomize;
      Repeat
            XElm:=5;YElm:=1;
            OldX:=5;OldY:=1;
            Nr:=1;
            ElementWaehlen(farbe);
            While Keypressed Do Dummy:=ReadKey;
            PunkteGeben;
            Repeat
                  SetFillStyle(solidfill,farbe);
                  TurnAl1:=Drehen(Xelm,Yelm+1);
                  TurnAl2:=Drehen(Oldx,Oldy+1);
                  ElementZeichnen(ElementName[Nr],Xelm,Yelm);
                  OldX:=XElm; OldY:=YElm;
                  Delay(600); Tastenabfrage;
                  If yelm<20 then
                  Begin SetFillStyle(solidfill,black);
                        ElementZeichnen(ElementName[Nr],OldX,OldY);
                  end;
                  Tetrisfeld; Tastenabfrage;
                  If (taste=' ') and (TurnAl1) and (TurnAl2) then
                     if (Nr>=1) and (nr<4)
                        then Inc(Nr)
                        else If Nr=4 then Nr:=1;
                  Taste:='0';
                  Inc(Yelm,1);
            Until Yelm>20;
            Inc(Points,Punkte);
      Until Ende;
      PutImage(340,300,Gameov^,0);
      Freemem(Gameov,GrGam);
      Repeat Until KeyPressed;
      Musik_Aus;
      CloseGraph;
End.











