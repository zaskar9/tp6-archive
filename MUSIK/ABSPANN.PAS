program abspann;
uses crt;

const Zeit=425;

Var I, a, max           : integer;
    str                 : array[1..100] of string;
    datei               : text;

begin
     clrscr;
     I:=0;
     Assign(datei,'A:\ABSPANN.DAT');
     Reset(Datei);
     While not Eof(Datei) Do
           Begin
                Inc(i);
                Readln(datei,Str[I]);
           End;
     max:=I;
     I:=1;
     repeat
           gotoxy(1,1);
           delline;
           a:=Length(str[I]);
           GotoXY(40-(a div 2), 24);
           Write(Str[I]);
           GotOXY(1,25);
           Delay(Zeit);
           inc(I);
     until I>max;
     For I:=1 TO 25 DO
         BEGIN
              GotoXY(1,1);
              DelLine;
              Delay(Zeit);
              GotoXY(1,25);
         End;
End.