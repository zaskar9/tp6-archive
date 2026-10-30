PROGRAM Rechnung;
USES CRT;

  VAR
    Menge,Preis,Rechnungsbetrag : REAL;

  BEGIN
    CLRSCR;
    WRITE('Gib die Menge ein: ');
    READLN(Menge);
    WRITE('Gib den Preis in Yen ein: ');
    READLN(Preis);

    Rechnungsbetrag:=Menge*Preis;
    WRITELN;WRITELN;
    WRITE('Rechnungsbetrag in Yen:',Rechnungsbetrag:10:2);
    REPEAT UNTIL KEYPRESSED;
  END.


