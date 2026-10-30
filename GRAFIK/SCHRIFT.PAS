PROGRAM Schriften;
USES CRT,GRAPH;

VAR I, Grafiktreiber, Grafikmodus, GRFehler : INTEGER;
    Pfad                                    : STRING;
    Farbe                                   : WORD;

BEGIN
   ClrScr;
   Pfad:='C:\TP\BGI';
   Grafiktreiber:=detect;
   InitGraph(Grafiktreiber,Grafikmodus,Pfad);
   GRFehler:=Graphresult;
   IF GRFehler <> 0 THEN Halt;
   I:=0;
   Repeat
         Rectangle(I,I,639-I,479-I);
         Inc(I,2);SOUND(I);DELAY(50);NOSOUND;
   Until I>640;
   NOSOUND;
   SETTEXTJUSTIFY(1,1);
   SETCOLOR(Black);
   SETTEXTSTYLE(0,0,0);OUTTEXTXY(320,150,'Default Font [0]');
   SETTEXTSTYLE(1,0,0);OUTTEXTXY(320,180,'Triplex Font [1]');
   SETTEXTSTYLE(2,0,0);OUTTEXTXY(320,220,'Small Font [2]');
   SETTEXTSTYLE(3,0,0);OUTTEXTXY(320,250,'Sans Serif Font [3]');
   SETTEXTSTYLE(4,0,0);OUTTEXTXY(320,300,'Gothic Font [4]');
   REPEAT UNTIL KEYPRESSED;
   CloseGRAPH;
END.
