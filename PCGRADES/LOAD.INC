Procedure LoadDatei;

VAR Pfad           : STRING;
    Result,I       : INTEGER;

BEGIN
     Hintergrund;
     GOTOXY(2,1);WRITE('D A T E N   L A D E N ');
     Repeat
           Rahmen(20,5,60,15,green);
           Gotoxy(22,6);Write('Pfad');
           TextBackGround(lightgray);
           GOTOXY(22,7);WRITE('                                     ');
           GOTOXY(23,7);READLN(Pfad);
           GOTOXY(22,16);
           Pfad:=Pfad+'.NOT';
           {$I-}
           Assign(Datei,Pfad);
           Reset(Datei);
           TextBackGround(green);
           Result:=IOResult;
           CASE Result OF
                0 : BEGIN
                         GOTOXY(22,9);WRITE('Datei gefunden  ');
                         GOTOXY(22,16);
                    END;
                2 : BEGIN
                         GOTOXY(22,9);WRITE('Datei nicht gefunden  ');
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
     UNTIL (Result=0) OR (Taste=#27);
     IF Taste=#27 THEN Begin Taste:='*';
                             Exit;
                       End;
     GOTOXY(22,11);
     WRITE('Lade jetzt Ihre Daten !');
     Gotoxy(22,16);
     Reset(Datei);
     {$I+}
     I:=1;
     Repeat
           {$I-}
           Read(Datei,Datensatz[i]);
           {$I+}
           IF IOResult<> 0 THEN BEGIN
                                     GotoXY(22,11);
                                     WRITE('Abbruch : Lesefehler   ');
                                     GOTOXY(22,16);
                                     WRITE(^G);
                                     DELAY(5000);Exit;
                                END;
           INC(I);
     UNTIL EOF(Datei);
     AnzDaten:=I;
     Status:=FOpen;
     Close(Datei);
     DELAY(2500);
END;