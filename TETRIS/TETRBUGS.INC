Procedure Bug(Score, Linien : Integer; Elm : String);
Type BugType = Record
                 Tag, Monat, Jahr : Word;
                 Std, Min, Sek : Word;
                 Sco, Lin : Integer;
                 Elment : String;
               End;
Var BugFile : File of Bugtype;
    BugCase : Array[0..25]of BugType;
    Tg, Mnt, J, Wt : Word;
    S, M, Sk, Hs : Word;
    Zahler, I : Integer;

Begin {$I-}
      Assign(BugFile,'TETRIS.BUG');
      Reset(BugFile);
      {$I+}
      If IOResult<>0 then Rewrite(BugFile);
      Zahler:=-1;
      While (Not Eof(BugFile)) and (Zahler<25) Do
            Begin Inc(Zahler);
                  Read(BugFile,BugCase[Zahler]);
            End;
      Close(BugFile);
      GetTime(S,M,Sk,Hs);
      GetDate(Tg,Mnt,J,Wt);
      BugCase[Zahler+1].Tag:=Tg;
      BugCase[Zahler+1].Monat:=Mnt;
      BugCase[Zahler+1].Jahr:=J;
      BugCase[Zahler+1].Std:=S;
      BugCase[Zahler+1].Min:=M;
      BugCase[Zahler+1].Sek:=Sk;
      BugCase[Zahler+1].Sco:=Score;
      BugCase[Zahler+1].Lin:=Linien;
      BugCase[Zahler+1].Elment:=Elm;
      ReWrite(BugFile);
      For I:=0 to (Zahler+1) do Write(BugFile,BugCase[I]);
      Close(BugFile);
End;