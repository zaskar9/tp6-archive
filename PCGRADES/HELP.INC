PROCEDURE NotOpen;

VAR Taste          : CHAR;

BEGIN
     Hintergrund;
     WRITE(' A U T O M A T I S C H E   H I L F E');
     Rahmen(29,12,50,14,red);
     WRITE('Keine offene Datei !');
     GotoXY(31,15);
     WRITE(^G);
     Taste:=ReadKey;
END;
