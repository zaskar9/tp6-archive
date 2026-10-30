PROGRAM ASCII;
USES CRT;

VAR x,y        : INTEGER;
    a,Taste    : CHAR;

BEGIN
     x:=0;
     ClrScr;
     {REPEAT
           a:=CHR(x);
           y:=ORD(' ');
           WRITELN(x,'  =  ',a);DELAY(1000);
           INC(x);
     UNTIL x > 255;
     WRITELN('Hallo');WRITE(CHR(7));DELAY(10000);
     WRITELN('Hallo');WRITE(CHR(10));}
     Repeat
           WRITELN(CHR(10));
           Taste:=ReadKey;
     Until Taste=CHR(10);
END.