{$F+}
Procedure InChain; Interrupt;
Begin if MI<fl then
         begin if Tl<=0 then
               begin Sound(F[MI]);
                     Inc(MI);
                     Tl:=F[MI];
                     Inc(MI);
               end
          Else Dec(Tl,224);
         end Else MI:=0;
         InLine($9C);
         IntSave;
End;
{$F-}