Program Test;
uses crt, mouse;

var Taste       : char;
    b,x,y       : integer;

begin
     textbackground(0);
     textcolor(7);
     clrscr;
     showCursor;
     Repeat
     IF Keypressed THEN Begin
                             Taste:=ReadKey;
                             If Taste=#0 THEN Taste:=ReadKey;
                             Write(Taste);
                        end
                   ELSE GetPosBut(b,x,y);
     Until (b=1) Or (taste='q');
     HideCursor;
end.