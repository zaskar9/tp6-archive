PROCEDURE FormTran(DateiPfad : STRING);

VAR ScrFormel, Message, AnzFormel, Titel : STRING;
    I, Formel, Fehler                    : INTEGER;

BEGIN
     SetTextStyle(1,0,0);
     Assign(Datei,DateiPfad);
     {$I-}
     Reset(Datei);
     {$I+}
     IF IOResult<>0 THEN Exit;
     I:=1;
     Readln(datei, AnzFormel);
     Val(AnzFormel,Formel,Fehler);
     IF Fehler<>0 THEN Exit;
     ReadLn(Datei, Titel);
     OutTextXY(200,25,Titel);
     Repeat
           Readln(Datei,ScrFormel);
           Inc(I);
           OutTextXY(235,15+I*45,ScrFormel);
     Until I>Formel;
     SetTextStyle(4,0,3);
     I:=0;
     WHILE NOT EOF(Datei) DO BEGIN
                               Readln(Datei,Message);
                               Inc(I);
                               OutTextXY(25,240+I*22,Message);
                          END;
     SetFillStyle(1,lightred);
     bar(415,455,520,470);
     bar(525,455,630,470);
     SetTextStyle(0,0,0);
     OutTextXY(420,460,'Abbruch');
     OutTextXY(530,460,'Berechnungen');
     ShowCursor;
     Repeat
           GetPosBut(Button,x,y);
     Until Button=1;
     IF y DIV 10 IN [45..47] THEN BEGIN
                                  IF x DIV 10 IN [41..52] Then BEGIN
                                                                    Ende:=Stop;
                                                                    GraphAus;
                                                               END;
                                  IF x DIV 10 IN [52..63] Then BEGIN
                                                                    Ende:=Norm;
                                                                    Exit;
                                                               End;
                             END;
END;



