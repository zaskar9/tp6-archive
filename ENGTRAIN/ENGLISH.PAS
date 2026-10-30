PROGRAM Englischtrainer;
USES CRT;

VAR Wort,Loesung,Eingabe               : STRING;
    Lektion,Nummer                     : STRING[3];
    Ziffer,Zahl,s,t,Error,u,o,Fehler   : INTEGER;
    Datei                              : TEXT;
    Wert                               : BOOLEAN;
    Taste,Taste1,Wahl                  : CHAR;

PROCEDURE Rahmen(Hintergrund,Groesse,Laenge : INTEGER);

        VAR I,v,x,y,z : INTEGER;
        BEGIN
           x:=5;z:=75;
           TEXTCOLOR(0);TEXTBACKGROUND(Hintergrund);
           GOTOXY(x,Groesse);WRITE('…');
           GOTOXY(z,Groesse);WRITE('ª');
           GOTOXY(x,Laenge);WRITE('»');
           GOTOXY(z,Laenge);WRITE('º');
           FOR I :=(x+1) TO (z-1) DO
               BEGIN
                  GOTOXY(I,Groesse);WRITE('Õ');
                  GOTOXY(I,Laenge);WRITE('Õ');
               END;
           FOR I :=(Groesse+1) TO (Laenge-1) DO
               BEGIN
                  GOTOXY(x,I);WRITE('∫                                                                     ∫');
               END;
        END;
PROCEDURE Bild(Hintergrund,Groesse,Laenge : INTEGER);

        VAR I,v,x,y,z : INTEGER;
        BEGIN
           x:=1;z:=80;
           TEXTCOLOR(0);TEXTBACKGROUND(Hintergrund);
           FOR I :=(x+1) TO (z-1) DO
               BEGIN
                  GOTOXY(I,Groesse);WRITE('Õ');
                  GOTOXY(I,Laenge);WRITE('Õ');
               END;
           FOR I :=(Groesse+1) TO (Laenge-1) DO
               BEGIN
                  GOTOXY(x,I);WRITE('∫                                                                              ∫');
               END;
           GOTOXY(x,Groesse);WRITE('…');
           GOTOXY(z,Groesse);WRITE('ª');
           GOTOXY(x,Laenge);WRITE('»');
           GOTOXY(z,Laenge);WRITE('º');
           GOTOXY(x,Groesse+2);WRITE('ÃÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕπ');
           GOTOXY(1,25);
END;
PROCEDURE Ordnen(Ziffer : INTEGER);
BEGIN
     CASE Ziffer OF
      1 : Assign(Datei, 'A:L1.VOC');
      2 : Assign(Datei, 'A:L2.VOC');
      3 : Assign(Datei, 'A:L3.VOC');
      4 : Assign(Datei, 'A:L4.VOC');
      5 : Assign(Datei, 'A:L5.VOC');
      6 : Assign(Datei, 'A:L6.VOC');
      7 : Assign(Datei, 'A:L7.VOC');
      8 : Assign(Datei, 'A:L8.VOC');
      9 : Assign(Datei, 'A:L9.VOC');
     END;
END;
PROCEDURE Zuordnen(Zahl : INTEGER);
BEGIN
     CASE Zahl OF
      1 : Assign(Datei, 'A:L_1.VOC');
      2 : Assign(Datei, 'A:L_2.VOC');
      3 : Assign(Datei, 'A:L_3.VOC');
      4 : Assign(Datei, 'A:L_4.VOC');
      5 : Assign(Datei, 'A:L_5.VOC');
      6 : Assign(Datei, 'A:L_6.VOC');
      7 : Assign(Datei, 'A:L_7.VOC');
      8 : Assign(Datei, 'A:L_8.VOC');
      9 : Assign(Datei, 'A:L_9.VOC');
     10 : Assign(Datei, 'A:L10.VOC');
     11 : Assign(Datei, 'A:L11.VOC');
     12 : Assign(Datei, 'A:L12.VOC');
     13 : Assign(Datei, 'A:L13.VOC');
     14 : Assign(Datei, 'A:L14.VOC');
     15 : Assign(Datei, 'A:L15.VOC');
     16 : Assign(Datei, 'A:L16.VOC');
     17 : Assign(Datei, 'A:L17.VOC');
     18 : Assign(Datei, 'A:L18.VOC');
     19 : Assign(Datei, 'A:L19.VOC');
     20 : Assign(Datei, 'A:L20.VOC');
     21 : Assign(Datei, 'A:L21.VOC');
     22 : Assign(Datei, 'A:L22.VOC');
     23 : Assign(Datei, 'A:L23.VOC');
     24 : Assign(Datei, 'A:L24.VOC');
     25 : Assign(Datei, 'A:L25.VOC');
     26 : Assign(Datei, 'A:L26.VOC');
     27 : Assign(Datei, 'A:L27.VOC');
     28 : Assign(Datei, 'A:L28.VOC');
     END;
END;
PROCEDURE Fanfare;
          CONST H=1000;
          CONST T=333;
          CONST S=666;
          CONST D=3000;
          BEGIN
	     SOUND(294);DELAY(H);NOSOUND;DELAY(20);
	     SOUND(370);DELAY(T);NOSOUND;DELAY(20);
	     SOUND(294);DELAY(T);NOSOUND;DELAY(20);
	     SOUND(370);DELAY(T);NOSOUND;DELAY(20);
	     SOUND(440);DELAY(H);NOSOUND;DELAY(20);
	     SOUND(587);DELAY(S);NOSOUND;DELAY(20);
	     SOUND(659);DELAY(T);NOSOUND;DELAY(20);
	     SOUND(659);DELAY(D);NOSOUND;DELAY(20);
	     SOUND(587);DELAY(T);NOSOUND;DELAY(20);
	     SOUND(659);DELAY(T);NOSOUND;DELAY(20);
	     SOUND(740);DELAY(T);NOSOUND;DELAY(20);
	     SOUND(659);DELAY(S);NOSOUND;DELAY(20);
	     SOUND(440);DELAY(T);NOSOUND;DELAY(20);
             SOUND(440);DELAY(D);NOSOUND;DELAY(20);
          END;
PROCEDURE Lob;
          BEGIN
               SOUND(392);DELAY(250);
               SOUND(440);DELAY(250);
               SOUND(494);DELAY(250);
               SOUND(523);DELAY(600);
               NOSOUND;
          END;
PROCEDURE Hymne;
          CONST A=250;
          CONST V=500;
          CONST H=1000;
          CONST P=1500;
          CONST G=2000;
          CONST D=3000;
          BEGIN
             SOUND(294);DELAY(H);NOSOUND;DELAY(20);
             SOUND(294);DELAY(H);
     	     SOUND(329);DELAY(H);
	     SOUND(277);DELAY(P);
	     SOUND(294);DELAY(V);
	     SOUND(329);DELAY(H);
	     SOUND(370);DELAY(H);NOSOUND;DELAY(20);
	     SOUND(370);DELAY(H);
	     SOUND(392);DELAY(H);
	     SOUND(370);DELAY(P);
	     SOUND(329);DELAY(V);
	     SOUND(294);DELAY(H);
	     SOUND(329);DELAY(H);
	     SOUND(294);DELAY(H);
	     SOUND(277);DELAY(H);
	     SOUND(294);DELAY(D);
	     SOUND(440);DELAY(H);NOSOUND;DELAY(20);
	     SOUND(440);DELAY(H);NOSOUND;DELAY(20);
	     SOUND(440);DELAY(H);NOSOUND;DELAY(20);
	     SOUND(440);DELAY(P);
	     SOUND(392);DELAY(V);
	     SOUND(370);DELAY(H);
	     SOUND(392);DELAY(H);NOSOUND;DELAY(20);
	     SOUND(392);DELAY(H);NOSOUND;DELAY(20);
	     SOUND(392);DELAY(H);NOSOUND;DELAY(20);
	     SOUND(392);DELAY(P);
	     SOUND(370);DELAY(V);
	     SOUND(329);DELAY(H);
	     SOUND(370);DELAY(H);
	     SOUND(392);DELAY(V);
	     SOUND(370);DELAY(V);
	     SOUND(329);DELAY(V);
	     SOUND(294);DELAY(V);
	     SOUND(370);DELAY(P);
	     SOUND(392);DELAY(V);
	     SOUND(440);DELAY(H);
	     SOUND(494);DELAY(V);
	     SOUND(392);DELAY(V);
	     SOUND(370);DELAY(H);
	     SOUND(329);DELAY(H);
	     SOUND(294);DELAY(D);
	     NOSOUND;
	  END;
PROCEDURE Kata;
          BEGIN
             SOUND(294);DELAY(800);
             SOUND(329);DELAY(200);
             SOUND(349);DELAY(1000);
             SOUND(294);DELAY(1000);
             SOUND(415);DELAY(250);
             SOUND(425);DELAY(250);
             SOUND(415);DELAY(250);
             SOUND(425);DELAY(250);
             SOUND(415);DELAY(250);
             SOUND(425);DELAY(250);
             SOUND(415);DELAY(250);
             SOUND(425);DELAY(250);
             NOSOUND;
          END;
PROCEDURE Bewertung(s,t : INTEGER);
          VAR Punkte,Maximum : INTEGER;
             Note            : REAL;
          BEGIN
             DELAY(2000);
             IF S>0 THEN BEGIN
                              Rahmen(2,7,18);
                              GOTOXY(31,9);WRITE('B E W E R T U N G :');
                              GOTOXY(17,11);WRITE('Richtige Wîrter  : ',s-t);
                              GOTOXY(17,12);WRITE('Falsche  Wîrter  : ',t);
                              GOTOXY(17,13);WRITE('Mîgliches Maximum: ',s);
                              IF S>0 THEN BEGIN
                                                Note:=((s-t)*5)/s+1;
                                                GOTOXY(17,14);WRITE('Trefferquote     : ',(100*(s-t))/s:4:1,' %');
                                                GOTOXY(17,15);WRITE('Note             : ',Note:2:1);
                                          END;
	                      GOTOXY(31,17);WRITE('WEITER MIT <TASTE>');GOTOXY(1,25);
                              IF S>0 THEN BEGIN
                                               IF Note>= 5.5 THEN Fanfare;
                                               IF Note<= 2.5 THEN Kata;
                         END;                 END;
             Taste:=READKEY;
          END;
PROCEDURE Copyright;
          BEGIN
              TEXTBACKGROUND(7);ClrScr;Bild(7,1,24);TEXTCOLOR(132);
              GOTOXY(29,2);WRITE('W I L L K O M M E N  !');
              TEXTCOLOR(0);
              Rahmen(3,7,18);
              GOTOXY(24,9);WRITE('E N G L I S H T R A I N E R  1.0');
              GOTOXY(39,11);WRITE('zu');
              GOTOXY(23,12);WRITE('Learning English Compact Course  I');
              GOTOXY(23,14);WRITE('von Michael Grossniklaus  (Syntax)');
              GOTOXY(23,15);WRITE('   und Fabian Kristmann (Musik)   ');
              GOTOXY(24,16);WRITE('              1993');GOTOXY(1,25);Hymne;
              TEXTCOLOR(0);GOTOXY(31,17);WRITE('WEITER MIT <TASTE>');GOTOXY(1,25);
              Taste:=READKEY;
          END;
PROCEDURE About;
          BEGIN
              TEXTBACKGROUND(7);ClrScr;Bild(7,1,24);TEXTCOLOR(1);
              GOTOXY(15,2);WRITE('ö B E R   D E N   E N G L I S H T R A I N E R   0.1');
              TEXTCOLOR(0);Rahmen(3,7,18);
              GOTOXY(9,8); WRITE('Bedienung : ');
              GOTOXY(14,10);WRITE('1. WÑhlen Sie im Menu einen Punkt mit dem angegebenen ');
              GOTOXY(14,11);WRITE('   Buchstaben aus.');
              GOTOXY(14,12);WRITE('2. Danach geben Sie die Lektion ein, die Sie bearbeiten');
              GOTOXY(14,13);WRITE('   wollen.');
              GOTOXY(14,14);WRITE('3. Geben Sie die englische öbersetzung des Wortes ein.');
              GOTOXY(14,16);WRITE('5. Im Notfall kann das Programm mit <+> beendet werden !');
              GOTOXY(14,15);WRITE('4. Mit <*> kann vorzeitig zur Bewertung gewechselt werden.');
              GOTOXY(31,17);WRITE('WEITER MIT <TASTE>');GOTOXY(1,25);
              Taste:=READKEY;
              TEXTCOLOR(0);Rahmen(3,7,18);
              GOTOXY(9,8);WRITE('Wissenswertes :');
              GOTOXY(12,10);WRITE('1. Bei der öbersetzung sollten Sie darauf achten, dass Sie');
              GOTOXY(12,11);WRITE('   alles genau so eingeben, wie es in der Aufgabenstellung');
              GOTOXY(12,12);WRITE('   auch getan wurde. Speziell Leerzeichen am Anfang oder am');
              GOTOXY(12,13);WRITE('   Ende der Lîsung kînnen zu MissverstÑndnissen fÅhren.');
              GOTOXY(12,14);WRITE('2. Interpunktionen mÅssen, sofern im deutschen Text vorhanden,');
              GOTOXY(12,15);WRITE('   an der gleichen Stelle gesetzt werden.');
              GOTOXY(31,17);WRITE('WEITER MIT <TASTE>');GOTOXY(1,25);
              Taste:=READKEY;
          END;
BEGIN
         Copyright;
         About;
         REPEAT
         s:=0;t:=0;
         TEXTBACKGROUND(7);
         Bild(7,1,24);GOTOXY(36,2);WRITE('M E N U E');
         GOTOXY(20,9);WRITE('First Steps..........................<A>');
         GOTOXY(20,10);WRITE('Unit 1...............................<B>');
         GOTOXY(20,11);WRITE('Unit 2...............................<C>');
         GOTOXY(20,12);WRITE('Unit 3...............................<D>');
         GOTOXY(20,13);WRITE('Unit 4...............................<E>');
         GOTOXY(20,14);WRITE('Unit 5...............................<F>');
         GOTOXY(20,15);WRITE('Unit 6...............................<G>');
         GOTOXY(20,16);WRITE('Unit 7...............................<H>');
         GOTOXY(20,18);WRITE('Programm beenden.....................<Z>');GOTOXY(1,25);
         Wahl:=UPCASE(READKEY);
         IF Wahl='Z' THEN BEGIN
                            ClrScr;Bild(7,1,24);GOTOXY(24,2);
                            TEXTCOLOR(132);WRITE('A U F   W I E D E R S E H E N  !');
                            Rahmen(3,7,18);
                            GOTOXY(24,9);WRITE('E N G L I S H T R A I N E R  1.0');
                            GOTOXY(39,11);WRITE('zu');
                            GOTOXY(23,12);WRITE('Learning English Compact Course  I');
                            GOTOXY(23,14);WRITE('von Michael Grossniklaus  (Syntax)');
                            GOTOXY(23,15);WRITE('   und Fabian Kristmann (Musik)   ');
                            GOTOXY(24,16);WRITE('              1993');GOTOXY(1,25);Fanfare;
                            TEXTBACKGROUND(0);TEXTCOLOR(7);ClrScr;
                          END
                          ELSE BEGIN
                                 CASE Wahl OF
                                    'A' : BEGIN u:=1;o:=9;END;
                                    'B' : BEGIN u:=1;o:=4;END;
                                    'C' : BEGIN u:=5;o:=8;END;
                                    'D' : BEGIN u:=9;o:=13;END;
                                    'E' : BEGIN u:=14;o:=17;END;
                                    'F' : BEGIN u:=18;o:=21;END;
                                    'G' : BEGIN u:=22;o:=25;END;
                                    'H' : BEGIN u:=26;o:=28;END;
                                 END;
                          ClrScr;Bild(7,1,24);GOTOXY(34,2);WRITE('A U S W A H L');
                          IF Wahl IN ['B'..'H'] THEN BEGIN
                                                    REPEAT
                                                        GOTOXY(12,13);
                                                        WRITE('Geben Sie die Lektion(',u,'-',o,') ein,');
                                                        WRITE(' die Sie lernen mîchten: ');
                                                        READLN(Lektion);
                                                        VAL(Lektion,Zahl,Error);
                                                        Bild(7,1,24);GOTOXY(34,2);WRITE('A U S W A H L');GOTOXY(1,25);
                                                        Zuordnen(Zahl);
                                                        GOTOXY(1,25);
                                                    UNTIL (Zahl IN [u..o]) and (Error = 0);
                                                 END
                                           ELSE  BEGIN
                                                    REPEAT
                                                        GOTOXY(12,13);WRITE('Geben Sie die Lektion(',u,'-',o,') ein,');
                                                        WRITE(' die Sie lernen mîchten: ');
                                                        READLN(Nummer);
                                                        VAL(Nummer,Ziffer,Fehler);
                                                        Bild(7,1,24);GOTOXY(34,2);WRITE('A U S W A H L');GOTOXY(1,25);
                                                        Ordnen(Ziffer);
                                                        GOTOXY(1,25);
                                                    UNTIL (Ziffer IN [u..o]) and (Fehler = 0)
                                                 END;
                                     IF Wahl='A' THEN BEGIN
                                                        ClrScr;Bild(7,1,24);GOTOXY(32,2);WRITE('L E K T I O N : ',Nummer);
                                                        GOTOXY(1,25);
                                                      END
                                                 ELSE BEGIN
                                                        ClrScr;Bild(7,1,24);GOTOXY(32,2);WRITE('L E K T I O N : ',Lektion);
                                                        GOTOXY(1,25);
                                                      END;
         		             Reset(Datei);
                                     REPEAT
                                     IF not EOF (Datei) THEN
                                       BEGIN
                                       READLN(Datei, Wort);
                                       READLN(Datei, Loesung);
                                       Rahmen(11,10,15);
                                       GOTOXY(60,12);WRITE('Richtig: ',s-t);
                                       GOTOXY(60,13);WRITE('Falsch : ',t);GOTOXY(60,14);WRITE('Total  : ',s);
                                       GOTOXY(9,11);WRITE(Wort,' : ');S:=S+1;
                                       READLN(Eingabe);
                                       IF Eingabe='*' THEN BEGIN
                                                             GOTOXY(1,25);
                                                             S:=S-1;
                                                           END
                                                       ELSE IF Eingabe= '+' THEN EXIT
                                                                            ELSE IF Eingabe=Loesung THEN BEGIN
                                                                                                          TEXTCOLOR(0);
                                                                                                          GOTOXY(35,14);
                                                                                                          WRITE('Richtig');
                                                                                                          GOTOXY(1,25);Lob;
                                                                                                         END
                                                                                                   ELSE BEGIN
                                                                                                         TEXTCOLOR(132);
                                                                                                         GOTOXY(35,14);
                                                                                                         WRITE('Falsch');
                                                                                                         WRITE(^G);
                                                                                                         TEXTCOLOR(0);T:=T+1;
                                                                                                         GOTOXY(10,12);
                                                                                                         WRITE('Lîsung : '
                                                                                                               ,Loesung);
                           			                                                         GOTOXY(1,25);DELAY(5000);
                                                                                                        END;
                                     END;
                                   UNTIL (Eingabe= '*')or(EOF(Datei));
                                     Bewertung(s,t);TEXTBACKGROUND(7);ClrScr;
                                     Bild(7,1,24);GOTOXY(28,2);WRITE('B I T T E   W A R T E N');
                                     Rahmen(14,10,14);
                                     GOTOXY(26,12);WRITE('Dies ist das Ende der Lektion.');
                                     GOTOXY(1,25);
                                     DELAY(5000);
                                   END;
           UNTIL Wahl='Z';
END.









