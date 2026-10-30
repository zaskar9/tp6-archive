PROGRAM Noten;
USES CRT;

   VAR Punktzahl, Note :REAL;
       Name            :STRING;
BEGIN
   ClrScr;
   GOTOXY(5,10);
   WRITE('Geben Sie bitte den Namen des SchÅlers, der SchÅlerin ein: ');
   READ(Name);
   GOTOXY(5,12);
   WRITE('Geben Sie nun bitte die erreichte Punktzahl ein: ');
   READ(Punktzahl);

   Note:= (Punktzahl*5)/17+1;
   GOTOXY(10,15);
   WRITE('Der SchÅler, die SchÅlerin : ',Name);
   GOTOXY(10,16);
   WRITE('erhÑlt die Note : ',Note:1:1);
   REPEAT UNTIL KEYPRESSED;
END.



