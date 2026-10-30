Program Alt_test;
Uses Crt;

Var Taste : Char;

Begin Repeat
            If Keypressed then
               begin Taste:=ReadKey;
                     If Taste=#0 then Taste:=ReadKey;
                     GotoXY(10,10);
                     Write('                    ');
                     GotoXY(10,10);
                     Write(Taste,'   #',Ord(Taste));
                     Write(^G);
               end;
      Until Taste=#27;
End.
