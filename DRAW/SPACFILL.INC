PROCEDURE Fill;

VAR x1, y1, Button : INTEGER;

BEGIN
     SetHorizontalLimits(140,630);
     SetVerticalLimits(40,400);
     SetCursorPos(385,220);
     SetGraphicCursor(uhr);
     Delay(500);
     SetGraphicCursor(rolli);
     SetViewPort(140,40,630,400,true);
     SetFillStyle(1,black);
     Repeat
     getposbut(Button,x1,y1);
     If Button=1 Then Begin
                           setcolor(red);
                           hidecursor;
                           floodfill(x1-140,y1-40,black);
                           showcursor;
                      end;
     Until Button=4;
END;