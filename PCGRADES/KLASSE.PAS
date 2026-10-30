PROGRAM Zusammenkunft;
USES CRT, MYOBJECT;

TYPE Klasse=RECORD
                name, Antw                          : STRING;
                Komme                               : BOOLEAN;
            END;

VAR Frame, Frame2                               : Rahmen;
    Bk                                          : Hintergrund;
    Datei                                       : FILE OF Klasse;
    Datensatz                                   : ARRAY[1..22] OF Klasse;
    Wahl, I, u                                  : INTEGER;

PROCEDURE Eingabe;

BEGIN
     Frame.Draw(black);
     GotoXY(3,2);
     Write('Name');
     GotoXY(33,2);
     Write('Anmeldung');
     I:=1;
     u:=1;
     Repeat
          Gotoxy(2,I+2);
          Readln(Datensatz[I].Name);
          IF Datensatz[I].Name =''  THEN BEGIN
                                         Repeat
                                               GotoXY(1,25);
                                               Write(Datei,Datensatz[u]);
                                               Inc(u);
                                         Until u>I;
                                         Exit;
                                    END;
          GotoXY(36,I+2);
          Readln(Datensatz[I].Antw);
          IF Datensatz[I].Antw ='+' THEN Datensatz[I].Komme:=TRUE
                                    ELSE Datensatz[I].Komme:=FALSE;
     Inc(I);
     Until I>21;
     Repeat
           Write(Datei,Datensatz[u]);
           Inc(u);
     Until u>I;
END;

BEGIN
     Frame.Init(1,2,80,24,cyan,false);
     Frame2.InitII(20,'A:\MEN1.DAT',blue,true);
     Bk.Init(1,1,80,25,'°');
     Bk.Draw(blue);
     Write(' Klassenzusammenkunft 4c Christoph Merian Schulhaus');
     GotoXY(3,25);
     Write('Copyright by Michael Grossniklaus, Basel 1993');
     {$I-}
     Assign(Datei,'A:\KLASSE.DAT');
     Reset(Datei);
     {$I+}
     IF IOResult <> 0 THEN Rewrite(Datei);
     Frame2.Draw(black);
     Wahl:=Frame2.Lightbar(lightgray,1);
     Frame2.Cancel('°',blue);
     Case Wahl Of
     1 : Eingabe;
     End;
END.