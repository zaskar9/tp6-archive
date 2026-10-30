PROGRAM Zeugnis;
USES CRT;
VAR Note, a,c              :REAL;
    b                      :INTEGER;
BEGIN
   ClrScr;
   GOTOXY(5,5);
   WRITE('B E R E C H N U N G  E I N E S  N O T E N D U C H S C H N I T T');
   GOTOXY(5,10);
   WRITE('Mit diesem Programm kannst Du deinen Notendurchschnitt berechnen.');
   GOTOXY(5,11);
   WRITE('   Sobald Du alle Noten eingegeben hast, musst Du <0> eingeben.');
   GOTOXY(5,12); WRITELN;
   b:=0;
   c:=0;
   REPEAT
   WRITE('                  Gib die Note ein: ');
   READ(a);
   c:=c+a;
   b:=b+1;
   UNTIL a=0;
   Note:=c/(b-1);
   GOTOXY(15,20);
   WRITE('Du hast den Durchschnitt: ',Note:2:2);
   REPEAT UNTIL KEYPRESSED;
END.