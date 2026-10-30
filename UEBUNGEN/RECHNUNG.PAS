PROGRAM Rechnung;
USES CRT;

VAR Betrag,Rabatt : REAL;

BEGIN

   ClrScr;
   Betrag:=583.20;
   Rabatt:=3.75/100;
   GOTOXY(33,7);
   TEXTCOLOR(14);
   WRITE('R E C H N U N G');
   Betrag:= Betrag*(1-Rabatt);
   TEXTCOLOR(3);
   GOTOXY(25,10);
   WRITE('Der Rechnungsbetrag ist : ',Betrag: 8:2);
   GOTOXY(35,15);
   WRITE('Vielen Dank !');
   REPEAT UNTIL KEYPRESSED;
END.