PROGRAM Lotto;
USES CRT,PRINTER;

VAR Zahl,I: INTEGER;
    Datum,Name : STRING[20];
BEGIN
    ClrScr;
    WRITELN(Lst,'             L O T T O  -  Z A H L E N');
    WRITELN(Lst);
    WRITE('Gib das Datum ein: ');
    READLN(Datum);
    WRITELN(Lst,'                 Datum: ',Datum);WRITELN(lst);
    GOTOXY(1,2);WRITE('Gib den Namen ein: ');READLN(Name);
    Randomize;
    FOR I := 1 to 6 DO
     Begin
        Zahl:=Random(45)+1;
        WRITELN(Lst,'                     Zahl ',I,': ',Zahl);
        GOTOXY(10,I+3);WRITE('Zahl ',I,' : ',Zahl);GOTOXY(1,25);DELAY(3000);
     End;
     Zahl:=Random(45)+1;
     WRITELN(Lst);
     WRITELN(Lst,'                 Zusatzzahl: ',Zahl);
     GOTOXY(7,I+4);
     WRITELN('Zusatzzahl: ',Zahl);
     WRITELN(lst);
     WRITE(Lst,'             Viel Glck, ',name,' !');
     I:=0;
     REPEAT
     INC(I);
     WRITELN(Lst);
     UNTIL I>46;
     REPEAT UNTIL KEYPRESSED;
END.