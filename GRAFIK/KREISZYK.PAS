PROGRAM Kreiszykloide;
USES CRT,GRAPH;

VAR Graphiktreiber, Graphikmodus, GRFehler,a,b : INTEGER;
    Pfad                                       : STRING;
    w,x,y,r,c,t                                : REAL;
BEGIN
   ClrScr;
   Pfad:='C:\TP\BGI';
   Graphiktreiber:=detect;
   InitGraph(Graphiktreiber,Graphikmodus,Pfad);
   GRFehler:=Graphresult;
   IF GRFehler <> 0 THEN Halt;
   w:=0;
   r:=1;
   c:=1;
   t:=0;
   Line(0,240,640,240);Line(320,0,320,480);
   REPEAT
        x:=((15*cos(w))*10);
        y:=((15*sin(w))*10);
        a:=ROUND(320+x);
        b:=ROUND(240-y);
        PUTPIXEL(a,b,white);
        w:=w+PI/360;
   UNTIL w>2*PI;
   REPEAT UNTIL KEYPRESSED;
   CloseGraph;
END.