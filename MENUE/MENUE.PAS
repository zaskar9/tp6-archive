PROGRAM Menue;

{$M 20000, 0, 0}

USES CRT, MYOBJECT, MOUSE, DOS;

VAR Taste                                                : CHAR;
    BackGround                                           : HinterGrund;
    Fram, Copyright                                      : Rahmen;
    I, Wahl, Button, x, y, PromptNr                      : INTEGER;
    x1,x2,y1,y2                                          : INTEGER;
    Stop                                                 : BOOLEAN;
    Path, MenuDatFile, ProgName                          : STRING;
    Configfile                                           : TEXT;
    ProgPfad                                             : PATHSTR;

{$I A:\HELPMENU.INC}
{$I A:\COPYRIGH.INC}
{$I A:\MENUMENU.INC}

BEGIN
     ProgPfad:=FEXPAND('CONFIG.MEN');
     Assign(Configfile,ProgPfad);
     Reset(Configfile);
     ReadLn(Configfile,ProgName);
     ReadLn(Configfile,Path);
     ReadLn(Configfile,MenuDatFile);
     ReadLn(ConfigFile,PromptNr);
     ChDir(Path);
     Stop:=False;
     TextBackGround(black);
     ClrScr;
     Copyrigh;
     Repeat
           Menu;
     Until Stop;
     TextBackGround(0);
     TextColor(7);
     HideCursor;
     ClrScr;
     ChDir('a:\');
END.


