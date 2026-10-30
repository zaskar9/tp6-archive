Program Wuefel;
Uses Crt, Graph;

Const a=200;
      MPktX=320;
      MPktY=220;

Var gd,gm,I : Integer;
    Alpha,b,c : Real;
    Distanz,DistanzX,DistanzY : Array[1..4] of Word;

Begin DetectGraph(gd,gm);
      InitGraph(gd,gm,'c:\tp\bgi');
      SetWriteMode(XORPut);
      Alpha:=0;
      Repeat Distanz[1]:=Round(a/2-((a*sin(Alpha))/4));
             Distanz[2]:=Round(a/2-((a*sin(Alpha+PI/2))/4));
             Distanz[3]:=Round(a/2-((a*sin(Alpha+PI))/4));
             Distanz[4]:=Round(a/2-((a*sin(Alpha+3*PI/2))/4));

             DistanzX[1]:=Round(cos(Alpha)*(Distanz[1]));
             DistanzX[2]:=Round(cos(Alpha+PI/2)*(Distanz[2]));
             DistanzX[3]:=Round(cos(Alpha+PI)*(Distanz[3]));
             DistanzX[4]:=Round(cos(Alpha+3*PI/2)*(Distanz[4]));

             b:=0.75*a;
             c:=0.355*a;

             DistanzY[1]:=round(b-(sin(alpha)*c)) div 2;
             DistanzY[2]:=round(b-(sin(alpha+pi/2)*c)) div 2;
             DistanzY[3]:=round(b-(sin(alpha+pi)*c)) div 2;
             DistanzY[4]:=round(b-(sin(alpha+3*pi/2)*c)) div 2;

             For I:=1 to 4 do If distanz[i]<0 then distanz[i]:=distanz[i]*-2;

             Line(MPktX+DistanzX[1],MPktY+DistanzY[1],MPktX+DistanzX[1],MPktY-DistanzY[1]);
             Line(MPktX+DistanzX[2],MPktY+DistanzY[2],MPktX+DistanzX[2],MPktY-DistanzY[2]);
             Line(MPktX+DistanzX[3],MPktY+DistanzY[3],MPktX+DistanzX[3],MPktY-DistanzY[3]);
             Line(MPktX+DistanzX[4],MPktY+DistanzY[4],MPktX+DistanzX[4],MPktY-DistanzY[4]);

             Line(MPktX+DistanzX[1],MPktY+DistanzY[1],MPktX+DistanzX[2],MPktY+DistanzY[2]);
             Line(MPktX+DistanzX[2],MPktY+DistanzY[2],MPktX+DistanzX[3],MPktY+DistanzY[3]);
             Line(MPktX+DistanzX[3],MPktY+DistanzY[3],MPktX+DistanzX[4],MPktY+DistanzY[4]);
             Line(MPktX+DistanzX[4],MPktY+DistanzY[4],MPktX+DistanzX[1],MPktY+DistanzY[1]);

             Line(MPktX+DistanzX[1],MPktY-DistanzY[1],MPktX+DistanzX[2],MPktY-DistanzY[2]);
             Line(MPktX+DistanzX[2],MPktY-DistanzY[2],MPktX+DistanzX[3],MPktY-DistanzY[3]);
             Line(MPktX+DistanzX[3],MPktY-DistanzY[3],MPktX+DistanzX[4],MPktY-DistanzY[4]);
             Line(MPktX+DistanzX[4],MPktY-DistanzY[4],MPktX+DistanzX[1],MPktY-DistanzY[1]);

             delay(25);

             Line(MPktX+DistanzX[1],MPktY+DistanzY[1],MPktX+DistanzX[1],MPktY-DistanzY[1]);
             Line(MPktX+DistanzX[2],MPktY+DistanzY[2],MPktX+DistanzX[2],MPktY-DistanzY[2]);
             Line(MPktX+DistanzX[3],MPktY+DistanzY[3],MPktX+DistanzX[3],MPktY-DistanzY[3]);
             Line(MPktX+DistanzX[4],MPktY+DistanzY[4],MPktX+DistanzX[4],MPktY-DistanzY[4]);
             Line(MPktX+DistanzX[1],MPktY+DistanzY[1],MPktX+DistanzX[2],MPktY+DistanzY[2]);
             Line(MPktX+DistanzX[2],MPktY+DistanzY[2],MPktX+DistanzX[3],MPktY+DistanzY[3]);
             Line(MPktX+DistanzX[3],MPktY+DistanzY[3],MPktX+DistanzX[4],MPktY+DistanzY[4]);
             Line(MPktX+DistanzX[4],MPktY+DistanzY[4],MPktX+DistanzX[1],MPktY+DistanzY[1]);
             Line(MPktX+DistanzX[1],MPktY-DistanzY[1],MPktX+DistanzX[2],MPktY-DistanzY[2]);
             Line(MPktX+DistanzX[2],MPktY-DistanzY[2],MPktX+DistanzX[3],MPktY-DistanzY[3]);
             Line(MPktX+DistanzX[3],MPktY-DistanzY[3],MPktX+DistanzX[4],MPktY-DistanzY[4]);
             Line(MPktX+DistanzX[4],MPktY-DistanzY[4],MPktX+DistanzX[1],MPktY-DistanzY[1]);

             Alpha:=Alpha+PI/180;

      Until Keypressed;
      CloseGraph;
End.