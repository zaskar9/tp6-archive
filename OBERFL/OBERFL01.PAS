Program Oberflaeche;
Uses Graph, Crt;

TYPE Fenster=OBJECT
               x1,y1,x2,y2 : integer;
               MenuText : ARRAY[0..9] of String[10];
               Constructor Init(a1,b1,a2,b2 : Integer);
               Procedure Rahmen;
               Procedure TitleBar(Text : string);
               Procedure MenuBar;
               Procedure MenuPlug;
               Procedure PopUpPlug;
               {Procedure CloseDownPlug;
               Procedure ResizePlug;}
             End;

Var gd, gm : Integer;
    Wind : Fenster;

Constructor Fenster.Init(a1,b1,a2,b2 : Integer);
Begin x1:=a1;
      x2:=a2;
      y1:=b1;
      y2:=b2;
      MenuText[0]:='File ';
      MenuText[1]:='Options ';
      MenuText[2]:='Edit ';
      MenuText[3]:='Window ';
      MenuText[4]:='Help ';
      MenuText[5]:=' ';
      MenuText[6]:=' ';
      MenuText[7]:=' ';
      MenuText[8]:=' ';
      MenuText[9]:=' ';
end;

Procedure Fenster.Rahmen;
Begin SetColor(Black);
      Rectangle(x1-3,y1-3,x2+3,y2+3);
      Rectangle(x1,y1,x2,y2);
      SetColor(lightgray);
      Rectangle(x1-1,y1-1,x2+1,y2+1);
      Rectangle(x1-2,y1-2,x2+2,y2+2);
end;

Procedure Fenster.TitleBar(Text : String);
Begin Setcolor(Black);
      line(x1,y1+18,x2,y1+18);
      Setfillstyle(solidfill,blue);
      bar(x1+1,y1+1,x2-1,y1+17);
      SetColor(white);
      SetTextJustify(CenterText, CenterText);
      OutTextXY((x1+x2) DIV 2, y1+9, Text);
end;

Procedure Fenster.MenuBar;
Begin SetColor(black);
      Line(x1,y1+36,x2,y1+36);
      SetTextStyle(0,0,0);
      SetTextJustify(LeftText,CenterText);
      OutTextXY(x1+5,y1+28,MenuText[0]+' '+MenuText[1]+' '+MenuText[2]+' '+MenuText[3]+' '+
                MenuText[4]+' '+MenuText[5]+' '+MenuText[6]+' '+MenuText[7]+' '+MenuText[8]+' '+MenuText[9]);
End;

Procedure Fenster.MenuPlug;
Begin SetFillStyle(solidfill,lightgray);
      bar(x1,y1,x1+18,y1+18);
      SetColor(black);
      Rectangle(x1,y1,x1+18,y1+18);
end;

Procedure Fenster.PopUpPlug;
Begin SetFillStyle(SolidFill,Lightgray);
      Bar(x2-18,y1,x2,y1+18);
      SetColor(Black);
      Rectangle(x2-18,y1,x2,y1+18);
      SetColor(darkgray);
      Line(x2-1,y1+2,x2-1,y1+17);
      Line(x2-2,y1+3,x2-2,y1+16);
      Line(x2-2,y1+17,x2-15,y1+17);
      Line(x2-3,y1+16,x2-15,y1+16);
      setColor(white);
      Line(x2-1,y1+1,x2-17,y1+1);
      Line(x2-2,y1+2,x2-16,y1+2);
      Line(x2-17,y1+2,x2-17,y1+17);
      Line(x2-16,y1+3,x2-16,y1+16);
End;

Procedure Rahmen(x1, y1, x2, y2 : Integer; Col1, Col2 : Word);
Begin SetColor(Col1);
      Line(x1,y2,x2,y2);
      Line(x2,y1,x2,y2);
      Line(x1+1,y2-1,x2-1,y2-1);
      Line(x2-1,y1+1,x2-1,y2-1);
      SetColor(Col2);
      Line(x1,y1,x2,y1);
      Line(x1,y1,x1,y2);
      Line(x1+1,y1+1,x2-1,y1+1);
      Line(x1+1,y1+1,x1+1,y2-1);
end;


procedure Schaltflaeche(x1,y1,x2,y2 : Integer; Text : String);
Begin SetFillStyle(SolidFill,lightgray);
      bar(x1,y1,x2,y2);
      Rahmen(x1,y1,x2,y2,darkgray,white);
      Setcolor(black);
      Rectangle(x1-1,y1-1,x2+1,y2+1);
      SetTextJustify(CenterText,CenterText);
      SetTextStyle(0,0,0);
      OutTextXY((x1+x2) DIV 2, (y1+y2) DIV 2, Text);
End;

Procedure Grund;
Begin SetFillStyle(solidfill,white);
      bar(1,1,640,480);
end;

Begin DetectGraph(gd, gm);
      initGraph(gd, gm, 'C:\tp\bgi');
      Grund;
      Schaltflaeche(310,450,410,470,'OK');
      Schaltflaeche(420,450,520,470,'Abbrechen');
      Schaltflaeche(530,450,630,470,'Hilfe');
      Wind.Init(5,5,635,475);
      Wind.Rahmen;
      Wind.TitleBar('Word for Windows');
      Wind.MenuBar;
      Wind.MenuPlug;
      Wind.PopUpPlug;
      Repeat Until Keypressed;
      CloseGraph;
End.