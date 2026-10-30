Program MyUtilTest;
Uses MyUtil, Graph, Crt;

Var I0, I1, I2, I3, Z, u : Integer;
    Pic : TPCXBild;
    ri0, ri1, ri2, ri3 : real;
    col : word;
    richtung, Fall : boolean;

Procedure M;
Var K, J : Integer;
Begin K:=1;
      Setcolor(Lightgray);
      For J:=1 to 110 do
          begin Line(125,J+100,150,j+100);
                Line(200,J+100,225,j+100);
                If K<37 then
                   begin Line(125+K,J+100,150+K,j+100);
                         Line(200-K,J+100,225-K,j+100);
                   end
                   else If K<51 then Line(125+K,J+100,225-K,J+100);
                If J mod 2=0 then Inc(K);
                Delay(20);
          end;
end;

Procedure G;
Var R : Real;
    XPkt, YPkt, x1, x2, y1, y2, I : Integer;
Begin R:=2*pi-PI/4;
      XPkt:=290;
      YPkt:=155;
      Repeat
            x1:=Round(Cos(r)*55);
            x2:=Round(Cos(r)*33);
            y1:=Round(sin(r)*55);
            y2:=Round(sin(r)*33);
            Line(Xpkt+X1,Ypkt+Y1,Xpkt+X2,Ypkt+Y2);
            r:=r-Pi/1440;
      Until r<0;
      For I:=1 to 7 do
          begin Line(Xpkt+33,YPkt-I,Xpkt+54,YPkt-I);
                Delay(15);
          end;
      For I:=49 downto 1 do
          begin If I<45 then Line(XPkt+5+I, YPkt-7, XPkt+5+I, YPkt+12);
                delay(15);
          end;
end;

Begin Graphik_Ein('C:\TP\BGI');
      Randomize;
      Pic.FName:='A:\ENTERTAI.PRW';
      PreparePCX(Pic);
      SetColor(Black);
      Z:=0;
      Repeat
            I1:=Random(640)+1;
            I2:=Random(480)+1;
            If GetPixel(I1,I2)<>lightgray then PutPixel(I1,I2,white);
            Inc(Z);
      Until Z>500;
      M; G;
      delay(500);
      ShowPCX(112,215,Pic);
      delay(1000);
      SetWriteMode(XOrPut);
      I0:=0;
      col:=15;
      setcolor(col);
      richtung:=true;
      Fall:=true;
      Z:=0;
      Repeat
            Line(100,80+I0,540,80+I0);
            if richtung then Inc(I0)
                        else Dec(i0);
            Delay(30);
      Until I0>220;
      repeat until keypressed;
      delay(200);
      closeGraph;
End.







      i0:=0;
      i1:=480;
      i2:=0;
      i3:=640;
      col:=white;
      Repeat
            For u:=1 to 4 do
                begin Line(i2+u,1,i2+u,640);
                     {Line(i3+u,1,i3+u,640);}
                      if u<4 then
                         begin Line(1,i0+u,640,i0+u);
                               {Line(1,i1+u,640,i1+u);}
                         end;
                end;
            delay(10);
            inc(i0,3); dec(i1,3);
            inc(i2,4); dec(i3,4);
            if i0>480 then i0:=0;
            if i1<0 then i1:=480;
            if i2>640 then i2:=0;
            if i3<0 then i3:=640;
      Until Keypressed;


