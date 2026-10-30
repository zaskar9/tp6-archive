PROCEDURE Zylinder;

BEGIN
     GraphEin;
     SetColor(black);
     SetColor(black);
     Ellipse(80,50,0,360,45,20);
     Ellipse(80,150,0,360,45,20);
     Line(80,50,80,150);
     Line(35,50,35,150);
     Line(125,50,125,150);
     Line(80,50,125,50);
     Line(80,150,125,150);
     SetTextStyle(0,0,1);
     OutTextXY(83,85,'h');
     OutTextXY(100,140,'r');
     FormTran('A:\ZYLIFORM.DAT');
     IF Ende=stop THEN Exit;
     HideCursor;
     GraphAus;
END;