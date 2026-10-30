PROCEDURE StereoMenu;

Begin
     Repeat
     Hintergrund;
     SetCursorPos(0,0);
     Write(' Stereometrie ');
     Rahmen(20,4,60,19,cyan);
     TEXTCOLOR(red);
     Write(' Sachgebiete ');
     TEXTCOLOR(black);
     GotoXY(25,7); Write('Zylinder');
     GotoXY(25,8); Write('Prisma');
     GotoXY(25,9); Write('Kegel');
     GotoXY(25,10);Write('Pyramide');
     GotoXY(25,11);Write('Tetraeder');
     GotoXY(25,12);Write('Hexaeder');
     GotoXY(25,13);Write('Oktaeder');
     GotoXY(25,14);Write('Dodekaeder');
     GotoXY(25,15);Write('Ikosaeder');
     GotoXY(25,16);Write('Kugel');
     GotoXY(25,17);Write('Exit           ');
     TextBackGround(green);
     For I:= 7 TO 17 DO Begin
                             GotoXY(53,I);
                             Write('>> <<');
                        END;
     GotoXY(22,20);
     ShowCursor;
     Repeat
           GetPosBut(Button,x,y);
     Until (Button=1) AND ((x DIV 8) IN [50..60]);
     If (x DIV 8) IN [50..60] THEN BEGIN
                                        CASE (y DIV 8)+1 OF
                                                 07 : Zylinder;
                                                 08 : Prisma;
                                                 09 : WRITE(^G);
                                                 10 : WRITE(^G);
                                                 11 : WRITE(^G);
                                                 12 : WRITE(^G);
                                                 13 : WRITE(^G);
                                                 14 : WRITE(^G);
                                                 15 : WRITE(^G);
                                                 16 : WRITE(^G);
                                                 17 : Exit;
                                        END;
                                          END;
        DELAY(500);
     Until Taste=#27;
     SetCursorPos(0,0);
end;


PROCEDURE Trigomenu;
Begin
     Repeat
     Hintergrund;
     SetCursorPos(0,0);
     Write(' Trigonometrie ');
     Rahmen(20,4,60,19,cyan);
     TEXTCOLOR(red);
     Write(' Sachgebiete ');
     TEXTCOLOR(black);
     GotoXY(25,7); Write('Definition der');
     GotoXY(27,8); Write('Winkelfunktionen');
     GotoXY(25,10);Write('Anwendung im recht-');
     GotoXY(27,11);Write('winkligen Dreieck');
     GotoXY(25,13);Write('Sinussatz');
     GotoXY(25,15);Write('Cosinussatz');
     GotoXY(25,17);Write('Exit');
     TextBackGround(green);
     GotoXY(53,8);Write('>> <<');
     For I:= 11 TO 17 DO Begin
                             IF odd(I) THEN BEGIN
                                                 GotoXY(53,I);
                                                 Write('>> <<');
                                            End;
                        END;
     GotoXY(22,20);
     ShowCursor;
     Repeat
           GetPosBut(Button,x,y);
     Until (Button=1) AND ((x DIV 8) IN [50..60]);
     If (x DIV 8) IN [50..60] THEN BEGIN
                                        CASE (y DIV 8)+1 OF
                                                 08 : WRITE(^G);
                                                 11 : WRITE(^G);
                                                 13 : WRITE(^G);
                                                 15 : WRITE(^G);
                                                 17 : Exit;
                                        END;
                                          END;
        DELAY(500);
     Until Taste=#27;
     SetCursorPos(0,0);
end;


PROCEDURE VektorMenu;
Begin
     Repeat
     Hintergrund;
     SetCursorPos(0,0);
     Write(' Vektorgeometrie ');
     Rahmen(20,4,60,19,cyan);
     TEXTCOLOR(red);
     Write(' Sachgebiete ');
     TEXTCOLOR(black);
     GotoXY(25,7); Write('Definition');
     GotoXY(25,9); Write('Addition');
     GotoXY(25,11);Write('Multiplikation');
     GotoXY(25,13);Write('Skalarprodukt');
     GotoXY(25,15);Write('Geradengleichungen');
     GotoXY(25,17);Write('Exit');
     TextBackGround(green);
     For I:= 07 TO 17 DO Begin
                             IF odd(I) THEN BEGIN
                                                 GotoXY(53,I);
                                                 Write('>> <<');
                                            End;
                        END;
     GotoXY(22,20);
     ShowCursor;
     Repeat
           GetPosBut(Button,x,y);
     Until (Button=1) AND ((x DIV 8) IN [50..60]);
     If (x DIV 8) IN [50..60] THEN BEGIN
                                        CASE (y DIV 8)+1 OF
                                                 07 : WRITE(^G);
                                                 09 : WRITE(^G);
                                                 11 : WRITE(^G);
                                                 13 : WRITE(^G);
                                                 15 : WRITE(^G);
                                                 17 : Exit;
                                        END;
                                          END;
        DELAY(500);
     Until Taste=#27;
     SetCursorPos(0,0);
end;

PROCEDURE AlgebraMenu;

Begin
     Repeat
     Hintergrund;
     SetCursorPos(0,0);
     Write(' Algebra ');
     Rahmen(20,4,60,19,cyan);
     TEXTCOLOR(red);
     Write(' Sachgebiete ');
     TEXTCOLOR(black);
     GotoXY(25,7); Write('Grundgesetze');
     GotoXY(25,9); Write('Binome');
     GotoXY(25,11);Write('Faktorzerlegung');
     GotoXY(25,13);Write('Quadratische Gleichungen');
     GotoXY(25,15);Write('Gleichungssysteme');
     GotoXY(25,17);Write('Exit           ');
     TextBackGround(green);
     For I:= 7 TO 17 DO Begin IF odd(I) THEN Begin
                                                  GotoXY(53,I);
                                                  Write('>> <<');
                                             END;
                        end;
     GotoXY(22,20);
     ShowCursor;
     Repeat
           GetPosBut(Button,x,y);
     Until (Button=1) AND ((x DIV 8) IN [50..60]);
     If (x DIV 8) IN [50..60] THEN BEGIN
                                        CASE (y DIV 8)+1 OF
                                                 07 : WRITE(^G);
                                                 09 : WRITE(^G);
                                                 11 : WRITE(^G);
                                                 13 : WRITE(^G);
                                                 15 : WRITE(^G);
                                                 17 : Exit;
                                        END;
                                          END;
        DELAY(500);
     Until Taste=#27;
     SetCursorPos(0,0);
end;