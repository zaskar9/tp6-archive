PROGRAM Michael;

USES CRT;

VAR Betrag,Rabatt, Rechnungsbetrag : REAL;
    Tagesdatum : STRING;

BEGIN
    ClrScr;
    GOTOXY(20,5);
    WRITE('Dies ist ein Programm zur Rabattberechnung.');
    GOTOXY(20,7);
    WRITE('Gib das Tagesdatum ein : ');
    READ(tagesdatum);
    GOTOXY(20,9);
    WRITE('Gib den Betrag an: ');
    READ(betrag);
    GOTOXY(20,10);
    WRITE('Wieviel Rabatt wird Ihnen gewÑhrt ? : ');
    READ(rabatt);
    GOTOXY(20,12);
    WRITE('Vielen Dank fÅr Ihre Information !');
    Rechnungsbetrag := Betrag*(1-Rabatt/100);
    GOTOXY(20,15);
    WRITE('Der Rechnungsbetrag ist: ',Rechnungsbetrag : 8:2);
    GOTOXY(20,20);
    WRITE('A U F   W I E D E R S E H E N  !');
    REPEAT UNTIL KEYPRESSED;
END.