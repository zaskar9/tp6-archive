Program test;
uses
  Graph;
var
  Gd, Gm : Integer;
  P      : pointer;
  Size   : Word;
begin
  Gd := Detect; InitGraph(Gd, Gm, 'C:\TP\BGI');
  if GraphResult <> grOk then Halt(1);
  Bar(0, 0, GetMaxX, GetMaxY);
  SetFillStyle(4,Yellow);
  bar(10,20,20,30);
  Size := ImageSize(1,1,300,200);
  GetMem(P, Size); { Get memory from heap }
  GetImage(1,1,300,200,P^);
  ReadLn;
  ClearDevice;
  PutImage(100, 100, P^, NormalPut);
  ReadLn;
  CloseGraph;
end.
