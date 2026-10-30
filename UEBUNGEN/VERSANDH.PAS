PROGRAM Versandhaus;

USES CRT;
VAR Betrag, Rabatt, Ergebnis : REAL;

BEGIN
    ClrScr;
    GOTOXY(10,10);
    WRITE('Gib den Betrag ein: ');
    READ(Betrag);
    IF Betrag>500 THEN  Rabatt:=8/100
                  ELSE  Rabatt:=3/100;

    Ergebnis:=Betrag*(1-Rabatt);
    GOTOXY(10,12);
    WRITE('Der endgÅltige Betrag ist: ',Ergebnis:10:2);

    REPEAT UNTIL KEYPRESSED;
    END.




