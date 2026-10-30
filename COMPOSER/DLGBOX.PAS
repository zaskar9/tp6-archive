Unit DlgBox;

InterFace

Uses MyUtil, Dos, Graph, Crt;

TYPE MessageBox=Object
                  Size          : Word;
                  Speicher      : Pointer;
                  x1,y1,x2,y2   : Integer;
                  BoxOpened     : Boolean;
                  ICol, HGrCol, TlCol, MCol, LCol, SCol, CSh, TCol : Byte;
                  Constructor Init(xa, ya, xb, yb : integer;
                              HGrundCol, TitelCol, LineCol, ShadowCol, ConShad, TxtCol : Byte);
                  Procedure BoxOpen(Titel : string); Virtual;
                  Procedure BoxClose; Virtual;
                End;

     BoxButton=Object
                 x,y : Integer;
                 Txt : String;
                 BCol,ICol, HGrCol, TlCol, MCol, LCol, SCol, CSh, TCol : Byte;
                 Constructor Init(a,b:Integer;Str:String;
                             ButtonCol,HGrundCol, TitelCol, LineCol, ShadowCol, ConShad, TxtCol : Byte);
                 Procedure MakeButton; Virtual;
                 Function OnButton:Boolean; Virtual;
               End;

     OKButton=Object(BoxButton)
                End;
     DefButton=Object(BoxButton)
                 End;
     HelpButton=Object(BoxButton)
                  End;

Implementation

Constructor MessageBox.Init(xa, ya, xb, yb : Integer;
            HGrundCol, TitelCol, LineCol, ShadowCol, ConShad, TxtCol : Byte);
Begin x1:=xa;
      x2:=xb;
      y1:=ya;
      y2:=yb;
      HGrCol:=HGrundCol;
      TlCol:=TitelCol;
      LCol:=LineCol;
      SCol:=ShadowCol;
      CSh:=ConShad;
      TCol:=TxtCol;
End;

Procedure MessageBox.BoxOpen(Titel : string);
Var Intysize : LongInt;
    XPos, YPos : Integer;
Begin HideCursor;
      Size:=ImageSize(x1,y1,x2+4,y2+4);
      If Size<MaxAvail
         then Begin GetMem(Speicher, Size);
                    GetImage(x1,y1,x2+4,y2+4,Speicher^);
                    SetWriteMode(NormalPut);
                    SetFillStyle(SolidFill,blue);
                    Bar(x1,y1,x2,y1+20);
                    SetFillStyle(SolidFill,HgrCol);
                    bar(x1,y1+21,x2,y2);
                    Setcolor(lCol);
                    Rectangle(x1,y1,x2,y2);
                    Line(x1,y1+20,x2,y1+20);
                    Line(x2+1,y1+5,x2+1,y2);
                    Line(x2+2,y1+5,x2+2,y2);
                    Line(x2+3,y1+5,x2+3,y2);
                    Line(x1+5,y2+1,x2+3,y2+1);
                    Line(x1+5,y2+2,x2+3,y2+2);
                    Line(x1+5,y2+3,x2+3,y2+3);
                    BoxOpened:=true;
                    SetColor(TCol);
                    XPos:=(x1+x2) div 2;
                    YPos:=y1+11;
                    SetColor(white);
                    SetTextJustify(centerText,centertext);
                    OutTextXY(Xpos,ypos,Titel);
              end
         else BoxOpened:=false;
      ShowCursor;
end;

Procedure MessageBox.BoxClose;
Begin if BoxOpened then
         begin HideCursor;
               PutImage(x1,y1,Speicher^,NormalPut);
               Freemem(Speicher,Size);
               ShowCursor;
         end;
End;

Constructor BoxButton.Init(a,b:Integer;Str:String;
            ButtonCol,HGrundCol, TitelCol, LineCol, ShadowCol, ConShad, TxtCol : Byte);
Begin x:=a;
      y:=b;
      Txt:=Str;
      BCol:=ButtonCol;
      HGrCol:=HGrundCol;
      TlCol:=TxtCol;
      LCol:=LineCol;
      SCol:=ShadowCol;
      CSh:=ConShad;
      TCol:=TxtCol;
End;

Procedure BoxButton.MakeButton;
Begin HideCursor;
      SetFillStyle(SolidFill,BCol);
      bar(x,y,x+100,y+25);
      SetColor(lcol);
      Rectangle(x,y,x+100,y+25);
      SetColor(CSh);
      Line(x+1,y+1,x+99,y+1);
      Line(x+1,y+2,x+98,y+2);
      Line(x+1,y+1,x+1,y+24);
      Line(x+2,y+1,x+2,y+23);
      SetColor(scol);
      Line(x+2,y+24,x+99,y+24);
      Line(x+3,y+23,x+99,y+23);
      Line(x+99,y+2,x+99,y+24);
      Line(x+98,y+3,x+98,y+24);
      SetColor(tcol);
      SetTextJustify(CenterText,CenterText);
      OutTextXY(x+50,y+13,Txt);
      ShowCursor;
end;

Function BoxButton.OnButton:Boolean;
Var Button, XPo, YPo : Integer;
    FuncTerm, IO : Boolean;
Begin SetWriteMode(NormalPut);
      GetPosBut(Button,Xpo,Ypo);
      IO:=true;
      If (Xpo>x) and (Xpo<(x+100)) and
         (Ypo>y) and (Ypo<(y+25)) and
         (Button=1) then
         begin Delay(150);
               HideCursor;
               SetFillStyle(SolidFill,BCol);
               bar(x+1,y+1,x+99,y+24);
               SetColor(scol);
               Line(x+1,y+1,x+99,y+1);
               Line(x+1,y+2,x+98,y+2);
               Line(x+1,y+1,x+1,y+24);
               Line(x+2,y+1,x+2,y+23);
               SetColor(csh);
               Line(x+2,y+24,x+99,y+24);
               Line(x+3,y+23,x+99,y+23);
               Line(x+99,y+2,x+99,y+24);
               Line(x+98,y+3,x+98,y+24);
               SetColor(tcol);
               SetTextJustify(CenterText,CenterText);
               OutTextXY(x+51,y+14,Txt);
               ShowCursor;
               Repeat
                     GetPosBut(Button,xpo,ypo);
                     If (Xpo>x) and (Xpo<(x+100)) and
                        (Ypo>y) and (Ypo<(y+25))
                        then IO:=true
                        else IO:=false;
               Until (Button=0) or (IO=false);
               HideCursor;
               Delay(150);
               SetFillStyle(SolidFill,BCol);
               bar(x+1,y+1,x+99,y+24);
               SetColor(csh);
               Line(x+1,y+1,x+99,y+1);
               Line(x+1,y+2,x+98,y+2);
               Line(x+1,y+1,x+1,y+24);
               Line(x+2,y+1,x+2,y+23);
               SetColor(scol);
               Line(x+2,y+24,x+99,y+24);
               Line(x+3,y+23,x+99,y+23);
               Line(x+99,y+2,x+99,y+24);
               Line(x+98,y+3,x+98,y+24);
               SetColor(tcol);
               SetTextJustify(CenterText,CenterText);
               OutTextXY(x+50,y+13,Txt);
               ShowCursor;
               Delay(300);
               if IO then FuncTerm:=True
                     else FuncTerm:=false;
         end
         else FuncTerm:=false;
      OnButton:=FuncTerm;
End;

End.