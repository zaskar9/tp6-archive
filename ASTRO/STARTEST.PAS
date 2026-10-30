Program Stars_test;
Uses Crt, Graph, Stars;

Var St    : StarField;
    I,gd, gm     : Integer;

Begin
     
     DetectGraph(gd,gm);
     InitGraph(gd,gm,'');
     SetFillstyle(1,white);
     bar(1,1,639,479);
     setFillstyle(1,black);
     bar(50,50,590,430);
     setFillstyle(1,red);
     bar(150,120,450,320);
     St.Init(50,50,590,430,150,120,450,320,40);
     St.Zeichnen(true,0);
     Repeat Until Keypressed;
     CloseGraph;
End.