PROGRAM Zahlenraten;
USES CRT;

VAR Zahl1, Zahl2, n : INTEGER;
    Taste           : CHAR;

BEGIN
    ClrScr;
    n:=0;
    LowVideo;
    GOTOXY(30,5);WRITE('Z A H L E N R A T E N');
    GOTOXY(15,7);WRITE('Der Computer hat sich eine Zahl zwischen 1 und 100');
    GOTOXY(21,8);WRITE('ausgedacht, die Du nun erraten sollst.');
    Randomize;
    Zahl1:=Random(100)+1;
    GOTOXY(33,15);HighVideo;WRITE('TASTE DRšCKEN !');GOTOXY(1,25);
    Taste:=READKEY;ClrScr;LowVideo;
    REPEAT
         n:=n+1;
         GOTOXY(10,5);WRITE('Gib eine Zahl ein: ');READLN(Zahl2);
         IF Zahl2>Zahl1 THEN BEGIN
                                 GOTOXY(10,6);WRITE('Diese Zahl ist zu gross !');
                             END
                        ELSE BEGIN
                                 IF Zahl2<Zahl1 THEN BEGIN
                                                         GOTOXY(10,6);
                                                         WRITE('Diese Zahl ist zu klein !');
                                                     END
                                                ELSE BEGIN
                                                         GOTOXY(10,6);
                                                         WRITE('Du hast es mit ',n,' Versuchen geschafft !');Taste:=READKEY;
                                                     END;
                             END;
         DELAY(1500);
         ClrScr;
    UNTIL Zahl1=Zahl2;
END.



