PROGRAM Test;

USES CRT;

Var Laenge : Integer;
    Dateiname : String;

BEGIN
     clrscr;
     Dateiname:='Michael.Dat';
     Laenge:=Length(DateiName);
     Delete(Dateiname,Laenge-2,3);
     Dateiname:=Dateiname+'PFD';
     Write(Dateiname);
     Repeat Until Keypressed;
END.