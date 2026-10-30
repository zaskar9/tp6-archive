PROGRAM Exponentilafunktion;
USES CRT, GRAPH;

VAR I                                      : REAL;
    Graphiktreiber, Graphikmodus, GRFehler : INTEGER;
    Pfad                                   : STRING;
    a,z,x,y                               : INTEGER;

BEGIN
   ClrScr;
   Pfad:='C:\TP\BGI';
   Graphiktreiber:=detect;
   InitGraph(Graphiktreiber,Graphikmodus,Pfad);
   GRFehler:=Graphresult;
   IF GRFehler <> 0 THEN Halt;
   I:=-3.0;z:=0;
   MoveTo(0,480);
   Repeat
         I:=I+0.015;
         Inc(z);
         a:=ROUND(exp(I));
         x:=z;
         y:=479-a;
         LineTo(x,y);
   Until I>6.15;
   Repeat Until Keypressed;
   CloseGraph;
END.