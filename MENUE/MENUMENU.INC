PROCEDURE Menu;

VAR Command, s, Laufwerk, MenuPfdFile, MenuDatName            : STRING;
    Erweiterung                                               : EXTSTR;
    Directory                                                 : DIRSTR;
    Name                                                      : NameStr;
    Kasten                                                    : Rahmen;
    Wahli, Laenge, fehler                                     : INTEGER;
    Datei                                                     : TEXT;
    Pfad, DirName, Dateiname                                  : ARRAY[0..25] OF STRING[79];
    Nummer                                                    : BYTE;

BEGIN
     ShowCursor;
     Command:='';
     BackGround.Draw(blue);
     GotoXY(2,1);Write(ProgName);
     Gotoxy(2,25);Write(' Copyright 1993 by Michael Grossniklaus, Basel');
     Fram.InitII(5,MenuDatFile,blue,true);
     Fram.Draw(white);
     Wahli:=1;
     Repeat
           Wahl:=Fram.LightBar(lightgray,Wahli);
           IF Wahl = 0 THEN Begin
                                 Stop:=True;
                                 Exit;
                            End;
           Wahli:=wahl;
           Laenge:=Length(MenuDatFile);
           MenuPfdFile:=MenuDatFile;
           Delete(MenuPfdFile,Laenge-2,3);
           MenuPfdFile:=MenuPfdFile+'PFD';
           {$I-}
           Assign(Datei,MenuPfdFile);
           Reset(Datei);
           {$I+}
           IF IOResult<>0 THEN Exit;
           I:=1;
           While Not Eof(Datei) DO
                 Begin
                      ReadLn(Datei,Dateiname[I]);
                      Inc(I);
                 End;
           Close(datei);
           MenuDatName:=Dateiname[Wahl];
           If Wahl <> PromptNr THEN Begin
                                  Kasten.InitII(42,MenuDatName,blue,true);
                                  Kasten.Draw(white);
                                  Wahl:=Kasten.LightBar(lightgray,1);
                                  Kasten.Cancel('∞',blue);
                             End;
     Until Wahl IN [1..25];
     IF Wahl <> PromptNr THEN
        BEGIN
             Laenge:=Length(MenuDatName);
             Delete(MenuDatName,Laenge-2,3);
             MenuDatName:=MenuDatName+'PFD';
             {$I-}
             Assign(Datei,MenuDatName);
             Reset(Datei);
             {$I+}
             IF IOResult<>0 THEN Exit;
             I:=1;
             While Not Eof(Datei) DO
                   Begin
                        ReadLn(Datei,Pfad[I]);
                        ReadLn(Datei,DirName[I]);
                        Inc(I);
                   End;
             Close(datei);
             TextBackGround(0);
             TextColor(7);
             {$I-}
             ChDir(DirName[Wahl]);
             {$I+}
             IF IOResult<>0 THEN Exit;
             FSplit(Pfad[Wahl],Directory,Name,Erweiterung);
             IF Erweiterung='.BAT' THEN BEGIN
                                             Pfad[0]:=Pfad[Wahl];
                                             Pfad[Wahl]:=GetEnv('COMSPEC');
                                             Command:='/C'+Pfad[0];
                                        END;
             ClrScr;
             SwapVectors;
             Exec(Pfad[Wahl],Command);
             SwapVectors;
             IF DosError <> 0 THEN Begin
                                        Fehler:=DosError;
                                        Write(^G);
                                        HelpMe(Fehler);
                                   End;
             TextBackGround(7);
             ChDir(Path);
        END
        ELSE BEGIN
                  Laufwerk:='';
                  Nummer:=0;
                  ChDir('C:\');
                  TextBackGround(0);
                  TextColor(7);
                  ClrScr;
                  WRITELN('ZurÅck zu ',ProgName,' ÕÕ ÆEXITØ ');
                  Repeat
                        {$I-}
                        GetDir(Nummer,s);
                        {$I+}
                        IF IOResult <> 0 THEN Exit;
                        Write(Laufwerk+s+'>');Readln(Command);
                        IF (Command='a:') OR (Command='A:') OR (Command='A:\') OR (Command='a:\') THEN Nummer:=1;
                        IF (Command='b:') OR (Command='B:') OR (Command='B:\') OR (Command='b:\') THEN Nummer:=2;
                        IF (Command='c:') OR (Command='C:') OR (Command='C:\') OR (Command='c:\') THEN Nummer:=3;
                        SwapVectors;
                        Exec(GetEnv('COMSPEC'),'/C'+Command);
                        SwapVectors;
                  Until (Command='exit') OR (Command='Exit') OR (Command='EXIT');
                  ChDir(Path);
             END;
END;
