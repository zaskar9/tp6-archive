PROGRAM Quadratische_Gleichungen;
USES CRT;
    VAR a,b,c,x1,x2,Diskriminante   : REAL;
BEGIN
    ClrScr;
    GOTOXY(10,10);
    WRITE('Gib bitte a ein: ');
    READ(a);
    GOTOXY(10,11);
    WRITE('Gib bitte b ein: ');
    READ(b);
    GOTOXY(10,12);
    WRITE('Gib bitte c ein: ');
    READ(c);
    Diskriminante:=sqr(b)-4*a*c;
    IF Diskriminante<0    THEN  BEGIN    GOTOXY(10,14);
                                         WRITE('Keine reellen L”sungen');
                                END
                          ELSE  BEGIN    x1:=(-b+sqrt(Diskriminante))/(2*a);
                                         x2:=-b/a-x1;
                                         GOTOXY(10,14);
                                         WRITE('Die erste  L”sung ist: ',x1:10:3);
                                         GOTOXY(10,15);
                                         WRITE('Die zweite L”sung ist: ',x2:10:3);
                                 END;
    REPEAT UNTIL KEYPRESSED;
    END.


