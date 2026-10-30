Procedure Musik_Ein;
Begin SwapVectors;
      SetIntVec($8,Addr(InChain));
End;

Procedure Musik_Aus;
Begin Nosound;
      SetIntVec($8,Addr(IntSave));
End;