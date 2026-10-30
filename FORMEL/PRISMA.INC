Procedure Prisma;

Begin
     GraphEin;
     Line(35,60,140,60);
     Line(35,60,100,080);
     Line(100,080,140,60);
     Line(35,180,140,180);
     Line(35,180,100,200);
     Line(100,200,140,180);
     Line(35,60,35,180);
     Line(100,80,100,200);
     Line(140,60,140,180);
     Line(90,70,90,190);
     OutTextXY(80,120,'h');
     OutTextXY(45,190,'G');
     FormTran('A:\PRISMA.DAT');
     IF Ende=Stop THEN Exit;
     GraphAus;
END;