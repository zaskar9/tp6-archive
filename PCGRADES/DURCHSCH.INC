PROCEDURE Schnitt;

VAR Code          : STRING;
    I, J, U       : INTEGER;
    Summe, Cut    : REAL;

BEGIN
     ClrScr;
     HintergrundII(3,true);
     WRITELN('D U R C H S C H N I T T');
     GotoXY(1,25);
{     Assign(Datei,Dateiname);
     Reset(Datei);}
     TextBackGround(5);
     GotoXY(1,2);WRITE('Namen der SchÅler');
     Gotoxy(30,2);WRITE('Notendurchschnitt');
     TextBackGround(3);GotoXY(1,25);
     I:=0;J:=0;U:=0;Summe:=0;Cut:=0;
{     WHILE NOT EOF(Datei) DO
     BEGIN
          INC(u);
          READ(Datei,Datensatz[u]);
     END;   }
     Repeat
           Inc(I);
           WITH Datensatz[I] DO
           BEGIN
                GotoXY(1,I+2);
                WRITE(I:2,' : ',Name);
                GOTOXY(30,2+I);
                J:=1;
                Summe:=0;
                While J<=anzahl do
                begin
                     Summe:=Summe+Note[j];
                     Inc(j);
                end;
                IF Anzahl > 0 THEN Cut:=Summe/Anzahl
                              else cut:=0;
                Write(cut:2:1);
                Summe:=0;
           END;
           WRITELN;
     Until I>Anzdaten-2;
     Taste:=ReadKey;
END;