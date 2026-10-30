PROGRAM E;
USES CRT;
VAR I :WORD;

BEGIN
    I:=2000;
    REPEAT
    SOUND(I);
    DELAY(10);
    I:=I-10;
    UNTIL I = 0;
    DELAY(1000);NOSOUND;
END.