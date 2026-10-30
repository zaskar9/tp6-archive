Procedure Init;
Var I, R : Integer;
Begin For I:= 1 to 10 Do
          For R:=1 to 15 Do
              Spielfeld[I,R]:=False;
      For I:=1 to 15 do
          Begin Spielfeld[0,I]:=true;
                Spielfeld[11,I]:=true;
          end;
      GetIntVec($8,Addr(IntSave));
      W[1]:=('11122122');W[2]:=('11122122');W[3]:=('11122122');W[4]:=('11122122');
      Z[1]:=('13122221');Z[2]:=('11212232');Z[3]:=('13122221');Z[4]:=('11212232');
      S[1]:=('11122223');S[2]:=('21311222');S[3]:=('11122223');S[4]:=('21311222');
      B[1]:=('21311141');B[2]:=('12131114');B[3]:=('21311141');B[4]:=('12131114');
      T[1]:=('11122213');T[2]:=('11213122');T[3]:=('21221223');T[4]:=('21122232');
      L[1]:=('11121323');L[2]:=('11213112');L[3]:=('11212223');L[4]:=('12223132');
      J[1]:=('21221323');J[2]:=('11122232');J[3]:=('11211213');J[4]:=('11213132');
      Tl:=0; MI:=0; Ende:=false;
      Points:=0; Lines:=0; Level:=1;
      XChangeLeft:=true; XChangeRight:=true;
      DetectGraph(gd, gm);
      InitGraph(gd, gm, 'C:\TP\BGI');
      ReadGraphFile('KUPPEL.PRW',Kuppel,GrKup);
      ReadGraphFile('TETRIS.PRW',Tetris,GrTet);
      ReadGraphFile('SCORE.PRW', Score, GrSco);
      ReadGraphFile('GAMEOVER.PRW', Gameov, GrGam);
      ReadGraphFile('COPY.PRW', Copyr, GrCopy);
end;

