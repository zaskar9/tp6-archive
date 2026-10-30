PROCEDURE DateiLoeschen;
          VAR Dat          : STRING;
              Fil          : FILE OF CLASS;
              Fehler       : INTEGER;
BEGIN
     ClrScr;
     Hintergrund;
     GotoXY(1,1);
     TextColor(0);
     WRITELN(' D A T E I L ™ S C H E N ');
     Repeat
           Rahmen(15,07,65,13,green);
           WRITE(' Geben Sie den Pfad ein');
           TEXTBACKGROUND(lightgray);
           GOTOXY(17,09);WRITE('                                               ');
           GOTOXY(18,09);READLN(Dat);
           IF Dat='' THEN Exit;
           TextBackGround(green);
           Dat:=Dat+'.NOT';
           GotoXY(1,25);
           Assign(Fil,Dat);
           {$I-}
           Erase(Fil);
           {$I+}
           GotoXY(17,11);
           Fehler:=IOResult;
           Case Fehler Of
           0 : WriteLn('Vorgang erfolgreich abgeschlossen !');
           2 : WriteLn('Datei nicht gefunden !');
           3 : WriteLn('Pfad nicht gefunden !');
           4 : WriteLn('Zu viele offene Dateien !');
           ELSE WriteLn('Schwerer Fehler !');
           END;
           GotoXY(1,25);
           Taste:=ReadKey;
     Until (Fehler=0) OR (Taste=#27);
     Taste:=' ';
END;

