FUNCTION CursorCheck(x1,y1,x2,y2 : INTEGER) : BOOLEAN;

VAR x,y,Button,verx,very         : INTEGER;

BEGIN
     ShowCursor;
     CursorCheck:=False;
     Repeat
           Repeat
                 GetPosBut(Button,x,y);
           Until Button=1;
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