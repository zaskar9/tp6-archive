Program FontII;
uses
  Graph;
var
  Driver, Mode : Integer;
  TestFont : Integer;
begin
  TestFont := InstallUserFont('GREEK.CHR');
  if GraphResult <> grOk then
  begin
    WriteLn('Error installing TestFont' +
            '(using DefaultFont)');
    ReadLn;
  end;
  Driver := Detect;
  Mode := 0;
  InitGraph(Driver, Mode, 'C:\TP\BGI');
  if GraphResult <> grOk then Halt(1);
  SetTextStyle(TestFont, HorizDir, 2);
  OutText('Installable fonts supported.');
  ReadLn;
  Closegraph;
end.