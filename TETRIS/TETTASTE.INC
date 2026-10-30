Procedure Tastenabfrage;
Begin If Keypressed then begin
      Taste:=Readkey;
      If Upcase(taste)='S' then If Musik then Begin Musik_Aus;
                                                    Musik:=false;
                                               end
                                          Else Begin Musik_Ein;
                                                     Musik:=True;
                                               end;
      if (XChangeLeft) and (taste=#75)  then
         begin Xelm:=xelm-1;
         end;
      If (XChangeRight) and (taste=#77) then
         begin Xelm:=xelm+1;
         end;
      end;
end;