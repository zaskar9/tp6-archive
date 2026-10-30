Procedure Examination;
Var ExamFrame         : Rahmen;

Begin ExamFrame.Init(20,7,59,15,red,true);
      ExamFrame.Draw(red);
      TextColor(White);
      GotoXY(23,8); Write('Thank you for using MGCC Products');
      TextColor(yellow);
      GotoXY(23,10);Write('MGCC Doctor is now examining your');
      GotoXY(23,11);Write('system...');
      Delay(2500);
      Version:=DosVersion;
      GetDate(Jh,Mt,Tg,Wtg);
      GetTime(Std,Min,Sek,S100);
      DFree:=DiskFree(3);
      DSize:=DiskSize(3);
      FlagReset(Status, Buttons);
      If Status=0 Then Maus:='negativ'
                  else Maus:='positiv';
      If (Port[$200]=0) or (Port[$210]=0) or (Port[$220]=0) or
         (Port[$230]=0) or (Port[$240]=0) or (Port[$250]=0)
         then SBlaster:='positiv'
         else SBlaster:='negativ';
      GotoXY(23,13); Write('Please hit a key to continue...');
      Taste:=ReadKey;
End;