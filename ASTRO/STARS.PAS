Unit Stars;

Interface

Uses Crt, Graph;

Type Startype=Record
         Radius  : Integer;
         Angle   : Integer;
         FaktorX : Integer;
         FaktorY : Integer;
         Color   : Byte;
     End;

Type Starfield=Object
                  Star                                           : Array[1..360] of StarType;
                  x1,y1,x2,y2,a1,b1,a2,b2,Anzahl,FPunktX,FPunktY : Integer;
                  gd, gm, Deg,stx,sty                            : Integer;
                  Constructor Init(xx,yx,xy,yy,ax,bx,ay,by,zahl  : Integer);
                  Procedure Zeichnen(Taste : Boolean; Anz : Integer); Virtual;
End;

Implementation

Constructor Starfield.Init(xx,yx,xy,yy,ax,bx,ay,by,zahl : Integer);
Var Ang, I,a : Integer;
Begin
     Anzahl:=zahl;
     stx:=Round((xy-xx)/2);
     sty:=Round((yy-yx)/2);
     Deg:=Round(360/zahl);
     Ang:=Random(360)+1;
     For I:=1 to zahl DO
         Begin
              Star[I].Radius:=Random(10);
              IF Star[I].Radius=1 THEN Star[I].Radius:=1
                                  ELSE Star[I].Radius:=0;
              Star[I].Angle:=Ang;
              Star[I].FaktorX:=Random(stx)+1;
              Star[I].FaktorY:=Random(sty)+1;
              a:=Random(2)+1;
              IF a=1 then Star[I].color:=yellow
                     else Star[I].color:=white;
              Inc(Ang,Deg);
         End;
     x1:=xx;y1:=yx;x2:=xy;y2:=yy;
     a1:=ax-x1;b1:=bx-y1;a2:=ay-x1;b2:=by-y1;
     FPunktX:=Round((x2+x1)/2)-x1;FPunktY:=Round((y2+y1)/2)-y1;
End;

Procedure Starfield.Zeichnen(Taste : Boolean; Anz : Integer);
Var sinus, cosinus, I, Zahler : Integer;
    viewp                     : ViewPortType;
    hsek                      : Integer;
    Draw                      : Boolean;

Begin
     Case Anzahl Of
     1..10 : hsek:=40;
     11..20 : hsek:=30;
     21..30 : hsek:=20;
     31..39 : hsek:=10;
     Else hsek:=0;
     End;
     setviewport(x1,y1,x2,y2,true);
     Randomize;
     Zahler:=0;
     Repeat
           If Taste=False then Inc(Zahler);
           Draw:=True;
           For I:=1 to Anzahl Do
           Begin
              SetFillStyle(1,Star[I].Color);
              SetColor(Star[I].Color);
              sinus:=Round(Star[I].FaktorY*sin((Star[I].Angle*PI)/180));
              cosinus:=Round(Star[I].FaktorX*cos((Star[I].Angle*PI)/180));
              IF (cosinus+FPunktX>a1-5) and (cosinus+FPunktX<a2+5) and
                 (Sinus+FPunktY>b1-5) and (Sinus+FPunktY<b2+5) Then Draw:=False
                                                           Else Draw:=True;
              IF Draw=true then Begin
              IF Star[I].Radius<1 then Putpixel(FPunktX+cosinus,FPunktY+sinus,Star[I].color)
                                  ELSE begin
                                          Circle(FPunktX+cosinus,FPunktY+sinus,Star[I].Radius);
                                          FloodFill(FPunktX+cosinus,FPunktY+sinus,Star[I].Color);
                                  End;
              End;
           End;
           SetFillStyle(1,black);
           SetColor(black);
           Draw:=True;
           Delay(hsek);
           For I:=1 to Anzahl Do
           Begin
              SetFillStyle(1,black);
              SetColor(black);
              sinus:=Round(Star[I].FaktorY*sin((Star[I].Angle*PI)/180));
              cosinus:=Round(Star[I].FaktorX*cos((Star[I].Angle*PI)/180));
              IF (cosinus+FPunktX>a1-5) and (cosinus+FPunktX<a2+5) and
                 (Sinus+FPunktY>b1-5) and (Sinus+FPunktY<b2+5) Then Draw:=False
                                                           Else Draw:=True;
              IF Draw=true then Begin
              IF Star[I].Radius<1 then Putpixel(FPunktX+cosinus,FPunktY+sinus,black)
                                  ELSE begin
                                          Circle(FPunktX+cosinus,FPunktY+sinus,Star[I].Radius);
                                          FloodFill(FPunktX+cosinus,FPunktY+sinus,black);
                                  End;
              End;
           End;
           For I:=1 to Anzahl Do
               Begin
                    Inc(Star[I].FaktorX, 6);
                    Inc(Star[I].FaktorY, 6);
                    IF (ABS(Star[I].FaktorX*cos((Star[I].Angle*PI)/180))>stX-5) OR
                       (ABS(Star[I].FaktorY*sin((Star[I].Angle*PI)/180))>sty-5) Then
                       Begin
                            Star[I].FaktorX:=Random(50)+1;
                            Star[I].FaktorY:=Random(50)+1;
                            Star[I].Angle:=Random(360)*deg;
                       End;
               End;
           IF (Keypressed) and (taste) Then Zahler:=anz+1;
     Until Zahler>anz;
     SetViewport(1,1,639,479,false);
End;

End.