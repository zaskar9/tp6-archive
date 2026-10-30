Program Inter;
Uses Crt, Dos, MyUtil, Graph;

Var OldVec : Pointer;
    I : Integer;

{$F+}
Procedure NewVec; Interrupt;
Begin Inc(I);
End;
{$F-}

Begin GetIntVec($1C,OldVec);
      SetIntVec($1C,@NewVec);
      Repeat Until Keypressed;
      SetIntVec($1C,OldVec);
End.