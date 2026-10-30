PROCEDURE GraphEin;

VAR gd, gm : INTEGER;

BEGIN
     gd:=detect;
     InitGraph(gd, gm, 'C:\TP\BGI');
     {Borlands Graphic Interface}
     SetFillStyle(1,white);
     bar(1,1,639,479);
     SETCOLOR(black);
     Rectangle(5,5,635,475);
END;


PROCEDURE GraphAus;

BEGIN
     CloseGraph;
END;