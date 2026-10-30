Procedure Notensys;
Var Abstand, Faktor, Sys : Integer;
Begin setcolor(linecol);
      abstand:=100;
      SetWriteMode(NormalPut);
      Sys:=1;
      Repeat
            Faktor:=0;
            Repeat
                  Line(10,Abstand+Faktor,630,abstand+Faktor);
                  Inc(Faktor,7);
            Until Faktor>28;
            {If Sys<2 then Line(12,Abstand,12,Abstand+28);}
            If Sys>6 then Line(628,Abstand,628,Abstand+28);
            {Line(10,Abstand,10,Abstand+28);}
            Line(630,Abstand,630,Abstand+28);
            inc(abstand,50);
            inc(sys);
      until abstand>400;
end;