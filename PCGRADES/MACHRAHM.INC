PROCEDURE Rahmen(x1,y1,x2,y2 : ShortInt; Farbe: Byte);

VAR J, I, Z, AnzahlX, AnzahlY : INTEGER;
    Text                      : STRING;
BEGIN
     TextBackGround(Farbe);
     Window(x1,y1,x2,y2);
     ClrScr;
     AnzahlX:=Abs(x1-x2);
     AnzahlY:=Abs(y1-y2);
     FOR I:=1+1 TO AnzahlX DO
             BEGIN
                  Gotoxy(I,1);WRITE('Í');
                  Gotoxy(I,AnzahlY+1);WRITE('Í');
             END;
     FOR I:= 1+1 TO AnzahlY DO
         BEGIN
              GOTOXY(1,I);Write('º');
              GOTOXY(AnzahlX+1,I);Write('º');
         END;
     Window(1,1,80,25);
     GOTOXY(x1,y1);WRITE('É');
     GOTOXY(x1,y2);WRITE('È');
     GOTOXY(x2,y1);WRITE('»');
     GOTOXY(x2,y2);WRITE('¼');
     FOR I:= y1+1 TO y2 DO
         BEGIN
              Gotoxy(x2+1,I);
              WRITE('Û');
         END;
     FOR I:=x1+1 TO x2+1 DO
         BEGIN
              Gotoxy(I,y2+1);
              WRITE('Û');
         END;
     GOTOXY(x1+1,y1+1);
END;