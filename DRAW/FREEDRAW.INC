PROCEDURE Draw;

VAR x1,y1, Button : INTEGER;

BEGIN
     SetViewPort(140,40,630,400,false);
     ShowCursor;
     SetHorizontalLimits(140,630);
     SetVerticalLimits(40,400);
     SetCursorPos(385,220);
     SetGraphicCursor(Uhr);
     SetLineStyle(0,1,1);
     ShowCursor;
     Delay(500);
     SetColor(black);
     SetGraphicCursor(Pinsel);
     Repeat
           if Button=1 THEN BEGIN
                                 MoveTo(x1-140,y1-40);
                                 GetPosBut(Button,x1,y1);
                                 HideCursor;
                                 LineTo(x1-140,y1-40);
                                 ShowCursor;
                            END
                       Else GetPosBut(Button,x1,y1);
     Until Button=2;
     SetFillStyle(1,white);
     HideCursor;
END;
