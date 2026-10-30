program snd2cmp;
uses crt;

var ftext, fsound   : text;
    fname, Zeile, STon, SLaenge, TonName, OktName    : string;
    Fehler, Ton, Okt, Laenge, Posi : Integer;

{$I TONZUWEI.INC}

begin fname:='a:\newyear';
      clrscr;
      assign(ftext,fname+'.snd'); Reset(ftext);
      Assign(fsound,fname+'.cmp'); Rewrite(fsound);
      Repeat
            Readln(ftext,Zeile);
            Posi:=Pos('(',Zeile);
            Delete(Zeile,1,Posi);
            Posi:=Pos(')',Zeile);
            STon:=Copy(Zeile,1,Posi-1);
            Delete(Zeile,1,posi);
            Posi:=Pos('(',Zeile);
            Delete(Zeile,1,posi);
            Posi:=Pos(')',Zeile);
            SLaenge:=Copy(Zeile,1,Posi-1);
            Str2Ton(STon, TonName, Okt);
            Str(Okt,OktName);
            Val(SLaenge, Laenge, Fehler);
            Case Laenge of
            4000 : SLaenge:='G';
            3000 : SLaenge:='D';
            2000 : SLaenge:='H';
            1500 : SLaenge:='P';
            1000 : SLaenge:='V';
            0750 : Slaenge:='L';
            0500 : SLaenge:='A';
            0333 : SLaenge:='T';
            0250 : SLaenge:='S';
            0100 : SLaenge:='K';
            2500 : SLaenge:='U';
            END;
            Writeln(fsound,TonName,',',OktName,',',SLaenge);
      Until Eof(Ftext);
      Close(Fsound);
      Close(fText);
      Write('Umwandlung abgeschlossen !');
      Repeat until keypressed;
End.





