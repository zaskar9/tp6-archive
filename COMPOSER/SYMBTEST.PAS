Program TestSymbols;
Uses Crt,Graph,Myutil;

Const Fk=7;

Var J,I,Col : Integer;

{$I MUSYMBOL.INC}

Begin Graphik_Ein('');
      SetFillStyle(SolidFill,White);
      bar(1,1,639,479);
      B_Schluessel(0,0);
      Violinschluessel(0,16);
      BassSchluessel(0,32);
      For I:=1 to 16 do
          for J:=1 to 48 do
              begin Col:=GetPixel(I,J);
                    SetFillstyle(SolidFill,Col);
                    bar(100+I*fk,50+J*fk,100+(I+1)*fk,50+(J+1)*fk);
              End;
      Repeat Until Keypressed;
      Graphik_Aus;
End.