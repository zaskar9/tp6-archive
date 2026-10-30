PROGRAM CrapTest;
USES CRT;

VAR Summe, Point, Gewinn, Verlust, I, n                        : INTEGER;
    Einsatz, ProVerlust, ProGewinn, VerVerlust, VerGewinn      : REAL;

PROCEDURE Wuerfeln;
    BEGIN
        Summe:=Random(6)+2+Random(6);
    END;
 
BEGIN
    ClrScr;
    Gewinn:=0;
    Verlust:=0;
    n:=10000;
    RANDOMIZE;
    FOR I :=1 TO n DO
    BEGIN
    GOTOXY(10,5);WRITELN('Anzahl WÅrfe: ',I);
    Wuerfeln;
    CASE Summe OF
         7,11 : Gewinn:=Gewinn+1;
       2,3,12 : Verlust:=Verlust+1;
        ELSE BEGIN
             Point:=Summe;
             REPEAT
                  Wuerfeln;
             UNTIL (Summe=7) OR (Summe=Point);
             IF Summe=Point THEN Gewinn:=Gewinn+1
                            ELSE Verlust:=Verlust+1;
             END;
    END;
    GOTOXY(05,10);WRITE('Gewinne:  ',Gewinn:10);
    GOTOXY(05,11);WRITE('Verluste: ',Verlust:10);
    ProGewinn:=Gewinn/(n/100);
    VerGewinn:=Gewinn/(I/100);
    ProVerlust:=Verlust/(n/100);
    VerVerlust:=Verlust/(I/100);
    GOTOXY(30,10);WRITE('in Prozent: ',ProGewinn:4:2,' %');
    GOTOXY(30,11);WRITE('in Prozent: ',ProVerlust:4:2,' %');
    GOTOXY(52,10);WRITE('VerhÑltnis: ',VerGewinn:4:2);
    GOTOXY(52,11);WRITE('VerhÑltnis: ',VerVerlust:4:2);
    GOTOXY(1,25);
    END;
    REPEAT UNTIL KEYPRESSED;
END.
