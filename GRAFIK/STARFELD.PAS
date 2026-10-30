Program Starfield;
Uses Crt, Graph;

Type Startype=Record
         Radius  : Integer;
         Angle   : Integer;
         FaktorX : Integer;
         FaktorY : Integer;
     End;

Var Star                                : Array[1..360] of StarType;
    I, M, gd, gm, Deg, FLPX, FLPY       : Integer;

Procedure Initialisieren;
Var Ang : Integer;
Begin
     Ang:=Random(Deg)+1;
     For I:=1 to M DO
         Begin
              Star[I].Radius:=Random(10);
              IF Star[I].Radius=1 THEN Star[I].Radius:=1
                                  ELSE Star[I].Radius:=0;
              Star[I].Angle:=Ang;
              Star[I].FaktorX:=Random(FLPX)+1;
              Star[I].FaktorY:=Random(FLPY)+1;
              Inc(Ang,Deg);
         End;
End;

Procedure Zeichnen(Col:Byte);
Var sinus, cosinus : Integer;
Begin
     SetFillStyle(1,col);
     SetColor(col);
     For I:=1 to M Do
         Begin
              sinus:=Round(Star[I].FaktorY*sin((Star[I].Angle*PI)/180));
              cosinus:=Round(Star[I].FaktorX*cos((Star[I].Angle*PI)/180));
              IF Star[I].Radius<1 then Putpixel(FLPX+cosinus,FLPY+sinus,col)
                                  ELSE begin
                                          Circle(FLPX+cosinus,FLPY+sinus,Star[I].Radius);
                                          FloodFill(FLPX+cosinus,FLPY+sinus,col);
                                  End;
         End;
End;

Begin
     M:=80;
     FLPX:=320;
     FLPY:=240;
     Randomize;
     Deg:=Round(360/M);
     Initialisieren;
     DetectGraph(gd,gm);
     InitGraph(gd,gm,'');
     ClearDevice;
     Repeat
           Zeichnen(white);
           Zeichnen(black);
           For I:=1 to M Do
               Begin
                    Inc(Star[I].FaktorX, 6);
                    Inc(Star[I].FaktorY, 6);
                    IF (Star[I].FaktorX>FLPX) AND (Star[I].FaktorY>FLPY) Then
                       Begin
                            Star[I].FaktorX:=Random(50)+1;
                            Star[I].FaktorY:=Random(50)+1;
                            Star[I].Angle:=Random(360)*Deg;
                       End;
               End;
     Until Keypressed;
End.