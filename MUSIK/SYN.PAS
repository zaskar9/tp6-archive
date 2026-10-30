program syn;
uses crt;
var v: string;
    b: real;
    c,i,y,z: integer;

const q:word=500;

procedure n;
begin
     delay(round(60*b));
end;

procedure _(s:word);
begin
     if s>0 then sound(s) else nosound;
end;

procedure r(s,f,d:word);
begin
     for z:=1 to round(d*b) do begin
     _(random(s)+f);_(0);
     end;
end;

procedure x(f,p,t:word);
begin
     for z:=1 to round(15*b) do
         begin _(f);
               for y:=1 to p do; _(0);
               for y:=1 to t do;
         end;
end;

begin
     v:=ParamStr(1);
     Val(paramstr(2),b,c);
     for I:=1 to Length(v) do
     case v[i] of
     'p' : begin
                delay(80);
                r(q*3,0,300);
           end;
     'b' : begin
                delay(60);
                r(1*q,q,99);
           end;
     'C' : r(q*6,q*2,200);
     'k' : begin
                n;
                r(q*6,q*2,200);
                delay(20);
           end;
     'g' : begin
                n;
                for z:=1 to 200 do _(random(2*q)+q*4);
                _(0);
           end;
     'H' : r(q*4,q*8,q*7);
     'h' : r(q*76,q*16,q*3);
     's' : r(q*6,q*16,q*7);
     'f' : r(q*15,q*15,q*7);
     'i' : x(q*5,1200,1200);
     'e' : x(1850,850,q*3);
     'Å' : x(1450,q*4,q);
     'l' : x(1800,1200,1200);
     'a' : x(1100,1200,1200);
     'm' : x(99,q*3,800);
     'o' : x(400,1200,1200);
     'O' : x(980,1200,1200);
     'u' : x(300,1400,1400);
     't' : begin
                n;
                r(q*6,q*10,500);
           end;
     'd' : begin
                n;
                r(q*3,q*10,600);
           end;
     end;
end.

