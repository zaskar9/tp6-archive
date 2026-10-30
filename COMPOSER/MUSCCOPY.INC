Procedure Copyright;             {MUSCCOPY.INC}

Var Button, X, Y : Integer;
    Size : Word;
    Speicher : Pointer;
    Bild : TPCXBild;

Begin Bild.FName:='COMPTTL.TPP';
      PreparePCX(Bild);
      SetWriteMode(NormalPut);
      Size:=ImageSize(199,149,441,300);
      GetMem(Speicher,Size);
      HideCursor;
      GetImage(199,149,441,300,Speicher^);
      ShowPCX(200,150,Bild);
      DisposePCX(Bild);
      {SetFillStyle(SolidFill,TitelCol);
      Bar(200,150,440,280);}
      SetColor(black);
      Rectangle(199,149,439,300);
      {SetColor(ConShad);
      Line(201,151,201,279);
      Line(202,151,202,278);
      Line(203,151,439,151);
      Line(203,152,438,152);
      SetColor(ShadowCol);
      Line(439,151,439,279);
      Line(438,152,438,279);
      Line(201,279,437,279);
      Line(202,278,437,278);
      SetColor(TxtCol);
      SetTextJustify(CenterText,CenterText);
      SetTextStyle(1,0,0);
      OutTextXY(320,170,'COMPOSER 1.0');
      SetTextStyle(0,0,0);
      OutTextXY(320,210,'Copyright');
      OutTextXY(320,225,'by');
      OutTextXY(320,240,'Michael Grossniklaus');
      OutTextXY(320,255,'1994');}
      Delay(100);
      Repeat ShowCursor;
      Until (MouseClick) or (Keypressed);
      SetFillstyle(SolidFill,HGrundCol);
      HideCursor;
      PutImage(199,149,Speicher^,NormalPut);
      ShowCursor;
      SetWriteMode(XOrPut);
      FreeMem(Speicher, Size);
      OutMessage('Composer 1.0');
End;

