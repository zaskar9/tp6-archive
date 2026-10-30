PROGRAM Kreis;
USES Crt, Graph;

VAR Grafiktreiber,Grafikmodus,GRFehler,A,r,b,o,I,Schwarz :INTEGER;
    Pfad : String;
    L : CHAR;
    CONST H=1000;
    CONST T=333;
    CONST S=666;
    CONST D=3000;

    BEGIN
       Pfad:='C:\TP\BGI';
       Grafiktreiber:=Detect;
       InitGraph(Grafiktreiber,Grafikmodus,Pfad);
       GRFehler := GraphResult;
       IF GRFehler<>0 THEN
       BEGIN
            WRITE('Grafikfehler: ',GRFehler,^G);
            DELAY(3000);
            Halt;
       END;
       Schwarz:= GETMAXCOLOR-15;
       SETBKCOLOR(0);
       Rectangle(2,2,GetMaxX-2,GetMaxY-2);
       FOR I := 1  TO 200 DO
            BEGIN
                 SETCOLOR(09);
                 I:=I+1;Sound(I+100);
                 Circle(320,I+20,I);
                 DELAY(150);
            END;
       SETBKCOLOR(0);
       SETCOLOR(0);
       SETFillStyle(0,0);
       FOR I:= 1 TO 110 DO
               BEGIN
                   FillEllipse(320,I+20,I-1,I-1);Sound(I+300);
                   DELAY(45);
               END;
       SETCOLOR(15);
       SETTEXTSTYLE(1,0,06);
       OUTTEXTXY(230,65,'Michael');
       SETTEXTSTYLE(1,0,04);
       OUTTEXTXY(225,120,'Grossniklaus');
       DELAY(1500);
       SETTEXTSTYLE(1,0,5);
       OUTTEXTXY(165,415,'p r e s e n t s');
             SOUND(294);DELAY(H);NOSOUND;DELAY(20);
	     SOUND(370);DELAY(T);NOSOUND;DELAY(20);
	     SOUND(294);DELAY(T);NOSOUND;DELAY(20);
	     SOUND(370);DELAY(T);NOSOUND;DELAY(20);
	     SOUND(440);DELAY(H);NOSOUND;DELAY(20);
	     SOUND(587);DELAY(S);NOSOUND;DELAY(20);
	     SOUND(659);DELAY(T);NOSOUND;DELAY(20);
	     SOUND(659);DELAY(D);NOSOUND;DELAY(20);
	     SOUND(587);DELAY(T);NOSOUND;DELAY(20);
	     SOUND(659);DELAY(T);NOSOUND;DELAY(20);
	     SOUND(740);DELAY(T);NOSOUND;DELAY(20);
	     SOUND(659);DELAY(S);NOSOUND;DELAY(20);
	     SOUND(440);DELAY(T);NOSOUND;DELAY(20);
             SOUND(440);DELAY(D);NOSOUND;DELAY(20);
       A:=0;
       Delay(5000);
       SETCOLOR(0);
       I:=0;
       FillEllipse(320,130,109,109);
       SETCOLOR(0);
       FOR I:= 1 TO 200 DO
           BEGIN
              Circle(320,I+20,I);
           END;
       Bar(3,350,635,475);DELAY(1000);
       REPEAT
       SETCOLOR(15);
       OUTTEXTXY(52,415,'Bitte eine Taste drÅcken !');
       UNTIL KEYPRESSED;
       CloseGraph;
END.