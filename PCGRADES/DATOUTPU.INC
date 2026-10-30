PROCEDURE Ausgabe;
VAR Code          : STRING;
    I, J, u, z    : INTEGER;
    x             : LONGINT;
    ad            : TEXT;
    Strecke       : INTEGER;

BEGIN
     ClrScr;
     IF Status=FClose THEN BEGIN
                                NotOpen;
                                LoadDatei;
                           END;
     IF Aux=scr THEN Begin
                          Assign(ad,'con');
                          HintergrundII(3,false);
                     end
                ELSE Begin
                          Assign(ad,'prn');
                          HinterGrund;
                          Write(' D R U C K E N');
                     end;
     Rewrite(ad);
     {$I-}
     GOTOXY(1,1);
     WRITELN(ad,' D A T E N A U S G A B E');
     {$I+}
     IF IOResult<>0 THEN Begin
                              Rahmen(28,5,51,7,red);
                              Write('Abbruch : Druckerfehler');
                              GotoXY(25,8);
                              WRITE(^G);
                              Taste:=ReadKey;
                              Exit;
                         End;
     I:=1;J:=0;
     IF Aux=prn THEN Begin
                          Rahmen(31,5,49,7,red);
                          Write('Es wird gedruckt');
                          For z:=1 TO 79 DO Write(lst,'-');
                          WRITELN(lst,'-');
                          GotoXY(35,8);
                     End;
     TextBackGround(5);
     GOTOXY(1,2);
     WRITELN(ad,' Namen der Schler            Noten');
     IF Aux=prn THEN Begin
                          For z:=1 TO 79 DO Write(lst,'-');
                          Writeln(Lst,'-');
                     END;
     TextBackGround(3);
     GOTOXY(1,3);
     Repeat
           WITH Datensatz[I] DO
           BEGIN
                WRITE(ad,I:2,': ',Name);
                Strecke:=25-Length(Name);
                For u:=1 TO Strecke DO Write(ad,' ');
                J:=1;
                Repeat
                      WRITE(ad,' ³ ');
                      WRITE(ad,Note[j]:2:1);
                      Inc(J);
                Until J>Anzahl;
                Strecke:=0;
           END;
           Inc(I);
           IF Aux=prn THEN WRITELN(Lst,' ³ ')
                      ELSE Begin
                                Write(' ³ ');
                                IF J<8 THEN WRITELN;
                           End;
     Until I>AnzDaten-1;
     GotoXY(1,25);
     IF aux=prn THEN Write(Lst,#12);
END;


