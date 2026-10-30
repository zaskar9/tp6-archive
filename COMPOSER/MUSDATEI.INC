Procedure Datei_Neu(Var Filename : String;Var Attributs : DatAttr);
Var Rahmen : MessageBox;
    OKBut,DefBut : BoxButton;
    N,Z,State,WhichBut,But,x,y,i,Posi,Err1,Err2 : Integer;
    Metrum,DatName,MetrOK,DatNOK : Boolean;
    NoteKey : Array[0..3] of Boolean;
    MetrStr,Dateiname,OutDatN,Zahler,Nenner : String;
    DatNStr : PathStr;
    SubStr : NameStr;
    Erw : ExtStr;
    Pfad : DirStr;
    Taste : Char;
    Len : Word;
    MusicFile : File;
    Temp : Real;
Begin Filename:='';
      Attributs.Tempo[1]:=0;
      Attributs.Tempo[2]:=0;
      Attributs.Schluessel:=0;
      If not DateiState
         then begin Rahmen.Init(140,150,500,340,HGrundCol,TitelCol,LineCol,ShadowCol,ConShad,TxtCol);
                    OkBut.Init(390,180,'OK',ButtonCol,HGrundCol,TitelCol,LineCol,ShadowCol,ConShad,TxtCol);
                    DefBut.Init(390,210,'Abbrechen',ButtonCol,HgrundCol,TitelCol,LineCol,ShadowCol,ConShad,TxtCol);
                    HideCursor;
                    Rahmen.BoxOpen('Datei Neu');
                    OKBut.MakeButton;
                    DefBut.MakeButton;
                    SetTextJustify(LeftText,CenterText);
                    SetColor(black);
                    OutTextXY(150,190,'Notenschl《sel:');
                    Rectangle(149,199,167,217);
                    Rectangle(149,219,167,237);
                    Rectangle(149,239,167,257);
                    ViolinSchluessel(149,199);   OutTextXY(175,210,'Violinschl《sel');
                    BassSchluessel(150,220);     OutTextXY(175,230,'Bassschl《sel');
                    BratschenSchluessel(150,240);OutTextXY(175,250,'Bratschenschl《sel');
                    Line(145,265,495,265);
                    OutTextXY(150,280,'Tempo:'); OutTextXY(325,280,'Dateiname:');
                    Rectangle(150,290,315,310);  Rectangle(325,290,490,310);
                    WhichBut:=0;
                    Metrum:=false;  MetrStr:=''; MetrOK:=false;
                    DatName:=false; DatNStr:=''; DatNOK:=false;
                    for i:=0 to 3 do NoteKey[i]:=false;
                    ShowCursor;
                    Repeat SetColor(white);
                           GetPosBut(But,x,y);
                           Delay(110);
                           if But=1 then
                              begin HideCursor;
                                    if x in[150..166] then
                                       Begin SetWriteMode(XOrPut);
                                             Case y of
                                                200..216 : begin if not NoteKey[1] then for i:=0 to 16 do
                                                                                            Line(150,200+i,166,200+i);
                                                                 NoteKey[1]:=true;
                                                                 If NoteKey[2] then
                                                                    begin for i:=0 to 16 do Line(150,220+i,166,220+i);
                                                                          NoteKey[2]:=false;
                                                                    end;
                                                                 If NoteKey[3] then
                                                                    begin for i:=0 to 16 do Line(150,240+i,166,240+i);
                                                                          NoteKey[3]:=false;
                                                                    end;
                                                           end;
                                                220..236 : begin if not NoteKey[2] then for i:=0 to 16 do
                                                                                            Line(150,220+i,166,220+i);
                                                                 NoteKey[2]:=true;
                                                                 if NoteKey[1] then
                                                                    begin for i:=0 to 16 do Line(150,200+i,166,200+i);
                                                                          NoteKey[1]:=false;
                                                                    end;
                                                                 If NoteKey[3] then
                                                                    begin for i:=0 to 16 do Line(150,240+i,166,240+i);
                                                                          NoteKey[3]:=false;
                                                                    end;
                                                           end;
                                                240..256 : begin if not NoteKey[3] then for i:=0 to 16 do
                                                                                            Line(150,240+i,166,240+i);
                                                                 NoteKey[3]:=true;
                                                                 if NoteKey[1] then
                                                                    begin for i:=0 to 16 do Line(150,200+i,166,200+i);
                                                                          NoteKey[1]:=false;
                                                                    end;
                                                                 If NoteKey[2] then
                                                                    begin for i:=0 to 16 do Line(150,220+i,166,220+i);
                                                                          NoteKey[2]:=false;
                                                                    end;
                                                           end;
                                             end;
                                             SetWriteMode(NormalPut);
                                       end;
                                    if (y>=290) and (y<=310) then
                                       begin SetColor(Black);
                                             SetFillStyle(SolidFill,White);
                                             SetTextJustify(LeftText,CenterText);
                                             Case x of
                                              150..315 : Begin Metrum:=true;
                                                               DatName:=false;
                                                               bar(151,291,314,309);
                                                               OutTextXY(155,300,MetrStr+'_');
                                                         end;
                                              325..490 : Begin Metrum:=false;
                                                               DatName:=true;
                                                               bar(326,291,489,309);
                                                               OutTextXY(330,300,DatNStr+'_');
                                                         end;
                                             End;
                                       End;
                                    ShowCursor;
                              end;
                           if Keypressed then
                              begin HideCursor;
                                    Taste:=ReadKey;
                                    SetColor(black);
                                    SetFillstyle(SolidFill,white);
                                    SetTextJustify(LeftText,CenterText);
                                    if ((Taste in['A'..'Z']) or (Taste in['a'..'z']) or
                                        (Taste in['0'..'9']) or (Taste in['.','/',':','\','-'])) or ((Taste=#8) or (Taste=#13))
                                        then begin If Metrum
                                                      then begin Len:=Length(MetrStr);
                                                                 if Taste=#8 then Delete(MetrStr,Len,1)
                                                                             else if (Taste<>#13) and (Len<19)
                                                                                     then MetrStr:=MetrStr+Taste;
                                                                 if Taste=#13
                                                                    then begin Metrum:=false;
                                                                               DatName:=true;
                                                                               bar(151,291,314,309);
                                                                               OutTextXY(155,300,MetrStr);
                                                                               bar(326,291,489,309);
                                                                               OutTextXY(330,300,DatNStr+'_');
                                                                         end
                                                                    else begin bar(151,291,314,309);
                                                                               OutTextXY(155,300,MetrStr+'_');
                                                                         end;
                                                           end
                                                      else if DatName
                                                              then begin Len:=Length(DatNStr);
                                                                         if Taste=#8 then Delete(DatNStr,Len,1)
                                                                                     else if (Taste<>#13) and (Len<19)
                                                                                             then DatNStr:=DatNStr+Taste;
                                                                         if Taste=#13
                                                                            then begin Metrum:=true;
                                                                                       DatName:=false;
                                                                                       bar(326,291,489,309);
                                                                                       OutTextXY(330,300,DatNStr);
                                                                                       bar(151,291,314,309);
                                                                                       OutTextXY(155,300,MetrStr+'_');
                                                                                 end
                                                                            else begin bar(326,291,489,309);
                                                                                       OutTextXY(330,300,DatNStr+'_');
                                                                                 end;
                                                                   end
                                                              else Write(^G);
                                             end
                                        else Write(^G);
                                    ShowCursor;
                              end;
                           If (NoteKey[1]) or (NoteKey[2]) or (NoteKey[3]) then NoteKey[0]:=true;
                           If (NoteKey[0])and(MetrOK)and(DatNOK) then If OkBut.OnButton then WhichBut:=1;
                           If DefBut.OnButton Then WhichBut:=2;
                           If Length(MetrStr)>0 then
                              begin Posi:=Pos('/',MetrStr);
                                    If Posi>0 then
                                       begin Zahler:=Copy(MetrStr,1,Posi-1);
                                             Nenner:=Copy(MetrStr,Posi+1,Length(MetrStr));
                                             Val(Zahler,Z,Err1); Val(Nenner,N,Err2);
                                             If (Err1=0) and (Err2=0) and (N>0) and (Z>0)
                                                then MetrOK:=true
                                                else MetrOK:=False;
                                       end;
                              end;
                           If Length(DatNStr)>0
                              then begin FSplit(DatNStr,Pfad,SubStr,Erw);
                                         If Erw<>'.CMP' then Erw:='.CMP';
                                         if Length(Substr)>0 then DatNOK:=true
                                                             else DatNOK:=false;
                                         OutDatN:=SubStr+Erw;

                                   end
                              else DatNOK:=False;
                    Until ((WhichBut=1) and (NoteKey[0]) and ((MetrOK)and(DatNOK))) or (WhichBut=2) ;
                    Rahmen.BoxClose;
                    DatNStr:=Pfad+SubStr+Erw;
                    For I:=1 to Length(OutDatN) do OutDatN[I]:=UpCase(OutDatN[I]);
                    If WhichBut=1 then
                       begin HideCursor;
                             NotenSys;
                             For I:=1 to 3 do if NoteKey[I] then Attributs.Schluessel:=I;
                             Attributs.Tempo[1]:=Z;
                             Attributs.Tempo[2]:=N;
                             Filename:=DatNstr;
                             SetFillstyle(SolidFill,blue);
                             bar(4,4,636,19); SetColor(white);
                             SetTextJustify(CenterText,CenterText);
                             OutTextXY(320,12,'Composer 1.0 - '+OutDatN);
                             SetTextJustify(LeftText,CenterText);
                             ShowCursor;
                             DateiState:=True;
                       end;
              end
         else ErrorMessage(2);
End;

Procedure Datei_Schliessen;
Var Rahmen : MessageBox;
    OKBut : BoxButton;
    State : Integer;
Begin If Dateistate
         then Begin Rahmen.Init(220,100,420,220,HGrundCol,TitelCol,LineCol,ShadowCol,ConShad,TxtCol);
                    OkBut.Init(270,150,'OK',ButtonCol,HGrundCol,TitelCol,LineCol,ShadowCol,ConShad,TxtCol);
                    Rahmen.BoxOpen('Datei Schliessen');
                    OKBut.MakeButton;
                    Repeat Until OkBut.OnButton;
                    Rahmen.BoxClose;
                    HideCursor;
                    SetFillStyle(SolidFill,white);
                    Bar(4,76,636,456);
                    SetFillstyle(SolidFill,blue);
                    Bar(4,4,636,19); SetColor(white);
                    SetTextJustify(CenterText,CenterText);
                    OutTextXY(320,12,'Composer 1.0 - unbenannt');
                    ShowCursor;
                    DateiState:=False;
              end
         else ErrorMessage(1);
End;