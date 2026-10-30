PROCEDURE Zeugnis(dateiname : string);

VAR Code          : STRING;
    I, J, U       : INTEGER;
    Summe, Cut    : REAL;

BEGIN
     ClrScr;
     HintergrundII(3,true);
     WRITELN('Z E U G N I S N O T E N');
     Gotoxy(1,25);
{     Assign(Datei,Dateiname+'.not');
     Reset(Datei);}
     I:=0;J:=0;U:=0;Summe:=0;Cut:=0;
     {while not Eof(datei) do
     begin
          INC(u);
          READ(Datei,Datensatz[u]);
     end; }
     TextBackGround(5);
     GotoXY(1,2);WRITE('Namen der Schler');
     Gotoxy(30,2);WRITE('Zeugnisnote');
     TextBackGround(3);
     Repeat
           Inc(I);
           WITH Datensatz[I] DO
           BEGIN
                Gotoxy(1,I+2);
                WRITE(I:2,' : ');
                WRITE(Name);
                GOTOXY(30,2+I);
                J:=0;
                Summe:=0;
                Repeat
                      Inc(J);
                      Summe:=Summe+Note[j];
                Until J>Anzahl-1;
                IF Anzahl>0 THEN Cut:=Summe/Anzahl;
                Write(cut:2:0);
                Cut:=0;
           END;
           WRITELN;
     Until I>Anzdaten-2;
     Taste:=ReadKey;
{     Close(Datei);}
END;