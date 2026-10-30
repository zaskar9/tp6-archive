PROGRAM Spiel;
USES CRT;

VAR Spieler1, Spieler2, Spieler : STRING[20];
    Anzahl, Wegnahme            : INTEGER;

BEGIN
    ClrScr;
    GOTOXY(30,5);WRITE('W I L L K O M M E N');
    GOTOXY(17,7);WRITE('50 H”lzer liegen auf dem Tisch; 2 Spieler nehmen');
    GOTOXY(15,8);WRITE('abwechslungsweise mindestens 1 aber h”chsten 8 H”lzer');
    GOTOXY(18,9);WRITE('Wer das letzte Holz nehmen muss hat verloren !');
    GOTOXY(10,12);WRITE('Name des 1. Spielers: ');READLN(Spieler1);
    GOTOXY(10,13);WRITE('Name des 2. Spielers: ');READLN(Spieler2);
    ClrScr;
    Anzahl:=50;
    Spieler:=Spieler1;
    REPEAT
         GOTOXY(5,5);WRITE('Vorhandene H”lzer: ',Anzahl);
         GOTOXY(5,7);WRITE('     ',Spieler,', Du bist am Zug !');
         REPEAT
              GOTOXY(5,8);WRITE('     Wie viele H”lzer nimmst Du ?                  ');
              GOTOXY(40,8); READLN(Wegnahme);
         UNTIL (Wegnahme>0) AND (Wegnahme<9);
         Anzahl:=Anzahl-Wegnahme;
         IF Spieler=Spieler1 THEN Spieler:=Spieler2
                             ELSE Spieler:=Spieler1;
         ClrScr;
    UNTIL Anzahl<2;
    GOTOXY(20,12);WRITE(Spieler,' ,du hast verloren !');GOTOXY(1,25);WRITE(^G);
    REPEAT UNTIL KEYPRESSED;
END.