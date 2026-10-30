PROCEDURE Copyright;

BEGIN
     ClrScr;
     Hintergrund;
     GotoXY(2,1);Write('PC Formelsammlung 1.5 ');
     GOTOXY(40,1);WRITE('<Mouse Version 2.15>');
     Rahmen(20,8,60,17,cyan);
     Textcolor(132);
     GotoXY(30,9);Write('PC Formelsammlung 1.5 ');
     Textcolor(black);
     GotoXY(39,11);Write('by ');
     GotoXY(32,12);Write('Dominique Wagner ');
     GotoXY(39,13);Write('and');
     GotoXY(30,14);Write('Michael Grossniklaus ');
     Textbackground(2);
     GotoXY(36,16);Write('   OK   ');
     GotoXY(22,18);
     Repeat Until (KeyPressed) OR (CursorCheck(36,15,43,16)=TRUE);
END;

