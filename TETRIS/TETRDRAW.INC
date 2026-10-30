Procedure ElementZeichnen(Element : String; X, Y : Integer);
Var Pos1,Pos2,Pos3,Pos4 : ARRAY[1..2] of Integer;
    Teil1,Teil2,Teil3,Teil4,Teil5,Teil6,Teil7,Teil8 : String;
    fa, Fehler, feldx, feldy, u, v, Size1, Size2, k, l : Integer;
    PosX, PosY : ARRAY[1..4] of Integer;
    ChEck1 : Boolean;
    Bild1, Bild2 : Pointer;

Begin
     Fehler:=0;
     Check1:=False;
     u:=1;
     Feldx:=100;
     feldy:=125;
     fa:=20;
     X:=X-2;
     Y:=Y-2;
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
     PosX[1]:=(X+Pos1[1])+1; PosY[1]:=(Y+Pos1[2])+1;
     PosX[2]:=(X+Pos2[1])+1; PosY[2]:=(Y+Pos2[2])+1;
     PosX[3]:=(X+Pos3[1])+1; PosY[3]:=(Y+Pos3[2])+1;
     PosX[4]:=(X+Pos4[1])+1; PosY[4]:=(Y+Pos4[2])+1;
     Bar(Feldx+(X+Pos1[1])*fa,FeldY+(Y+Pos1[2])*fa,Feldx+(X+Pos1[1]+1)*fa-1,FeldY+(Y+Pos1[2]+1)*fa-1);
     Bar(Feldx+(X+Pos2[1])*fa,FeldY+(Y+Pos2[2])*fa,Feldx+(X+Pos2[1]+1)*fa-1,FeldY+(Y+Pos2[2]+1)*fa-1);
     Bar(Feldx+(X+Pos3[1])*fa,FeldY+(Y+Pos3[2])*fa,Feldx+(X+Pos3[1]+1)*fa-1,FeldY+(Y+Pos3[2]+1)*fa-1);
     Bar(Feldx+(X+Pos4[1])*fa,FeldY+(Y+Pos4[2])*fa,Feldx+(X+Pos4[1]+1)*fa-1,FeldY+(Y+Pos4[2]+1)*fa-1);
     SetColor(black);
     Rectangle(Feldx+(X+Pos1[1])*fa+1,FeldY+(Y+Pos1[2])*fa+1,Feldx+(X+Pos1[1]+1)*fa-2,FeldY+(Y+Pos1[2]+1)*fa-2);
     Rectangle(Feldx+(X+Pos2[1])*fa+1,FeldY+(Y+Pos2[2])*fa+1,Feldx+(X+Pos2[1]+1)*fa-2,FeldY+(Y+Pos2[2]+1)*fa-2);
     Rectangle(Feldx+(X+Pos3[1])*fa+1,FeldY+(Y+Pos3[2])*fa+1,Feldx+(X+Pos3[1]+1)*fa-2,FeldY+(Y+Pos3[2]+1)*fa-2);
     Rectangle(Feldx+(X+Pos4[1])*fa+1,FeldY+(Y+Pos4[2])*fa+1,Feldx+(X+Pos4[1]+1)*fa-2,FeldY+(Y+Pos4[2]+1)*fa-2);
     SetColor(white);
     If (PosY[1]>14) or (PosY[2]>14) or (PosY[3]>14) or (PosY[4]>14) or
        (Spielfeld[PosX[1],PosY[1]+1]) or (Spielfeld[PosX[2],PosY[2]+1]) or
        (Spielfeld[PosX[3],PosY[3]+1]) or (Spielfeld[PosX[4],PosY[4]+1])
        then begin Yelm:=21;
                   Spielfeld[PosX[1],PosY[1]]:=True;
                   Spielfeld[PosX[2],PosY[2]]:=True;
                   Spielfeld[PosX[3],PosY[3]]:=True;
                   Spielfeld[PosX[4],PosY[4]]:=True;
                   If (PosX[1]=0) or (PosX[2]=0) or (PosX[3]=0) or (PosX[4]=0)
                       then Bug(Points,Lines,ElementName[Nr]);
             end;
     if {(PosX[1]>=fa-1) or (PosX[2]>=fa-1) or (PosX[3]>=fa-1) or (PosX[4]>=fa-1) or}
        (Spielfeld[PosX[1]+1,PosY[1]+1]) or (Spielfeld[PosX[2]+1,PosY[2]+1]) or
        (Spielfeld[PosX[3]+1,PosY[3]+1]) or (Spielfeld[PosX[4]+1,PosY[4]+1])
        then begin if (Spielfeld[PosX[1],1]) or (Spielfeld[PosX[2],1]) or
                      (Spielfeld[PosX[3],1]) or (Spielfeld[PosX[4],1])
                      then XChangeLeft:=false;
                   XChangeRight:=False;
             end
        else if (PosX[1]<2) or (PosX[2]<2) or (PosX[3]<2) or (PosX[4]<2) or
                (Spielfeld[PosX[1]-1,PosY[1]+1]) or (Spielfeld[PosX[2]-1,PosY[2]+1]) or
                (Spielfeld[PosX[3]-1,PosY[3]+1]) or (Spielfeld[PosX[4]-1,PosY[4]+1]) or
                (Spielfeld[PosX[1],1]) or (Spielfeld[PosX[2],1]) or
                (Spielfeld[PosX[3],1]) or (Spielfeld[PosX[4],1])
                then begin XChangeLeft:=false;
                     end
                else begin XChangeRight:=true;
                           XchangeLeft:=true;
                end;
     For v:=1 to 15 Do
         if (Spielfeld[1,v]) and (Spielfeld[2,v]) and
            (Spielfeld[3,v]) and (Spielfeld[4,v]) and
            (Spielfeld[5,v]) and (Spielfeld[6,v]) and
            (Spielfeld[7,v]) and (Spielfeld[8,v]) and
            (Spielfeld[9,v]) and (Spielfeld[10,v]) then begin
            SetFillStyle(SolidFill,black);
            
            Size1:=ImageSize(feldx,feldy,feldx+100,feldy+(V*fa)-1);
            Size2:=ImageSize(feldx+101,feldy,feldx+200,feldy+(v*fa)-1);
            GetMem(Bild1, Size1);
            GetMem(Bild2, Size2);
            GetImage(feldx,feldy,feldx+100,feldy+(v-1)*fa-1,Bild1^);
            GetImage(feldx+101,feldy,feldx+200,feldy+(v-1)*fa-1,Bild2^);
            Bar(feldx,feldy+((V-1)*fa)-1,feldx+200,feldy+(V*fa)-1);
            PutImage(Feldx,feldy+fa,Bild1^,0);
            PutImage(Feldx+101,feldy+fa,Bild2^,0);
            FreeMem(Bild1, Size1);
            FreeMem(Bild2, Size2);
            l:=v;
            Repeat
                  For k:=1 to 10 Do Spielfeld[k,l]:=Spielfeld[k,l-1];
                  Dec(l);
            Until l<=1;
            Inc(lines);
         end;
     Repeat
           Inc(u);
     Until (U>10) or (Spielfeld[u-1,1]=true);
     If Spielfeld[u-1,1] then Ende:=True;
     u:=1;
end;