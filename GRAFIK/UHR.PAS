PROGRAM Uhr;
USES CRT,GRAPH;

VAR STD,MIN,SEK:INTEGER;
    Stunden, Minuten,Sekunden :STRING[2];
    Graphmode,Graphdriver :INTEGER;
BEGIN
   ClrScr;
   GOTOXY(5,3);WRITE('Gib die Stunde  ein: ');READ(STD);
   GOTOXY(5,4);WRITE('Gib die Minute  ein: ');READ(MIN);
   GOTOXY(5,5);WRITE('Gib die Sekunde ein: ');READ(SEK);
   ClrScr;
     Graphdriver:=Detect;
     InitGraph(Graphdriver, Graphmode,'C:\TP\bgi' );
     SETTEXTSTYLE(4,0,8);
     SETCOLOR(1);
     BAR(100,100,630,400);
   REPEAT
        Str(Sek,Sekunden);Str(Min,Minuten);Str(Std,Stunden);
        IF Std<10 then Stunden:='0'+Stunden;
        OUTTEXTXY(120,200,Stunden+':');
           IF Min<10 Then Minuten:='0'+Minuten;
              BAR(330,100,460,400);
           if min mod 10=0 then BAR(300,100,400,400);
        OUTTEXTXY(300,200,Minuten+':');
           IF Sek<10 then Sekunden:='0'+Sekunden;
              BAR(510,100,600,400);
           IF sek mod 10=0 then    BAR(480,100,540,400);
        OUTTEXTXY(480,200,Sekunden);
        DELAY(2500);
        SEK:=SEK+1;
        IF SEK > 59 THEN
                      BEGIN
                       SEK:=0;MIN:=MIN+1;
                       BAR(400,100,460,400);
                       IF MIN > 59 THEN
                                    BEGIN
                                      MIN:=0;
                                      STD:=STD+1;
                                      {BAR(100,100,220,400);}
                                      IF STD > 23 THEN STD:=0;
                                    END;
                      END;
   UNTIL KEYPRESSED;
closegraph;
END.