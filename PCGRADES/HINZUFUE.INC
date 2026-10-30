PROCEDURE Hinzufugen;

VAR I,Zahl,u,z,o,j,x,y,Lang,Fehler,zi     : INTEGER;
    Noten                                 : STRING;
    ch                                    : CHAR;

BEGIN
     ClrScr;
     HintergrundII(3,true);
     WRITELN('H I N Z U F ö G E N');
     GotoXY(1,25);
     TextBackGround(5);
     GotoXY(1,2);WRITE('Namen der SchÅler');
     Gotoxy(30,2);WRITE('Noten');
     Ausgabe;
     I:=0;U:=0;z:=0;
     GotoXY(1,3);
     Z:=Anzdaten-1;
     Repeat
           Inc(Z);
           WITH Datensatz[z] DO
                BEGIN
                     GotoXY(1,z+2);
                     WRITE(z:2,':                                                                   ');
                     GotoXY(5,z+2);
                     Readln(Name);
                     if name='' then
                        begin Anzdaten:=z;
                              Gespeichert:=false;
                              exit;
                        end;
                     Gotoxy(30,Z+2);
                     J:=1;
                     Repeat
                           WRITE(' ≥ ');
                           Noten:='';
                           ch:=ReadKey;
                           Noten:=noten+ch;
                           IF ch<>#27{esc} THEN BEGIN
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
                                                ch:=#0;
                                           END;
                                      Inc(J);
                                      IF Fehler <> 0 THEN BEGIN Dec(J);
                                                                Anzahl:=J-1;
                                                          END
                                                     ELSE Anzahl:=j-2;
                     Until (J>08) OR (ch=#27);
                     IF J>8 THEN Anzahl:=Anzahl+1;
                End;
                WRITELN;
     Until (z>22);
     Gespeichert:=false;
     Anzdaten:=z;
     Repeat Until KeyPressed;
END;