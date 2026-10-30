PROCEDURE WahlVerarbeiten;

BEGIN
     Menu;
     Repeat
           Taste:=ReadKey;
           If Taste=#0 THEN BEGIN
                                 Taste:=ReadKey;
                                 CASE Taste OF
                                    #59 : Eingabe;
                                    #60 : begin Ausgabe; Repeat until keypressed; end;
                                    #61 : Hinzufugen;
                                    #62 : Schnitt;
                                    #63 : Zeugnis(dateiname);
                                    #64 : DateiSuchen;
                                    #65 : DateiLoeschen;
                                    #66 : LoadDatei;
                                    #67 : SaveDatei;
                                    #68 : InitDevice;
                                    #27 : begin end;
                                 END;
                                 Exit;
                            END;
     Until (Taste In[#59..#66]) OR (Taste=#27);
     If Gespeichert=false
        then savedatei;
     Exit;
END;



