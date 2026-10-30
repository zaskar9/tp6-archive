UNIT StarUnit;

INTERFACE

USES CRT, GRAPH, WRITING, DOS;
TYPE StarGround=OBJECT
                      x1,y1,x2,y2                   : INTEGER;
                      LangeX, LangeY                : LONGINT;
                      Flaeche                       : LONGINT;
                      CONSTRUCTOR Init(a1,b1,a2,b2 : INTEGER);
                      PROCEDURE Draw; VIRTUAL;
                 END;

     StarFrame=OBJECT
                     x1,x2,y1,y2                : INTEGER;
                     Bk                         : WORD;
                     CONSTRUCTOR Init(a1,b1,a2,b2 : INTEGER; BkColor : WORD);
                     PROCEDURE Draw; VIRTUAL;
                     PROCEDURE Refrish; VIRTUAL;
               END;

IMPLEMENTATION

CONSTRUCTOR StarGround.Init(a1,b1,a2,b2 : INTEGER);

VAR gd, gm : INTEGER;

BEGIN
     DetectGraph(gd, gm);
     InitGraph(gd, gm, 'A:\');
     x1:=a1;
     x2:=a2;
     y1:=b1;
     y2:=b2;
     LangeX:=a2-a1;
     LangeY:=b2-b1;
     Flaeche:=(LangeX)*(LangeY);
END;

PROCEDURE StarGround.Draw;

VAR I, a, b                  : INTEGER;
    Anzahl                   : LONGINT;
    Color                    : WORD;

BEGIN
     I:=0;
     Anzahl:=TRUNC((400/307200)*Flaeche);
     SETCOLOR(white);
     RANDOMIZE;
     REPEAT
           a:=RANDOM(x2)+x1;
           b:=RANDOM(y2)+y1;
           IF I MOD 2 = 0 THEN Color:=Yellow
                          ELSE Color:=White;
           PUTPIXEL(a,b,Color);
           IF I MOD 10 = 0 THEN CIRCLE(a,b,1);
           INC(I);
     UNTIL I>Anzahl;
END;


CONSTRUCTOR StarFrame.Init(a1,b1,a2,b2 : INTEGER; BkColor : WORD);

BEGIN
     x1:=a1;
     x2:=a2;
     y1:=b1;
     y2:=b2;
     Bk:=BkColor;
END;

PROCEDURE StarFrame.Draw;

BEGIN
     SETFILLSTYLE(1,Bk);
     BAR(x1,y1,x2,y2);
     SetViewPort(0, 0, GetMaxX, GetMaxY, ClipOn);
     SETCOLOR(White);
     RECTANGLE(x1+2,y1+2,x2-2,y2-2);
     RECTANGLE(x1+4,y1+4,x2-4,y2-4);
END;

PROCEDURE StarFrame.Refrish;

VAR I, a, b          : INTEGER;
    Color            : WORD;
    Anzahl           : LONGINT;

BEGIN
     I:=0;
     SETVIEWPORT(x1,y1,x2,y2, ClipOn);
     CLEARVIEWPORT;
     SetViewPort(0, 0, GetMaxX, GetMaxY, ClipOn);
     SETCOLOR(white);
     Anzahl:=TRUNC((400*((x2-x1)*(y2-y1)))/307200);
     RANDOMIZE;
     REPEAT
           a:=RANDOM(x2)+x1;
           b:=RANDOM(y2)+y1;
           IF I MOD 2 = 0 THEN Color:=Yellow
                          ELSE Color:=White;
           PUTPIXEL(a,b,Color);
           IF I MOD 10 = 0 THEN CIRCLE(a,b,1);
           INC(I);
     UNTIL I>Anzahl;
END;

END.
