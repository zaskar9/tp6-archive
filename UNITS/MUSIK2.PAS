UNIT Musik;

INTERFACE
USES CRT;
PROCEDURE Ton(Hoehe : STRING; Oktave : INTEGER; VAR Hertz : Integer);
PROCEDURE Pause(Laenge : CHAR);
PROCEDURE Zufall(Obergrenze, Untergrenze, Anzahl : INTEGER);
IMPLEMENTATION
PROCEDURE Ton(Hoehe : STRING; Oktave : INTEGER; VAR Hertz : INTEGER);

VAR I,J,A, Test : INTEGER;

BEGIN
     IF Hoehe='*' THEN I:=20000;
     FOR A := 1 TO LENGTH(Hoehe) DO
         Hoehe[A] := UPCASE(Hoehe[A]);
              Repeat
                    Test:=POS(' ',Hoehe);
                    Delete(Hoehe,Test,1);
              Until Test=0;
              IF Hoehe='C' THEN BEGIN
                                  CASE Oktave OF
                                     0 : I := 16;
                                     1 : I := 33;
                                     2 : I := 65;
                                     3 : I := 131;
                                     4 : I := 262;
                                     5 : I := 523;
                                     6 : I := 1047;
                                     7 : I := 2093;
                                  END;
                                END;
              IF Hoehe='CIS' THEN BEGIN
                                    CASE Oktave OF
                                       0 : I := 17;
                                       1 : I := 35;
                                       2 : I := 69;
                                       3 : I := 139;
                                       4 : I := 277;
                                       5 : I := 554;
                                       6 : I := 1109;
                                       7 : I := 2218;
                                    END;
                                  END;
             IF Hoehe='D' THEN BEGIN
                                 CASE Oktave OF
                                    0 : I := 18;
                                    1 : I := 37;
                                    2 : I := 73;
                                    3 : I := 147;
                                    4 : I := 294;
                                    5 : I := 587;
                                    6 : I := 1175;
                                    7 : I := 2349;
                                 END;
                               END;
             IF Hoehe='DIS' THEN BEGIN
                                   CASE Oktave OF
                                      0 : I := 19;
                                      1 : I := 39;
                                      2 : I := 78;
                                      3 : I := 156;
                                      4 : I := 311;
                                      5 : I := 622;
                                      6 : I := 1245;
                                      7 : I := 2489;
                                   END;
                                 END;
              IF Hoehe='E' THEN BEGIN
                                   CASE Oktave OF
                                      0 : I := 21;
                                      1 : I := 41;
                                      2 : I := 82;
                                      3 : I := 165;
                                      4 : I := 329;
                                      5 : I := 659;
                                      6 : I := 1319;
                                      7 : I := 2637;
                                   END;
                                 END;
              IF Hoehe='F' THEN BEGIN
                                   CASE Oktave OF
                                      0 : I := 22;
                                      1 : I := 44;
                                      2 : I := 87;
                                      3 : I := 175;
                                      4 : I := 349;
                                      5 : I := 699;
                                      6 : I := 1397;
                                      7 : I := 2794;
                                   END;
                                 END;
              IF Hoehe='FIS' THEN BEGIN
                                   CASE Oktave OF
                                      0 : I := 23;
                                      1 : I := 46;
                                      2 : I := 93;
                                      3 : I := 185;
                                      4 : I := 370;
                                      5 : I := 740;
                                      6 : I := 1480;
                                      7 : I := 2960;
                                   END;
                                 END;
              IF Hoehe='G' THEN BEGIN
                                   CASE Oktave OF
                                      0 : I := 25;
                                      1 : I := 49;
                                      2 : I := 98;
                                      3 : I := 196;
                                      4 : I := 392;
                                      5 : I := 784;
                                      6 : I := 1568;
                                      7 : I := 3136;
                                   END;
                                 END;
              IF Hoehe='GIS' THEN BEGIN
                                   CASE Oktave OF
                                      0 : I := 26;
                                      1 : I := 52;
                                      2 : I := 104;
                                      3 : I := 208;
                                      4 : I := 415;
                                      5 : I := 831;
                                      6 : I := 1661;
                                      7 : I := 3322;
                                   END;
                                 END;
              IF Hoehe='A' THEN BEGIN
                                   CASE Oktave OF
                                      0 : I := 28;
                                      1 : I := 55;
                                      2 : I := 110;
                                      3 : I := 220;
                                      4 : I := 440;
                                      5 : I := 880;
                                      6 : I := 1760;
                                      7 : I := 3520;
                                   END;
                                 END;
               IF Hoehe='AIS' THEN BEGIN
                                   CASE Oktave OF
                                      0 : I := 29;
                                      1 : I := 58;
                                      2 : I := 117;
                                      3 : I := 233;
                                      4 : I := 466;
                                      5 : I := 932;
                                      6 : I := 1865;
                                      7 : I := 3729;
                                   END;
                                 END;
               IF Hoehe='H' THEN BEGIN
                                   CASE Oktave OF
                                      0 : I := 31;
                                      1 : I := 62;
                                      2 : I := 124;
                                      3 : I := 247;
                                      4 : I := 494;
                                      5 : I := 988;
                                      6 : I := 1976;
                                   END;
                                 END;
         Hertz:=I;
         END;

PROCEDURE Pause(Laenge : CHAR);
          VAR J : INTEGER;
          BEGIN
           CASE UPCASE(Laenge) OF
            'A': J :=250;
            'V': J :=500;
            'H': J :=1000;
            'P': J :=1500;
            'G': J :=2000;
           END;
           DELAY(J);
          END;
PROCEDURE Zufall(Obergrenze, Untergrenze, Anzahl : INTEGER);
          VAR H,Ton,Laenge : INTEGER;
          BEGIN
             H := 0;
             Randomize;
             REPEAT
               Inc(H);
               Ton:=RANDOM(Obergrenze)+Untergrenze;
               Laenge:=RANDOM(500)+1;
               SOUND(Ton);DELAY(Laenge);NOSOUND;
             UNTIL H > Anzahl;
          END;
END.