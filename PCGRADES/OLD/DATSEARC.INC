PROCEDURE Suchen;
{VAR String1, String2, Code, Output : STRING;
    I                              : INTEGER;}

BEGIN
     ClrScr;
     WRITELN('D A T E N S U C H E');
     {ReadStringXY(100,100,'Geben Sie den Suchstring ein: ',String1);
     Assign(Datei,DatFile);
     Reset(Datei);
     I:=0;
     Repeat
           ReadLn(Datei,String2);
           IF String1 = String2 THEN Inc(I);
     Until Eof(Datei);
     Str(I,Code);
     IF I>0 THEN Output:='Der String wurde '+Code+' Mal gefunden.'
            ELSE Output:='Der String wurde nicht gefunden !';
     OutTextXY(100,200,Output);}
     Taste:=ReadKey;
END;