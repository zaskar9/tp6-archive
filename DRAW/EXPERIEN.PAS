PROGRAM Mauserfahrung;
USES Crt, Mouse;

VAR x, y, x1, y1, x2, y2, I, J, z, ButtonStatus : INTEGER;
    Austritt : BOOLEAN;
{$I A:\MACHRAHM.INC}

BEGIN
     IF not DriverInstalled THEN HALT;
     TextBackGround(7);
     ClrScr;Z:=0;
     Gotoxy(25,2);
     Write('Klicken Sie ins orange Feld !');
     TextColor(0);
     SetTextCursor(0,1,80);
     Rahmen(10,10,20,15,yellow);
     Gotoxy(11,16);
     TextBackground(7);
     SetCursorPos(40*8-1,4*8-1);
     Gotoxy(35,4);
     Austritt:= FALSE;
     Write('===>  <===');
     GotoXY(1,25);
     ShowCursor;
     Repeat
          GetPosBut(ButtonStatus,x,y);
          x1:=(x Div 8)+1;
          y1:=(y Div 8)+1;
          IF (x1 in[11..19]) AND (ButtonStatus=1) THEN BEGIN
                                     If y1 in[11..14] THEN BEGIN
                                                                HideCursor;
                                                                Sound(440);
                                                                Delay(500);
                                                                NoSound;
                                                                Gotoxy(37,20);
                                                                WRITE('<TASTE>');
                                                                Gotoxy(1,25);
                                                                Repeat Until KeyPressed;
                                                                Austritt:=TRUE;
                                                            END;
                                END;
     Until Austritt;
     Gotoxy(1,20);DelLine;Rahmen(50,20,60,22,green);
     Write(' E N D E ');
     ShowCursor;
     GotoXY(1,25);
     Repeat
           GetPosBut(ButtonStatus,x,y);
           x1:=(x Div 8)+1;
           y1:=(y Div 8)+1;
     Until (y1=21) And (x1 in[51..59]) AND (Buttonstatus=2);
     Delay(1000);
END.



