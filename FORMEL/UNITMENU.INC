PROCEDURE MatheMenu;
BEGIN
     Repeat
     Hintergrund;
     SetCursorPos(0,0);
     GotoXY(2,1);Write('Mathematik');
     Rahmen(20,4,60,17,cyan);
     TextColor(red);
     GotoXY(22,5);Write('Sachgebiete: ');
     TextColor(black);
     GotoXY(25,7); Write('Stereometrie   ');
     GotoXY(25,9); Write('Trigonometrie  ');
     GotoXY(25,11);Write('Vektorgeometrie');
     GotoXY(25,13);Write('Algebra        ');
     GotoXY(25,15);Write('Exit           ');
     TextBackGround(green);
     For I:= 7 TO 15 DO Begin
                             IF odd(i) THEN begin
                                                GotoXY(53,I);
                                                Write('>> <<');
                                           END;
                        end;
     GotoXY(22,18);
     ShowCursor;
     Repeat
           GetPosBut(Button,x,y);
     Until (Button=1) AND ((x DIV 8) IN [50..60]);
     If (x DIV 8) IN [50..60] THEN BEGIN
                                        CASE (y DIV 8)+1 OF
                                                 07 : StereoMenu;
                                                 09 : Trigomenu;
                                                 11 : Vektormenu;
                                                 13 : AlgebraMenu;
                                                 15 : Exit;
                                        END;
                                          END;
        DELAY(500);
     Until Taste=#27;
     SetCursorPos(0,0);
end;

PROCEDURE PhysikMenu;
BEGIN
     Repeat
     Hintergrund;
     SetCursorPos(0,0);
     GotoXY(2,1);Write('Physik');
     Rahmen(20,4,60,21,cyan);
     TextColor(red);
     GotoXY(22,5);Write('Sachgebiete: ');
     TextColor(black);
     GotoXY(25,7); Write('Mechanik');
     GotoXY(25,9); Write('Optik');
     GotoXY(25,11);Write('W„rmelehre(Kalorik)');
     GotoXY(25,13);Write('Akustik');
     GotoXY(25,15);Write('Elektrizit„tslehre');
     GotoXY(25,17);Write('Atom- und Kernphysik');
     GotoXY(25,19);Write('Exit           ');
     TextBackGround(green);
     For I:= 7 TO 19 DO Begin
                             IF odd(i) THEN begin
                                                GotoXY(53,I);
                                                Write('>> <<');
                                           END;
                        end;
     GotoXY(22,22);
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
                                                 17 : WRITE(^G);
                                                 19 : Exit;
                                        END;
                                          END;
       DELAY(500);
     Until Taste=#27;
     SetCursorPos(0,0);
end;

PROCEDURE ChemieMenu;
BEGIN
     Repeat
     Hintergrund;
     SetCursorPos(0,0);
     GotoXY(2,1);Write('Chemie');
     Rahmen(20,8,60,17,cyan);
     TextColor(red);
     GotoXY(22,09);Write('Sachgebiete: ');
     TextColor(black);
     GotoXY(25,11); Write('organische Chemie   ');
     GotoXY(25,13); Write('anorganische Chemie  ');
     GotoXY(25,15);Write('Exit');
     TextBackGround(green);
     For I:= 11 TO 15 DO Begin
                             IF odd(i) THEN begin
                                                GotoXY(53,I);
                                                Write('>> <<');
                                           END;
                        end;
     GotoXY(22,18);
     ShowCursor;
     Repeat
           GetPosBut(Button,x,y);
     Until (Button=1) AND ((x DIV 8) IN [50..60]);
     If (x DIV 8) IN [50..60] THEN BEGIN
                                        CASE (y DIV 8)+1 OF
                                                 11 : WRITE(^G);
                                                 13 : WRITE(^G);
                                                 15 : Exit;
                                        END;
                                          END;
        DELAY(500);
     Until Taste=#27;
     SetCursorPos(0,0);
end;

