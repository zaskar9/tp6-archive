PROGRAM Devisenumrechnung;
USES CRT;

  CONST DMKURS=0.8825;
  CONST DOLLARKURS=1.5050;
  CONST PFUNDKURS=2.5710;
  CONST FFKURS=0.2595;
  CONST LIREKURS=0.001182;

  VAR  SFR,DM,DOLLAR,PFUND,FF,LIRE      :REAL;

BEGIN
   ClrScr;
   GOTOXY(10,3);
   WRITE('Umrechnung von S.Fr.in verschiedene W„hrungen');
   GOTOXY(4,5);
   WRITE('Betrag in S.Fr.: ');
   READLN(SFR);

   DM:=SFR/DMKURS;
   DOLLAR:=SFR/DOLLARKURS;
   PFUND:=SFR/PFUNDKURS;
   FF:=SFR/FFKURS;
   LIRE:=SFR/LIREKURS;

   GOTOXY(4,7); WRITELN('Betrag in DM  : ',DM:10:2);
   GOTOXY(4,8); WRITELN('Betrag in $   : ',DOLLAR:10:2);
   GOTOXY(4,9); WRITELN('Betrag in œ   : ',PFUND:10:2);
   GOTOXY(4,10);WRITELN('Betrag in FF  : ',FF:10:2);
   GOTOXY(4,11);WRITELN('Betrag in Lit.: ',LIRE:10:0);
   REPEAT UNTIL KEYPRESSED;
END.


