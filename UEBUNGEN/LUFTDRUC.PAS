PROGRAM Ldruck;
USES CRT,GRAPH;

VAR Erdbeschleunigung, Dichte, Druck, Luftdruck : REAL;
    Hoehe : LongInt;
    Grafiktreiber, Grafikmodus, GRFehler, x, y, Druck1 : INTEGER;
    Pfad : STRING;
    Taste : CHAR;
BEGIN
   ClrScr;
   Pfad:='C:\TP\BGI';
   Grafiktreiber:=detect;
   InitGraph(Grafiktreiber,Grafikmodus,Pfad);
   GRFehler:=Graphresult;
   IF GRFehler <> 0 THEN Halt;
   Erdbeschleunigung:=9.80665;
   Luftdruck:=100000;
   Dichte:=1;
   Hoehe:=0;
   X:=10;
   SETCOLOR(15);
   Settextstyle(1,0,4);
   OUTTEXTXY(343,30,'Luftdruckabnahme');
   OUTTEXTXY(497,60,'nach der');
   OUTTEXTXY(397,90,'barometrischen');
   OUTTEXTXY(440,125,'H”henformel ');
   SETCOLOR(white);
   REPEAT
      LINE(x,470,x,467);
      INC(x,100);
   UNTIL X>640;
   X:=470;
   REPEAT
      Line(8,x,12,x);
      DEC(x,120);
   UNTIL X<0;
   SETTEXTSTYLE(0,0,1);
   OUTTEXTXY(14,10,'1bar');
   OUTTEXTXY(14,235,'1/2');
   OUTTEXTXY(14,115,'3/4');
   OUTTEXTXY(14,355,'1/4');
   OUTTEXTXY(95,472,'10km');
   OUTTEXTXY(195,472,'20km');
   OUTTEXTXY(295,472,'30km');
   OUTTEXTXY(395,472,'40km');
   OUTTEXTXY(495,472,'50km');
   OUTTEXTXY(595,472,'60km');
   OUTTEXTXY(2,472,'0');
   LINE(10,0,10,480);
   LINE(5,5,10,0);LINE(15,5,10,0);
   LINE(0,470,640,470);
   LINE(635,475,640,470);LINE(635,465,640,470);
   MoveTo(11,0);X:=0;
   REPEAT
       Druck:=Luftdruck*exp((-Dichte*Erdbeschleunigung*Hoehe)/Luftdruck);
       Inc(Hoehe,100);
       X:=X+1;
       Y:=ROUND(480*Druck/100000);
       SETCOLOR(lightblue);
       LineTO(8+x,470-y);DELAY(20);
   UNTIL X=600;
   Taste:=READKEY;
CloseGRAPH;
END.



