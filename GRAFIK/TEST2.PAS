Program Test;
Uses Crt, Graph, MyUtil;

Var Name  : String;
    Alter : Integer;
    Wurz2 : real;
    X, Y, x1,y1,Button : Integer;
    Cursor : GraphicCursor;


{$I CURSOR.INC}

Begin
     Graphik_Ein('C:\TP\BGI');
     SetFillStyle(solidFill,white);
     bar(500,300,600,400);
     SetFillStyle(solidFill,red);
     bar(400,300,500,400);
     SetFillStyle(solidFill,blue);
     bar(300,300,400,400);
     SetFillStyle(solidFill,green);
     bar(200,300,300,400);
     SetFillStyle(solidFill,yellow);
     bar(100,300,200,400);
     SetHorizontalLImits(0,GetMaxX);
     SetVerticalLimits(0,GetMaxY);
     If DriverInstalled then OutTextXY(100,100,'Mouse Driver installiert.')
                        else OutTextXY(100,100,'Mouse Driver nicht installiert.');
     If DriverInstalled then
     showcursor;
        begin SetGraphicCursor(InvFace);
              ShowCursor;
              Repeat SetColor(black);
                     {If (x>50) and (x<170)
                        and (y>150) and (y<260) then HideCursor;
                     OutIntXY(100,200,X1,5);
                     OutIntXY(100,220,Y1,5);
                     ShowCursor;
                     SetColor(white);
                     Delay(10);}
                     GetPosBut(Button, X, Y);
                     {x1:=x;y1:=y;
                     If (x>50) and (x<170)
                        and (y>150) and (y<260) then HideCursor;
                     OutIntXY(100,200,X1,5);
                     OutIntXY(100,220,Y1,5);
                     ShowCursor;}
              Until Button=1;
              HideCursor
        end;
     Graphik_Aus;


End.







