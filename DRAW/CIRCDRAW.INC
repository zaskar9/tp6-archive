PROCEDURE Cirle;

VAR Radius, x, y            : LONGINT;
    x1, y1, x2, y2, Button  : INTEGER;

BEGIN
     SetVerticalLimits(40,400);
     SetHorizontalLimits(140,630);
     SetCursorPos(385,200);
     SetGraphicCursor(Uhr);
     ShowCursor;
     Delay(500);
     SetGraphicCursor(Kreuz);
     ShowCursor;
{
     SetLineStyle(1,1,1);
}
     SetViewPort(140,40,630,400,true);
     x1:=0;y1:=0;
     Repeat
           Delay(1000);
           Button:=0;
           Repeat
                 GetPosBut(Button,x1,y1);
                 Delay(100);
           Until Button in[1..4];
           If Button=1 Then BEGIN
                                 HideCursor;
                                 PutPixel(x1-140,y1-40,red);
                                 ShowCursor;
                                 DELAY(1000);
                                 Button:=0;
{
                                 SetColor(white);
                                 SetWriteMode(XORput);
}
                                 Repeat
                                      GetPosBut(Button,x2,y2);
                                      If x1-(x2-140)=0 then x:=1
                                                       else x:=abs((x1-140)-(x2-140));
                                      If y1-(y2-40)=0 then y:=1
                                                      else y:=abs((y1-40)-(y2-40));
                                      radius:=Round(SQRT(x*x+y*y));
{
                                      HideCursor;
                                      Circle(x1-140,y1-40,Radius);
                                      ShowCursor;
                                      DELAY(10);
                                      HideCursor;
                                      Circle(x1-140,y1-40,Radius);
                                      ShowCursor;
}
                                 Until Button=1;
                                 SetColor(Black);
{
                                 SetWriteMode(0);
                                 SetLineStyle(0,1,1);
}
                                 If Button=1 Then Begin
                                                       HideCursor;
                                                       Circle(x1-140,y1-40,Radius);
                                                       ShowCursor;
                                                       x:=0;x1:=0;x2:=0;
                                                       y:=0;y1:=0;y2:=0;
                                                  End;
                            End;
     Until Button=4;
     SetViewPort(1,1,640,480,true);
END;