Program FarbTest;
Uses Crt, Graph;

Var Farbe : Word;
    gd, gm, I, x : Integer;

Begin DetectGraph(gd, gm);
      InitGraph(gd, gm, '');
      Farbe:=0;
      SetFillStyle(1, white);
      bar(0,0,639,479);
      SetWriteMode(XorPut);
      x:=0;
      Repeat
            SetColor(Farbe);
            For I:=x to x+40 do Line(I,1,I,41);
            Inc(Farbe);
            Inc(x,41);
      Until Farbe>15;
      Repeat Until Keypressed;
end.
