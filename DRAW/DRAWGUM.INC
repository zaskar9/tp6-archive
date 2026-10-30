Procedure Gumm;

Begin
     SetVerticalLimits(40,400);
     SetHorizontalLimits(140,630);
     SetCursorPos(385,200);
     SetGraphicCursor(Uhr);
     ShowCursor;
     Delay(500);
     SetGraphicCursor(Gum);
     ShowCursor;
     SetViewPort(140,40,630,400,true);
     SetFillStyle(1,white);
     Repeat
           GetPosBut(Button,x,y);
           x:=x-140;
           y:=y-40;
           IF Button=1 THEN Begin
                                 HideCursor;
                                 bar(x,y,x+13,y+13);
                                 ShowCursor;
                            end;
     Until Button=4;
end;