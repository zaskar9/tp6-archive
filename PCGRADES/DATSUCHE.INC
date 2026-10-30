PROCEDURE DateiSuchen;

VAR DirRecord : SearchRec;
    Attribut  : WORD;
    I,x       : INTEGER;
    Pfad      : STRING;
    Fehler    : INTEGER;

BEGIN
     ClrScr;
     I:=0;x:=2;
     HintergrundII(3,true);
     WRITELN(' D A T E I S U C H E ');
     GotoXY(1,2);
     Rahmen(15,07,65,10,green);
     WRITE(' Geben Sie den Suchpfad ein');
     TEXTBACKGROUND(lightgray);
     GOTOXY(17,09);WRITE('                                               ');
     GOTOXY(18,09);READLN(Pfad);
     TextBackGround(green);
     HintergrundII(3,true);
     WRITELN('D A T E I S U C H E ');
     TextBackGround(3);
     GetFAttr(Datei,Attribut);
     FindFirst(Pfad,Attribut,DirRecord);
     Fehler:=DosError;
     CASE Fehler OF
          0 : BEGIN
                   GotoXY(1,2);
                   TextBackGround(5);
                   Write('Auflistung aller Dateien im Verzeichnis ',Pfad);
                   GotoXY(1,25);
                   TextBackGround(3);
              END;
          2 : BEGIN
                   GOTOXY(5,5);WRITE('Datei nicht gefunden  ');
                   GOTOXY(1,25);
                   Taste:=ReadKey;
              END;
          3 : BEGIN
                   GOTOXY(5,5);WRITE('Pfad nicht richtig  ');
                   GOTOXY(1,25);
                   Taste:=ReadKey;
                   END;
          5 : BEGIN
                   GotoXY(5,5); WRITE('Kein Datenzugriff m”glich');
                   GOTOXY(1,25);
                   Taste:=ReadKey;
              END;
         ELSE BEGIN
                   GotoXY(5,5);WRITE('Starten Sie Ihr System neu !');
                   GOTOXY(1,25);
                   DELAY(5000);Halt;
              END;
     END; {END OF CASE}
     WHILE Fehler <> 18 DO BEGIN
           Inc(I);
           IF I>21 THEN BEGIN
                             Inc(x,13);
                             I:=1;
                             IF x>70 THEN BEGIN
                                               GotoXY(65,24);
                                               WRITE('Zuviele Dateien');
                                               GotoXY(1,25);
                                               Taste:=ReadKey;
                                               Exit;
                                          END;
                        END;
           GOTOXY(x,2+I);
           Writeln(DirRecord.Name);
           FindNext(DirRecord);
           Fehler:=DosError;
     END;
     IF I<1 THEN BEGIN
                      GotoXY(5,5);
                      WRITE('Keine Dateien in diesem Verzeichnis');
                 END;
     GotoXY(1,25);
     Taste:=ReadKey;
END;


