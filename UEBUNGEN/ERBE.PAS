Program Vererbung;
Uses Crt;

Var Teil1, Teil2 : Integer;
    Krank, Gesund, halb : LongInt;
    I, Zahl : LongInt;
    Verhaltnis : Real;

Begin ClrScr;
      Randomize;
      Krank:=0;
      Gesund:=0;
      Halb:=0;
      I:=0;
      GotoXY(10,3); Write('Wieviel Durchl„ufe sollen gemacht werden: ');
      Readln(Zahl);
      If Zahl=0 then Zahl:=2147483640;
      GotoXY(10,9); Write('gesund');
      GotoXY(28,9); Write('gesunder Merkmalstr„ger');
      GotoXY(60,9); Write('krank');
      Repeat
            Teil1:=Random(2)+1;
            Teil2:=Random(2)+1;
            if Teil1=Teil2 then If Teil1=1 then Inc(Gesund)
                                           else Inc(Krank)
                           else Inc(Halb);
            GotoXY(10,10); Write(Gesund:5);
            GotoXY(30,10); Write(Halb:10);
            GotoXY(60,10); Write(Krank:5);
            GotoXY(10,12); Write('Verh„ltnis: ',(Gesund*2+Halb),' : ',(Krank*2+Halb));
            Verhaltnis:=(Gesund*2+Halb+1)/(Krank*2+Halb+1);
            GotoXY(10,13); Write('            ',Verhaltnis:1:15);
            GotoXY(30,5); Write('Anzahl: ',I+1:10);
            Inc(I);
      Until I>Zahl-1;
      GotoXY(1,25);
      Repeat Until Keypressed;
End.