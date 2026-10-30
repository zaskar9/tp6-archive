PROGRAM Test;
USES CRT,GRAPH;

VAR Grafiktreiber, Grafikmodus, GRFehler : INTEGER;
    Pfad                                 : STRING;
    a,b                                  : REAL;
    v,w,x,y,s,I                          : INTEGER;
    Farbe, Hintergrund, Screen           : WORD;


BEGIN
   Farbe:=black;
   Hintergrund:=white;
   Screen:=black;
   ClrScr;
   Pfad:='C:\TP\BGI';
   Grafiktreiber:=detect;
   InitGraph(Grafiktreiber,Grafikmodus,Pfad);
   GRFehler:=Graphresult;
   IF GRFehler <> 0 THEN Halt;
   a:=90*PI/11500;b:=90*PI/11500;s:=0;
   SETCOLOR(Hintergrund);
   SETBKCOLOR(Screen);
   x:=240;y:=240;
   Repeat
         Rectangle(x,y,640-x,480-y);
         Dec(x,1);
         Dec(y,1);
         Delay(20);
   Until y<10;
   x:=x-1;y:=y-1;
   Repeat
         Rectangle(x,y,640-x,480-y);
         Dec(x,2);
         Dec(y,2);
         Delay(20);
   Until x<0;
   Delay(1000);
   SetColor(Farbe);
   REPEAT
        x:=ROUND(140+(100*sin(a)));
        y:=ROUND(320+(100*cos(a)));
        v:=ROUND(140+(65*sin(b)));
        w:=ROUND(320+(65*cos(b)));
        a:=a+PI/11500;b:=b+PI/11500;
        Line(y,x,w,v);
   UNTIL a>2*PI;
   SetColor(Hintergrund);
   Line(341,140,420,140);
   SetColor(Farbe);
   FOR I:=45 DOWNTO 0 DO
   BEGIN
        Line(342+I,142,342+I,170);
        Line(342+I,110,342+I,139);
        DELAY(100);
   END;
   FOR I:=0 TO 37 DO
   BEGIN
        PutPixel(300,42+I,Hintergrund);
        PutPixel(340,42+I,Hintergrund);
        PutPixel(299,42+I,Hintergrund);
        PutPixel(341,42+I,Hintergrund);
        DELAY(100);
   END;
   SETCOLOR(Farbe);
   FOR I:=0 TO 128 DO
   BEGIN
        Line(301,76+I,339,76+I);
        DELAY(100);
   End;
   FOR I:=1 TO 38 DO
   BEGIN
        PutPixel(300,200+I,Hintergrund);
        PutPixel(340,200+I,Hintergrund);
        PutPixel(299,200+I,Hintergrund);
        PutPixel(341,200+I,Hintergrund);
        DELAY(100);
   END;
   SETCOLOR(Farbe);
   SETTEXTSTYLE(1,0,0);
   SETTEXTJUSTIFY(1,1);
   OUTTEXTXY(320,300,'GROSSNIKLAUS');
   OUTTEXTXY(320,350,'INTERNATIONAL');
   OUTTEXTXY(320,400,'PICTURES');
   Repeat Until Keypressed;
   CloseGraph;
END.