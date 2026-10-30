PROCEDURE Menu;

BEGIN
     Repeat
           SetGraphicCursor(Pfeil);
           SetCursorPos(70,160);
           ShowCursor;
           SetViewPort(1,1,630,480,false);
           SetHorizontalLimits(10,110);
           SetVerticalLimits(40,400);
           Repeat
                GetPosBut(Button,x,y);
                x1:=x;
                y1:=y
           Until Button=1;
           IF (x1 IN[12..60]) THEN BEGIN
                                     CASE y1 OF
                                          42..80 : Draw;
                                          81..120 : Linedraw;
                                          121..160 : gumm;
                                          161..200 : delfield;
                                          201..240 : ende;
                                     END;
                                     END;
           IF (x1 IN[60..108]) THEN BEGIN
                                      CASE y1 OF
                                          42..80 : Cirle;
                                          81..120 : Fill;
                                          121..160 : muster;
                                          161..200 : Rechteck;
                                      END;
                                      END;
     Until Keypressed;
     HideCursor;
END;