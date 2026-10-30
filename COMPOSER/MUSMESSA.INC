Procedure OutMessage(Text : String);
Begin if not MCodeLine then Text:='Composer 1.0';
      if (Text=' ') or (Text='') then Text:='Composer 1.0';
      HideCursor;
      SetFillstyle(SolidFill,TitelCol);
      Bar(6,460,429,474);
      SetTextJustify(LeftText,CenterText);
      SetTextStyle(0,0,0);
      SetColor(TxtCol);
      OutTextXY(10,468,Text);
      ShowCursor;
      SetColor(White);
End;


