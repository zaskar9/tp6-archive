PROGRAM Experiment;
USES CRT,GRAPH;

VAR Graphiktreiber, Graphikmodus, GRFehler : INTEGER;
    Pfad : STRING;

BEGIN
   ClrScr;
   Pfad:='C:\TP\BGI';
   Graphiktreiber:=detect;
   InitGraph(Graphiktreiber,Graphikmodus,Pfad);
   GRFehler:=Graphresult;
   IF GRFehler <> 0 THEN Halt;
   CloseGraph;
END.
 