Program SchriftTest;

Uses crt, graph;

type schrift=RECORD
            str:STRING;
            x:INTEGER;
            Minus:INTEGER;
end;

Var gd, gm, I, z                : Integer;
    Texte                       : array[1..100]of schrift;

begin
     DetectGraph(gd,gm);
     InitGraph(gd,gm,'c:\tp\bgi');
     texte[1].str:='JURASSIC';
     texte[2].str:='  PARK  ';
     texte[1].x:=50;
     texte[2].x:=50;
     texte[1].minus:=100;
     texte[2].minus:=0;
     SetWriteMode(XORPut);
     SetTextStyle(3,0,0);
     I:=-135;
     Repeat
           For Z:=1 TO 2 DO OutTextXY(texte[z].x,10+(I)-texte[z].minus,texte[z].str);
           Delay(1);
           For z:=1 TO 2 do OutTextXY(texte[z].x,10+(I)-texte[z].minus,texte[z].str);
           Inc(I,2);
           IF I>520 then I:=-135;
     Until KeyPressed;
     CloseGraph;
End.
