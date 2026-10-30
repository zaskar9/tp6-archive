PROGRAM Ideal;
USES CRT;
VAR Gewicht,Normalgewicht, Groesse, Idealgewicht : REAL;
    Geschlecht                     : CHAR;
BEGIN
    ClrScr;
    GOTOXY(10,10);
    WRITE('Gib Dein Geschlecht an (f/m): ');
    READ(Geschlecht);
    GOTOXY(10,11);
    WRITE('Gib Deine Gr”sse in cm ein  : ');
    READ(Groesse);
    CASE Geschlecht OF
        'f': Idealgewicht:=(Groesse-100)*0.85;
        'm': Idealgewicht:=(Groesse-100)*0.90
    END;
    GOTOXY(10,12);
    WRITE('Gib Dein Gewicht ein        : ');
    READ(gewicht);
    GOTOXY(10,14);
    WRITE('Dein Idealgewicht  w„re      : ',Idealgewicht:3:2);
    Normalgewicht:=Groesse-100;
    GOTOXY(10,15);
    WRITE('Dein Normalgewicht w„re      : ',Normalgewicht:3:2);

    IF Gewicht>Idealgewicht*1.2  THEN BEGIN
                                           GOTOXY(25,17);
                                           TEXTCOLOR(4);
                                           WRITE('Du hast šbergewicht !');
                                       END
                                 ELSE  IF Gewicht>Normalgewicht THEN
                                          BEGIN
                                          GOTOXY(25,17);
                                          TEXTCOLOR(2);
                                          WRITE('Achte auf Deine Linie!');
                                       END
                                       ELSE
                                          BEGIN
                                          GOTOXY(25,17);
                                          TEXTCOLOR(11);
                                          WRITE('Versuche Dein Idealgewicht zu erreichen!');
                                       END;

REPEAT UNTIL KEYPRESSED;



END.


