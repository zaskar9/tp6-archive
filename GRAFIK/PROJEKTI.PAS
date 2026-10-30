PROGRAM Projektion;
USES CRT,GRAPH;

CONST Ecke:Array[1..24]of REAL =
      (0,0,0, 1,0,0, 1,1,0, 0,1,0, 0,0,1, 1,0,1, 1,1,1, 0,1,1);

VAR xpMax, xpMin, zpMax, zpMin   : REAL;
    a,b,c                        : REAL;
    Taste                        : CHAR;

PROCEDURE Eingabe;
          BEGIN
               xpMin:=-1;xpMax:=3;
               zpMin:=-1;zpMax:=2;
               {
               Write('Gib die x-Koordinate des Auges an: ');Readln(a);
               Write('Gib die y-Koordinate des Auges an: ');Readln(c);
               Write('Gib die Tiefe des Raumes an      : ');Readln(b);
               }
               a:=0.2;b:=-2;c:=0.5;
               
               DELAY(1000);
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

FUNCTION u(I:INTEGER):INTEGER;
         VAR x,y,xp : REAL;
         BEGIN
              x:=Ecke[3*I-2];
              y:=Ecke[3*I-1];
              xp:=(a*y-b*x)/(y-b);
              u:=ROUND(GetMaxX/(xpMax-xpMin)*(xp-xpMin));
         END;

FUNCTION v(I:INTEGER):INTEGER;
         VAR y,z,zp : REAL;
         BEGIN
              z:=Ecke[3*I];
              y:=Ecke[3*I-1];
              zp:=(c*y-b*z)/(y-b);
              v:=GetMaxY-ROUND(GetMaxY/(zpMax-zpMin)*(zp-zpMin));
         END;

PROCEDURE Transformieren_und_Zeichnen;
          BEGIN
               Line(u(1),v(1),u(2),v(2));
               Line(u(2),v(2),u(3),v(3));
               Line(u(3),v(3),u(4),v(4));
               Line(u(4),v(4),u(1),v(1));
               Line(u(1),v(1),u(5),v(5));
               Line(u(2),v(2),u(6),v(6));
               Line(u(3),v(3),u(7),v(7));
               Line(u(4),v(4),u(8),v(8));
               Line(u(5),v(5),u(6),v(6));
               Line(u(6),v(6),u(7),v(7));
               Line(u(7),v(7),u(8),v(8));
               Line(u(8),v(8),u(5),v(5));
          END;

BEGIN
     Eingabe;
     Graphik_Ein;
     Transformieren_und_Zeichnen;
     Taste:=ReadKey;
     Graphik_Aus;
END.