PROGRAM Gauss;
USES CRT;
VAR Summe,n,a :REAL;

BEGIN
    ClrScr;
    GOTOXY(9,5);
    WRITE('Mit diesem Programm wird es, erstmals in der Geschichte der');
    GOTOXY(11,6);
    WRITE('Mathematik m”glich, alle natrlichen Zahlen bis zu einer');
    GOTOXY(13,7);
    WRITE('Zahl, die die Obergrenze bildet, schnell zu addieren.');
    GOTOXY(10,10);
    WRITE('Gib die Zahl ein, bis zu der die Addition erfolgen soll: ');
    READ(a);
    summe:=0;
    n:=0;

    REPEAT
         summe:=summe+n;
         n:=n+1;
    UNTIL n>a;

    GOTOXY(10,12);
    WRITE('Das Ergebnis ist: ',summe:10:0);

    REPEAT UNTIL KEYPRESSED;
END.


