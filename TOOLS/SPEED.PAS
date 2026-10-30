Program Speed;
Uses Crt, Dos;

Var HSec, Sec, Min, Std : Array[1..2] of Word;
    NewStd, NewMin, NewSec, Time : Array[1..2] of LongInt;
    I, Diff : LongInt;
    k : byte;
    a,b : word;
    Txt : String;

Procedure Rahmen(x1,y1,x2,y2: Integer);
Var m,n : Integer;
Begin For m:=x1+1 to x2-1 do
          begin GotoXY(m,y1); Write('Ä');
                GotoXY(m,y2); Write('Ä');
          end;
      For n:=y1+1 to y2-1 do
          begin GotoXY(x1,n); Write('³');
                GotoXY(x2,n); Write('³');
          end;
      GotoXY(x1,y1); Write('Ú');
      GotoXY(x1,y2); Write('À');
      GotoXY(x2,y1); Write('¿');
      GotoXY(x2,y2); Write('Ù');
end;

Begin ClrScr;
      TextColor(black);
      GotoXY(1,25); Write('Û');
      TextColor(lightgray); GotoXY(3,25);
      Write('Copyright by Michael Grossniklaus, 1994');
      TextColor(white);
      GotoXY(1,2);
      Write('Geschwindikeitstest ');
      I:=0;
      GetTime(Std[1],Min[1],Sec[1],HSec[1]);
      TextColor(white);
      Rahmen(1,4,80,6);
      TextColor(yellow);
      GotoXY(2,5);
      b:=5;
      a:=2;
      Repeat
            Inc(I);
            IF I mod 2500=0 then
               begin GotoXY(a,b);
                     Write('Û');
                     a:=wherex;
               end;
            GotoXY(1,25);
      Until I>78*2500;
      GetTime(Std[2],Min[2],Sec[2],HSec[2]);
      For k:=1 to 2 do
          begin NewMin[k]:=Min[k]*60*100;
                NewSec[k]:=Sec[k]*100;
                Time[k]:=NewMin[k]+NewSec[k]+HSec[k];
          end;
      TextColor(white);
      Diff:=Time[2]-Time[1];
      GotoXY(1,8); Write('Ihr Computer ben”tigte ',Diff,' Hundertstelsekunden');
      Case Diff of
            0.. 100 : Txt:='sehr schnell - 1';
          101.. 200 : Txt:='sehr schnell - 2';
          201.. 300 : Txt:='sehr schnell - 3';
          301.. 400 : Txt:='sehr schnell - 4';
          401.. 500 : Txt:='sehr schnell - 5';
          501.. 600 : Txt:='schnell      - 1';
          601.. 700 : Txt:='schnell      - 2';
          701.. 800 : Txt:='schnell      - 3';
          801.. 900 : Txt:='schnell      - 4';
          901..1000 : Txt:='schnell      - 5';
         1001..1100 : Txt:='normal       - 1';
         1101..1200 : Txt:='normal       - 2';
         1201..1300 : Txt:='normal       - 3';
         1301..1400 : Txt:='normal       - 4';
         1401..1500 : Txt:='normal       - 5';
         1501..1600 : Txt:='eher langsam - 1';
         1601..1700 : Txt:='eher langsam - 2';
         1701..1800 : Txt:='eher langsam - 3';
         1801..1900 : Txt:='eher langsam - 4';
         1901..2000 : Txt:='eher langsam - 5';
         2001..2100 : Txt:='langsam      - 1';
         2101..2200 : Txt:='langsam      - 2';
         2201..2300 : Txt:='langsam      - 3';
         2301..2400 : Txt:='langsam      - 4';
         2401..2500 : Txt:='langsam      - 5';
         2501..2600 : Txt:='sehr langsam - 1';
         2601..2700 : Txt:='sehr langsam - 2';
         2701..2800 : Txt:='sehr langsam - 3';
         2801..2900 : Txt:='sehr langsam - 4';
         2901..3000 : Txt:='sehr langsam - 5';
      End;
      GotoXY(1,10); Write('Kathegorie: ',Txt);
      GotoXY(1,12); Write('Erkl„rung:  Klasse       - Abstufung');
      GotoXY(1,14); Write('Klasse: - sehr schnell     Abstufung: - 1');
      GotoXY(1,15); Write('        - schnell                     - 2');
      GotoXY(1,16); Write('        - normal                      - 3');
      GotoXY(1,17); Write('        - eher langsam                - 4');
      GotoXY(1,18); Write('        - langsam                     - 5');
      GotoXY(1,19); Write('        - sehr langsam');
      TextColor(lightgray);
      GotoXY(1,25);
      Repeat Until Keypressed;
      ClrScr;
End.