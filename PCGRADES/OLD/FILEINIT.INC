Function InitFile : STRING;

VAR DatName,Code   : STRING;
    Zeichen        : CHAR;
    Ziffer         : STRING[1];
    I              : INTEGER;
    Pfad           : STRING;
    DatFile        : STRING;
    Dateieman      : STRING;

BEGIN
     ClrScr;
     Hintergrund;
     WRITE('D A T E I E R K E N N U N G');
     DatName:='';
     Dateieman:='';
     DatFile:='';
     Rahmen(14,5,66,14,green);
     Repeat
           GOTOXY(16,6);
           WRITE('Gib das Laufwerk ein  :                           ');
           GOTOXY(40,6);READLN(Pfad);
     Until (Pfad='A:\') OR (Pfad='B:\') OR (Pfad='C:\');
     GotoXY(16,7);
     WRITE('Gib den Dateinamen ein: ');READLN(Datname);Gotoxy(16,15);
     FOR I:=1 TO Length(Datname) DO
         BEGIN
              Ziffer:=COPY(Datname,I,1);
              MEM[SEG(Zeichen):OFS(Zeichen)]:=MEM[SEG(Ziffer):OFS(Ziffer)+1];
              Dateieman:=Dateieman+UpCase(Zeichen);
         END;
     DatFile:=Pfad+Dateieman+'.NOT';
     ASSIGN(Datei,DatFile);
     {$I-}
     RESET(Datei);
     {$I+}
     IF IOResult=0 THEN BEGIN
                             GotoXY(16,9);
                             WRITE('Ihre Datei wurde gefunden');
                        END
                   ELSE BEGIN
                             Gotoxy(16,9);
                             WRITE('Ihre Datei wurde erstellt');
                        END;
     Gotoxy(16,13);
     WRITE('Ihre Datei: ',DatFile);Gotoxy(16,15);
     InitFile:=DatFile;
     Taste:=ReadKey;
     ClrScr;
END;