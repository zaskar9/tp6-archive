Program vectors;
uses crt, graph, myutil;
type Punkt3D=record
                 x,y,z : Real;
             end;
     Punkt2D=record
                 x,y : Integer;
             end;
     Koord=Array[1..8] of Punkt2D;

var A : Punkt3D;
    P,Q : Array[1..8] of Punkt3D;
    P_Neu,Q_Neu : Koord;
    i : Integer;
    Taste : Char;
    alpha, savealpha :real;

Procedure Pkt3D_Pkt2D(Pkt3D : Punkt3D; VAR Pkt2D : Punkt2D);
Var Vect : Punkt3D;
    t : Real;
Begin Vect.x:=Pkt3D.x-A.x;
      Vect.y:=Pkt3D.y-A.y;
      Vect.z:=Pkt3D.z-A.z;
      If Vect.x=0 then Vect.x:=0.001;
      t:=-A.x/Vect.x;
      Pkt2D.x:=Trunc(320-A.y+t*Vect.y*5);
      Pkt2D.y:=Trunc(240-A.z+t*Vect.z*5);
end;

Procedure Quader_Zeichnen(K2D : Koord);
Begin Line(K2D[1].x,K2D[1].y,K2D[2].x,K2D[2].y); Line(K2D[1].x,K2D[1].y,K2D[4].x,K2D[4].y);
      Line(K2D[1].x,K2D[1].y,K2D[5].x,K2D[5].y); Line(K2D[2].x,K2D[2].y,K2D[6].x,K2D[6].y);
      Line(K2D[2].x,K2D[2].y,K2D[3].x,K2D[3].y); Line(K2D[3].x,K2D[3].y,K2D[7].x,K2D[7].y);
      Line(K2D[3].x,K2D[3].y,K2D[4].x,K2D[4].y); Line(K2D[4].x,K2D[4].y,K2D[8].x,K2D[8].y);
      Line(K2D[5].x,K2D[5].y,K2D[8].x,K2D[8].y); Line(K2D[5].x,K2D[5].y,K2D[6].x,K2D[6].y);
      Line(K2D[6].x,K2D[6].y,K2D[7].x,K2D[7].y); Line(K2D[7].x,K2D[7].y,K2D[8].x,K2D[8].y);
End;

begin Graphik_ein('c:\tp\bgi');
      A.x:=35; A.y:=7.5; A.z:=7.5;

      P[1].x:=30;   P[1].y:=5;   P[1].z:=5;
      P[2].x:=30;   P[2].y:=10;  P[2].z:=5;
      P[3].x:=25;   P[3].y:=10;  P[3].z:=5;
      P[4].x:=25;   P[4].y:=5;   P[4].z:=5;
      P[5].x:=30;   P[5].y:=5;   P[5].z:=10;
      P[6].x:=30;   P[6].y:=10;  P[6].z:=10;
      P[7].x:=25;   P[7].y:=10;  P[7].z:=10;
      P[8].x:=25;   P[8].y:=5;   P[8].z:=10;

      Q[1].x:=32;   Q[1].y:=15;  Q[1].z:=10;
      Q[2].x:=32;   Q[2].y:=20;  Q[2].z:=10;
      Q[3].x:=27;   Q[3].y:=20;  Q[3].z:=10;
      Q[4].x:=27;   Q[4].y:=15;  Q[4].z:=10;
      Q[5].x:=32;   Q[5].y:=15;  Q[5].z:=15;
      Q[6].x:=32;   Q[6].y:=20;  Q[6].z:=15;
      Q[7].x:=27;   Q[7].y:=20;  Q[7].z:=15;
      Q[8].x:=27;   Q[8].y:=15;  Q[8].z:=15;

      alpha:=0;

      Repeat
            alpha:=alpha+Pi/(180*1);
            savealpha:=alpha;
            For I:=1 to 4 do
                begin P[I].x:=(27.5+3.5*cos(alpha));
                      P[I].y:=(7.5+3.5*sin(alpha));
                      P[I+4].x:=(27.5+3.5*cos(alpha));
                      P[I+4].y:=(7.5+3.5*sin(alpha));
                      Alpha:=alpha+PI/2;
                end;
            Alpha:=savealpha;
            For I:=1 to 8 do
                begin 
                      Pkt3D_Pkt2D(P[I],P_Neu[I]);
                      {Pkt3D_Pkt2D(Q[I],Q_Neu[I]);}
                End;
            SetColor(white);
            Quader_Zeichnen(P_Neu);
            {Quader_Zeichnen(Q_Neu);}
            Taste:='0';
            If Keypressed then
            Taste:=Upcase(ReadKey);
                   Case Taste Of
                        'Q' : begin end;
                        '2' : A.x:=A.x+0.15;
                        '8' : A.x:=A.x-0.15;
                        '4' : A.y:=A.y-0.15;
                        '6' : A.y:=A.y+0.15;
                        '+' : A.z:=A.z+0.15;
                        '-' : A.z:=A.z-0.15;
                   End;
            Delay(35);
            SetColor(black);
            Quader_Zeichnen(P_Neu);
            {Quader_Zeichnen(Q_Neu);}
      Until Taste='Q';
      CloseGraph;
End.