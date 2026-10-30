PROGRAM Geometrie;
USES CRT,GRAPH;

VAR Grafiktreiber, Grafikmodus, GRFehler, Ecke : INTEGER;
    Pfad : STRING;


PROCEDURE Dreieck(Ecke:INTEGER);
   BEGIN
        Line(Ecke,Ecke+100,Ecke+250,Ecke+200);
        Line(Ecke,Ecke+100,Ecke+150,Ecke-70);
        Line(Ecke+150,Ecke-70,Ecke+250,Ecke+200);
   END;
PROCEDURE Halbieren(x1,y1,x2,y2:INTEGER);
   VAR x,y :INTEGER;
   BEGIN
        X:= ROUND(x2-(x2-x1)/2);
        Y:= ROUND(y2-(y2-y1)/2);
        SETCOLOR(Yellow);
        Circle(x,y,2);
  END;
PROCEDURE Winkel(x1,y1,x2,y2,x3,y3:INTEGER);
  VAR Alfa,Beta,Delta,tan1,tan2 : REAL;
      a,b,c,d                   : INTEGER;
      Startwinkel,Endwinkel     : WORD;
  BEGIN
       a:=x3-(x3-x1);
       b:=y3-(y3-y1);
       c:=x3-x3+x2;{200}
       d:=y3-y3+y2;
       IF (b>0)AND(d>0) THEN BEGIN
                                  tan1:=b/a;
                                  tan2:=d/c;
                             END
                        ELSE Exit;
       Alfa:=Arctan(tan1)*(180/PI);
       Beta:=Arctan(tan2)*(180/PI);
       Delta:=180-Alfa-Beta;
       SETCOLOR(red);
       Startwinkel:=TRUNC(Alfa+(Delta/2));
       Endwinkel:=TRUNC(Beta+(Delta/2)+1);
       PieSlice(x3,y3,Startwinkel,Endwinkel,120);
       PieSlice(x3,y3,0,TRUNC(Beta),120);
       PieSlice(x3,y3,180,180-Trunc(Alfa),120);
       Circle(x3,y3,10);
  END;
PROCEDURE A(x,y:INTEGER);
    BEGIN
        PUTPIXEL(x+1,y+3,white);
        PUTPIXEL(x+1,y+4,white);
        PUTPIXEL(x+1,y+5,white);
        PUTPIXEL(x+1,y+6,white);
        PUTPIXEL(x+1,y+7,white);
        PUTPIXEL(x+1,y+8,white);
        PUTPIXEL(x+2,y+2,white);
        PUTPIXEL(x+2,y+9,white);
        PUTPIXEL(x+3,y+10,white);
        PUTPIXEL(x+3,y+1,white);
        PUTPIXEL(x+4,y+1,white);
        PUTPIXEL(x+4,y+10,white);
        PUTPIXEL(x+5,y+10,white);
        PUTPIXEL(x+5,y+1,white);
        PUTPIXEL(x+6,y+10,white);
        PUTPIXEL(x+6,y+1,white);
        PUTPIXEL(x+7,y+2,white);
        PUTPIXEL(x+7,y+8,white);
        PUTPIXEL(x+7,y+9,white);
        PUTPIXEL(x+8,y+3,white);
        PUTPIXEL(x+8,y+4,white);
        PUTPIXEL(x+8,y+5,white);
        PUTPIXEL(x+8,y+7,white);
        PUTPIXEL(x+9,y+5,white);
        PUTPIXEL(x+9,y+6,white);
        PUTPIXEL(x+9,y+7,white);
        PUTPIXEL(x+9,y+8,white);
        PUTPIXEL(x+9,y+9,white);
        PUTPIXEL(x+10,y+3,white);
        PUTPIXEL(x+10,y+4,white);
        PUTPIXEL(x+10,y+10,white);
        PUTPIXEL(x+11,y+1,white);
        PUTPIXEL(x+11,y+2,white);
        PUTPIXEL(x+11,y+10,white);
        PUTPIXEL(x+12,y+1,white);
        PUTPIXEL(x+12,y+8,white);
        PUTPIXEL(x+12,y+9,white);
        PUTPIXEL(x+13,y+6,white);
        PUTPIXEL(x+13,y+7,white);
        PUTPIXEL(x+13,y+8,white);
   END;
PROCEDURE B(x,y:INTEGER);
   BEGIN
        SETCOLOR(white);
        Line(x+1,y+20,x+1,y+17);
        Line(x+2,y+16,x+2,y+8);
        Line(x+3,y+7,x+3,y+2);
        Line(x+4,y+1,x+7,y+1);
        Line(x+8,y+2,x+8,y+5);
        PutPixel(x+7,y+6,white);
        Line(x+5,y+7,x+7,y+7);
        PutPixel(x+8,y+8,white);
        Line(x+9,y+9,x+9,y+11);
        PutPixel(x+8,y+12,white);
        Line(x+4,y+13,x+7,y+13);
   END;
PROCEDURE C(x,y:INTEGER);
    BEGIN
         PutPixel(x+1,y+2,white);
         Line(x+1,y+1,x+2,y+1);
         Line(x+3,y+2,x+3,y+3);
         Line(x+4,y+4,x+4,y+5);
         Line(x+5,y+6,x+5,y+8);
         Line(x+6,y+6,x+6,y+8);
         Line(x+4,y+9,x+4,y+16);
         Line(x+7,y+9,x+7,y+16);
         Line(x+5,y+17,x+6,y+17);
         Line(x+9,y+2,x+10,y+2);
         Line(x+8,y+3,x+8,y+4);
         PutPixel(x+7,y+5,white);
    END;
BEGIN
   ClrScr;
   Pfad:='C:\TP\BGI';
   Grafiktreiber:=detect;
   InitGraph(Grafiktreiber,Grafikmodus,Pfad);
   GRFehler:=Graphresult;
   IF GRFehler <> 0 THEN Halt;
   Dreieck(100);
   Ecke:=100;
   Halbieren(250,30,350,300);
   Halbieren(Ecke,Ecke+100,Ecke+250,Ecke+200);
   Halbieren(Ecke,Ecke+100,Ecke+150,Ecke-70);
   A(240,40);B(110,190);C(330,275);
   Repeat Until Keypressed;
   CloseGraph;
END.