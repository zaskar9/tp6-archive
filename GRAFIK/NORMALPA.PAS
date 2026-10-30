PROGRAM Normalparabel;
USES CRT,GRAPH;
VAR x, a, b, I, z, t, Grafiktreiber, Grafikmodus, GRFehler : INTEGER;
    Pfad : STRING;
    c : REAL;
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
   x:=0;
   LINE(0,479,640,479);
   LINE(320,0,320,480);
   z:=480;
   REPEAT
     LINE(318,z,322,z);
     z:=z-10;
   UNTIL z<0;
   FOR I:= -79 TO 79 DO
   BEGIN
        a:=(I*I);
        b:=479-a;
        x:=x+4;
        MoveTo(320,1);
        LineTo(x,b);DELAY(20);
   END;
   REPEAT UNTIL KEYPRESSED;
   CloseGraph;
END.