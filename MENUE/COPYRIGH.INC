PROCEDURE Copyrigh;

VAR LName, XKoor               : INTEGER;

BEGIN
     BackGround.Init(1,1,80,25,'°');
     BackGround.Draw(blue);
     Write(' ',ProgName,'                         <MouseVersion>');
     GotoXY(3,25);Write('Copyright 1993 by Michael Grossniklaus, Basel');
     Copyright.Init(25,7,55,15,cyan,true);
     Copyright.Draw(black);
     TextColor(red+blink);
     LName:=Length(ProgName);
     XKoor:=40-(LName Div 2);
     GotoXY(XKoor,08);Write(ProgName);
     TextColor(black);
     GotoXY(39,10);Write('by');
     GotoXY(30,12);Write('Michael Grossniklaus');
     GotoXY(38,13);Write('1993');
     GotoXY(1,25);
     ShowCursor;
     Repeat
           GetPosBut(Button,x,y);
     Until (KeyPressed) OR (Button=1);
     HideCursor;
     Button:=0;
     Delay(150);
     Copyright.Cancel('°',blue);
END;

