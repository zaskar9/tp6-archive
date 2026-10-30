PROCEDURE Hintergrund;
VAR x, y : ShortInt;

BEGIN
     TextColor(7);
     TextBackGround(7);
     ClrScr;
     x:=1;
     TextColor(1);
     Repeat
           FOR Y:= 2 TO 24 DO
               BEGIN
                    GOTOXY(x,y);
                    WRITE('°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°');
               END;
           INC(x,80);
     Until x>80;
     TextColor(0);
     GOTOXY(1,25);
     WRITE('Û Copyright 1993 by Michael Grossniklaus');
     GotoXY(1,1);
END;

PROCEDURE HintergrundII(Farbe:BYTE; Modus : BOOLEAN);
VAR x, y, I : ShortInt;

BEGIN
     TextBackGround(7);
     ClrScr;
     x:=1;
     TextBackGround(5);
     FOR I:=1 TO 80 DO
         BEGIN
              Gotoxy(I,2);
              WRITE(' ');
         END;
     IF Modus THEN Begin
                        TextColor(Farbe);
                        Repeat
                              FOR Y:= 3 TO 24 DO
                                  BEGIN
                                       GOTOXY(x,y);
WRITE('ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ');
                                  END;
                              INC(x,80);
                        Until x>80;
                   End
              ELSE Begin
                        TextBackGround(Farbe);
                        Repeat
                              FOR Y:= 3 TO 24 DO
                                  BEGIN
                                       GOTOXY(x,y);
WRITE('                                                                                ');
                                  END;
                              INC(x,80);
                        Until x>80;
                   End;
     TextColor(0);
     TextBackGround(7);
     GOTOXY(1,25);
     WRITE('Û Copyright 1993 by Michael Grossniklaus');
     GotoXY(1,1);
END;
