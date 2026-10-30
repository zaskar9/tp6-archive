PROGRAM Menue;

USES Objects, Drivers, Views, Menus, Dialogs, App;

VAR Taste                                         : CHAR;
    A, B, x, y                                    : INTEGER;

TYPE Hintergrund=OBJECT(TBackground)
                 CONSTRUCTOR Init(Var Bounds : TRECT; APattern : CHAR);
                 PROCEDURE Draw; VIRTUAL;
     END;

Begin
     Hintergrund.Init('°');
     Hintergrund.Draw;
     Taste:=ReadKey;
END.