Procedure TetrisFeld;
Const x=99;
      y=125;
Var w:Integer;

Begin Line(x,y,x,y+300);
      Line(x-2,y,x-2,y+302);
      Line(x-2,y,x,y);
      Line(x,y+300,x+201,y+300);
      Line(x-2,y+302,x+203,y+302);
      Line(x+201,y+300,x+201,y);
      Line(x+203,y+302,x+203,y);
      Line(x+203,y,x+201,y);
      {w:=0;
      Repeat
            Line(x+20+w,y,x+20+w,y+300);
            Inc(w,20);
      Until w>180;
      w:=0;
      Repeat
            Line(x,y+w,x+200,y+w);
            Inc(w,20);
      Until w>300;}
End;