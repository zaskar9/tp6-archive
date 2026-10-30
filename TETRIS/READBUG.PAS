Program ReadBug;
Uses Dos,Crt;
Type BugType = Record
                 Tag, Monat, Jahr : Word;
                 Std, Min, Sek : Word;
                 Sco, Lin : Integer;
                 Elment : String;
               End;
Var BugFile : File of Bugtype;
    BugCase : BugType;
    I : Integer;

Begin Assign(BugFile,'TETRIS.BUG');
      {$I-}
      Reset(BugFile);
      {$I+}
      ClrScr;
      IF IOResult<> 0 then
         begin GotoXY(10,10);
               Write('File nicht vorhanden !');
               GotoXY(1,25);
               Repeat Until Keypressed;
               ClrScr;
               Halt;
         End;
      GotoXY(1,1);
      Writeln('Date          Time           Lines      Points          Element');
      Write('-------------------------------------------------------------------------------');
      GotoXY(1,3);
      I:=1;
      Repeat
            Read(BugFile,BugCase);
            Writeln(BugCase.jahr,'.',BugCase.Monat,'.',BugCase.tag,'     ',
                    BugCase.Std,',',BugCase.Min,'          ',BugCase.Lin:5,'       ',
                    BugCase.Sco:5,'          ',BugCase.Elment);
            Inc(I);
      Until (Eof(BugFile)) or (I>22);
      GotoXY(1,25);
      TextColor(Black);
      Write('Û');
      TextColor(white);
      Write(' Copyright 1993 by Michael Grossniklaus, Basel');
      Textcolor(Lightgray);
      GotoXY(1,25);
      Repeat Until KeyPressed;
End.
