Program Vektor;
Uses Crt,Graph;

Var Punkt : Array[1..8,1..3]of Integer;
    ProPkt : Array[1..8,1..2] of Integer;
    a,b,c : Real;

    I,x,y,gd,gm : Integer;
    Strx,Stry : String;

Procedure Projektion(PktNr : Word;Var xKoord,yKoord : Integer);
Var Veka,Vekb,Vekc,t,u,v,w : Real;
    tStr : String;
Begin Veka:=a-Punkt[PktNr,1];
      Vekb:=b-Punkt[PktNr,2];
      Vekc:=c-Punkt[PktNr,3];
      t:=((-((2*a)*(2*a))+((2*b)*(2*b)))/(a*Veka+b*Vekb+1));
      Str(t:3:0,Tstr);
      OutTextXY(50,90+I*10,TStr);
      u:=a+t*Veka;
      v:=b+t*Vekb;
      w:=c+t*Vekc;
      xKoord:=Round(sqrt(((-a-u)*(-a-u))+((-b-v)*(-b-v))));
      yKoord:=Round(w);
End;

Begin DetectGraph(gd,gm);
      InitGraph(gd,gm,'c:\tp\bgi');
      Punkt[1,1]:=  0; Punkt[1,2]:=  0; Punkt[1,3]:= 10;
      Punkt[2,1]:=-10; Punkt[2,2]:= 10; Punkt[2,3]:=  0;
      Punkt[3,1]:=-10; Punkt[3,2]:=-10; Punkt[3,3]:=  0;
      Punkt[4,1]:= 10; Punkt[4,2]:=-10; Punkt[4,3]:=  0;
      Punkt[5,1]:= 10; Punkt[5,2]:= 10; Punkt[5,3]:= 20;
      Punkt[6,1]:=-10; Punkt[6,2]:= 10; Punkt[6,3]:= 20;
      Punkt[7,1]:=-10; Punkt[7,2]:=-10; Punkt[7,3]:= 20;
      Punkt[8,1]:= 10; Punkt[8,2]:=-10; Punkt[8,3]:= 20;
      I:=1;
      a:=10; b:=0; c:=10;
      Repeat
            Projektion(I,x,y);
            
            if I<5 then ProPkt[I,1]:=320+(x*2)
                   else ProPkt[I,1]:=320-(x*2);
            ProPkt[I,2]:=240-(y*2);
            Str(ProPkt[I,1],strx); Str(ProPkt[I,2],stry);
            OutTextXY(100,90+I*10,Strx+'  '+Stry);
            Inc(I);
      Until I>8;
      Line(ProPkt[1,1],ProPkt[1,2],ProPkt[2,1],ProPkt[2,2]);
      Line(ProPkt[2,1],ProPkt[2,2],ProPkt[3,1],ProPkt[3,2]);
      Line(ProPkt[3,1],ProPkt[3,2],ProPkt[4,1],ProPkt[4,2]);
      Line(ProPkt[4,1],ProPkt[4,2],ProPkt[1,1],ProPkt[1,2]);

      Line(ProPkt[5,1],ProPkt[5,2],ProPkt[6,1],ProPkt[6,2]);
      Line(ProPkt[6,1],ProPkt[6,2],ProPkt[7,1],ProPkt[7,2]);
      Line(ProPkt[7,1],ProPkt[7,2],ProPkt[8,1],ProPkt[8,2]);
      Line(ProPkt[8,1],ProPkt[8,2],ProPkt[5,1],ProPkt[5,2]);
      Repeat Until Keypressed;
      CloseGraph;
End.