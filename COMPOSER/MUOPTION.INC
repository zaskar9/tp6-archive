Procedure Optionen_Farben;
Var Rahmen : MessageBox;
    AbbBut : DefButton;
    OkBut : OkButton;
    I,State,Code,XPs,N : Integer;
    Farbe,Zahl,st : string;
    NeuFarb,AltFarb : Array[1..10] of Integer;
    T : Char;
    AbbrBooly,OkBooly,Abbr,AllCol : Boolean;

begin HideCursor;
      Rahmen.Init(100,100,540,300,HGrundCol,TitelCol,LineCol,ShadowCol,ConShad,TxtCol);
      AbbBut.Init(430,160,'Abbrechen',ButtonCol,HGrundCol,TitelCol,LineCol,ShadowCol,ConShad,TxtCol);
      OkBut.Init(430,130,'OK',ButtonCol,HGrundCol,TitelCol,LineCol,ShadowCol,ConShad,TxtCol);
      Rahmen.BoxOpen('Farbauswahl');
      AbbBut.MakeButton; OkBut.MakeButton;
      SetColor(LineCol);
      Rectangle(110,130,414,155);
      rectangle(110,155,414,167);
      For I:=1 to 15 do line(110+I*19,130,110+19*I,167);
      I:=0;
      SetColor(txtCol);
      SetTextStyle(0,0,0);
      SetTextJustify(CenterText,CenterText);
      Repeat
            SetFillstyle(Solidfill,I);
            Floodfill(115+I*19,135,linecol);
            Str(I,Zahl);
            OutTextXY(119+I*19,162,Zahl);
            Inc(I);
      Until I>15;
      SetTextJustify(LeftText,Centertext);
      OutTextXY(330,260,'Nummer der Farbe eingeben,');
      OutTextXY(330,270,'Leereingabe bernimmt');
      OutTextXY(330,280,'Standardwert.');
      Altfarb[8]:=ButtonCol;
      Altfarb[3]:=MenuMark;
      Altfarb[5]:=ItemCol;
      Altfarb[4]:=MenuCol;
      Altfarb[2]:=HGrundCol;
      Altfarb[1]:=TitelCol;
      Altfarb[7]:=LineCol;
      Altfarb[9]:=ShadowCol;
      Altfarb[10]:=ConShad;
      Altfarb[6]:=TxtCol;
      OutTextXY(110,190,'Titel           :');
      OutTextXY(110,200,'Hintegrund      :');
      OutTextXY(110,210,'PopUpGrund      :');
      OutTextXY(110,220,'Hervorhebung    :');
      OutTextXY(110,230,'Itemfarbe       :');
      OutTextXY(110,240,'Textfarbe       :');
      OutTextXY(110,250,'Linien          :');
      OutTextXY(110,260,'Schaltfl„che    :');
      OutTextXY(110,270,'unterer Schatten:');
      OutTextXY(110,280,'oberer Schatten :');
      I:=0;
      N:=0;
      Farbe:='';
      Repeat
            Repeat
                  If N=0 then begin st:='';
                                    XPs:=0;
                              end;
                  SetFillStyle(SolidFill,HGrundCol);
                  SetTextJustify(LeftText,Centertext);
                  bar(250,185+(I*10),320,190+((I+1)*10));
                  SetColor(TxtCol);
                  ShowCursor;
                  MouseInTextXY(250,190+(I*10),'',Farbe,4,Abbr,st,xPs);
                  XPs:=GetX-250-TextWidth(Farbe);
                  St:=Farbe;
                  Inc(N);
                  OkBooly:=false; AbbrBooly:=false;
                  If AbbBut.Onbutton then AbbrBooly:=true
                                     else if OkBut.OnButton then OkBooly:=true;
                  HideCursor;
                  Code:=0;
                  If Farbe='' then Neufarb[I+1]:=AltFarb[I+1]
                              else Val(Farbe, Neufarb[I+1], Code);
                  If Abbr then Code:=0;
            Until (Code=0) or (Abbr);
            If I=3 then Neufarb[I+1]:=Abs(NeuFarb[I+1]-15);
            If not Abbr then Inc(I);
            Delay(250);
            if not Abbr then st:='';
      Until (I>9)or((OkBooly)or(AbbrBooly));
      ShowCursor;
      AllCol:=false;
      Repeat
            If Keypressed then T:=readKey
                          else T:='*';
            If I>9 then
               begin OkBooly:=false; AbbrBooly:=false; AllCol:=true;
                     If AbbBut.Onbutton then AbbrBooly:=true
                                        else if OkBut.OnButton then OkBooly:=true;
            end;
      Until ((OkBooly) or (AbbrBooly)) or ((t=' ') or (T=#27) or (t=#13));
      if (AllCol)and((OkBooly) or (t=#13)) then
         begin ButtonCol:=Neufarb[8];
               MenuMark:=Neufarb[3];
               ItemCol:=Neufarb[5];
               Menucol:=Neufarb[4];
               HGrundCol:=Neufarb[2];
               TitelCol:=Neufarb[1];
               LineCol:=Neufarb[7];
               ShadowCol:=Neufarb[9];
               ConShad:=Neufarb[10];
               TxtCol:=Neufarb[6];

         end;
      Rahmen.BoxClose;
      If (OkBooly) or (t=' ') then
         begin Bildaufbau;
         end;
End;

Procedure Optionen_Statuszeile;
Begin If MCodeline=true then MCodeline:=false
                        else MCodeline:=true;
      if MCodeLine=False then OutMessage('Composer 1.0');
End;