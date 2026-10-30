PROGRAM ScanCode;
USES CRT;

VAR Scan   : CHAR;
    FTaste : BOOLEAN;

PROCEDURE InKey(VAR ch : CHAR; VAR fk : BOOLEAN);
          BEGIN
               fk:=FALSE;
               ch:=ReadKey;
               IF ch = #0 THEN BEGIN
                                    fk:=TRUE;
                                    WriteLn('Nochmals drÅcken !');
                                    ch:=Readkey;
                               END;
          END;

BEGIN
    Repeat
          Inkey(Scan,FTaste);
          WriteLn('Zeichen: ',Scan,' Scan Code: ',ord(scan),' F-Taste: ',FTaste);
    Until ord(Scan) = 27;
END.