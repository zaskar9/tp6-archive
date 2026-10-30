PROGRAM Schatz;
USES CRT, GRAPH, WRITING;

VAR n, m, Wert, Grafiktreiber, Grafikmodus, GRFehler, x, y, a ,b, Fehler, Fehlerstelle : INTEGER;
    Pfad, Test, g, f, Versuch, String1, String2, Name                                  : STRING;
    Distanz                                                                            : REAL;
    Taste                                                                              : CHAR;

PROCEDURE Raster(Rechts,Oben:INTEGER);
    VAR I : INTEGER;
    BEGIN
    I:=Oben;
    Rectangle(Rechts,Oben,Rechts+300,Oben+300);DELAY(300);
    REPEAT
         Line(I,Oben,I,Oben+300);DELAY(100);
         Line(Rechts,I,Rechts+300,I);DELAY(100);
         Inc(I,30);
    UNTIL I>Rechts+300;
    I:=Oben+30;
    Rectangle(Rechts+330,Oben,Rechts+515,Oben+300);
    Rectangle(Rechts+330,Oben+30,Rechts+360,Oben+300);
    REPEAT
         Line(Rechts+330,I,Rechts+515,I);
         Inc(I,30);
    UNTIL I>Rechts+300;
    SETTEXTSTYLE(3,0,0);
    OUTTEXTXY(Rechts+340,Oben-06,'Die Farben:');
    SETFILLSTYLE(1,white);FLOODFILL(Rechts+350,Oben+35,white);
    SETFILLSTYLE(1,yellow);FLOODFILL(Rechts+350,Oben+65,white);
    SETFILLSTYLE(1,red);FLOODFILL(Rechts+350,Oben+95,white);
    SETFILLSTYLE(1,magenta);FLOODFILL(Rechts+350,Oben+125,white);
    SETFILLSTYLE(1,Cyan);FLOODFILL(Rechts+350,Oben+155,white);
    SETFILLSTYLE(1,lightblue);FLOODFILL(Rechts+350,Oben+185,white);
    SETFILLSTYLE(1,blue);FLOODFILL(Rechts+350,Oben+215,white);
    SETFILLSTYLE(1,lightgray);FLOODFILL(Rechts+350,Oben+245,white);
    SETFILLSTYLE(1,darkgray);FLOODFILL(Rechts+350,Oben+275,white);
    SETTEXTSTYLE(0,0,1);
    OUTTEXTXY(Rechts+370,Oben+45,'Endlich geschafft');
    OUTTEXTXY(Rechts+370,Oben+75,'Extrem nah dran');
    OUTTEXTXY(Rechts+370,Oben+105,'Sehr nah dran');
    OUTTEXTXY(Rechts+370,Oben+135,'Nah dran');
    OUTTEXTXY(Rechts+370,Oben+165,'Ziemlich nah dran');
    OUTTEXTXY(Rechts+370,Oben+195,'Ziemlich weit weg');
    OUTTEXTXY(Rechts+370,Oben+225,'Weit weg');
    OUTTEXTXY(Rechts+370,Oben+255,'Sehr weit weg');
    OUTTEXTXY(Rechts+370,Oben+285,'Extrem weit weg');
    OUTTEXTXY(Rechts-10,Oben+05,'1');
    OUTTEXTXY(Rechts-10,Oben+35,'2');
    OUTTEXTXY(Rechts-10,Oben+65,'3');
    OUTTEXTXY(Rechts-10,Oben+95,'4');
    OUTTEXTXY(Rechts-10,Oben+125,'5');
    OUTTEXTXY(Rechts-10,Oben+155,'6');
    OUTTEXTXY(Rechts-10,Oben+185,'7');
    OUTTEXTXY(Rechts-10,Oben+215,'8');
    OUTTEXTXY(Rechts-10,Oben+245,'9');
    OUTTEXTXY(Rechts-18,Oben+275,'10');
    OUTTEXTXY(Rechts+05,Oben-10,'1');
    OUTTEXTXY(Rechts+35,Oben-10,'2');
    OUTTEXTXY(Rechts+65,Oben-10,'3');
    OUTTEXTXY(Rechts+95,Oben-10,'4');
    OUTTEXTXY(Rechts+125,Oben-10,'5');
    OUTTEXTXY(Rechts+155,Oben-10,'6');
    OUTTEXTXY(Rechts+185,Oben-10,'7');
    OUTTEXTXY(Rechts+215,Oben-10,'8');
    OUTTEXTXY(Rechts+245,Oben-10,'9');
    OUTTEXTXY(Rechts+275,Oben-10,'10');
    END;

PROCEDURE Zeigen(x,y:Integer;Wert : REAL);
    VAR Farbe : WORD;

    BEGIN
       IF (Wert>120) THEN Farbe:=Darkgray;
       IF (Wert>100) AND (Wert<=120) THEN Farbe:=Lightgray;
       IF (Wert>80) AND (Wert<=100)  THEN Farbe:=blue;
       IF (Wert>60) AND (Wert<=80)  THEN Farbe:=Lightblue;
       IF (Wert>40) AND (Wert<=60)  THEN Farbe:=Cyan;
       IF (Wert>20) AND (Wert<=40)  THEN Farbe:=magenta;
       IF (Wert>10) AND (Wert<=20)  THEN Farbe:=red;
       IF  Wert=10  THEN Farbe:=yellow;
       IF  Wert=0   THEN Farbe:=white;
       SETFILLSTYLE(1,Farbe);
       x:=(27*x-27)+78;
       y:=(27*y-27)+78;
       FloodFill(x,y,white);
    END;

PROCEDURE Signet;
          BEGIN
               Rectangle(5,5,635,475);
               SETTEXTSTYLE(4,0,8);SETCOLOR(red);
               OUTTEXTXY(60,50,'Die Schatzsuche');
               SETTEXTSTYLE(1,0,5);SETCOLOR(magenta);
               OUTTEXTXY(200,200,'Knobelspiel');
               OUTTEXTXY(270,250,'von');
               OUTTEXTXY(110,300,'Michael Grossniklaus');
               SETTEXTSTYLE(2,0,0);SETCOLOR(white);
               OUTTEXTXY(255,440,'Copyright 1993,Basel');
               Taste:=ReadKey;
               ClearDevice;
               Rectangle(5,5,635,475);
               SETTEXTSTYLE(4,0,6);OUTTEXTXY(070,070,'Die Spielregeln:');
               SETTEXTSTYLE(0,0,1);
               OUTTEXTXY(070,170,'Auf einem Feld von 10 mal 10 H„uschen ist ein Schatz versteckt,');
               OUTTEXTXY(070,200,'den man suchen muss.');
               OUTTEXTXY(070,230,'Dies kann man tun, indem man die Koordinaten des H„uschens eingibt,');
               OUTTEXTXY(070,260,'auf dem man den Schatz vermutet. Dazu muss man zuerst die ');
               OUTTEXTXY(070,290,'Koordinate in X-Richtung (horizontal) eingeben, dann die in ');
               OUTTEXTXY(070,320,'Y-Richtung (vertikal). Der Computer zeigt bei einem Fehlversuch, ');
               OUTTEXTXY(070,350,'je nach Entfernung, ein gelbes bis graues Feld an. Ausserdem');
               OUTTEXTXY(070,380,'erscheint unten am Bildschirm ein Kommentar ber die Entfernung.');
               OUTTEXTXY(070,410,'War der Tip jedoch richtig erscheint ein weisses Feld, und das Spiel');
               OUTTEXTXY(070,440,'ist zu Ende.');
               Taste:=ReadKey;
               ClearDevice;
          END;
PROCEDURE Spieler_identifizieren;
          BEGIN
               Rectangle(5,5,634,474);
               SetTextStyle(1,0,4);
               ReadStringXY(50,220,'Gib deinen Namen ein: ',Name);
               Delay(2000);
               ClearDevice;
          END;
BEGIN
   ClrScr;
   Pfad:='C:\TP\BGI';
   Grafiktreiber:=detect;
   InitGraph(Grafiktreiber,Grafikmodus,Pfad);
   GRFehler:=Graphresult;
   IF GRFehler <> 0 THEN Halt;
   Signet;
   Spieler_identifizieren;
   REPEAT
     SETTEXTSTYLE(4,1,7);SETCOLOR(Lightred);
     OUTTEXTXY(560,20,'Die Schatzsuche');
     Randomize;
     SETCOLOR(white);
     a:=RANDOM(10)+1;
     b:=RANDOM(10)+1;
     Raster(50,50);
     SETTEXTSTYLE(1,0,4);
     N:=0;M:=0;
     REPEAT
        Repeat
           SetViewPort(1,360,550,479,ClipOn);TextColor(0);
           ReadStringXY(50,25,'Gib die X-Koordinate ein: ',f);
           ReadStringXY(50,65,'Gib die Y-Koordinate ein: ',g);
           Val(f,x,Fehlerstelle);Val(g,y,Fehler);
           Delay(2000);ClearViewPort;
           IF (x<0) OR (x>10) OR (y<0) OR (y>10) THEN BEGIN
                                                           SETCOLOR(lightred);
                                                           OUTTEXTXY(50,45,'Unzul„ssige Eingabe !');
                                                           WRITE(^G);
                                                           DELAY(2000);ClearViewPort;
                                                           SETCOLOR(white);
                                                      END;
        Until (x>0) AND (x<=10) AND (0<y) AND (y<=10) AND (Fehlerstelle=0) AND (Fehler=0);
        Distanz:=SQRT((a-x)*(a-x)+(b-y)*(b-y));
        Wert:=ROUND(Distanz*10);
        IF (Wert>120) THEN Test:='Extrem weit weg !';
        IF (Wert>100) AND (Wert<=120) THEN Test:='Sehr weit weg';
        IF (Wert>80) AND (Wert<=100)  THEN Test:='Weit weg';
        IF (Wert>60) AND (Wert<=80)  THEN Test:='Ziemlich weit weg';
        IF (Wert>40) AND (Wert<=60)  THEN Test:='Ziemlich nah dran';
        IF (Wert>20) AND (Wert<=40)  THEN Test:='Nah dran';
        IF (Wert>10) AND (Wert<=20)  THEN Test:='Sehr nah dran';
        IF  Wert=10  THEN Test:='Extrem nah dran !';
        IF  Wert=0   THEN Test:='Endlich geschafft !';
        SETCOLOR(white);
        OUTTEXTXY(50,45,Test);
        DELAY(2500);ClearViewPort;
        SETVIEWPORT(1,1,639,479,ClipOn);
        Zeigen(x,y,Wert);
        m:=m+1;
     UNTIL (Wert=0) OR (x=0);
     STR(m,Versuch);
     X:=1;Y:=1;N:=0;
     REPEAT
         Inc(n);
         IF X MOD 11 = 0 THEN BEGIN
                                   X:=0;
                                   Y:=Y+1;
                              END;
         Distanz:=SQRT((a-x)*(a-x)+(b-y)*(b-y));
         Wert:=ROUND(Distanz*10);
         Zeigen(x,y,Wert);
         X:=X+1;
     UNTIL n>108;
     Taste:=ReadKey;
     ClearDevice;
     Rectangle(5,5,634,474);
     Rectangle(7,7,632,472);
     SETTEXTSTYLE(1,0,4);
     SETTEXTJUSTIFY(1,1);
     REPEAT
           IF m>1 THEN BEGIN
                            String1:=' ,du hast es mit ';
                            String2:=Concat(Name, String1, Versuch);
                            OUTTEXTXY(320,100,String2);
                            OUTTEXTXY(320,150,'Versuchen geschafft.');
                       END
                  ELSE BEGIN
                            String1:=' ,Du hast es beim';
                            String2:=Concat(Name, String1);
                            OUTTEXTXY(320,100,String2);
                            OUTTEXTXY(320,150,'ersten Mal geschafft.');
                       END;
           DELAY(2000);
           OUTTEXTXY(320,250,'Willst Du nochmals ? (j/n)');
           Taste:=UPCASE(READKEY);
     UNTIL (Taste='N') OR (Taste='J');
     Delay(1000);ClearDevice;
     SetTextJustify(0,2);
   UNTIL Taste='N';
   CloseGraph;
END.