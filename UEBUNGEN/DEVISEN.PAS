PROGRAM Devisenumrechnung;
USES CRT;

       CONST DMKURS = 0.8825;
       VAR DM, SFR : REAL;

BEGIN
       ClrScr;
       GOTOXY(15,3);
       WRITE('Umrechnung von schweizer Franken in deutsche Mark');
       GOTOXY(4,5);
       WRITE('Betrag in schweizer Franken : ');
       READLN(SFR);
       DM:=SFR/DMKURS;
       GOTOXY(4,7);
       WRITE('Betrag in deutschen Mark    : ',DM:10:2);
       REPEAT UNTIL KEYPRESSED;
END.
