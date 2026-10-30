PROCEDURE Menu;

BEGIN
         ClrScr;
         Hintergrund;
         WRITELN(' M E N U');
         Rahmen(18,5,61,17,cyan);
         GOTOXY(20,6); WRITE('Eingabe der DatensÑtze..............<F1>');
         GOTOXY(20,7); WRITE('Ausgabe der DatensÑtze..............<F2>');
         GOTOXY(20,8); WRITE('HinzufÅgen von DatensÑtzen..........<F3>');
         GOTOXY(20,09);WRITE('Durchschnitt berechnen..............<F4>');
         GOTOXY(20,10);WRITE('Zeugnisnoten berechnen..............<F5>');
         GOTOXY(20,11);WRITE('Dateien auflisten...................<F6>');
         GOTOXY(20,12);WRITE('Datei lîschen.......................<F7>');
         GOTOXY(20,13);WRITE('Daten laden.........................<F8>');
         GOTOXY(20,14);WRITE('Daten speichern.....................<F9>');
         GOTOXY(20,15);WRITE('Ausgabemodus Ñndern................<F10>');
         GOTOXY(20,16);WRITE('Programm beenden...................<ESC>');
         GOTOXY(19,18);
END;