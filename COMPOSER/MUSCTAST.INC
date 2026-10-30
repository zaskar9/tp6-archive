Procedure MouseInTextXY(xi,yi:Integer;Tx:String;VAR s:String;
                        Anz:Word;Var Outing:Boolean;sBeg:string;xPos:Integer);
Const Enter=#13;
Var ch : Char;
    farbe,txtfarbe : Word;
    xcur,sta : integer;
    chstr : String;
    Booly : Boolean;
Begin s:=sBeg;
      xi:=xi+xPos;
      Farbe:=GetPixel(xi,yi);
      txtfarbe:=GetColor;
      Booly:=false;
      OutTextXY(xi,yi,Tx);
      OutTextXY(xi+TextWidth(Tx),yi,s);
      MoveTo(xi+TextWidth(Tx)+TextWidth(s),yi);
      Repeat If not Keypressed then
                Begin xcur:=getX;
                      HideCursor;
                      OutTextXY(xcur,Yi,'_');
                      ShowCursor;
                      Repeat Booly:=MouseClick;
                      Until (Keypressed) or (Booly);
                      SetColor(Farbe);
                      HideCursor;
                      OutTextXY(xcur,Yi,'_');
                      ShowCursor;
                end;
             if not Booly then
                begin HideCursor;
                      SetColor(txtfarbe);
                      ch:=ReadKey;
                      if ch=#8 then
                         begin SetColor(farbe);
                               chstr:=COPY(s,Length(s),1);
                               OutTextXY(GetX-Textwidth(chstr),GetY,chstr);
                               Delete(s,Length(s),1);
                               SetColor(txtfarbe);
                               If (GetX-Textwidth(chstr))>=(Xi+TextWidth(Tx))
                                  then MoveTo(getX-Textwidth(chstr),getY);
                         end;
                      if (ch in[' '..'þ']) and (Length(s)<Anz)
                         then begin OutText(ch);
                                    s:=s+ch;
                              End;
                      ShowCursor;
                end;
      Until (ch=Enter) or (Booly);
      MoveTo(xi+TextWidth(Tx)+TextWidth(s),yi);
      If Booly then Outing:=true
               else Outing:=false;
End;