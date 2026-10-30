Program Test;
Uses Crt, Graph;

Var I, J, K, gd, gm       : INTEGER;

Begin
     I:=0;
     J:=0;
     K:=-35;
     ClrScr;
     DetectGraph(gd, gm);
     InitGraph(gd, gm, 'C:\tp\BGI');
     SetColor(white);
     SetTextStyle(5,0,0);
     Repeat
           OutTextXY(K,I+10,Chr(J));
           Inc(J);
           Inc(I,30);
           DELAY(100);
           IF I>410 THEN Begin
                             I:=0;
                             Inc(K,35);
                        EnD;
     Until J>255;
     Repeat Until Keypressed;
End.
