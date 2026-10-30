Procedure SaveDatei;

VAR Pfad             : STRING;
    Wort, Antwort    : CHAR;
    u,i              : INTEGER;
    Result           : INTEGER;

BEGIN
     Hintergrund;
     GOTOXY(2,1);
     WRITE('D A T E N   S P E I C H E R N');
     Repeat
           Rahmen(20,5,60,15,green);
           GOTOXY(22,6);WRITE('Pfad');
           TEXTBACKGROUND(lightgray);
           GOTOXY(22,7);WRITE('                                     ');
           GOTOXY(23,7);READLN(Pfad);                                     
           Gotoxy(22,16);
           Pfad:=Pfad+'.NOT';
           ASSIGN(Datei,Pfad);
           {$I-}
           Reset(Datei);
           TextBackGround(green);
           Result:=IOResult;
           CASE Result OF
                0 : BEGIN
                         GotoXY(22,9); WRITE('Ihre Datei besteht bereits  ');
                         GotoXY(22,10);WRITE('Alle Daten wrden gel”scht  ');
                         GOTOXY(22,11);WRITE('Wollen Sie trotzdem speichern (j/n)');
                         Gotoxy(22,16);
                         Repeat
                               antwort:=Upcase(ReadKey);
                         until (antwort='J') OR (antwort='N');
                         IF antwort='N' THEN Exit;
                    END;
                2 : BEGIN
                         GOTOXY(22,9); WRITE('Datei nicht gefunden  ');
                         GOTOXY(22,10);WRITE('Datei wird erstellt');
                         GOTOXY(22,16);
                         Taste:=ReadKey;
                    END;
                3 : BEGIN
                         GOTOXY(22,9);WRITE('Pfad nicht richtig  ');
                         GOTOXY(22,16);
                         Taste:=ReadKey;
                    END;
                 5 : BEGIN
                          GotoXY(22,9); WRITE('Kein Datenzugriff m”glich');
                          GOTOXY(22,16);
                          Taste:=ReadKey;
                     END;
                152 : BEGIN
                          GotoXY(22,9); WRITE('Laufwerk nicht bereit');
                          GOTOXY(22,16);
                          Taste:=ReadKey;
                     END;
                ELSE BEGIN
                          GotoXY(22,10);WRITE('Starten Sie Ihr System neu !');
                          GOTOXY(22,16);
                          DELAY(5000);Halt;
                     END;
           END; {END OF CASE}
     UNTIL (Result=0) OR (Result=2);
     GOTOXY(22,13);
     WRITE('Speichere jetzt Ihre Daten !');
     Gotoxy(22,16);
     Rewrite(Datei);
     {$I+}
     I:=1;
     Repeat
           WRITE(Datei,Datensatz[i]);
           INC(I);
     UNTIL I>AnzDaten;
     SEEK(Datei,AnzDaten-1);
     TRUNCATE(Datei);
     Gespeichert:=true;
     Close(Datei);
END;

