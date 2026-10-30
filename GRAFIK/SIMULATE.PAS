Program test;
Uses Crt, Graph, MyUtil;

Type TVector=Record
                x,y,z : real;
             end;
     ScrKrd=Array[1..2] of Integer;

Var u,v,w,Auge   : TVector;
    P1,PNew      : Array[1..8] of TVector;
    Trans        : TVector;
    BildPkt      : Array[1..8] of TVector;
    a,b,c,d,e,h  : Real;
    Taste        : Char;
    I            : integer;
    ScrPkt       : Array[1..8] of ScrKrd;


Procedure InitVector(Var a:TVector;x0,y0,z0 : Real);
Begin a.x:=x0;  a.y:=y0;  a.z:=z0
End;

Procedure Bild2Screen(P:TVector;Var P_Out:ScrKrd);
begin P_Out[1]:=320+Round(BildPkt[i].y*10);
      P_Out[2]:=240-Round(BildPkt[i].z*10);
end;

Procedure DrehTrans(Trans:TVector;Wa,Wb,Wc:Real;P:TVector;Var PNew:TVector);
Var a11,a12,a13,a21,a22,a23,a31,a32,a33:Real;
Begin a11:=cos(wb)*cos(wc);                             {1}
      a12:=cos(wa)*sin(wc)+sin(wa)*sin(wb)*cos(wc);     {0}
      a13:=sin(wa)*sin(wc)-cos(wa)*sin(wb)*cos(wc);     {0}

      a21:=-cos(wb)*sin(wc);                            {0}
      a22:=cos(wa)*cos(wc)-sin(wa)*sin(wb)*sin(wc);     {1}
      a23:=sin(wa)*cos(wc)+cos(wa)*sin(wb)*sin(wc);     {0}

      a31:=sin(wb);                                     {0}
      a32:=-sin(wa)*cos(wb);                            {0}
      a33:=cos(wa)*cos(wb);                             {1}

      PNew.x:=a11*(p.x-Trans.x)+a21*(p.y-Trans.y)+a31*(p.z-Trans.z);
      PNew.y:=a12*(p.x-Trans.x)+a22*(p.y-Trans.y)+a32*(p.z-Trans.z);
      PNew.z:=a13*(p.x-Trans.x)+a23*(p.y-Trans.y)+a33*(p.z-Trans.z)
End;

Procedure Abbildung(PNew,Auge:TVector;Var PBild:TVector);
Begin PBild.x:=0;
      PBild.y:=Auge.x*PNew.y/(Auge.x-PNew.x);
      PBild.z:=Auge.x*PNew.z/(Auge.x-PNew.x);
End;

Procedure Wurfel(Col : Word);
Begin SetColor(Col);
      Line(ScrPkt[1,1],ScrPkt[1,2],ScrPkt[2,1],ScrPkt[2,2]);
      Line(ScrPkt[2,1],ScrPkt[2,2],ScrPkt[3,1],ScrPkt[3,2]);
      Line(ScrPkt[3,1],ScrPkt[3,2],ScrPkt[4,1],ScrPkt[4,2]);
      Line(ScrPkt[4,1],ScrPkt[4,2],ScrPkt[1,1],ScrPkt[1,2]);

      Line(ScrPkt[5,1],ScrPkt[5,2],ScrPkt[6,1],ScrPkt[6,2]);
      Line(ScrPkt[6,1],ScrPkt[6,2],ScrPkt[7,1],ScrPkt[7,2]);
      Line(ScrPkt[7,1],ScrPkt[7,2],ScrPkt[8,1],ScrPkt[8,2]);
      Line(ScrPkt[8,1],ScrPkt[8,2],ScrPkt[5,1],ScrPkt[5,2]);

      Line(ScrPkt[1,1],ScrPkt[1,2],ScrPkt[5,1],ScrPkt[5,2]);
      Line(ScrPkt[2,1],ScrPkt[2,2],ScrPkt[6,1],ScrPkt[6,2]);
      Line(ScrPkt[3,1],ScrPkt[3,2],ScrPkt[7,1],ScrPkt[7,2]);
      Line(ScrPkt[4,1],ScrPkt[4,2],ScrPkt[8,1],ScrPkt[8,2]);

end;


Begin Graphik_ein('');
      Repeat if Keypressed then Taste:=readKey
      until not Keypressed;
      Taste:=' ';
      InitVector(P1[1],5,6,0);
      InitVector(P1[2],0,6,0);
      InitVector(P1[3],0,0,0);
      InitVector(P1[4],5,0,0);
      InitVector(P1[5],4,5,2);
      InitVector(P1[6],1,5,2);
      InitVector(P1[7],1,1,2);
      InitVector(P1[8],4,1,2);  {altes Koordinatensys.}


      a:=0; b:=0; c:=0; d:=1; e:=1; h:=1;

      PutPixel(320,240,red);

      Repeat
            InitVector(Trans,d,e,h);{Ursprung des neuen Koordinatensys.}
            For i:=1 to 8 do DrehTrans(Trans,a,b,c,P1[i],PNew[i]);
            InitVector(Auge,5,0,0); {neues Koordinatensys.}

            for i:=1 to 8 do
                begin Abbildung(PNew[i],Auge,BildPkt[i]);
                      Bild2Screen(BildPkt[i],ScrPkt[i]);
                end;

            Wurfel(white);
            repeat until keypressed;
            begin repeat Taste:=ReadKey;
                  until not keypressed;
                  Case Taste of
                  '2' : b:=b+pi/90;
                  '8' : b:=b-pi/90;
                  '4' : c:=c-Pi/90;
                  '6' : c:=c+Pi/90;
                  '+' : a:=a+Pi/90;
                  '-' : a:=a-Pi/90;
                  '9' : d:=d-0.1;
                  '3' : d:=d+0.1;
                  '7' : h:=h+0.1;
                  '1' : h:=h-0.1;
                  '0' : e:=e-0.1;
                  '.' : e:=e+0.1;
                  End;
            end;
            Wurfel(black);
      Until Taste='q';

      Graphik_Aus;
End.

      

