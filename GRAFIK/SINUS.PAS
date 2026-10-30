(****************************************************************************)
(*                                 ACHTUNG                                  *)
(*       Dieses Programm arbeitet nur zuverl„ssig, wenn der Schalter        *)
(*      [ ] 8087/80287 im Menu Options | Compiler... deaktiviert ist.       *)
(****************************************************************************)

PROGRAM Sinus;

{$N-}

USES CRT,GRAPH;

VAR y,a,c,b,r,d,e : REAL;
    Grafiktreiber, Grafikmodus, GRFehler, I, x : INTEGER;
    Pfad : STRING;
    u : CHAR;
    f : WORD;

PROCEDURE Koordinaten;
VAR I : INTEGER;
   BEGIN
   I:=0;
   SETCOLOR(15);
   LINE(0,240,400,240);
   LINE(395,245,400,240);
   LINE(395,235,400,240);
   LINE(0,1,0,480);
     REPEAT
       Line(I,235,I,245);
       I:= I+45;
     Until I>370;
   SETTEXTSTYLE(0,0,1);
   OUTTEXTXY(350,250,'360ø');
   OUTTEXTXY(260,250,'270ø');
   OUTTEXTXY(170,250,'180ø');
   OUTTEXTXY(82,250,'90ø');
   OUTTEXTXY(2,250,'0ø');
   SETTEXTSTYLE(1,0,0);
   OUTTEXTXY(425,215,'x-Achse');
   END;
PROCEDURE T_Achse;
   BEGIN
   SETCOLOR(15);
   Line(0,0,3,0);Line(0,479,3,479);
   Line(0,220,3,220);
   SETTEXTSTYLE(0,0,1);
   OUTTEXTXY(6,472,'-58');
   OUTTEXTXY(6,0,'58');
   OUTTEXTXY(6,218,'5');
   END;
PROCEDURE Y_Achse;
VAR I : INTEGER;
    BEGIN
    I := 240;
    SETCOLOR(15);
    REPEAT
    I:= I - 24;
    Line(0,I,3,I);
    UNTIL I < 0;
    I := 240;
    REPEAT
    I:= I + 24;
    Line(0,I,3,I);
    UNTIL I > 480;
    Line(0,479,3,479);
    SETTEXTSTYLE(0,0,1);
    OUTTEXTXY(6,0,'1');
    OUTTEXTXY(6,472,'-1');
    SETTEXTSTYLE(0,1,1);
    OUTTEXTXY(14,108,'0.5');
    OUTTEXTXY(14,348,'-0.5');
    END;
PROCEDURE Ausgabe(Text : STRING;Farbe : WORD);
    BEGIN
    SETCOLOR(Farbe);
    SETTEXTSTYLE(1,0,4);
    OUTTEXTXY(400,0,Text);
    END;
BEGIN
   ClrScr;
   Pfad:='C:\TP\BGI';
   Grafiktreiber:=detect;
   InitGraph (Grafiktreiber, Grafikmodus, Pfad);
   GRFehler := GraphResult;
   IF GRFehler <> 0 THEN
          BEGIN
               WRITE('Grafikfehler. ',GRFehler,^G);
               DELAY(3000);
               Halt;
          END;
   I:=0;
   Rectangle(2,2,638,478);
   SETTEXTSTYLE(1,0,5);
   SetColor(15);
   OUTTEXTXY(120,40,'* DEMONSTRATION *');
   SETTEXTSTYLE(1,0,4);
   OUTTEXTXY(287,100,'von');
   SETCOLOR(10);
   OUTTEXTXY(200,150,'Sinus-Kurven,');
   SETCOLOR(12);
   OUTTEXTXY(188,190,'Cosinus-Kurven');
   SETCOLOR(15);
   OUTTEXTXY(285,230,'und');
   SETCOLOR(3);
   OUTTEXTXY(186,270,'Tangens-Kurven');
   SETCOLOR(15);
   OUTTEXTXY(295,350,'by');
   OUTTEXTXY(160,390,'Michael Grossniklaus');
   SETTEXTSTYLE(0,0,1);
   OUTTEXTXY(413,467,'Alle Rechte vorbehalten 1993');
   U:=ReadKey;
(*--------------------------------SINUS-KURVE-------------------------------*)
       ClearDevice;
       Ausgabe('Sinus-Kurve',LightGreen);
       SETCOLOR(LightGreen);
       Koordinaten;
       Y_Achse;
       MoveTo(0,240);
       FOR I:= 1 TO 360 DO
       BEGIN
            y:=(I*PI)/180;
            a:=sin(y);
            b:=240-(a*240);
            x:=Trunc(b);
            SETCOLOR(LightGreen);
            LineTo(I,x);DELAY(30);
       END;NOSOUND;
       u:=READKEY;
(*-------------------------------COSINUS-KURVE------------------------------*)
       ClearDevice;
       Ausgabe('Cosinus-Kurve',Lightred);
       SETCOLOR(LightRed);
       Koordinaten;
       Y_Achse;
       MoveTo(0,0);
       FOR I:= 1 TO 360 DO
       BEGIN
            y:=(I*PI)/180;
            a:=cos(y);
            b:=240-(a*240);
            x:=Trunc(b);
            SETCOLOR(LightRed);
            LineTo(I,x);DELAY(30);
       END;NOSOUND;
       u:=READKEY;
(*-------------------------------TANGENS-KURVE------------------------------*)
       f:=3;
       ClearDevice;
       SETCOLOR(14);
       Ausgabe('Tangens-Kurve',f);
       Koordinaten;
       T_Achse;
       MOVETO(0,240);
       FOR I:= 0 TO 269 DO
           BEGIN
                a:=(I*PI)/180;
                b:=sin(a);
                c:=cos(a);
                IF c<>0 THEN BEGIN
                                    d:=(240*(b/c))/58;
                                    e:=240-d;
                                    x:=TRUNC(e);
                                    SETCOLOR(f);
                                    LINETO(I,x);Delay(20)
                               END;
           END;
       FOR I:= 271 TO 360 DO
           BEGIN
                a:=(I*PI)/180;
                b:=sin(a);
                c:=cos(a);
                IF c<>0 THEN BEGIN
                                    d:=(240*(b/c))/58;
                                    e:=240-d;
                                    x:=TRUNC(e);
                                    SETCOLOR(f);
                                    LINETO(I,x);Delay(20)
                               END;
           END;
   SETCOLOR(15);
   Line(90,0,90,480);Line(270,0,270,480);
   SETTEXTSTYLE(0,0,1);
   OUTTEXTXY(95,470,'undefiniert');OUTTEXTXY(275,470,'undefiniert');
   u:=READKEY;
   ClearDevice;
   SETCOLOR(15);
   RECTANGLE(2,2,638,478);
   SETTEXTSTYLE(4,0,9);
   OUTTEXTXY(110,140,'E N D E');
   REPEAT UNTIL KEYPRESSED;
   CloseGraph;
END.



