Procedure HelpMe(Code : INTEGER);

VAR Rect              : Rahmen;
    Text              : STRING;

BEGIN
     Rect.Init(10,7,70,13,red,false);
     Case Code Of
      2 : Text:='Datei nicht gefunden';
      3 : Text:='Pfad nicht gefunden';
      4 : Text:='Zuviele Dateien';
      5 : Text:='Kein Datenzugriff mîglich';
      6 : Text:='UngÅltiger Zugriff';
      8 : Text:='Zuwenig Speicher';
     10 : Text:='UngÅltiger Bereich';
     11 : Text:='UngÅltiges Befehlsformat';
     15 : Text:='Laufwerk ungÅltig';
     16 : Text:='Verzeichnis kann nicht entfernt werden';
     18 : Text:='Keine Datei mehr vorhanden';
     ELSE Text:='Schwerer Fehler';
     END;
     HideCursor;
     Rect.Draw(lightred);
     Write(Text);
     TextColor(0);
     GotoXY(1,25);
     Repeat Until KeyPressed;
     TextColor(white);
     Rect.Cancel('€',black);
     ShowCursor;
END;
