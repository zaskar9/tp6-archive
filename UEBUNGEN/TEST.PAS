PROGRAM Test;
USES CRT;

VAR Testdatei : TEXT;
    Zeile1, Zeile2, Zeile3, Eingabe : STRING;
    x,y : INTEGER;

BEGIN
    ClrScr;
    X:=5;y:=5;
    ASSIGN(Testdatei, 'A:TEST.TXT');
    RESET(Testdatei);

    WHILE NOT EOF(Testdatei) DO
    BEGIN
        GOTOXY(y,x);READLN(Testdatei, Zeile1);WRITELN(Zeile1);
        GOTOXY(y,x+1);READLN(Testdatei, Zeile2);WRITELN(Zeile2);
        GOTOXY(y,x+2);READLN(Testdatei, Zeile3);WRITELN(Zeile3);x:=x+4;
    END;
    CLOSE(Testdatei);GOTOXY(y,x);
    WRITE('Testdatei wurde vollends aufgelistet !');
    REPEAT UNTIL KEYPRESSED;
    GOTOXY(y,x+2);
    WRITE('Geben Sie nun den Text in der letzten Zeile ein: ');READLN(Eingabe);
    IF Eingabe=Zeile3 THEN WRITE('    Richtig')
                      ELSE BEGIN
                              WRITELN('    Falsch');
                              WRITE('    Richtig w„re: ',Zeile3);
                           END;
    REPEAT UNTIL KEYPRESSED;
END.