Function Drehen(X, Y : integer) : Boolean;
Var Pos1,Pos2,Pos3,Pos4 : ARRAY[1..2] of Integer;
    Teil1,Teil2,Teil3,Teil4,Teil5,Teil6,Teil7,Teil8 : String;
    fa, Fehler, feldx, feldy, u, v : Integer;
    PosX, PosY : ARRAY[1..4] of Integer;
    Element : String[8];

Begin
     If (Nr>=1) and (Nr<4) then Element:=ElementName[Nr+1]
                           else if Nr=4 then Element:=Elementname[1];
     Fehler:=0;
     Teil1:=COPY(Element,1,1);
     Teil2:=COPY(Element,2,1);
     Teil3:=COPY(Element,3,1);
     Teil4:=COPY(Element,4,1);
     Teil5:=COPY(Element,5,1);
     Teil6:=COPY(Element,6,1);
     Teil7:=COPY(Element,7,1);
     Teil8:=COPY(Element,8,1);
     Val(Teil1,Pos1[1],Fehler);
     Val(Teil2,Pos1[2],Fehler);
     Val(Teil3,Pos2[1],Fehler);
     Val(Teil4,Pos2[2],Fehler);
     Val(Teil5,Pos3[1],Fehler);
     Val(Teil6,Pos3[2],Fehler);
     Val(Teil7,Pos4[1],Fehler);
     Val(Teil8,Pos4[2],Fehler);
     PosX[1]:=(X+Pos1[1]); PosY[1]:=(Y+Pos1[2]);
     PosX[2]:=(X+Pos2[1]); PosY[2]:=(Y+Pos2[2]);
     PosX[3]:=(X+Pos3[1]); PosY[3]:=(Y+Pos3[2]);
     PosX[4]:=(X+Pos4[1]); PosY[4]:=(Y+Pos4[2]);
     If (Spielfeld[PosX[1],PosY[1]]) or (Spielfeld[PosX[2],PosY[2]]) or
        (Spielfeld[PosX[3],PosY[3]]) or (Spielfeld[PosX[4],PosY[4]]) or
        (PosY[1]>15) or (PosY[2]>15) or (PosY[3]>15) or (PosY[4]>15)
        then Drehen:=false
        else Drehen:=true;
end;
