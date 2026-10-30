PROGRAM Video;
USES CRT;

VAR Name,Medium,Vorname,Datum,frist                   : STRING;
    Anzahl,s,kunde                                    : INTEGER;
    n1,n2,n3,n4,n5,n6,n7,n8,n9,n10,nummer             : STRING;

BEGIN
   ClrScr;
   GOTOXY(10,2);TEXTCOLOR(7);
   WRITE('Gib die Kundennummer ein        : ');
   READLN(kunde);
   GOTOXY(10,3);
   WRITE('Gib den Namen ein               : ');
   READLN(name);
   GOTOXY(10,4);
   WRITE('Gib den Vornamen ein            : ');
   READLN(vorname);
      CASE kunde OF
           001 : BEGIN name:='Weiss';vorname:='Andr';END;
      END;
   GOTOXY(10,5);
   WRITE('Gib das Medium ein              : ');
   READLN(Medium);
   GOTOXY(10,6);
   WRITE('Gib die Anzahl ein(max.10 Stck): ');
   READLN(anzahl);
          IF anzahl>10 THEN BEGIN TEXTCOLOR(6);WRITELN('         Limit berschritten !');END;
          IF anzahl>10 THEN anzahl:=10;
   GOTOXY(10,9);TEXTCOLOR(7);WRITE('Gib das heutige Datum ein       : ');READLN(datum);
   s:=0;n1:='*';n2:='*';n3:='*';n4:='*';n5:='*';n6:='*';n7:='*';n8:='*';n9:='*';n10:='*';
   WRITELN;
   REPEAT
          s:=s+1;
          WRITE('         Gib die Nummer ein: ');
          READLN(nummer);
               CASE s OF
                    1 : N1:=nummer;
                    2 : N2:=nummer;
                    3 : N3:=nummer;
                    4 : N4:=nummer;
                    5 : N5:=nummer;
                    6 : N6:=nummer;
                    7 : N7:=nummer;
                    8 : N8:=nummer;
                    9 : N9:=nummer;
                    10 : N10:=nummer;
                END;
   UNTIL s=anzahl;
   IF medium='Video'THEN frist:='2 Wochen'
                    ELSE frist:='3 Wochen';

   CLRSCR;
   GOTOXY(5,5);TEXTCOLOR(7);
   WRITE('ษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป');
   GOTOXY(5,6);WRITE('บ');
   GOTOXY(75,6);WRITE('บ');
   GOTOXY(10,6);WRITE('MICHAEL  GROSSNIKLAUS  VIDEOVERLEIH');
   GOTOXY(5,7);WRITELN('ฬอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออน');
   s:=0;
   REPEAT
        WRITELN('    บ                                                                     บ');
        s:=s+1;
   UNTIL s>10;
   WRITELN('    ศอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ');
   GOTOXY(10,8);WRITE('Vorname: ',vorname);
   GOTOXY(10,9);WRITE('Name   : ',name);
   GOTOXY(10,11);WRITE('Medium : ',medium,'         ( ',anzahl,' Stck )');
   GOTOXY(10,13);WRITE('Nummer : ',n1,' / ',n2,' / ',n3,' / ',n4,' / ',n5);
   GOTOXY(10,14);WRITE('         ',n6,' / ',n7,' / ',n8,' / ',n9,' / ',n10);
   GOTOXY(10,16);TEXTCOLOR(11);WRITE('AUSLEIHDATUM  : ',datum);
   GOTOXY(10,18);TEXTCOLOR(5);WRITE('AUSLEIHFRIST  : ',frist);
   GOTOXY(25,80);WRITELN;

   REPEAT UNTIL KEYPRESSED;

END.




