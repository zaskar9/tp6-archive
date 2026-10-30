program taste;
uses crt;
var t:char;
begin clrscr;
      gotoxy(1,1);Write('Tastecodes:');
      repeat t:=ReadKey;
             gotoxy(5,10);ClrEol;write('Taste -> ',ord(t));
      until t=#27
end.
