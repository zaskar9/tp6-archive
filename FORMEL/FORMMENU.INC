PROCEDURE Menu;
VAR Wahl : BOOLEAN;

Begin
     Repeat
           Hintergrund;
           SetCursorPos(0,0);
           GotoXY(2,1);Write('Menu ');
           Rahmen(20,7,60,18,cyan);
           TextColor(red);
           GotoXY(22,8);Write('Sachgebiete: ');
           TextColor(black);
           GotoXY(25,10);Write('Mathematik                ');TextBackGround(green);Write('>> <<');
           TextBackGround(cyan);
           GotoXY(25,12);Write('Physik                    ');TextBackGround(green);Write('>> <<');
           TextBackGround(cyan);
           GotoXY(25,14);write('Chemie                    ');TextBackGround(green);Write('>> <<');
           TextBackGround(cyan);
           GotoXY(25,16);write('Programm beenden          ');TextBackGround(green);Write('>> <<');
           TextBackGround(black);
           Gotoxy(22,19);
           ShowCursor;
                 Repeat
                       GetPosBut(Button,x,y);
                 Until (Button=1) AND ((x DIV 8) IN [50..60]);
                 Wahl:=False;
                 If (x DIV 8) IN [50..60] THEN BEGIN
                                            CASE (y DIV 8) OF
                                                 09 : MatheMenu;
                                                 11 : PhysikMenu;
                                                 13 : ChemieMenu;
                                                 15 : Halt;
                                            END;
                                          END;
                 DELAY(100);
     Until Taste=#27;
     SetCursorPos(0,0);
END;