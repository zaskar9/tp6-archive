Program sbscope;
uses crt, graph;
const a=$220;
var z, g : integer;
    b : array[100..541]of byte;

function r : boolean;
begin
     g:=0;
     repeat
           Port[a+$6]:=1;
           Port[a+$6]:=0;
           Inc(g);
     until (Port[a+$E]>=128)AND(Port[a+$A]=$AA) OR(g=50);
     if g=50 then r:=true else r:=false;
end;

procedure osc;
begin
     b[100]:=128;
     z:=101;
     SetColor(2);
     repeat
           Port[a+$C]:=$20;
           repeat until Port[a+$E]>=128;
           b[z]:=Port[a+$A];
           Line(z-1,b[z-1]+145,z,b[z]+145);
           Inc(z);
           if z>541 then
           begin
                SetColor(0);
                for z:=101 to 541 do Line(z-1,b[z-1]+145,z,b[z]+145);
                SetColor(2);
                z:=101;
           end;
     Until Keypressed;
end;

begin
     g:=0;
     InitGraph(g,g,'C:\tp\bgi');
     SetTextStyle(3,0,0);
     SetColor(11);
     OutTextXY(140,50,'SoundBlaster Oszilloskop');
     SetColor(15);
     Rectangle(98,140,542,400);
     SetTextStyle(0,0,0);
     OutTextXY(65,143,'+128');
     OutTextXY(65,391,'-128');
     OutTextXY(85,270,'0');
     if r=true then osc else write(#7);
     CloseGraph;
end.