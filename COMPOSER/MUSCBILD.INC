Procedure Bildaufbau;
begin Rectangle(3,3,637,477);
      Line(3,20,637,20);
      Line(3,38,637,38);
      SetFillstyle(SolidFill,Titelcol);
      bar(4,4,636,19);
      bar(4,457,636,476);
      {SetFillStyle(Solidfill,Menucol);
      bar(4,21,636,37);}
      Line(3,457,637,457);
      SetColor(Shadowcol);
      {Line(5,5,635,5);
      Line(5,5,5,18);}
      Line(5,459,430,459);
      Line(433,459,635,459);
      Line(5,459,5,475);
      Line(433,459,433,475);
      SetColor(Conshad);
      {Line(5,18,635,18);
      Line(635,18,635,5);}
      Line(5,475,430,475);
      Line(433,475,635,475);
      Line(430,475,430,459);
      Line(635,475,635,459);
      SetColor(TxtCol);
      SetTextJustify(CenterText,CenterText);
      OutTextXY(320,12,'Composer 1.0');
      SetTextJustify(LeftText,CenterText);
      OutTextXY(440,467,'by Michael Grossniklaus');
      OutMessage('Welcome to Composer 1.0');
End;