Procedure Muster;

VAR x1,x2,y1,y2,Button : INTEGER;

BEGIN
     SetVerticalLimits(40,400);
     SetHorizontalLimits(140,630);
     SetCursorPos(385,200);
     SetGraphicCursor(Uhr);
     ShowCursor;
     Delay(500);
     SetGraphicCursor(Kreuz);
     ShowCursor;
     SetViewPort(140,40,630,400,true);
     Repeat
           Delay(1000);
           Button:=0;
           Repeat
                 GetPosBut(Button,x1,y1);
                 Delay(100);
           Until Button in[1..4];
           DELAY(1000);
           SetLineStyle(0,1,1);
           If Button=1 Then BEGIN
                                 Button:=0;
                                 Repeat
                                      GetPosBut(Button,x2,y2);
                                      SetColor(black);
                                      HideCursor;
                                      Line(x1-140,y1-40,x2-140,y2-40);
                                      ShowCursor;
                                      DELAY(10);
                                 Until Button=1;
                                 x:=0;x1:=0;x2:=0;
                                 y:=0;y1:=0;y2:=0;
                            End;

     Until Button=4;
     HideCursor;
END;