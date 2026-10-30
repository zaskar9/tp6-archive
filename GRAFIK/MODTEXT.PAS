Program How_To_Modify_A_Piece_Of_String;
Uses Crt,Graph,MyUtil;

Var Name : String;

Procedure InTextModifyXY(x,y:Integer;OutStr,StartText:String;NrChar:Word;Color:Word;
                         InsMode:Boolean;VAR ResultText:String);
Var BackGround : Word;
    OutStr_Length, Index_Length : Integer;
    Text_Height : Integer;
    Taste : Char;
    Index, Alt_Index : Integer;
    Dummy, Alt_ResultText : String;
    NewText : Boolean;

Procedure PutCursor;
begin Dummy:=Copy(ResultText,0,Index);
      Index_Length:=TextWidth(Dummy);
      If InsMode then OutTextXY(x+OutStr_Length+Index_Length,y,'_')
                 else OutTextXY(x+OutStr_Length+Index_Length,y,'_');
end;

Procedure DelCursor;
Var Alt_Index_Length : Integer;
    Alt_Dummy : String;
begin Alt_Dummy:=Copy(Alt_ResultText,0,Alt_Index);
      Alt_Index_Length:=TextWidth(Alt_Dummy);
      SetColor(backGround);
      OutTextXY(x+OutStr_Length+Alt_Index_Length,y,'_');
      SetColor(Color);
end;

Begin SetTextJustify(LeftText,CenterText);
      SetColor(Color);
      BackGround:=GetPixel(x,y);
      Index:=Length(StartText);
      Text_Height:=TextHeight(OutStr);
      ResultText:=StartText;
      OutStr_Length:=TextWidth(OutStr);
      OutTextXY(x,y,OutStr);
      OutTextXY(x+OutStr_Length,y,ResultText);
      PutCursor;
      Taste:=#0;
      Repeat If Keypressed then
                begin Taste:=ReadKey;
                      Alt_Index:=Index;
                      Alt_ResultText:=ResultText;
                      If ((Taste=#0) or (Taste=#13) or (Taste=#8))
                         then begin if taste=#0 then
                                       begin Taste:=ReadKey;
                                             Case Taste of
                                               {End}      #79 : begin Index:=Length(ResultText);
                                                                      Repeat If ResultText[Index]=' ' then
                                                                             Delete(ResultText,Index,1);
                                                                             Dec(Index);
                                                                      Until ResultText[Index]<>' ';
                                                                      Inc(Index);
                                                                end;
                                               {Home}     #71 : Index:=0;
                                               {Left}     #75 : Dec(Index);
                                               {Right}    #77 : Inc(Index);
                                               {Ins}      #82 : InsMode:=not InsMode;
                                               {Del}      #83 : Delete(ResultText,Index+1,1);
                                             end;
                                             If Index>Length(ResultText) then Index:=Length(ResultText);
                                             If Index<0 then Index:=0;
                                             If (Taste in[#79,#71,#75,#76]) and (InsMode) then NewText:=False
                                                                                              else NewText:=True;
                                       end;
                                    If (Taste=#8)and(Index>0) then begin Delete(ResultText,Index,1);
                                                                         Dec(Index);
                                                                         NewText:=True;
                                                                   end
                                                              else if Taste in[#13,#71..#83] then if (Taste<>#83) and
                                                                                                         (Taste<>#82)
                                                                                                     then NewText:=False
                                                                                                     else NewText:=true
                                                                                             else NewText:=false;
                              end
                         else begin If (Taste>#31) and (Length(ResultText)<NrChar)
                                       then begin If InsMode then Insert(Taste,ResultText,Index+1)
                                                             else begin Delete(ResultText,Index+1,1);
                                                                        Insert(Taste,ResultText,Index+1);
                                                                  end;
                                                  Inc(Index);
                                                  NewText:=True;
                                            end;

                              end;
                      DelCursor;
                      If NewText then
                         begin SetFillStyle(SolidFill,BackGround);
                               SetColor(BackGround);
                               OutTextXY(x+OutStr_Length,y,Alt_ResultText);
                               Bar(x+OutStr_Length,y-Text_Height div 2,x+OutStr_Length+TextWidth(ResultText+'12345'),
                                   y+Text_Height div 2);
                               SetColor(Color);
                               OutTextXY(x+OutStr_Length,y,ResultText);
                         end;
                      PutCursor;
                end;
      Until Taste=#13;
end;

Begin Graphik_Ein('c:\tp\bgi');
      SetFillStyle(SolidFill,white);
      bar(0,0,GetMaxX,GetMaxY);
      SetColor(black);
      SetTextStyle(0,0,0);
      InTextModifyXY(100,100,'Name: ','Michael',50,black,True,Name);
      OutTextXY(100,200,Name);
      Repeat Until Keypressed;
      CloseGraph;
End.