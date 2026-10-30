PROCEDURE Sternzeichen_bestimmen;

VAR Datum, Mon, Tg, Zt, Std, Min, YZ, ZY                          : STRING;
    I, Position, Zahl, Monat, Tag, Fehler, Stu, Miu, AnzahlStd,
    yx, Zeichen, SZ, Asz                                          : INTEGER;
    Zeit                                                          : REAL;
    XY, Ask                                                       : STRING;

BEGIN
     Zahl:=1;
     Rahmen.Init(100,100,540,250,black);
     Repeat
           Rahmen.Draw;
           SetColor(white);
           ReadStringXY(110,125,'Geben Sie Ihr Geburtsdatum ein (Tag.Monat): ',
                        Datum);
           Position:=Pos('.',Datum);
           If Position>2 THEN Zahl:=2
                         ELSE Zahl:=1;
           Tg:=Copy(Datum,1,Zahl);
           Mon:=Copy(Datum,Position+1,2);
           Val(Mon,Monat,Fehler);
           Val(Tg,Tag,Fehler);
     Until Fehler=0;
     CASE Monat OF
     1  : IF Tag IN[1..20] THEN Zeichen:=10
                           ELSE Zeichen:=11;
     2  : IF Tag IN[1..19] THEN Zeichen:=11
                           ELSE Zeichen:=12;
     3  : IF Tag IN[1..20] THEN Zeichen:=12
                           ELSE Zeichen:=1;
     4  : IF Tag IN[1..20] THEN Zeichen:=1
                           ELSE Zeichen:=2;
     5  : IF Tag IN[1..21] THEN Zeichen:=2
                           ELSE Zeichen:=3;
     6  : IF Tag IN[1..21] THEN Zeichen:=3
                           ELSE Zeichen:=4;
     7  : IF Tag IN[1..22] THEN Zeichen:=4
                           ELSE Zeichen:=5;
     8  : IF Tag IN[1..23] THEN Zeichen:=5
                           ELSE Zeichen:=6;
     9  : IF Tag IN[1..23] THEN Zeichen:=6
                           ELSE Zeichen:=7;
     10 : IF Tag IN[1..23] THEN Zeichen:=7
                           ELSE Zeichen:=8;
     11 : IF Tag IN[1..22] THEN Zeichen:=8
                           ELSE Zeichen:=9;
     12 : IF Tag IN[1..21] THEN Zeichen:=9
                           ELSE Zeichen:=10;
     END;
     SZ:=Zeichen;
     Repeat
           ReadStringXY(110,145,'Geben Sie Ihre Geburtszeit ein (Std.Min)  : ',
                       Zt);
           Position:=Pos('.',Zt);
           If Position>2 THEN Zahl:=2
                         ELSE Zahl:=1;
           Std:=Copy(Zt,1,Zahl);
           Min:=Copy(Zt,Position+1,2);
           Val(Std,Stu,Fehler);
           Val(Min,Miu,Fehler);
     Until Fehler=0;
     IF Stu<=6 THEN Stu:=Stu+24;
     IF Miu>=30 THEN Stu:=Stu+1;
     AnzahlStd:=(Stu-6) DIV 2;
     I:=0;
     Asz:=AnzahlStd+Zeichen;
     Repeat
           IF Asz>12 THEN Asz:=Asz-12;
     Until Asz<=12;
     OUTTEXTXY(110,175,'Ihr Sternzeichen: '+Sternzeichen[SZ]);
     OUTTEXTXY(110,195,'Ihr Aszendent   : '+Sternzeichen[Asz]);
     OUTTEXTXY(110,230,'<ESC> Abbruch - <TASTE> Weiter');
END;


