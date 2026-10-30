program Mauserich;
uses crt,mouse,graph;

var Status,x,y,xalt,yalt,Anzahltasten    :Integer;
    graphdriver,graphmode                : integer;
    taste                                : char;
    aa,bb                                : string;

{$I A:\CURSOR.INC}

procedure SetCursorToKreuz;
const
  kreuz : GraphicCursor =
           (screenMask: ($FC3F,$FC3F,$FC3F,$FC3F,$FC3F,$FC3F,
                         0,0,0,0,$FC3F,$FC3F,$FC3F,$FC3F,$FC3F,$FC3F);
           cursorMask: (0,384,384,384,384,384,384,
                         $7E7E,$7E7E,384,384,384,384,384,384,0);
            
            hotX: 8;
            hotY: 8);
 begin
   SetGraphiccursor(UHR);
end;



BEGIN
  CLRSCR;
     Flagreset(status,anzahltasten);
     Write('Anzahl der Maustasten: ',Anzahltasten);
     ShowCursor;

    repeat
      GetPosBut(status,x,y);
     gotoxy(10,2); writeln('Mausknopf,POSx,POSy  ',Status,'   ',x:3,'   ',y:3);

   until status=3;

     hidecursor;

    graphdriver:=detect;
    InitGraph(graphdriver, graphmode,'C:\tp\Bgi');
    Bar(10,10,40,40);
    SetBkColor(1);
    xalt:=0; yalt:=0;
    SetCursorToKreuz;
    SetHorizontalLimits(0,628);
    SetVerticalLimits(0,464);
       ShowCursor;
       Outtextxy(200,10,'mittlere Taste dr…ken');
       LightPenOn;
       REPEAT
        GetPosBut(status,x,y);
        if (xalt<>x) or (yalt<>y) THEN BEGIN
                                            xalt:=x;yalt:=y;
                                            str(x,aa);str(y,bb);
                                            setcolor(4);
                                            bar(300,350,380,450);
                                            outtextxy(300,400,aa);
                                            outtextxy(340,400,bb);
                                       END;
       UNTIL status=4;
       ClearDevice;
       status:=0;
       SetColor(14);
       Outtextxy(200,10,'linke Taste dr…ken');
       xalt:=0;yalt:=0;
       Setcolor(4);
       SetCursorPos(300,300);Moveto(300,300);
       REPEAT
         GetPosBut(status,x,y);
         if (xalt<>x) or (yalt<>y) THEN BEGIN
                                             HideCursor;
                                             lineto(x,y);
                                             ShowCursor;
                                             xalt:=x;yalt:=y;
                                             str(x,aa);str(y,bb);
                                             bar(300,350,380,450);
                                             outtextxy(300,400,aa);
                                             outtextxy(340,400,bb);
                                             Moveto(x,y);
                                        END;
       UNTIL status=1;
       HideCursor;
       clearDevice;
       status:=0;
       SetColor(14);
       Outtextxy(50,10,'linke Taste gedr…kt: es wird gezeichnet. rechte Taste dr…ken:Ende');
       Setcolor(14);
       ShowCursor;
       REPEAT
             GetPosBut(status,x,y);
             xalt:=0;yalt:=0;
             Moveto(x,y);
             while status=1 do BEGIN
                GetPosBut(status,x,y);
                if (xalt<>x) or (yalt<>y) THEN BEGIN
                                                 HideCursor;
                                                 lineto(x,y);
                                                 ShowCursor;
                                                 xalt:=x;yalt:=y;
                                                 setcolor(4);
                                                 str(x,aa);str(y,bb);
                                                 bar(300,350,380,450);
                                                 outtextxy(300,400,aa);
                                                 outtextxy(340,400,bb);
                                                 Moveto(x,y);
                                               END;
             end;
       UNTIL STATUS=2;
       HIDECursor;
       LightPenOFF;
       closegraph;
       HIDECursor;
END.


