{$N+}
Program PCXUtils;
Uses Crt,Graph,MyUtil;

Var Bild : tPCXBild;
    gd, gm,Nr : integer;
    Titel : Array[0..4] of string;

Procedure PixPerPix;
Var I,J : Integer;
    Z : LongInt;
    Col : Array[1..5]of Word;
Begin Z:=0;
      Repeat
            I:=Random(320)+1;
            J:=Random(175)+1;
            SetActivePage(0);
            Col[1]:=GetPixel(I,J);
            Col[2]:=GetPixel(I,J+1);
            Col[3]:=GetPixel(I,J-1);
            Col[4]:=GetPixel(I+1,J);
            Col[5]:=GetPixel(I-1,J);
            SetActivePage(1);
            PutPixel(160+I,87+J,Col[1]);
            PutPixel(160+I,87+J+1,Col[2]);
            PutPixel(160+I,87+J-1,Col[3]);
            PutPixel(160+I+1,87+J,Col[4]);
            PutPixel(160+I-1,87+J,Col[5]);
            Inc(Z);
      Until Z>39000;
      For I:=1 to 320 do
          For J:=1 to 175 do
              begin SetActivePage(0);
                    Col[1]:=GetPixel(I,J);
                    SetActivePage(1);
                    PutPixel(160+I,87+J,Col[1]);
              end;
End;

Procedure BlowUp;
Var H,I,J,K,x,y : Integer;
    Col : Word;
    FarbW : Array[0..4]of Real;
    Farb : Array[0..4]of word;
    Wert : Real;

Begin VGA_Aus;
      H:=1;
      For I:=1 to 320 do
          begin K:=1;
                For J:=1 to 175 do
                    begin SetActivePage(0);
                          Col:=GetPixel(I,J);
                          SetActivePage(1);
                          PutPixel(H+1,K,Col);
                          PutPixel(H+1,K+1,Col);
                          PutPixel(H,K,Col);
                          PutPixel(H,K+1,Col);
                          Inc(K,2);
                    end;
                Inc(H,2);
          end;
{
      SetActivePage(1);
      H:=1;
      Repeat K:=2;
             Repeat Farb[1]:=GetPixel(H-1,K-1);
                    Farb[2]:=GetPixel(H+1,K-1);
                    Farb[3]:=GetPixel(H-1,K+1);
                    Farb[4]:=GetPixel(H+1,K+1);
                    Wert:=(Farb[1]+Farb[2]+Farb[3]+Farb[4])/4;
                    FarbW[0]:=15;
                    Farb[0]:=Farb[2];
                    For I:=1 to 4 do
                        begin FarbW[I]:=Abs(Wert-Farb[I]);
                              if FarbW[I]<FarbW[0] then
                                 begin FarbW[0]:=FarbW[I];
                                       Farb[0]:=Farb[I];
                                 end;
                        end;
                    Col:=Farb[0];
                    PutPixel(H,K,Col);
                    Inc(K,2);
             Until K>350;
             Inc(H,2);
      Until H>640;

      H:=1;
      k:=1;
      Repeat Repeat Farb[1]:=GetPixel(H,K-1);
                    Farb[2]:=GetPixel(H,K+1);
                    Farb[3]:=GetPixel(H-1,K);
                    Farb[4]:=GetPixel(H+1,K);
                    Wert:=(Farb[1]+Farb[2]+Farb[3]+Farb[4])/4;
                    FarbW[0]:=15;
                    Farb[0]:=Farb[2];
                    For I:=1 to 4 do
                        begin FarbW[I]:=Abs(Wert-Farb[I]);
                              if FarbW[I]<FarbW[0] then
                                 begin FarbW[0]:=FarbW[I];
                                       Farb[0]:=Farb[I];
                                 end;
                        end;
                    Col:=Farb[0];
                    PutPixel(H,K,Col);
                    Inc(K,2);
             Until K>350;
             if k mod 2=0 then k:=1
                          else k:=0;
             Inc(H);
      Until H>640;
}
      VGA_Ein;
end;

begin Titel[0]:='d:\tpwork\signet.tpp';
      Titel[1]:='a:\mgs.prw';
      Titel[2]:='a:\rekl.prw';
      Titel[3]:='a:\comp.prw';
      Titel[4]:='a:\mgs.prw';
      DetectGraph(gd,gm);
      gm:=1;
      InitGraph(gd,gm,'D:\TP\BGI');
      Nr:=2;
      Repeat SetActivePage(0);
             SetVisualPage(1);
             Bild.FName:=Titel[Nr];
             PreparePCX(Bild);
             ShowPCX(1,1,Bild);
             PixPerPix;
             { BlowUp; }
             Inc(Nr);
             If Nr>4 then Nr:=0;
      Until Keypressed;
      DisPosePCX(Bild);
      CloseGraph;
End.