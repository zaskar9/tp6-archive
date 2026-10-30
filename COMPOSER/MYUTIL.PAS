Unit MyUtil;

Interface

  Uses Crt, Graph, Dos;

  type RegType = Registers;
       GraphicCursor = record
	                 screenMask,
		         cursorMask: ARRAY [0..15] OF word;
		         hotX, hotY: Integer;
	               end;

        tPCXBild = Record Name     : Pointer;
                       FName    : String;
                       Groesse  : Word
                End;

  Procedure Graphik_Ein(Pfad:String);
  Procedure Graphik_Aus;

  Procedure OutIntXY(x,y,zahl,s1:Integer);
  Procedure OutRealXY(x,y:Integer; Zahl:Real; s1,s2:Integer);
  Procedure InTextXY(x,y:Integer; Txt:String; VAR s:String; Anz:Word);
  Procedure InIntXY(x,y:Integer; Txt:String; VAR Zahl:Integer);
  Procedure InRealXY(x,y:Integer; Txt:String; VAR Zahl: Real);

  Function DriverInstalled : Boolean;
  Procedure ShowCursor;
  Procedure HideCursor;
  Procedure GetPosBut(VAR ButtonStatus, horizontal, Vertical : Integer);
  Procedure SetCursorPos(Horizontal, Vertical : Integer);
  Procedure SetGraphicCursor(VAR Cursor : GraphicCursor);
  Procedure SetHorizontalLimits(MinPos, MaxPos : Integer);
  Procedure SetVerticalLimits(MinPos, MaxPos : Integer);

  Procedure PreparePCX(Var Bild:tPCXBild);
  Procedure ShowPCX(x,y:Integer;Bild:tPCXBild);
  Procedure DisposePCX(Var Bild:tPCXBild);

  Procedure VGA_Ein;
  Procedure VGA_Aus;

  Implementation

  Procedure Graphik_Ein(Pfad:String);
  Var gd, gm : Integer;
  Begin DetectGraph(gd,gm);
        InitGraph(gd, gm, Pfad);
  End;

  Procedure Graphik_Aus;
  Begin CloseGraph;
  End;

  Procedure OutIntXY(x,y,Zahl,s1: Integer);
  Var s : String;
  Begin str(zahl:s1,s);
        OutTextXY(x,y,s);
  End;

  Procedure OutRealXY(x,y:Integer; Zahl:Real; s1,s2:Integer);
  Var s : String;
  Begin str(zahl:s1:s2,s);
        OutTextXY(x,y,s);
  End;

  Procedure InTextXY(x,y:Integer; Txt:String; VAR s:String; Anz:Word);
  Const Enter=#13;
  Var ch : Char;
      farbe,txtfarbe : Word;
      xcur : integer;
      chstr : String;
  Begin s:='';
        Farbe:=GetPixel(x,y);
        txtfarbe:=GetColor;
        OutTextXY(x,y,Txt);
        MoveTo(x+TextWidth(Txt),y);
        Repeat If not Keypressed then
                  Begin xcur:=getX;
                        Repeat OutTextXY(xcur,Y,'_');
                        Until Keypressed;
                        SetColor(Farbe);
                        OutTextXY(xcur,Y,'_');
                  end;
               SetColor(txtfarbe);
               ch:=ReadKey;
               if ch=#8 then
                  begin SetColor(farbe);
                        chstr:=COPY(s,Length(s),1);
                        OutTextXY(GetX-Textwidth(chstr),GetY,chstr);
                        Delete(s,Length(s),1);
                        SetColor(txtfarbe);
                        If (GetX-Textwidth(chstr))>=(X+TextWidth(Txt))
                           then MoveTo(getX-Textwidth(chstr),getY);
                  end;
               if (ch in[' '..'þ']) and (Length(s)<Anz)
                  then begin OutText(ch);
                             s:=s+ch;
                       End;
        Until ch=Enter;
  End;

  Procedure InIntXY(x,y:Integer; Txt:String; VAR Zahl:Integer);
  Const Enter=#13;
  Var ch : Char;
      s : String;
      Code : Integer;
      farbe,txtfarbe : Word;
      xcur : integer;
      chstr : String;
  Begin s:='';
        Farbe:=GetPixel(x,y);
        txtfarbe:=GetColor;
        OutTextXY(x,y,Txt);
        MoveTo(x+TextWidth(Txt),y);
        Repeat If not Keypressed then
                  Begin xcur:=getX;
                        Repeat OutTextXY(xcur,y,'_');
                        Until Keypressed;
                        SetColor(Farbe);
                        OutTextXY(xcur,Y,'_');
                  end;
               ch:=Readkey;
               SetColor(txtfarbe);
               if ch=#8 then
                  begin SetColor(farbe);
                        chstr:=COPY(s,Length(s),1);
                        OutTextXY(GetX-Textwidth(chstr),GetY,chstr);
                        Delete(s,Length(s),1);
                        SetColor(txtfarbe);
                        If (GetX-Textwidth(chstr))>=(X+TextWidth(Txt))
                           then MoveTo(getX-Textwidth(chstr),getY);
                 end;
              if (ch in['+','-']) and (s='') or (ch in['0'..'9'])
                 then begin OutText(ch);
                            s:=s+ch;
                      End
        Until ch=Enter;
        Val(s, Zahl, Code);
  End;

  Procedure InRealXY(x,y:Integer; Txt:String; VAR Zahl: Real);
  Const Enter=#13;
  Var ch : Char;
      C : Set of Char;
      Code, PosPkt, Lang : Integer;
      s : String;
      farbe,txtfarbe : Word;
      xcur : integer;
      chstr : String;
  Begin s:='';
        Farbe:=GetPixel(x,y);
        txtfarbe:=GetColor;
        OutTextXY(x,y,Txt);
        MoveTo(x+TextWidth(Txt),y);
        C:=['.','0'..'9'];
        Repeat If not Keypressed then
               PosPkt:=Pos('.',s);
               Lang:=Length(s);
                  Begin xcur:=getX;
                        Repeat OutTextXY(xcur,y,'_');
                        Until Keypressed;
                        SetColor(Farbe);
                        OutTextXY(xcur,Y,'_');
                  end;
               ch:=ReadKey;
               SetColor(txtfarbe);
               if ch=#8 then
                  begin SetColor(farbe);
                        chstr:=COPY(s,Length(s),1);
                        OutTextXY(GetX-Textwidth(chstr),GetY,chstr);
                        Delete(s,Length(s),1);
                        SetColor(txtfarbe);
                        If (GetX-Textwidth(chstr))>=(X+TextWidth(Txt))
                           then MoveTo(getX-Textwidth(chstr),getY);
                        If PosPkt>=Lang then C:=['0'..'9','.'];
                  end;
               if (ch in['+','-']) and (s='') or (ch in C)
                  then begin OutText(ch);
                             s:=s+ch;
                             if ch='.' then C:=['0'..'9']
                       End
        Until ch=Enter;
        Val(s, Zahl, Code);
  End;

  function DriverInstalled : boolean;
  const
    iret = 207;
  var
    driverOff, driverSeg : Integer;

  begin
   driverOff := MemW[0000:0204];
   driverSeg := MemW[0000:0206];
   if ((driverSeg <> 0) and (driverOff <> 0)) then
   begin
    if (Mem [driverSeg:driverOff] <> iret) then DriverInstalled := true
    else DriverInstalled := false
   end
   else
   DriverInstalled := false
  end;

  procedure SetGraphicCursor(VAR cursor: GraphicCursor);
    (* Microsoft Mouse Driver System Call 9
	  Input : AX = 9 System Call 9
		  BX    <-- cursor hot spot (horizontal)
		  CX    <-- cursor hot spot (vertical)
		  ES:DX <-- pointer to screen and cursor
			    masks
    *)
  var
    regSet : RegType;
  begin
    regSet.AX := 9;
    regSet.DX := Ofs (cursor.screenMask);
    regSet.ES := Seg (cursor.screenMask);
    regSet.BX := cursor.hotX;
    regSet.CX := cursor.hotY;
    intr (51, regSet);
  end;

  procedure ShowCursor;
    (* Microsoft Mouse Driver System Call 1
	  Input : AX = 1 System Call 1
    *)
  var
    regSet : RegType;
  begin
   regSet.AX := 1;
   intr (51, regSet);
  end;

  procedure HideCursor;
    (* Microsoft Mouse Driver System Call 2
	  Input : AX = 2 System Call 2
    *)
  var
    regSet : RegType;
  begin
   regSet.AX := 2;
   intr (51, regSet);
  end;

  procedure GetPosBut(VAR buttonStatus, horizontal, vertical:Integer);
    (* Microsoft Mouse Driver System Call 3
	  Input : AX = 3 System Call 3

	  Output: BX --> mouse button status
		  CX --> horizontal cursor position
		  DX --> vertical cursor position
    *)
  var
    regSet : RegType;
  begin
    regSet.AX := 3;
    intr (51, regSet);
    horizontal := regSet.CX;
    vertical := regSet.DX;
    buttonStatus := regSet.BX
  end;


  procedure SetCursorPos(horizontal, vertical: Integer);
    (* Microsoft Mouse Driver System Call 4
	  Input : AX = 4 System Call 4
		  CX <-- horizontal mouse cursor position
		  DX <-- vertical mouse cursor position
    *)
  var
    regSet : RegType;
  begin
    regSet.AX := 4;
    regSet.CX := horizontal;
    regSet.DX := vertical;
    intr (51, regSet);

  end;

  procedure SetHorizontalLimits(minPos, maxPos: Integer);
    (* Microsoft Mouse Driver System Call 7
	  Input : AX = 7 System Call 7
		  CX <-- minimum horizontal position
		  DX <-- maximum horizontal position
    *)
  var
    regSet : RegType;
  begin
    regSet.AX := 7;
    regSet.CX := minPos;
    regSet.DX := maxPos;
    intr (51, regSet);
  end;

  procedure SetVerticalLimits(minPos, maxPos: Integer);
    (* Microsoft Mouse Driver System Call 8
	  Input : AX = 8 System Call 8
		  CX <-- minimum vertical position
		  DX <-- maximum vertical position
    *)
  var
    regSet : RegType;
  begin
    regSet.AX := 8;
    regSet.CX := minPos;
    regSet.DX := maxPos;
    intr (51, regSet);
  end;

  procedure PreparePCX(Var Bild:tPCXBild);
  var g : file;
      Breite, Hoehe : Integer;

  Begin assign(g,Bild.FName);
        {$I-} reset(g,1); {$I+}
        if IOResult=0
           then begin BlockRead(g,breite,2);
                      BlockRead(g,hoehe,2);
                      Bild.Groesse:=Imagesize(0,0,breite,hoehe);
                      getmem(Bild.Name,Bild.Groesse);
                      Seek(g,0);
                      blockread(g,Bild.Name^,Bild.Groesse);
                      close(g);
                end
           else begin
                end;
  end;

  Procedure ShowPCX(x,y:Integer;Bild:tPCXBild);
  Begin PutImage(x,y,Bild.Name^,NormalPut)
  End;

  Procedure DisposePCX(Var Bild:tPCXBild);
  Begin FreeMem(Bild.Name,Bild.Groesse);
  End;

  Procedure VGA_Ein;
  Var A:Byte;
  Begin A:=Port[$03DA];
        A:=Port[$03C0];
        Port[$03C0]:=$20;
  end;

  Procedure VGA_Aus;
  Var A:Byte;
  Begin A:=Port[$03DA];
        A:=Port[$03C0];
        Port[$03C0]:=$00;
  End;

End.
