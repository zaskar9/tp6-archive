Program Test;
Uses Crt, Graph, MyUtil;

Var Name  : String;
    Alter : Integer;
    Wurz2 : real;
    X, Y, x1,y1,Button : Integer;
    Cursor : GraphicCursor;


Begin
     Graphik_Ein('C:\TP\BGI');
     SetColor(white);
     InRealXY(100,100,'Gib eine Real-Zahl ein: ',Wurz2);
     OutRealxy(100,120,Wurz2,10,5);
     InIntXY(100,140,'Gib eine Integer-Zahl ein: ',Alter);
     OutIntXY(100,160,Alter,5);
     InTextXY(100,180,'Gib einen String ein: ',Name);
     OutTextXY(100,200,Name);
     Repeat Until Keypressed;
     Graphik_Aus;
End.

