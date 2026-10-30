Program Help;
uses
  Crt, Graph;
var
  Driver, Mode,
  i : Integer;
  x1, y1, dx, dy : Integer;
  FillInfo : FillSettingsType;

begin
  DirectVideo := false;
  Randomize;
  Driver := Detect;
  InitGraph(Driver, Mode, 'C:\TP\BGI');
  if GraphResult < 0 then Halt(1);
  { Fill screen with background pattern }
  GetFillSettings(FillInfo);
  SetFillStyle(WideDotFill, FillInfo.Color);
  Bar(0, 0, GetMaxX, GetMaxY);
  dx := GetMaxX div 4;
  dy := GetMaxY div 4;
  SetLineStyle(SolidLn, 0, ThickWidth);
  SetWriteMode(XORput); { XOR mode }
  repeat { Draw until a key is pressed }
    x1 := Random(GetMaxX - dx);
    y1 := Random(GetMaxY - dy);
    Rectangle(x1, y1, x1 + dx, y1 + dy);
    Delay(500);
    Rectangle(x1, y1, x1 + dx, y1 + dy);
  until KeyPressed;
  ReadLn;
  Closegraph;
end.