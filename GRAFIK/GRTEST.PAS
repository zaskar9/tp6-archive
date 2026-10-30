Program Graphik;
Uses Crt, Graph, Pic1;

Var gm, gd, Max: Integer;
    MaxStr : String;
    x,y,c,y2 : Integer;

Begin gm:=0;
      gd:=9;
      Randomize;
      InitGraph(gd,gm,'');
      SetActivePage(0);
      SetVisualPage(1);
      PutImage(0,0,@GIP^,1);
      For x:=1 to 400 do
          begin y2:=1;
                y:=1;
                repeat SetactivePage(0);
                       C:=GetPixel(x,y);
                       SetActivePage(1);
                       Inc(y,2); Inc(y2);
                       PutPixel(x,y2,C);
                until y>300;
          end;
      Repeat Until Keypressed;
      CloseGraph;
End.