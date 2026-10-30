PROGRAM Rechtwinkliges_Dreieck;
  USES CRT;

  VAR      a,b :Real;
           Hypotenuse :Real;

  BEGIN
           ClrScr;
           GotoXY(5,2);Write('Kathete a= ');
           Readln(a);
           GotoXY(5,3);Write('Kathete b= ');
           Readln(b);
           Hypotenuse:=sqrt(a*a+b*b);
           GotoXY(5,5);
           Write('Hypotenuse c= ',Hypotenuse:10:3);
  END.