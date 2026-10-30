Function MouseClick : Boolean;
Var Button, X, Y : Integer;
    Taste : Char;
Begin Button:=-1;
      GetPosBut(Button, X, Y);
      If Button=1 then MouseClick:=True
                  else MouseClick:=False;
End;