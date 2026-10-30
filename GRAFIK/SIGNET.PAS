PROGRAM Signet;
USES CRT, GRAPH;

VAR Grafiktreiber, Grafikmodus, GRFehler, x, y, n, n2 : INTEGER;
    Pfad : STRING;
    a    : REAL;

BEGIN
   ClrScr;
   Pfad:='C:\TP\BGI';
   Grafiktreiber:=detect;
   InitGraph(Grafiktreiber,Grafikmodus,Pfad);
   GRFehler:=Graphresult;
   IF GRFehler <> 0 THEN Halt;
   n:=-320;
   n2:=000;
   SETBKCOLOR(white);
   Bar(0,221,640,299);
   SETCOLOR(lightgray);
   Line(0,220,640,220);
   Line(000,300,640,300);
   REPEAT
        Line(n,480,n2,300);
        n:=n+64;
        n2:=32+n2;
   UNTIL n>960;
   n:=10;
   REPEAT
      a:=0;
      REPEAT
        x:=ROUND(n*cos(a));
        y:=ROUND(n*sin(a));
        PutPixel(320+x,219-y,blue);
        a:=a+PI/360;
        Delay(0);
      UNTIL a>PI;
      n:=n+3;
   UNTIL n>200;
   REPEAT UNTIL KEYPRESSED;
   CloseGraph;
END.