PROGRAM Formelsammlung;
USES CRT, MOUSE, GRAPH, WRITING;

VAR I                                   : INTEGER;
    Taste                               : CHAR;


{$I MACHRAHM.INC}
{$I BACKGROU.INC}


FUNCTION CursorCheck(x1,y1,x2,y2 : INTEGER) : BOOLEAN;

VAR x,y,Button,verx,very         : INTEGER;
    Status,AnzTasten             : INTEGER;

BEGIN
     FlagReset(Status,AnzTasten);
     SetTextCursor(0,0,0);
     ShowCursor;
     CursorCheck:=False;
     Repeat
           Repeat
                 GetPosBut(Button,x,y);
           Until Button=1;
           Gotoxy(30,30);
                 Write(button:2,'  ',x:2,'  ',y:2);
           HideCursor;
           verX:=(x Div 8)+1;
           verY:=(y DIV 8)+1;
           IF verx IN [x1..x2] THEN
                    Begin
                         IF very in [y1..y2] Then CursorCheck:=True
                                                 ELSE CursorCheck:=False;
                    end;
     Until CursorCheck(x1,y1,x2,y2)=true;
     CursorCheck:=True;
END;

{$I COPYRIGH.INC}

BEGIN
     TextBackGround(black);
     ClrScr;
     Hintergrund;
     Copyright;
     Taste:=ReadKey;
END.