Procedure Lizenz_Registrierung;
Var Rahmen                              : MessageBox;
    OkBut                               : OKButton;
    AbbrBut                             : DefButton;
    State,RegNr,Fehler,Xps,N            : Integer;
    Code,st                             : String;
    IO,Ex,Abbr,OkBooly,AbbrBooly        : Boolean;
Begin HideCursor;
      Rahmen.Init(140,100,500,300,HGrundCol,TitelCol,LineCol,ShadowCol,ConShad,TxtCol);
      OkBut.Init(210,265,'OK',ButtonCol,HGrundCol,TitelCol,LineCol,ShadowCol,ConShad,TxtCol);
      AbbrBut.Init(330,265,'Abbrechen',ButtonCol,HGrundCol,TitelCol,LineCol,ShadowCol,ConShad,TxtCol);
      Rahmen.BoxOpen('Registrierung');
      OKBut.MakeButton;
      AbbrBut.MakeButton;
      OutTextXY(320,140,'Um Composer 1.0 zu registrieren, und damit');
      OutTextXY(320,155,'rechtmÑssig zu lizenzieren, mÅssen Sie im');
      OutTextXY(320,170,'unten stehenden Feld die Seriennummer');
      OutTextXY(320,185,'(auf der Verpackung) eingeben');
      ShowCursor;
      SetColor(black);
      SetWriteMode(NormalPut);
      Repeat HideCursor;
             SetFillStyle(Solidfill,White);
             Bar(160,200,480,220);
             Rectangle(160,200,480,220);
             SetTextJustify(LeftText,CenterText);
             ShowCursor;
             N:=0;
             Repeat
                   If N=0 then begin XPs:=0;
                                     st:='';
                               end;
                   SetColor(txtCol);
                   MouseInTextXY(165,212,'',Code,38,Abbr,st,XPs);
                   XPs:=GetX-165-TextWidth(code); st:=Code;
                   OkBooly:=false; AbbrBooly:=false;
                   If AbbrBut.Onbutton then AbbrBooly:=true
                                       else if OkBut.OnButton then OkBooly:=true;
                   Inc(N);
             Until (AbbrBooly) or (OkBooly) or ((Code='') and (not Abbr)) or (Not Abbr);
             If Code='' then Ex:=true
                        else Ex:=false;
             Repeat Val(Code,RegNr,Fehler);
                    If Fehler<>0 then Delete(Code,Fehler,1);
             Until (Fehler=0) or (Code='');
             If (RegNr Mod 18=0) and (Fehler=0)
                then IO:=true
                else IO:=false;
             ShowCursor;
             If (IO=false) and (not ((Ex) or (AbbrBooly))) then ErrorMessage(3);
      Until (IO) or (Ex) or (AbbrBooly);
      Rahmen.BoxClose;
End;