Program MGCCDoctor;             {MGCCDOC.PAS}
Uses MyUtil, Crt, Graph, Dos, Mouse, MyObject;

Var HGrund                                                      : Hintergrund;
    Copyr, Frame, Menu                                          : Rahmen;
    Taste                                                       : Char;
    gd, gm, Status, Buttons, MaxX, MaxY                         : Integer;
    jh, Tg, Mt, Wtg, Col, Version, Std, Min, Sek, S100          : Word;
    DFree, DSize                                                : LongInt;
    Maus, ModName, GrName, SBlaster                             : String;


{$I MGCCCOPY.INC}
{$I MGCCEXAM.INC}
{$I MGCCRESU.INC}
{$I SIGNET.INC}

Begin Signet;
      DetectGraph(gd,gm);
      InitGraph(gd, gm, 'A:\');
      GrName:=GetDriverName;
      MaxX:=GetMaxX;
      MaxY:=GetMaxY;
      CloseGraph;
      ClrScr;
      HGrund.Init(1,1,80,25,'°');
      Copyr.Init(25,9,54,15,cyan,true);
      Frame.Init(1,2,80,24,blue,false);
      Menu.InitII(25,'MENU.DAT',blue,true);
      CopyRight;
      Examination;
      Resultat;
      TextColor(lightgray);
      TextBackGround(black);
      ClrScr;
End.