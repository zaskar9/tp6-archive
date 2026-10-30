Procedure ProgInit;
Begin MCodeLine:=true;

      HGrundCol:=white;
      MenuCol:=white;
      TitelCol:=lightgray;
      LineCol:=Black;
      ShadowCol:=darkgray;
      ConShad:=white;
      TxtCol:=black;
      MenuFarb[1]:=black;
      MenuFarb[2]:=red;
      MenuFarb[3]:=white;
      ButtonCol:=Lightgray;

      CompMenu.Init('MAINMENU.MEN',MenuFarb,true);

      ScreenInit;

      CompMenu.Menu;
end;
