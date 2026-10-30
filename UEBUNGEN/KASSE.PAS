PROGRAM Kasse;
USES CRT;
   CONST Apfel=0.5;
   CONST Birne=0.45;
   CONST Citrone=1.25;
   VAR Menge,Ergebnis : REAL;
       Artikel        : CHAR;
       Eingabe        : BOOLEAN;
BEGIN
   ClrScr;
   EINGABE:=FALSE;
   GOTOXY(10,3);
   WRITE('Willkommen !');
   GOTOXY(10,5);
   WRITE('Unser Sortiment umfasst:');
   GOTOXY(12,7);
   WRITE('<a>   épfel');
   GOTOXY(12,8);
   WRITE('<b>   Birnen');
   GOTOXY(12,9);
   WRITE('<c>   Citronen');
   GOTOXY(10,12);
   WRITE('Wenn Du etwas mîchtest, gib jeweils den Anfangsbuchstaben an: ');
   READ(artikel);

CASE Artikel OF
   'A','a' : EINGABE:=TRUE;
   'B','b' : EINGABE:=TRUE;
   'C','c' : EINGABE:=TRUE;

ELSE
    BEGIN
         GOTOXY(10,15);
         WRITELN('Tut mir leid, diesen Artikel fÅhren wir NICHT');
    END;
END;
   IF Eingabe THEN
      BEGIN
         GOTOXY(10,16);
         WRITE('Wieviel brauchst Du ? : ');
         READLN(menge);
             CASE Artikel OF
                     'A','a' : Ergebnis:= Apfel*(menge);
                     'B','b' : Ergebnis:= Birne*(menge);
                     'C','c' : Ergebnis:= Citrone*(menge);
             END;
         GOTOXY(10,17);
         WRITE('Bezahle in Franken : ',Ergebnis:10:2);
       END;

   GOTOXY(10,20);
   WRITELN('Bitte eine Taste drÅcken !');
   REPEAT UNTIL KEYPRESSED;
 END.