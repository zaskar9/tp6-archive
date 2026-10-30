PROGRAM MAUS;
USES CRT, GRAPH, MOUSE;

VAR GD, GM, x1, y1, x2, y2, Button  : INTEGER;
    Radius, x, y                    : LONGINT;

{$I CURSOR.INC}

procedure SetCursorToKreuz;
const
  kreuz : GraphicCursor =
           (screenMask: ($FC3F,$FC3F,$FC3F,$FC3F,$FC3F,$FC3F,
                        $FC3F,$FC3F,$FC3F,$FC3F,$FC3F,$FC3F,$FC3F,$FC3F,$FC3F,$FC3F);
            cursorMask: (0,384,384,384,384,384,384,
                         $7E7E,$7E7E,384,384,384,384,384,384,0);
            hotX: 8;
            hotY: 8);
  Michael : GraphicCursor =
           (screenMask: ($FFFF,$9FF9,$9FF9,$8FF1,$87E1,$93C9,$9999,$9C39,$9E79,
                         $9009,$9009,$9009,$9009,$9009,$9009,0);
            cursorMask: (0,$6006,$6006,$700E,$781E,$6C36,$6666,$63C6,$6186,
                         $6006,$6006,$6006,$6006,$6006,$6006,0);
            hotx: 8;
            hoty: 16);
 begin
 SetGraphicCursor(uhr);
end;


BEGIN
     ClrScr;
     GD:= Detect;
     GM:= 0;
     InitGraph(GD,GM,'C:\TP\BGI');
     SetCursorToKreuz;
     Showcursor;
     SetColor(white);
     SetHorizontalLimits(0,640);
     SetVerticalLimits(0,480);
     x1:=0;x2:=0;
     Repeat
           if Button=1 THEN BEGIN
                                 MoveTo(x1,y1);
                                 GetPosBut(Button,x1,y1);
                                 HideCursor;
                                 LineTo(x1,y1);
                                 ShowCursor;
                            END
                       Else GetPosBut(Button,x1,y1);
     Until Button=4;
     HideCursor;
     ClearDevice;
     ShowCursor;
     x1:=0;y1:=0;
     Repeat
           Delay(1000);
           Button:=0;
           Repeat
                 GetPosBut(Button,x1,y1);
                 Delay(100);
           Until Button in[1..4];
           HideCursor;
           PutPixel(x1,y1,yellow);
           ShowCursor;
           DELAY(1000);
           If Button=1 Then BEGIN
                                 Button:=0;
                                 Repeat
                                      GetPosBut(Button,x2,y2);
                                      Delay(100);
                                 Until Button in[1..4];
                                 If x1-x2=0 then x:=1
                                            else x:=abs(x1-x2);
                                 If y1-y2=0 then y:=1
                                            else y:=abs(y1-y2);
                                 radius:=Round(SQRT(x*x+y*y));
                                 If Button=1 Then Begin
                                                       HideCursor;
                                                       Circle(x1,y1,Radius);
                                                       ShowCursor;
                                                       x:=0;x1:=0;x2:=0;
                                                       y:=0;y1:=0;y2:=0;
                                                  End;
                            End;

     Until Button=4;
     HideCursor;
     ClearDevice;
     ShowCursor;
     x1:=0;y1:=0;
     Repeat
           Delay(1000);
           Button:=0;
           Repeat
                 GetPosBut(Button,x1,y1);
                 Delay(100);
           Until Button in[1..4];
           HideCursor;
           PutPixel(x1,y1,yellow);
           ShowCursor;
           DELAY(1000);
           If Button=1 Then BEGIN
                                 Button:=0;
                                 Repeat
                                      GetPosBut(Button,x2,y2);
                                      Delay(100);
                                 Until Button in[1..4];
                                 If Button=1 Then Begin
                                                       HideCursor;
                                                       Line(x1,y1,x2,y2);
                                                       ShowCursor;
                                                       x:=0;x1:=0;x2:=0;
                                                       y:=0;y1:=0;y2:=0;
                                                  End;
                            End;

     Until Button=4;
     Repeat
     getposbut(Button,x1,y1);
     If Button=1 Then Begin
                           setcolor(red);
                           hidecursor;
                           floodfill(x1,y1,white);
                           showcursor;
                      end;
     Until Button=4;
          closeGraph;
END.