PROGRAM Test;

USES CRT, MOUSE, SPORTOBJ;

VAR Frame                 : RAHMEN;
    Wahl                  : INTEGER;
    Taste                 : CHAR;

BEGIN
     TextBackground(white);
     ClrScr;
     Frame.InitII(30,'A:\TEST.DAT',blue, red, white, false);
     Frame.Draw(blue);
     Wahl:=Frame.Lightbar(lightgray, black, 1);
     TextBackGround(lightgray);
     TextColor(black);
     GotoXY(5,20); WRITE(wahl);GotoXY(1,25);
     Taste:=ReadKey;
     ClrScr;
END.