PROGRAM Crap;
USES CRT;

VAR Summe, Point, Startkapital        : INTEGER;
    Einsatz, Count                    : REAL;
    Taste, Antwort                    : CHAR;
    Text, Spieler                     : STRING[20];

CONST Farbe_Einsatz     = Green;
CONST Farbe_Hintergrund = White;
CONST Farbe_Wuerfeln    = Cyan;
CONST Farbe_Spieler     = Red;
CONST Farbe_Achtung     = brown;

PROCEDURE Wuerfeln;
    BEGIN
        Summe:=Random(6)+2+Random(6);
        GOTOXY(25,11);TEXTBACKGROUND(Farbe_Wuerfeln);
        WRITELN('Die Wrfel zeigen:         ');
        GOTOXY(46,11);WRITE(Summe);GOTOXY(1,25);
        DELAY(1000);
        TEXTBACKGROUND(Farbe_Hintergrund);
    END;
PROCEDURE Rahmen(x,y :INTEGER;Farbe:WORD);
    VAR I,a : INTEGER;
    BEGIN
         TEXTBACKGROUND(Farbe);
         FOR i:= x+1 TO (40-x)+40 DO
         BEGIN
              GOTOXY(I,y);WRITE('Í');
              GOTOXY(I,(13-y)+12);WRITE('Í');
         END;
         FOR i:= y+1 TO (13-y)+12 DO
         BEGIN
              GOTOXY(x,I);WRITE('º');
              GOTOXY((81-x),I);WRITE('º');
         END;
         GOTOXY(x,y);WRITE('É');
         GOTOXY(81-x,y);WRITE('»');
         GOTOXY(x,13-y+12);WRITE('È');
         GOTOXY(81-x,13-y+12);WRITE('¼');
         a:=y+1;
         REPEAT
             FOR I:= x+1 TO 80-x DO
                 BEGIN
                       GOTOXY(I,a);WRITE(' ');
                 END;
             a:=a+1;
         UNTIL a>24-y;
    END;

BEGIN
    Rahmen(1,1,Farbe_Hintergrund);
    Rahmen(20,10,Farbe_Spieler);
    GOTOXY(25,12);WRITE('Gib Deinen Namen ein: ');
    READLN(Spieler);
    ClrScr;
    RANDOMIZE;
    StartKapital:=Random(100)+1000;
    Count:=Startkapital;
    TEXTBACKGROUND(Farbe_Hintergrund);
    TEXTCOLOR(black);
    REPEAT
        ClrScr;
        REPEAT
        Rahmen(1,1,Farbe_Hintergrund);
              Rahmen(20,10,Farbe_Einsatz);
              GOTOXY(25,13);WRITE('       Dein Kontostand: ');
              GOTOXY(49,13);WRITE(Count:5:2);
              GOTOXY(25,12);WRITE('Gib deinen Einsatz ein: ');READLN(Einsatz);
              IF Einsatz>Count THEN BEGIN
                                         WRITE(^G);
                                         Rahmen(15,10,Farbe_Achtung);
                                         GOTOXY(17,10);TEXTBACKGROUND(Farbe_Achtung+Blink);
                                         WRITE('Warnung an ',Spieler,' !');GOTOXY(31,12);
                                         WRITE('Nicht bescheissen !');GOTOXY(27,13);
                                         WRITE('Du hast nicht soviel Geld !');GOTOXY(1,25);
                                         Taste:=READKEY;TEXTBACKGROUND(Farbe_Hintergrund);ClrScr;
                                    END;
        UNTIL (Einsatz<=Count) AND (Einsatz>0);
        TEXTBACKGROUND(Farbe_Hintergrund);
        ClrScr;
        Rahmen(1,1,Farbe_Hintergrund);
        GOTOXY(2,21);WRITE('   Spieler: ',Spieler);
        GOTOXY(2,22);WRITE('   Einsatz: ',Einsatz:5:2);
        GOTOXY(2,23);WRITE('Kontostand:             ');
        GOTOXY(14,23);WRITE(Count:5:2);
        GOTOXY(37,20);WRITE('>TASTE<');GOTOXY(1,25);Taste:=READKEY;
        Rahmen(20,09,Farbe_Wuerfeln);
        Wuerfeln;
        CASE Summe OF
             7,11 : BEGIN
                     TEXTCOLOR(17);TEXTBACKGROUND(Farbe_Wuerfeln);
                     GOTOXY(25,13);WRITE('Du hast Fr.',2*Einsatz:5:2,' gewonnen !');
                     Count:=Count+2*Einsatz;
                     GOTOXY(1,25);
                    END;
           2,3,12 : BEGIN
                     TEXTCOLOR(17);TEXTBACKGROUND(Farbe_Wuerfeln);
                     GOTOXY(25,13);WRITE('Du hast verloren !');
                     Count:=Count-Einsatz;
                     GOTOXY(1,25);
                    END;
           ELSE BEGIN
                  Point:=Summe;
                  TEXTCOLOR(4);
                  GOTOXY(28,2);WRITE('Du spielst mit Point: ',Point);
                  SOUND(440);DELAY(100);NOSOUND;
                  TEXTCOLOR(black);
                  REPEAT
                        GOTOXY(37,20);WRITE('>TASTE<');GOTOXY(1,25);Taste:=READKEY;
                        Wuerfeln;
                        UNTIL (Summe=7) OR (Summe=Point);
                  GOTOXY(25,13);
                  TEXTCOLOR(17);TEXTBACKGROUND(Farbe_Wuerfeln);
                  IF Summe=7 THEN BEGIN
                                      WRITE('Du hast verloren !');
                                      Count:=Count-Einsatz;
                                  END
                             ELSE BEGIN
                                      WRITE('Du hast Fr.',2*Einsatz:5:2,' gewonnen !');
                                      Count:=Count+2*Einsatz;
                                  END;
                             GOTOXY(1,25);
                END;
        END;
        REPEAT
              TEXTCOLOR(black);TEXTBACKGROUND(Farbe_Hintergrund);
              GOTOXY(2,23);WRITE('Kontostand:               ');
              GOTOXY(14,23);WRITE(Count:5:2);GOTOXY(1,25);
              IF Count>0 THEN BEGIN
                                   GOTOXY(28,20);
                                   WRITE('Willst Du nochmals ? [j/n]');
                                   GOTOXY(1,25);Antwort:=READKEY;
                                   END
                         ELSE BEGIN
                                   DELAY(2000);Rahmen(15,10,Farbe_Achtung);
                                   GOTOXY(17,10);TEXTBACKGROUND(Farbe_Achtung+Blink);
                                   WRITE('Mitteilung an ',Spieler,' !');GOTOXY(29,12);
                                   WRITE('Dein Geld ist zuende !');GOTOXY(24,13);
                                   WRITE('Willst Du nochmals neu anfangen ?[j/n]');
                                   GOTOXY(1,25);
                                   Antwort:=READKEY;TEXTBACKGROUND(Farbe_Hintergrund);ClrScr;
                                   Startkapital:=Random(100)+1000;
                                   Count:=Startkapital;
                              END;
        UNTIL (Antwort='n') OR (Antwort='j');
    UNTIL Antwort='n';
END.



