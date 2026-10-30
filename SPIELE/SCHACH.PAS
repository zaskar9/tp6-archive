PROGRAM Schachbrett;
USES CRT;

VAR Summe, Feld : REAL;
    n           : INTEGER;

BEGIN
    ClrScr;
    GOTOXY(24,5);WRITE('DIE GESCHICHTE VOM SCHACHBRETT');
    GOTOXY(12,7);WRITE('Man lege auf das erste Feld eines Schachbretts 1 Reiskorn.');
    GOTOXY(18,8);WRITE('Auf das zweite jedoch 2 und auf das dritte 4.');
    GOTOXY(13,9);WRITE('So fahre man fort bis zum letzten Feld des Schachbretts.');
    HIGHVIDEO;
    GOTOXY(5,11);WRITE('Die Frage ist nun, wie viele Reisk”rner liegen am Schluss auf dem Brett ?');
    Summe:=0;
    Feld:=1;
    n:=0;
    REPEAT
         Summe:=Summe+Feld;
         Feld:=Feld*2;
         n:=n+1;
    UNTIL n=64;
    GOTOXY(31,13);LOWVIDEO;
    WRITE('Die Antwort ist:');
    GOTOXY(28,14);
    WRITE(Summe:21:0);
    REPEAT UNTIL KEYPRESSED;
END.
