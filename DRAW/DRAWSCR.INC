Procedure InitScreen;

Begin
     SetFillStyle(11,white);
     bar(0,0,640,480);
     SetFillStyle(1,white);
     bar(10,40,110,400);
     bar(140,40,630,400);
     SetFillStyle(1,cyan);
     setColor(white);
     rectangle(138,38,632,402);
     Setcolor(black);
     bar(10,10,630,30);
     OutTextXY(95,17,'INTERNATIONAL PAINT by MICHAEL GROSSNIKLAUS 1993, BASEL');
     Setcolor(black);
     rectangle(12,42,108,398);
     Line(60,42,60,398);
     FOR I:=1 TO 8 DO Line(12,i*40+40,108,i*40+40);
     SETTEXTSTYLE(1,0,0);
{Pencil}
     Line(20,72,20,77);Line(20,77,25,77);Line(25,77,50,52);Line(20,72,45,47);Line(45,47,50,52);
     Line(20,72,25,77);SetFillStyle(1,black);Floodfill(21,76,black);SETFILLSTYLE(1,red);FLOODFILL(46,49,black);
{Line}
     Line(20,85,55,115);
{Circle}
     Circle(85,60,12);
{Fill}
     rectangle(65,85,103,115);Line(65,95,103,96);SETFILLSTYLE(1,black);FLOODFILL(67,97,black);
{Gum}
     Line(17,125,17,155);line(17,125,25,125);line(17,155,30,155);line(25,125,30,155);FloodFill(20,127,black);
     line(55,125,55,155);Line(55,125,43,125);line(55,155,48,155);line(48,155,43,125);FloodFill(50,150,black);
{Pattern}
     Line(65,155,65,125);Line(65,155,70,127);Line(65,155,75,130);Line(65,155,80,133);
     Line(65,155,85,135);Line(65,155,90,137);Line(65,155,95,140);Line(65,155,100,143);
     Line(65,155,103,145);Line(65,155,105,150);
{new}
     rectangle(25,165,50,195);Line(45,165,45,170);Line(45,170,50,170);Line(45,165,50,170);
     SetFillStyle(1,lightGray);FloodFill(49,166,black);
{rectangle}
     rectangle(65,168,103,192);
{end}
     OUTTEXTXY(30,200,'E');
     SetFillStyle(1,white);
end;