PROGRAM Kreisring;

USES CRT;
VAR Flaecheninhalt,R1,R2 : REAL;

BEGIN
    ClrScr;
    GOTOXY(20,5);
    WRITE('Willkommen !');
    GOTOXY(20,8);
    WRITE('Dies ist ein Programm zur Berechnung eines Kreisringes.');
    GOTOXY(20,11);
    WRITE('Gib R1 als gr”ssere Zahl ein : ');
    READ(r1);
    GOTOXY(20,12);
    WRITE('Gib R2 als kleinere Zahl ein : ');
    READ(r2);
    GOTOXY(20,14);
    WRITE('DANKE !');
    Flaecheninhalt:= PI*(R1*R1 - R2*R2);
    GOTOXY(20,16);
    WRITE('Der Fl„cheninhalt A betr„gt : ',Flaecheninhalt : 10:4);
    GOTOXY(20,20);
    WRITE('AUF WIEDERSEHEN !');
    REPEAT UNTIL KEYPRESSED;


END.


