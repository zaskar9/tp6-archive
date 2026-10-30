PROGRAM Zeller;
USES CRT;
VAR Monat,Jahr,JH,Tag,z :INTEGER;

BEGIN
   ClrScr;
   GOTOXY(6,8);
   WRITE('Mit diesem Programm kannst Du den Tag errechnen an dem Du geboren bist.');
   GOTOXY(10,10);
   WRITE('An welchem Tag bist Du geboren        : ');
   READ(Tag);
   GOTOXY(10,11);
   WRITE('In welchem Monat bist Du geboren      : ');
   READ(Monat);
   GOTOXY(10,12);
   WRITE('In welchem Jahr bist Du geboren       : ');
   READ(Jahr);
   IF Monat < 3 THEN BEGIN
                     Monat:=Monat+12;
                     Jahr:=Jahr-1;
                     END;
   JH:=Jahr DIV 100;
   Jahr:=Jahr MOD 100;

   z:=(Tag+TRUNC(2.6*(Monat+1))+TRUNC(1.25*Jahr)+TRUNC(0.25*JH)-2*JH-1) MOD 7;

   GOTOXY(10,15);
   WRITE('Dieser Tag ist ein ');
   CASE z OF
        0:WRITE('Sonntag.');
        1:WRITE('Montag.');
        2:WRITE('Dienstag.');
        3:WRITE('Mittwoch.');
        4:WRITE('Donnerstag.');
        5:WRITE('Freitag.');
        6:WRITE('Samstag.')
        ELSE
        WRITE('Tag der nicht existiert !');
   END;
   REPEAT UNTIL KEYPRESSED;
END.
