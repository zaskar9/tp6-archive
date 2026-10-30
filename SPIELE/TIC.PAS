Program TicTacToe;
Uses Crt,Graph,MyUtil,Dos;

Var SpielBrettSpieler, SpBrCo1, SaveSpielBr            : Array[1..3,1..3] of Byte;
    SpielBrettStatus, SpBrSt1, SaveBrettStat           : Array[1..3,1..3] of Boolean;
    Spieler                                            : Array[1..2] of String;
    SpielerNr, Zug, Nr,FeldX,FeldY,But,x,y,RekursionNr : Integer;
    ComputerModus, ZugIO, NewMode                      : Boolean;
    Taste,Resp                                         : Char;
    ComptoComp                                         : Boolean;
    AnzSpiele                                          : Integer;
    Pl                                                 : Array[1..2] of Integer;

Procedure ShadowBar(x1,y1,x2,y2 : Integer; Col1,Col2 : Word);
Begin SetFillStyle(SolidFill,Col2);
      Bar(x1+10,y1+10,x2+15,y2+15);
      SetFillStyle(SolidFill,Col1);
      Bar(x1,y1,x2,y2);
end;

Procedure Screen;
Begin SetFillStyle(Solidfill,white);
      bar(0,0,640,480);
      SetColor(black);
      Rectangle(3,3,636,476);
End;

Procedure SpielFeld;
Var I : Integer;
begin Shadowbar(48,48,322,322,Lightgray,black);
      SetColor(white);
      Rectangle(50,50,320,320);
      For I:=1 to 270 do
          if I mod 90=0 then
             begin Line(I+50,50,I+50,320);
                   Line(50,I+50,320,I+50);
             end;
end;

Procedure Init;
Var I,J : Integer;
Begin For I:=1 to 3 do
          for J:=1 to 3 do
              begin SpielBrettSpieler[I,J]:=0;
                    SpielBrettStatus[I,J]:=false;
              end;
      SpielerNr:=1;
      SetLineStyle(SolidLn,0,NormWidth);
      Zug:=0;
      SetHorizontalLimits(0,GetMaxX);
      SetVerticalLimits(0,GetMaxY);
      Randomize;
end;

Procedure Spieler_Eingabe;
Var Wahl : Integer;
Begin SetTextJustify(LeftText,TopText);
      Repeat ShadowBar(370,48,600,148,red,black);
             SetColor(white);
             SetTextStyle(0,0,0);
             OutTextXY(380,60,'Willkommen zu TicTacToe');
             OutTextXY(380,80,'1. Spieler/Spieler');
             OutTextXY(380,95,'2. Computer/Spieler');
             InIntXY(380,115,'Ihre Wahl: ',Wahl);
      Until (Wahl=1) or (Wahl=2) or (Wahl=3);
      If (Wahl=2) or (wahl=3) then ComputerModus:=True
                              else ComputerModus:=False;
      If Wahl=3 then ComptoComp:=true
                else ComptoComp:=false;
      ShadowBar(370,148,600,238,red,black);
      OutTextXY(380,160,'Eingabe der Spieler');
      If not ComptoComp
         then begin If ComputerModus
                       then begin OutTextXY(380,180,'Spieler 1: Computer');
                                  Spieler[1]:='Computer';
                            end
                       else InTextXY(380,180,'Spieler 1: ',Spieler[1],10);
                    InTextXY(380,200,'Spieler 2: ',Spieler[2],10);
              end
         else begin Spieler[1]:='Computer #1';
                    Spieler[2]:='Computer #2';
              end;
      Delay(200);
      SetFillStyle(SolidFill,white);
      Bar(370,48,620,260);
End;

Procedure Spieler_Ausgabe(Nummer:Integer);
Var OutStrTxt : String;
Begin ShadowBar(370,250,600,300,lightblue,black);
      SetTextJustify(CenterText,TopText);
      SetColor(white);
      if Spieler[Nummer]='Computer' then OutStrTxt:='Der Computer'
                                    else OutStrTxt:=Spieler[Nummer];
      OutTextXY(485,270,OutStrTxt+' ist am Zug');
End;

Procedure Sieger_Ausgabe(Nummer:Integer);
Var OutStrTxt : String;
Begin HideCursor;
      if Nummer=1 then Nummer:=2
                  else if Nummer=2 then Nummer:=1;
      ShadowBar(360,48,610,100,green,black);
      SetColor(white);
      SetTextJustify(CenterText,TopText);
      if Spieler[Nummer]='Computer' then OutStrTxt:='Der Computer'
                                    else OutStrTxt:=Spieler[Nummer];
      If Nummer>2 then begin OutTextXY(485,70,'Das Spiel ist unentschieden.');
                             Inc(Pl[1]); Inc(Pl[2]);
                       end
                  else begin OutTextXY(485,70,OutStrTxt+' hat gewonnen.');
                             Inc(Pl[Nummer],2);
                       end;
      ShowCursor;
End;

Procedure Spieler_Frage(Var Antw: Char);
Begin HideCursor;
      ShadowBar(170,350,470,400,cyan,black);
      SetColor(white);
      SetTextJustify(CenterText,TopText);
      OutTextXY(320,370,'Wollen Sie nochmals spielen (J/N)?');
      Repeat Taste:=Upcase(ReadKey);
      Until (Taste='N') or (Taste='J');
      Antw:=Taste;
      ShowCursor;
End;

Function Neuer_Modus : Boolean;
Begin HideCursor;
      ShadowBar(170,400,470,420,cyan,black);
      SetColor(white);
      SetTextJustify(CenterText,TopText);
      OutTextXY(320,390,'Spieler wechseln (J/N)?');
      Repeat Taste:=Upcase(ReadKey);
      Until (Taste='N') or (Taste='J');
      If Taste='J' then begin Neuer_Modus:=true;
                              AnzSpiele:=0;
                        end
                   else Neuer_Modus:=false;
End;

Procedure Out_Stand;
Var Pkt1, Pkt2 : String;
Begin HideCursor;
      ShadowBar(370,150,600,200,blue,black);
      SetTextJustify(CenterText,TopText);
      SetColor(white);
      Str(Pl[1],Pkt1); Str(Pl[2],Pkt2);
      OutTextXY(485,162,'Spieler #1: '+Pkt1);
      OutTextXY(485,182,'Spieler #2: '+Pkt2);
      ShowCursor;
End;

Procedure Cross(a,b : Integer);
Begin Line(a-40,b-40,a+40,b+40);
      Line(a-40,b+40,a+40,b-40);
end;

Function Gewonnen(Var Nummer: Integer):Boolean;
Var WinBooly : Array[0..4]of Boolean;
    I,J : Integer;
Begin WinBooly[0]:=False;
      I:=1;
      Repeat J:=1;
             Repeat If ((SpielBrettSpieler[1,I]=J) and (SpielBrettSpieler[2,I]=J) and (SpielBrettSpieler[3,I]=J))
                       then WinBooly[1]:=true
                       else WinBooly[1]:=false;
                    If ((SpielBrettSpieler[I,1]=J) and (SpielBrettSpieler[I,2]=J) and (SpielBrettSpieler[I,3]=J))
                       then WinBooly[2]:=true
                       else WinBooly[2]:=false;
                    If ((SpielBrettSpieler[1,1]=J) and (SpielBrettSpieler[2,2]=J) and (SpielBrettSpieler[3,3]=J))
                       then WinBooly[3]:=true
                       else WinBooly[3]:=false;
                    If ((SpielBrettSpieler[1,3]=J) and (SpielBrettSpieler[2,2]=J) and (SpielBrettSpieler[3,1]=J))
                       then WinBooly[4]:=true
                       else WinBooly[4]:=false;
                    If (WinBooly[1]) or (WinBooly[2]) or (WinBooly[3]) or  (WinBooly[4])
                       then begin WinBooly[0]:=true;
                                  Nummer:=J;
                            end
                       else WinBooly[0]:=false;
                    Inc(J);
             Until (WinBooly[0]) or (J>=3);
             Inc(I);
      Until (I>=4) or (WinBooly[0]);
      Gewonnen:=WinBooly[0];
End;

Procedure ComputerZug(Var x,y : Integer);
Var a,b,c,d,Nr,WinNr, LoseNr : Integer;
    Stop       : Boolean;
Begin ZugIO:=False;
      If Spieler[1]='Computer'
         then begin WinNr:=1;
                    LoseNr:=2;
              end
         else begin WinNr:=2;
                    LoseNr:=1;
              end;
      Inc(RekursionNr);
      SaveSpielBr:=SpielBrettSpieler;
      SaveBrettStat:=SpielBrettStatus;
      a:=1;
      Repeat b:=1;
             Repeat If SpielBrettStatus[a,b]=false then
                       begin SpielBrettStatus[a,b]:=true;
                             SpielBrettSpieler[a,b]:=WinNr;
                             if Gewonnen(Nr)
                                then begin if Nr=WinNr
                                              then begin ZugIO:=true;
                                                         x:=a;
                                                         y:=b;
                                                   end;
                                     end;
                             SpielBrettStatus:=SaveBrettStat;
                             SpielBrettSpieler:=SaveSpielBr;
                       end;
                    Inc(b);
             Until (ZugIO) or (b>=4);
             Inc(a);
      Until (ZugIO) or (a>=4);
      if ZugIO=false then
         begin a:=1;
               Repeat b:=1;
                      Repeat If SpielBrettStatus[a,b]=false then
                                begin SpielBrettStatus[a,b]:=true;
                                      SpielBrettSpieler[a,b]:=LoseNr;
                                      if Gewonnen(Nr)
                                         then begin if Nr=LoseNr
                                                       then begin ZugIO:=true;
                                                                  x:=a;
                                                                  y:=b;
                                                            end;
                                              end;
                                      SpielBrettStatus:=SaveBrettStat;
                                      SpielBrettSpieler:=SaveSpielBr;
                                end;
                             Inc(b);
                      Until (ZugIO) or (b>=4);
                      Inc(a);
               Until (ZugIO) or (a>=4);
         end;
      if ZugIO=false then
         begin a:=1;
               Repeat b:=1;
                      Repeat SpielbrettSpieler[a,b]:=WinNr;
                             SpBrCo1:=SpielBrettSpieler;
                             SpBrSt1:=SpielBrettStatus;
                             c:=1;
                             Repeat d:=1;
                                    Repeat If SpielBrettStatus[c,d]=false then
                                              begin SpielBrettStatus[c,d]:=true;
                                                    SpielBrettSpieler[c,d]:=LoseNr;
                                                    if Gewonnen(Nr) then if Nr=LoseNr
                                                       then ZugIO:=false;
                                                    SpielBrettStatus:=SpBrSt1;
                                                    SpielBrettSpieler:=SpBrCo1;
                                              end;
                                              Inc(d);
                                    Until (ZugIO) or (d>=4);
                                    Inc(c);
                             Until (ZugIO) or (c>=4);
                             SpielBrettSpieler:=SaveSpielBr;
                             SpielBrettStatus:=SaveBrettStat;
                             Inc(b);
                      Until (ZugIO) or(b>=4);
                      Inc(a);
               Until (ZugIO) or (a>=4);
         end;
      If (ZugIO=false) then
         begin repeat x:=Random(3)+1;
                      y:=random(3)+1;
               until SpielBrettStatus[x,y]=false;
         end;
end;

Procedure Zug_Ausfuehren;
Var x,y,Button,a,b : Integer;
    IOZug : Boolean;
Begin IOZug:=False;
      FeldX:=0; FeldY:=0;
      Repeat GetPosBut(Button,x,y);
      Until Button=0;
      Repeat if ((ComputerModus=false) or (SpielerNr=2)) and (not ComptoComp) then
                begin ShowCursor;
                      Repeat GetPosBut(Button,x,y);
                      Until (Button=1);
                      x:=x-50; y:=y-50;
                      If ((x>0) and (x<270)) and ((y>0) and (y<270))
                         then begin Case x of
                                      0..90  : FeldX:=1;
                                     91..180 : FeldX:=2;
                                    181..270 : FeldX:=3;
                                    end;
                                    Case y of
                                      0..90  : FeldY:=1;
                                     91..180 : FeldY:=2;
                                    181..270 : FeldY:=3;
                                    end;
                              end
                         else IOZug:=False;
                end;
                if ((ComputerModus) and (SpielerNr=1)) or (ComptoComp)
                   then begin RekursionNr:=0;
                              ComputerZug(FeldX,FeldY);
                        end;
                if (not SpielBrettStatus[FeldX,FeldY]) and ((FeldX<>0) and (FeldY<>0))
                   then begin IOZug:=true;
                              a:=5+(FeldX*90);
                              b:=5+(FeldY*90);
                              HideCursor;
                              SetLineStyle(SolidLn,0,ThickWidth);
                              if SpielerNr=1 then Cross(a,b);
                              if SpielerNr=2 then Circle(a,b,40);
                              ShowCursor;
                              SpielBrettStatus[FeldX,FeldY]:=true;
                              SpielBrettSpieler[FeldX,FeldY]:=SpielerNr;
                        end
                   else IOZug:=False;
      Until IOZug;
      Inc(Zug);
end;

Begin Graphik_Ein('C:\TP\BGI');
      NewMode:=true;
      AnzSpiele:=0;
      Pl[1]:=0;
      Pl[2]:=0;
      Repeat Init;
             Screen;
             SpielFeld;
             if NewMode then Spieler_Eingabe;
             SpielerNr:=Random(5)+1;
             If SpielerNr<=3 then SpielerNr:=1
                             else SpielerNr:=2;
             Out_Stand;
             Repeat Spieler_Ausgabe(SpielerNr);
                    Zug_Ausfuehren;
                    if not ComptoComp then
                       If SpielerNr=1 then Sound(440)
                                      else Sound(660);
                    Delay(100);
                    NoSound;
                    If SpielerNr=1 then SpielerNr:=2
                                   else SpielerNr:=1;
             Until (Gewonnen(Nr)) or (Zug>8);
             if (Zug>8) and (not Gewonnen(nr)) then SpielerNr:=5;
             Repeat GetPosBut(But,x,y);
             Until But=0;
             Sieger_Ausgabe(SpielerNr);
             Delay(1500);
             if not ComptoComp then Spieler_Frage(Resp);
             Inc(AnzSpiele);
             If (Resp='J') and (not ComptoComp) then NewMode:=Neuer_Modus;
             If ComptoComp then NewMode:=false;
      Until (Resp='N') or ((CompToComp) and (AnzSpiele>30));
      Graphik_Aus;
End.