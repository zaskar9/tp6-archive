PROGRAM Automat;
USES CRT;

VAR Fahrpreis, Betrag, Retour             : REAL;
    Anz5, Anz2, Anz1, Anz50, Anz20, Anz10 : INTEGER;

BEGIN
    ClrScr;
    GOTOXY(20,5);WRITE('Willkommen am B V B - Automaten !');
    GOTOXY(20,8);WRITE('Gib den Fahrpreis ein: ');READLN(Fahrpreis);
    REPEAT
         GOTOXY(20,9);WRITE('Wirf das Geld ein    :            ');
         GOTOXY(43,9);READLN(Betrag);
    UNTIL Betrag>=Fahrpreis;
    Retour:=Betrag-Fahrpreis;
    GOTOXY(20,11);WRITE('Du bekommmst ',Retour:5:2,' Fr. zur…k.');
    Retour:=Retour+0.01;
    Anz5:=0;
    Anz2:=0;
    Anz1:=0;
    Anz50:=0;
    Anz20:=0;
    Anz10:=0;
    WHILE Retour>0.1 DO
        BEGIN
            WHILE Retour>5 DO
                BEGIN
                    Anz5:=Anz5+1;
                    Retour:=Retour-5;
                END;
            WHILE Retour>2 DO
                BEGIN
                    Anz2:=Anz2+1;
                    Retour:=Retour-2;
                END;
            WHILE Retour>1 DO
                BEGIN
                    Anz1:=Anz1+1;
                    Retour:=Retour-1;
                END;
            WHILE Retour>0.5 DO
                BEGIN
                    Anz50:=Anz50+1;
                    Retour:=Retour-0.5;
                END;
            WHILE Retour>0.2 DO
                BEGIN
                    Anz20:=Anz20+1;
                    Retour:=Retour-0.2;
                END;
            WHILE Retour>0.1 DO
                BEGIN
                    Anz10:=Anz10+1;
                    Retour:=Retour-0.1;
                END;
        END;
        WRITELN;WRITELN;
        IF Anz5>0 THEN  WRITELN('                   Anzahl 5 Franken-St…ke: ',Anz5);
        IF Anz2>0 THEN  WRITELN('                   Anzahl 2 Franken-St…ke: ',Anz2);
        IF Anz1>0 THEN  WRITELN('                   Anzahl 1 Franken-St…ke: ',Anz1);
        IF Anz50>0 THEN WRITELN('                   Anzahl 50 Rappen-St…ke: ',Anz50);
        IF Anz20>0 THEN WRITELN('                   Anzahl 20 Rappen-St…ke: ',Anz20);
        IF Anz10>0 THEN WRITELN('                   Anzahl 10 Rappen-St…ke: ',Anz10);
        REPEAT UNTIL KEYPRESSED;
END.