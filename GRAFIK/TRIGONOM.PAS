PROGRAM Kurve;
USES CRT, GRAPH;

VAR xMin,xMax,yMin,yMax                 : REAL;
    VonWinkel,BisWinkel,DeltaWinkel     : REAL;
    Taste                               : CHAR;

FUNCTION R(phi:REAL):REAL;
         BEGIN
              R:=cos(1*sin(4*phi));
         END;

PROCEDURE Eingabe;
          BEGIN
              ClrScr;
              WRITELN;WRITELN;
              WRITELN('                        Fenster');
                WRITE('        minimaler x-Wert: ');READLN(xMin);
                WRITE('        maximaler x-Wert: ');READLN(xMax);
                WRITE('        minimaler y-Wert: ');READLN(yMin);
                WRITE('        maximaler y-Wert: ');READLN(yMax);
              WRITELN('                        Winkel');
                WRITE('             Startwinkel: ');READLN(VonWinkel);
                WRITE('               Endwinkel: ');READLN(BisWinkel);
                WRITE('           Schrittgr”sse: ');READLN(DeltaWinkel);
          END;

PROCEDURE Graphik_Ein;
          VAR GraphDriver,GraphMode : INTEGER;
          BEGIN
               Graphdriver:=Detect;
               InitGraph(Graphdriver,GraphMode,'C:\TP\BGI');
          END;

PROCEDURE Graphik_Aus;
          BEGIN
               CloseGraph;
          END;
PROCEDURE Zeichnen;
          VAR fx,fy,phi,x,y : REAL;
              u,v,n         : INTEGER;
          BEGIN
               fx:=GetMaxX/(xMax-xMin);
               fy:=GetMaxY/(yMax-yMin);
               phi:=VonWinkel;
               n:=0;
               REPEAT
                     IF R(phi)>0 THEN
                                     BEGIN
                                          Inc(n);
                                          x:=R(phi)*cos(phi);
                                          y:=R(phi)*sin(phi);
                                          u:=ROUND(fx*(x-xMin));
                                          v:=GetMaxY-ROUND(fy*(y-yMin));
                                          IF n=1 THEN SETCOLOR(black)
                                                 ELSE SETCOLOR(white);
                                          LineTo(u,v);
                                     END;
                                     phi:=phi+DeltaWinkel;
               UNTIL phi>BisWinkel;
          END;

BEGIN
     REPEAT
           Eingabe;
           Graphik_Ein;
           Zeichnen;
           Taste:=READKEY;
           Graphik_Aus;
     UNTIL Taste='q';
END.