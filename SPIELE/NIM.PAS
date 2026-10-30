PROGRAM Nim;
USES CRT,GRAPH;

VAR GraphDriver,GraphMode : INTEGER;
    Taste                 : CHAR;

PROCEDURE Holz(x,y : INTEGER; Richtung : CHAR);

          VAR x1,y1,x2,y2,x3,y3,x4,y4 : INTEGER;
              a,b                     : INTEGER;
          BEGIN
               CASE Richtung OF
                    'O','o' : BEGIN
                                   x1:=x-3;y1:=y+3;
                                   x2:=x+3;y2:=y+3;
                                   x3:=x+3;y3:=y+73;
                                   x4:=x-3;y4:=y+73;
                                   a:=x1+1;b:=y2+1;
                              END;
                    'G','g' : BEGIN
                                   x1:=x+3;y1:=y+3;
                                   x2:=x+3;y2:=y-3;
                                   x3:=x+73;y3:=y-3;
                                   x4:=x+73;y4:=y+3;
                                   a:=x+10;b:=y+2;
                              END;
                    'L','l' : BEGIN
                                   x1:=x-3;y1:=y+3;
                                   x2:=x+3;y2:=y+3;
                                   x3:=x+47;y3:=y+60;
                                   x4:=x+43;y4:=y+63;
                                   x:=x-1;y:=y+1;
                                   a:=x+3;b:=y+3;
                              END;
                    'R','r' : BEGIN
                                   x1:=x-3;y1:=y+3;
                                   x2:=x+3;y2:=y+3;
                                   x3:=x-43;y3:=y+63;
                                   x4:=x-47;y4:=y+60;
                                   x:=x+1;y:=y+1;
                                   a:=x-3;b:=y+3;
                              END;
               END;
               SetColor(Yellow);
               Line(x1,y1,x2,y2);
               Line(x2,y2,x3,y3);
               Line(x3,y3,x4,y4);
               Line(x4,y4,x1,y1);
               SetFillStyle(1,Yellow);
               FloodFill(a,b,Yellow);
               SetColor(Red);
               SetFillStyle(1,Red);
               Circle(x,y,5);
               FloodFill(x,y,Red);
               SetColor(white);
          END;

PROCEDURE Signet(n,m : INTEGER);

          BEGIN
               Holz(n+25,m,'o');
               Holz(n+40,m+5,'l');
               Holz(n+95,m,'o');
               Holz(n+145,m,'o');
               Holz(n+195,m,'o');
               Holz(n+210,m+5,'l');
               Holz(n+305,m+5,'r');
               Holz(n+320,m,'o');
               {------------------}
               Holz(n-55,m+45,'l');
               Holz(n-5,m-25,'r');
               Holz(n+10,m-25,'g');
               Holz(n+5,m+105,'g');
               Holz(n+95,m-25,'g');
               Holz(n+90,m+105,'g');
               Holz(n+180,m-25,'g');
               Holz(n+175,m+105,'g');
               Holz(n+265,m-25,'g');
               Holz(n+260,m+105,'g');
               Holz(n+350,m-25,'l');
               Holz(n+395,m+45,'r');
               {-------------------}
               SETTEXTSTYLE(1,0,6);
               OUTTEXTXY(180,220,'Knobelspiel');
               OUTTEXTXY(270,290,'von');
               OUTTEXTXY(55,360,'Michael Grossniklaus');
               SETTEXTSTYLE(0,0,0);
               OUTTEXTXY(314,465,'Copyright by M. Grossniklaus, April 1993');
          END;

PROCEDURE Vorbereiten(x,u,y,z : INTEGER);
          BEGIN
               ClearDevice;
               Holz(x,y,'o');
               Holz(x,y+z,'o');
               Holz(x+u,y+z,'o');
               Holz(x-u,y+z,'o');
               Holz(x-2*u,y+2*z,'o');
               Holz(x-u,y+2*z,'o');
               Holz(x,y+2*z,'o');
               Holz(x+u,y+2*z,'o');
               Holz(x+2*u,y+2*z,'o');
               Holz(x-3*u,y+3*z,'o');
               Holz(x-2*u,y+3*z,'o');
               Holz(x-u,y+3*z,'o');
               Holz(x,y+3*z,'o');
               Holz(x+u,y+3*z,'o');
               Holz(x+2*u,y+3*z,'o');
               Holz(x+3*u,y+3*z,'o');
          END;

BEGIN
     GraphDriver:=Detect;
     InitGraph(GraphDriver,GraphMode,'C:\TP\BGI');
     Rectangle(5,5,635,474);
     Signet(145,80);
     Taste:=ReadKey;
     Vorbereiten(200,40,40,95);
     Repeat Until Keypressed;
     CloseGraph;
END.