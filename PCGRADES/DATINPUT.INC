PROCEDURE Eingabe;
VAR I,J,Fehler,Lang,u,z,x,y,t   : INTEGER;
    Code                        : STRING;
    Noten                       : STRING;
    ch                          : CHAR;

BEGIN
     ClrScr;
     HintergrundII(3,true);
     GOTOXY(1,25);
     GotoXY(1,1);
     WRITELN(' D A T E N E I N G A B E');
     TextBackGround(5);
     GotoXY(1,2);WRITE(' Namen der SchÅler');
     Gotoxy(30,2);WRITE('Noten');
     I:=0;J:=1;Noten:='';T:=0;
     TextBackGround(3);
     GotoXY(1,3);
     Repeat
          Inc(I);Inc(t);
          WITH Datensatz[I] DO
          BEGIN
              WRITE(I:2,' :                                                                    ');
              WRITE(#8);
              Gotoxy(6,t+2);
              READLN(Name);
              IF Name='' THEN Begin AnzDaten:=I;
                                    gespeichert:=false;
                                    EXIT;
                              END;
              GOTOXY(30,t+2);
              J:=1;
              Repeat
                 WRITE(' ≥ ');
                 Noten:='';
                 ch:=ReadKey;
                 Noten:=noten+ch;
                 IF ch<>#27 THEN BEGIN
                                      Repeat
                                            WRITE(ch);
                                            ch:=ReadKey;
                                            IF ch<>#8 THEN Noten:=Noten+ch
                                                      ELSE BEGIN
                                                                X:=WhereX-1;
                                                                Y:=WhereY;
                                                                Gotoxy(X,Y);
                                                                ClrEol;
                                                                GotoXY(x+1,y);
                                                                Lang:=Length(Noten);
                                                                Delete(Noten,Lang,1);
                                                                Val(Noten,Note[J],Fehler);
                                                                IF Fehler <> 0 THEN WRITE(^G);
                                                           END;
                                      Until ch=#13;
                                      Lang:=Length(Noten);
                                      Delete(Noten,Lang,1);
                                      Val(Noten,Note[J],Fehler);
                                      IF Fehler <> 0 THEN WRITE(^G);
                                 END
                            ELSE Note[J]:=0.0;
                 Inc(J);
                 IF Fehler <> 0 THEN BEGIN Dec(J);
                                           Anzahl:=J-1;
                                     END
                                ELSE Anzahl:=J-2;
              Until (J>08) OR (ch=#27);
              IF J>8 THEN Anzahl:=Anzahl+1;
          End;
          IF I>20 THEN BEGIN
                            Dec(T,1);
                            GOTOXY(1,3);
                            DelLine;
                            TextBackGround(Cyan);
                            Gotoxy(1,23);
                            InsLine;
                       END
                  ELSE WRITELN;
     Until I>25;
     AnzDaten:=I;
     Gespeichert:=false;
END;




