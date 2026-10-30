PROCEDURE InitDevice;

BEGIN
     Hintergrund;
     WRITE(' W A H L   D E S   A U S G A B E G E R é T S');
     Rahmen(20,8,60,13,cyan);
     Write(' Angeschlossene GerÑte:');
     GotoXY(22,10);Write('Drucker..........................<F1>');
     GotoXY(22,11);Write('Bildschirm.......................<F2>');
     GotoXY(22,12);Write('Abbrechen.......................<ESC>');
     Gotoxy(22,14);
     Repeat
           Taste:=ReadKey;
           If Taste=#27 THEN BEGIN
                                  Taste:=' ';
                                  Exit;
                             END;
           If Taste=#0 THEN Begin
                           Taste:=ReadKey;
                           Case Taste Of
                                #59 : Aux:=Prn;
                                #60 : Aux:=Scr;
                           End; {END OF CASE}
           END;
     Until Taste IN[#59..#60];
     Rahmen(13,16,67,18,red);
     Write('All Ihre Ausgaben laufen nun Åber das gewÑhlte GerÑt.');
     GOTOXY(15,19);
     Taste:=ReadKey;
END;
