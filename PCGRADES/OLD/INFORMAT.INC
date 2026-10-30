PROCEDURE Info (DatFile : STRING);
VAR Code       : STRING;
    I          : INTEGER;
BEGIN
     ClrScr;
     WRITELN('D A T E I I N F O R M A T I O N');
     WRITELN('Ihre Datei: ',DatFile);
     Assign(Datei,DatFile);
     Reset(Datei);
     I:=1;
     {Repeat
           Inc(i);
           Readln(Datei);
     Until Eof(Datei);
     Str(I-1,Code);
     OutTextXY(100,130,'Anzahl Zeilen: ');
     OutTextXY(270,130,Code);}
     Taste:=ReadKey;
END;