PROGRAM Kreis;

USES CRT;

VAR Radius, Flaeche, Umfang : REAL;

BEGIN
    ClrScr;
    GOTOXY(10,10);
    WRITE('Gib bitte den Radius des Kreises an : ');
    READ(radius);
    Flaeche:= PI*SQR(radius);
    Umfang:=(2*PI)*radius;
    GOTOXY(10,12);
    WRITE('Die FlÑche hat den Wert : ',Flaeche:10:2);
    GOTOXY(10,13);
    WRITE('Der Umfang hat den Wert : ',Umfang:10:2);
    GOTOXY(10,15);
    WRITE('Bitte eine Taste drÅcken !');
    REPEAT UNTIL KEYPRESSED;

END.