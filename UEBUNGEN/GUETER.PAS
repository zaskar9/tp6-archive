PROGRAM Gueter;
USES CRT;

    VAR Preis1,Preis2,Gewinn :REAL;

BEGIN
    ClrScr;
    GOTOXY(5,10);
    WRITE('Gib den Preis des ersten  Gutes ein: ');
    READ(Preis1);
    GOTOXY(5,11);
    WRITE('Gib den Preis des zweiten Gutes ein: ');
    READ(Preis2);
    Gewinn:=1230*Preis1-30*sqr(Preis1)+5*Preis1*Preis2+610*Preis2-20*sqr(Preis2)+20800;
    GOTOXY(5,15);
    WRITE('Der Gewinn betr„gt: ',Gewinn:20:5);
    REPEAT UNTIL KEYPRESSED;
 END.
