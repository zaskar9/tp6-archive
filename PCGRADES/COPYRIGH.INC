PROCEDURE CopyRight;

BEGIN
     ClrScr;
     Hintergrund;
     WRITE(' C O P Y R I G H T');
     Rahmen(25,7,55,12,7);
     TextColor(red);
     GOTOXY(31,8);WRITE('PC SchoolMarks 2.3');
     TextColor(0);
     Gotoxy(39,10);Write('by');
     GOTOXY(30,11);Write('Michael Grossniklaus');
     Gotoxy(30,13);
     Taste:=ReadKey;
END;