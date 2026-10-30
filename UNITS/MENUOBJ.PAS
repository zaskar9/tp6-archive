UNIT MenuObj;

INTERFACE

USES CRT, MOUSE;

TYPE HinterGrund=OBJECT
        x1, x2, y1, y2                    : INTEGER;
        FillChar                          : CHAR;
        CONSTRUCTOR Init(xa, ya, xb, yb : INTEGER; NewFillChar : CHAR);
        PROCEDURE Draw(Color : WORD); VIRTUAL;
        PROCEDURE Rebuild(xx,yy,xxx,yyy : INTEGER; Color : WORD); VIRTUAL;
     END;

     Rahmen=OBJECT
        x1, x2, y1, y2                        : INTEGER;
        Schatten                              : BOOLEAN;
        RahmenColor, ItemColor, TxtColor      : WORD;
        MaxDat                                : INTEGER;
        Position, TxtStrLg                    : ARRAY[1..25] OF INTEGER;
        TxtStr, Teil1, Teil2, LightChar       : ARRAY[1..25] OF STRING;
        CONSTRUCTOR Init(xa, ya, xb, yb : INTEGER; InitDatei : STRING; BkColor, ItCol,
                    TColor : WORD; Shad : BOOLEAN);
        PROCEDURE Draw(LineColor : WORD); VIRTUAL;
        PROCEDURE Cancel(BackGroundChar : CHAR; CharColor : WORD); VIRTUAL;
        PROCEDURE WriteIn(Number : INTEGER; Item, TxtC, BackC : WORD);
        FUNCTION LightBar(BarColor, BarTxtCol : WORD; Wo : INTEGER): INTEGER;
     END;

IMPLEMENTATION

CONSTRUCTOR HinterGrund.Init(xa, ya, xb, yb : INTEGER; NewFillChar : CHAR);
BEGIN x1:=xa; x2:=xb; y1:=ya; y2:=yb;
      FillChar:=NewFillChar;
END;

PROCEDURE HinterGrund.Draw(Color : WORD);
VAR I, Z                         : INTEGER;
    Text                         : STRING[80];
BEGIN
     TextColor(Color);
     TextBackGround(lightgray);
     Text:='';
     Window(x1,y1,x2,y2);
     For I := x1 TO x2 DO Text:=Text+FillChar;
     ClrScr;
     Z:=2;
     For I := y1+1 TO y2-1 DO
         BEGIN
              GotoXY(1,Z);
              Write(Text);
              Inc(z);
         END;
     Window(1,1,80,25);
     TextColor(black);
     GotoXY(x1,y2); Write('Û');
     GotoXY(x1,y1);
END;


PROCEDURE HinterGrund.Rebuild(xx, yy, xxx, yyy : INTEGER; Color : WORD);

VAR I                              : INTEGER;
    Text                           : STRING[80];

BEGIN
     IF (xx<x1) OR (xxx>x2) OR (yy<y1+1) OR (yyy>y2-1)
       THEN BEGIN Write(^G); Exit;
            END;
     Text:='';
     TextBackGround(lightgray);
     TextColor(Color);
     For I := xx TO xxx DO Text:=Text+FillChar;
     I:=yy;
     For I := yy TO yyy DO
         BEGIN
              GotoXY(xx,I);
              Write(text);
         END;
     GotoXY(1,25);
END;

CONSTRUCTOR Rahmen.Init(xa, ya, xb, yb : INTEGER; InitDatei : STRING; BkColor, ItCol,
            TColor : WORD; Shad : BOOLEAN);

VAR I, z                          : INTEGER;
    Datei                         : TEXT;

BEGIN
     I:=0;z:=1;
     Repeat
           TxtStr[I]:='';
           Inc(I);
     Until I>25;
     {$I-}
     Assign(Datei,InitDatei);
     Reset(datei);
     {$I+}
     IF IOResult<>0 THEN Exit;
     I:=1;
     While Not Eof(Datei) Do
           Begin
                ReadLn(Datei,TxtStr[I]);
                Inc(I);
           End;
     Close(Datei);
     RahmenColor:=BkColor;
     Schatten:=Shad;
     ItemColor:=ItCol;
     TxtColor:=TColor;
     MaxDat:=I-1;
     y1:=ya;
     y2:=yb;
     x1:=xa;
     x2:=xb;
     I:=1;
     Repeat
           TxtStrLg[I]:=LENGTH(TxtStr[I])-1;
           Position[I]:=POS('~',TxtStr[I]);
           Teil1[I]:=COPY(TxtStr[I],0,Position[I]-1);
           Teil2[I]:=COPY(TxtStr[I],Position[I]+2,TxtStrLg[I]);
           LightChar[I]:=COPY(TxtStr[I],Position[I]+1,1);
           Inc(I);
     UNTIL I>MaxDat;
END;

PROCEDURE Rahmen.Draw(LineColor : WORD);

VAR I                       : INTEGER;
    TextX                   : STRING[80];

BEGIN
     {HideCursor;}
     Window(x1,y1,x2,y2);
     TextColor(LineColor);
     TextBackGround(RahmenColor);
     ClrScr;
     TextX:='';
     Window(1,1,80,25);
     For I := x1+1 To x2-1 Do TextX:=TextX+'Í';
     For I := y1+1 To y2-1 Do
         Begin
              GotoXY(x1,I);Write('º');
              GotoXY(x2,I);Write('º');
         End;
     GotoXY(x1+1,y1);Write(TextX);
     GotoXY(x1+1,y2);Write(TextX);
     GotoXY(x1,y1);Write('É');
     GotoXY(x2,y1);Write('»');
     GotoXY(x2,y2);Write('¼');
     GotoXY(x1,y2);Write('È');
     IF Schatten THEN
        Begin
             TextColor(0);
             For I := y1+1 To y2 Do
                 Begin
                      Gotoxy(x2+1,I); Write('Û');
                 End;
             For I := x1+1 To x2+1 Do
                 Begin
                      Gotoxy(I,y2+1); Write('Û');
                 End;
        End;
     GotoXY(x1+1,y1+1);
     I:=0;
     {ShowCursor;}
     Exit;
END;

PROCEDURE Rahmen.Cancel(BackGroundChar : CHAR; CharColor : WORD);

VAR I                                             : INTEGER;
    Text                                          : STRING[80];

BEGIN
     Text:='';
     NormVideo;
     If Schatten Then Begin
                           x2:=x2+1;
                           y2:=y2+1;
                      End;
     For I := x1 to x2 Do Text:=Text+BackGroundChar;
     TextColor(CharColor);
     TextBackGround(lightgray);
     For I := y1 to y2 Do
         Begin
              GotoXY(x1,I);Write(Text);
         End;
     Gotoxy(1,25);
END;

PROCEDURE Rahmen.WriteIn(Number : INTEGER; Item, TxtC, BackC : WORD);

VAR Maxx : INTEGER;

BEGIN
     maxx:=x2-1;
     TextBackGround(BackC);
     GotoXY(x1+1,y1+Number);
     TextColor(TxtC);  Write('  ',Teil1[Number]);
     TextColor(Item);  Write(LightChar[Number]);
     TextColor(TxtC);  Write(Teil2[Number]);
     Repeat
           Write(' ');
     Until WhereX>maxx;
END;

FUNCTION Rahmen.LightBar(BarColor, BarTxtCol : WORD; Wo : INTEGER): INTEGER;

VAR I, a, b, xLength, BarLength, maxx, minx, maxy, miny, Ent, Stelle,
    x, y, Button, realx, realy, savex, savey, TasteII, f           : INTEGER;
    Taste, CharCh                                                  : CHAR;
    DrawNeed, TestChar                                             : BOOLEAN;
    Verz, Entscheidung, TasteIII                                   : STRING;

BEGIN
     I:=Wo;
     Entscheidung:='';
     TestChar:=FALSE;
     Ent:=1;
     Repeat
         MEM[SEG(CharCh):OFS(CharCh)]:=MEM[SEG(LightChar[Ent]):OFS(LightChar[Ent])+1];
         Entscheidung:=Entscheidung+UPCASE(CharCh);
         Inc(Ent);
     until Ent>MaxDat;
     maxx:=x2-1;
     maxy:=y2-1;
     minx:=x1+1;
     miny:=y1+1;
     GotoXY(1,25);
     TextBackGround(RahmenColor);
     Repeat
           Rahmen.WriteIn(I, ItemColor, TxtColor, RahmenColor);
           Inc(I);
     Until I>MaxDat;
     IF I<2 THEN Begin
                      LightBar:=1;
                      Exit;
                 End;
     Gotoxy(1,25);
     I:=Wo;
     {ShowCursor;}
     DrawNeed:=True;
     Repeat
           a:=x1+1;
           b:=y1+I;
           {GetPosBut(Button,savex,savey);}
           IF DrawNeed THEN BEGIN
           Gotoxy(a,b);
           {Schrift Untermalt}
           Rahmen.WriteIn(I, ItemColor, barTxtCol, BarColor);
           GotoXY(1,25);
           END;
           IF KeyPressed THEN BEGIN
              Taste:=ReadKey;
              IF Taste=#0
                Then Begin
                           {Schrift Normal}
                                  Taste:=ReadKey;
                                  Gotoxy(a,b);
                                  Rahmen.WriteIn(I, ItemColor, TxtColor, RahmenColor);
                                  Case Taste of
                                  {Up} #72 : Begin
                                                  If I=1 Then Begin
                                                                   I:=maxDat;
                                                                   TestChar:=TRUE;
                                                              End
                                                          Else Dec(I);
                                             End;
                               {Down}  #80 : Begin
                                                  If I=maxDat Then Begin
                                                                        I:=1;
                                                                        TestChar:=TRUE;
                                                                   End
                                                          Else Inc(I);
                                             End;
                                End;
                                DrawNeed:=TRUE;
                            End;
              End
              ELSE BEGIN
                        Delay(100);
                        {GetPosBut(Button,x,y);}
                        IF (y<>savey) THEN BEGIN
                        DELAY(0);
                        savex:=x;savey:=y;
                        realx:=x DIV 8;
                        realy:=(y DIV 8)+1;
                        IF (realy IN [y1+1..maxdat+y1]) AND (realx IN [x1..x2])
                        THEN Begin
                                Gotoxy(a,b);
                                TextBackground(RahmenColor);
                                HideCursor;
                                Rahmen.WriteIn(I, ItemColor, TxtColor, RahmenColor);
                                ShowCursor;
                                I:=realy-y1;
                           END;
                           DrawNeed:=true;
                        END
                        ELSE DrawNeed:=FALSE;
                   END;
                                               TasteIII:=UpCase(Taste);
                                               Stelle:=POS(TasteIII, Entscheidung);
                   Val(Taste,TasteII,f);
     Until (Taste=#13) OR (Taste=#27) OR (Button IN [1,2]) OR (Stelle>0);
     {HideCursor;}
     Delay(500);
     If Stelle>0 THEN Lightbar:=Stelle
                 ELSE If (Taste=#27) OR (Button=2) THEN LightBar:=0
                                                   ELSE If (Taste=#13) OR (Button=1) THEN Lightbar:=I;

     Taste:=#0;
END;

END.