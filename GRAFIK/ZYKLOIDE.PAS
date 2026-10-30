PROGRAM Zykloide;
USES CRT,GRAPH;

VAR Graphiktreiber, Graphikmodus, GRFehler,x2,y2,I : INTEGER;
    x1,y1,r,a,t,c,d : REAL;
    Taste : CHAR;
    Pfad : STRING[30];
PROCEDURE Koordinaten;
   BEGIN
       Line(0,240,600,240);
       Line(50,0,50,480);
       Line(113,245,113,235);
       Line(176,245,176,235);
       Line(239,245,239,235);
       Line(302,245,302,235);
       Line(365,245,365,235);
       Line(428,245,428,235);
       Line(491,245,491,235);
       Line(554,245,554,235);
       Line(45,5,50,0);Line(55,5,50,0);
       Line(45,474,50,479);Line(55,474,50,479);
       Line(595,235,600,240);Line(595,245,600,240);
       Line(45,180,55,180);
       Line(45,120,55,120);
       Line(45,60,55,60);
       Line(45,300,55,300);
       Line(45,360,55,360);
       Line(45,420,55,420);
       SETTEXTSTYLE(0,0,1);
       OUTTEXTXY(35,177,'1');
       OUTTEXTXY(100,250,'180ø');
   END;

BEGIN
   ClrScr;
   Pfad:='d:\TP\BGI';
   Graphiktreiber:=detect;
   InitGraph(Graphiktreiber, Graphikmodus, Pfad);
   GRFehler:=Graphresult;
   IF GRFehler <> 0 THEN Halt;
   a:=0;
   REPEAT
     r:=1;Koordinaten;
     t:=0;
     REPEAT
           x1:=r*t-a*sin(t);
           y1:=r-a*cos(t);
           c:=(x1*20)+51;
           d:=240-(y1*60);
           x2:=TRUNC(c);
           y2:=TRUNC(d);
           PUTPIXEL(x2,y2,yellow);DELAY(0);
           t:=t+PI/180;
     UNTIL t>8*pi;
       Taste:=READKEY;
       ClearDevice;a:=a+0.50;
   UNTIL a>2.5;
   CloseGRAPH;
END.


