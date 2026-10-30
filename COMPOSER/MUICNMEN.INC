Procedure ExButton(a1,b1,a2,b2:Integer;Var Mode : Boolean);
Var a,b,code : Integer;
    Test : Boolean;
Begin Test:=False;
      Repeat GetPosBut(code,a,b);
             if ((a>a1) and (a<a2) and (b>=b1) and (b<=b2))
                then if Code=0
                        then begin Test:=true;
                                   Mode:=False
                             end
                        else Test:=False
                else if Code=1
                        then begin Test:=true;
                                   Mode:=True
                             end
                        else Test:=false;
      Until Test;
End;

Procedure IconMenu(Var Number : Integer);
Var XPos, NrCode : Integer;
    WahlVerarb, Ok : Boolean;
Begin if ((y>39) and (y<75) and (MouseClick)) and
         ((HauptMenuCode=0) and (UnterMenuCode=0)) then
         begin if (x>2) and (x<111) then
                  begin Ok:=true;
                        Case x of
                            4..38 : begin XPos:=3;  NrCode:=1; end;
                           40..74 : begin XPos:=39; NrCode:=2; end;
                          76..110 : begin XPos:=75; NrCode:=3; end;
                          else Ok:=false;
                        end;
                        if ok then
                           begin UseSw(XPos,NrCode,true);
                                 ExButton(XPos,39,XPos+36,75,Wahlverarb);
                                 If WahlVerarb then Number:=0
                                               else Number:=NrCode;
                                 UseSw(XPos,NrCode,false);
                           end;
                  end;
               If (x>127) and (x<307) then
                  begin Ok:=true;
                        Case x of
                           128..162 : begin XPos:=127; NrCode:=4; end;
                           164..198 : begin XPos:=163; NrCode:=5; end;
                           200..234 : begin XPos:=199; NrCode:=6; end;
                           236..270 : begin XPos:=235; NrCode:=7; end;
                           272..306 : begin XPos:=271; NrCode:=8; end;
                           else Ok:=false;
                        end;
                        if ok then
                           begin UseSw(XPos,NrCode,true);
                                 ExButton(XPos,39,XPos+36,75,Wahlverarb);
                                 UseSw(XPos,NrCode,false);
                                 If WahlVerarb then Number:=0
                                               else Number:=NrCode;
                           end;
                  end;
               If (x>323) and (x<395) then
                  begin Ok:=true;
                        Case x of
                           324..358 : begin XPos:=323; NrCode:=9;  end;
                           360..396 : begin XPos:=359; NrCode:=10; end;
                           else Ok:=false;
                        end;
                        if ok then
                           begin UseSw(XPos,NrCode,true);
                                 ExButton(XPos,39,XPos+36,75,Wahlverarb);
                                 UseSw(XPos,NrCode,false);
                                 If WahlVerarb then Number:=0
                                               else Number:=NrCode;
                           end;
                  end;
         end
         else Number:=0;
End;