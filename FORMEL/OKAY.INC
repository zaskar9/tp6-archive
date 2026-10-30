FUNCTION CursorCheck(x1,y1,x2,y2 : INTEGER) : BOOLEAN;

VAR

    Button,verx,very                 : INTEGER;
    Status,AnzTasten             : INTEGER;
    I                            : INTEGER;

BEGIN
     FlagReset(Status,AnzTasten);
     ShowCursor;
     I:=0;
     CursorCheck:=False;
     Repeat
           GetPosBut(Button,x,y);
                 Delay(1);
                 verX:=(x Div 8)+1;
                 verY:=(y DIV 8)+1;
                 IF verx IN [x1..x2] THEN
                    Begin
                         IF very in [y1..y2] Then Begin CursorCheck:=True;
                                                  End
                                                  ELSE CursorCheck:=False;
                    end;
     Until Button=1;
END;