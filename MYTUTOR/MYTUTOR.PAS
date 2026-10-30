Program MyUtil_Tutor;
Uses Crt,Graph,MyUtil,MenuObj;

Var Taste : Char;
    HGrund : Hintergrund;
    Menu,Hgr : Rahmen;
    Choice : Integer;

Procedure Titel;
Var gd,gm : Integer;
    Bild : TPCXBild;
Begin DetectGraph(gd,gm);
      InitGraph(gd,gm,'c:\tp\bgi');
      Bild.FName:='myutil.prw';
      PreparePCX(Bild);
      VGA_Aus;
      ShowPCX(160,120,Bild);
      DisposePCX(Bild);
      VGA_Ein;
      Repeat Until Keypressed;
      While Keypressed do Taste:=ReadKey;
      CloseGraph;
End;

Procedure Init;
Begin HGrund.Init(1,1,80,25,'∞');
      Menu.Init(20,10,41,15,'MYUTIL.MEN',blue,red,white,true);
      Hgr.Init(1,2,80,24,'MYUTIL.MEN',blue,red,white,false);
End;

Procedure Screen;
Begin HGrund.Draw(blue);
      GotoXY(2,1); Write('MyUtil Tutor 1.0');
      GotoXY(3,25);Write('Copyright by Michael Grossniklaus, 1994');
End;

Procedure DoMenu(Var Wahl:Integer);
Begin Menu.Draw(blue);
      Wahl:=Menu.Lightbar(Lightgray,black,1);
End;

Procedure TextOnScr(Datei:String);
Var Daten : Text;
    Txt   : String;
    I : Integer;
Begin Hgr.Draw(white);
      Assign(Daten,Datei);
      Reset(Daten);
      I:=3;
      TextColor(white);
      While Not Eof(Daten) Do
            begin Readln(Daten,Txt);
                  GotoXY(3,I); Write(Txt);
                  Inc(I);
            End;
      Close(Daten);
End;

Procedure PressKey;
Begin TextColor(yellow);
      GotoXY(60,24); Write(Chr(17)+' Taste drÅcken '+Chr(16));
      GotoXY(1,25);
      Taste:=ReadKey;
End;

Procedure TurnPg(Min,Max : Integer; Head : String);
Var Seite : Integer;
    Nr,Titel : String;
    NewScr : Boolean;
Begin Seite:=Min;
      NewScr:=true;
      Repeat Str(Seite,Nr);
             Titel:=Head+Nr+'.DAT';
             If NewScr then TextOnScr(Titel);
             TextColor(yellow);
             GotoXY(41,24); Write(Chr(17)+' '+Chr(27)+' vorwÑrts ≥ '+Chr(26)+' zurÅck ≥ ESC Ende '+Chr(16));
             GotoXY(1,25);
             Taste:=ReadKey;
             If Taste=#0 then Taste:=ReadKey;
             Case Taste of
        {Left}   #75 : Begin Inc(Seite);
                             NewScr:=true;
                       End;
        {Right}  #77 : Begin Dec(Seite);
                             NewScr:=true;
                       End;
                  Else NewScr:=False;
             End;
             If Seite<Min then begin Seite:=Min;
                                     NewScr:=false;
                               end;
             If Seite>Max then begin Seite:=Max;
                                     NewScr:=False;
                               end;
             Delay(250);
      Until Taste=#27;
End;

Procedure GraphModul;
Begin TextOnScr('THEMA1_1.DAT');
      PressKey;
      TurnPg(2,5,'THEMA1_');
End;

Procedure MouseModul;
Begin TextOnScr('THEMA2_1.DAT');
      PressKey;
End;

Procedure PCXModul;
Begin TextOnScr('THEMA3_1.DAT');
      PressKey;
End;

Begin ClrScr;
      Init;
      Titel;
      Repeat
            Screen;
            DoMenu(Choice);
            Case Choice of
            1 : GraphModul;
            2 : MouseModul;
            3 : PCXModul;
            End;
      Until (Choice=4) or (Choice=0);
      TextBackGround(black);
      TextColor(lightgray);
      ClrScr;
End.