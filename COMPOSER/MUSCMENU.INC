Procedure OutMenuTextXY(X,Y : Integer; Txt : String);
Var PosItem, Laenge, x1, x2, x3 : Integer;
    Teil1,Letter,Teil2 : String;
Begin PosItem:=Pos('~',Txt);
      Laenge:=Length(Txt);
      Teil1:=Copy(Txt,1,PosItem-2);
      Teil2:=Copy(Txt,PosItem+1,Laenge);
      Letter:=Copy(Txt,PosItem-1,1);
      x1:=x;
      x2:=x+TextWidth(Teil1);
      x3:=x+TextWidth(teil1)+TextWidth(Letter);
      SetColor(TxtCol); OutTextXY(x1,y,Teil1);
      SetColor(ItemCol);   OutTextXY(x2,Y,Letter);
      SetColor(TxtCol); OutTextXY(x3,y,Teil2);
End;

Function ItemChar(Txt : string) : String;
Var PosItem, I : Integer;
    ItemStr : String;
Begin PosItem:=Pos('~',Txt);
      ItemStr:=Copy(Txt,PosItem-1,1);
      For I := 1 to Length(ItemStr)
       do ItemStr[I]:=UpCase(ItemStr[I]);
      ItemChar:=ItemStr;
End;

Procedure Menu(VAR MainPoints : Integer; VAR SubPoints : SubAnzahl; VAR SubMenuStr : SubMenuType;
          VAR AktivBereich : MenuBereichtype; VAR HauptCode : str10; VAR UnterCode : SubMenuCode);
Var TxtStr  : String;
    I, XIndex, PktZahl, MenuZahl, EndPos, Position, SeperatorPos : Integer;

Begin XIndex:=10;
      MenuZahl:=0;
      HauptCode:='';
      For I:=1 to 10 do UnterCode[I]:='';
      Repeat
            Readln(MenuDat,TxtStr);
            Position:=POS('MAINMENU',TxtStr);
            EndPos:=Pos('ENDMAIN',TxtStr);
            If (Position<>0) or (EndPos<>0) then Readln(MenuDat, TxtStr);
            OutMenuTextXY(XIndex,29,TxtStr);
            HauptCode:=HauptCode+ItemChar(TxtStr);
            Inc(MenuZahl);
            Aktivbereich[MenuZahl,0]:=XIndex-5;
            XIndex:=XIndex+TextWidth(TxtStr)+20;
            Aktivbereich[MenuZahl,1]:=XIndex-15;
            Readln(MenuDat, TxtStr);
            Position:=Pos('SUBMENU',TxtStr);
            PktZahl:=0;
            If Position<>0 then
               begin Repeat
                           Readln(MenuDat,TxtStr);
                           Position:=Pos('ENDSUB',TxtStr);
                           SeperatorPos:=pos('SEPERATOR',TxtStr);
                           if SeperatorPos<>0 then TxtStr:='----';
                           If Position=0 then
                              begin Inc(PktZahl);
                                    SubMenuStr[MenuZahl,PktZahl]:=TxtStr;
                                    If ItemChar(TxtStr)='-' then TxtStr:=' ~';
                                    UnterCode[MenuZahl]:=UnterCode[MenuZahl]+ItemChar(TxtStr);
                              end;
                           SubPoints[MenuZahl]:=PktZahl;
                     until Position<>0;
               end;
      until EndPos<>0;
      MainPoints:=MenuZahl-1;
End;

Procedure Menuaktivieren(MainPoints : Integer; SubPoints : SubAnzahl; SubMenuStr : SubMenuType;
                        AktivBereich : MenuBereichtype; var mainmenuindex, submenuindex : integer;
                        HauptMenu : str10; UnterMenu : SubMenuCode);
Var Button, X, Y : Integer;
    I, J, K, TastI : Integer;
    MenuAktiv : Array[0..10] of Boolean;
    Vorher : Pointer;
    Size : Word;
    Ort : Integer;
    Posi, seppos, z, l, Xindexalt, yindexalt, altmenu : integer;
    menuinuse, menuclick, MenuPass, Bedienung : boolean;
    Wahl, Choice : Char;
    Verschieb : char;

Function MenuAktivTest : Boolean;
Var Z, Test : Integer;
Begin Z:=1;
      Test:=0;
      Repeat
            If MenuAktiv[Z] then Inc(Test);
            Inc(Z);
      Until Z>Mainpoints;
      If Test>0 then MenuAktivtest:=True
             else MenuAktivTest:=False;
End;

Function AltTaste(T : Char) : Char;
begin
     Case Ord(T) of
     30 : AltTaste:='A';
     48 : AltTaste:='B';
     46 : AltTaste:='C';
     32 : AltTaste:='D';
     18 : AltTaste:='E';
     33 : AltTaste:='F';
     34 : AltTaste:='G';
     35 : AltTaste:='H';
     23 : AltTaste:='I';
     36 : AltTaste:='J';
     37 : AltTaste:='K';
     38 : AltTaste:='L';
     50 : AltTaste:='M';
     49 : AltTaste:='N';
     24 : AltTaste:='O';
     25 : AltTaste:='P';
     16 : AltTaste:='Q';
     19 : AltTaste:='R';
     31 : AltTaste:='S';
     20 : AltTaste:='T';
     22 : AltTaste:='U';
     47 : AltTaste:='V';
     17 : AltTaste:='W';
     45 : AltTaste:='X';
     21 : AltTaste:='Y';
     44 : AltTaste:='Z';
     End;
End;


Procedure SubMenuDeaktivieren(MenuCode : Integer; SubPoints : SubAnzahl; SubmenuStr: SubMenuType;
                              AktivBereich : MenuBereichType);
Var I, Item, YCode, Laenge, Laengster, LeerPos, yindex, xindex : Integer;
begin Laengster:=0;
      YIndex:=SubPoints[MenuCode]*20+38;
      I:=1;
      Repeat
            repeat
                  LeerPos:=Pos(' ',SubMenuStr[MenuCode,I]);
                  If LeerPos<=1 then Delete(SubMenuStr[MenuCode,I],LeerPos,1);
            until (LeerPos>1) or (leerpos=0);
            Inc(i);
      Until (I>SubPoints[MenuCode]) or (I>9);
      I:=1;
      Repeat
            Laenge:=TextWidth(SubMenuStr[MenuCode,I]);
            If Laenge>Laengster then Laengster:=Laenge;
            Inc(I);
      Until (I>SubPoints[MenuCode]) or (I>9);
      XIndex:=AktivBereich[MenuCode,0]+Laengster+20;
      HideCursor;
      setcolor(white);
      Line(AktivBereich[MenuCode,0],38+1,Aktivbereich[MenuCode,0],Yindex-1);
      Line(AktivBereich[Menucode,0],Yindex,XIndex,YIndex);
      Line(Xindex,38+1,Xindex,Yindex-1);
      PutImage(ort-1,38,Vorher^,NormalPut);
      Freemem(Vorher, Size);
      ShowCursor;
      setcolor(white);
end;

Procedure Statusausgabe(MenuCode, MenuNr : Integer);
Begin Case MenuCode Of
        1 : Case MenuNr of
              1 : OutMessage('Neue Datei');
              2 : OutMessage('Datei speichern');
              3 : OutMessage('Datei unter Namen speichern');
              5 : OutMessage('Programm beenden');
            End;
        2 : Case MenuNr of
              1 : OutMessage('Farben des Programms einstellen');
              2 : OutMessage('Statuszeile deaktivieren/aktivieren');
            End;
        3 : Case MenuNr of
              1 : OutMessage('NotenlÑnge festlegen');
            End;
        4 : Case MenuNr of
              1 : OutMessage('PausenlÑnge festlegen');
            End;
        5 : Case MenuNr of
              1 : OutMessage('WÑhlt eine Dur-Tonart');
              2 : OutMessage('WÑhlt eine Moll-Tonart');
            End;
        6 : Case MenuNr of
              1 : OutMessage('StÅck zu spielen beginnen');
              2 : OutMessage('StÅck unterbrechen');
              3 : OutMessage('StÅck anhalten');
            End;
        7 : Case MenuNr of
              1 : OutMessage('Kontextbezogene Hilfe');
              2 : OutMessage('Hilfe Index');
              4 : OutMessage('öber Composer 1.0');
            End;
      End;
End;

Procedure SubMenuAuswahl(seppos, xmark, ymark, MenuCode : integer; subpoints : subanzahl;
                         Aktivbereich : MenuBereichtype;
                         VAR mainmenuindex, submenuindex : integer);
Var Posi1,posi2,x,y,Button,ystart,altstart,k,menunr,MenuTest,AltMenu : Integer;
    submenuaktiv : array[0..10] of boolean;
    YPosition : array[0..10] of byte;
    sep : string;
    Balken, Stop, TastWahl, Invers, Release, Key : Boolean;
    Wahl1, Wahl2 : Char;
    SaveX, SaveY : Integer;
    MenuZiffer : String;

Begin If MouseClick then Invers:=true
                    else Invers:=false;
      Setcolor(MenuMark);
      SetWriteMode(xorPut);
      showcursor;
      Stop:=False;
      Balken:=True;
      TastWahl:=False;
      Key:=false;
      stop:=false;
      menunr:=1;
      YStart:=0;
      For k:=0 to 10 do YPosition[k]:=k*20-2;
      For k:=0 to 10 do submenuaktiv[k]:=false;
{---------------------------------------------------------------------------}
      Repeat If (Balken) and (SubMenuAktiv[MenuNr]=false) and (MenuNr<>SepPos-1) then
                begin HideCursor;
                      For k:=(ystart+2) to (ystart+18) do Line(aktivbereich[menucode,0]+2,k+38,xmark-2,k+38);
                      ShowCursor;
                      SubMenuAktiv[MenuNr]:=True;
                      Statusausgabe(MenuCode,MenuNr);
                      AltMenu:=MenuNr;
                      Altstart:=Ystart;
                end;
{---------------------------------------------------------------------------}
             If Not Keypressed then
                begin GetPosBut(Button,x,y);
                      ystart:=((y-38) div 20)*20;
                      menunr:=(ystart div 20)+1;
                      If ((x<xmark) and (x>aktivbereich[menucode,0]) and
                         (y>38) and (y<ymark))
                         then begin if Submenuaktiv[menunr]=false then
                                       begin if (submenuaktiv[AltMenu]) and (AltMenu<>MenuNr) then
                                                begin HideCursor;
                                                      setcolor(MenuMark);
                                                      For k:=0 to 16 do
                                                      Line(aktivbereich[menucode,0]+2,Yposition[AltMenu]-k+38,
                                                           xmark-2,yposition[AltMenu]-k+38);
                                                      Submenuaktiv[AltMenu]:=false;
                                                      ShowCursor;
                                                 end;
                                       end;
                              end
                         else begin menunr:=AltMenu;
                                    yStart:=AltStart;
                              end;
                end;
{---------------------------------------------------------------------------}
             If keypressed
                then begin Key:=true;
                           if Key then begin Wahl:=ReadKey;
                                             Wahl2:=UpCase(Wahl);
                                       end;
                           Posi1:=0; Posi2:=0;
                           if (wahl=#0) and (key)
                              then begin Wahl1:=readkey;
                                         Choice:=AltTaste(Wahl);
                                         posi1:=Pos(Choice,UnterMenu[MenuCode]);
                                         menuzahl:=posi1;
                                         if Wahl1=#75
                                            then begin Verschieb:='l';
                                                       stop:=true;
                                                 end
                                            else if Wahl1=#77
                                                    then begin Verschieb:='r';
                                                               stop:=true;
                                                         end
                                                    else begin verschieb:='m';
                                                               balken:=false;
                                                         end;
                                         if Wahl1=#80 {Down}
                                            then begin SubMenuAktiv[MenuNr]:=False;
                                                       HideCursor;
                                                       SetColor(MenuMark);
                                                       For k:=0 to 16 do
                                                       Line(aktivbereich[menucode,0]+2,Yposition[MenuNr]-k+38,
                                                            xmark-2,yposition[MenuNr]-k+38);
                                                       ShowCursor;
                                                       If SubMenuAktiv[MenuNr+1]=False then MenuNr:=MenuNr+1;
                                                       If MenuNr>SubPoints[MenuCode] then MenuNr:=1;
                                                       If MenuNr=SepPos-1 then Inc(MenuNr);
                                                       ystart:=menunr*20-20;
                                                       Balken:=true;
                                                 end
                                            else if Wahl1=#72 {Up}
                                                    then Begin SubMenuAktiv[MenuNr]:=False;
                                                               HideCursor;
                                                               SetColor(MenuMark);
                                                               For k:=0 to 16 do
                                                               Line(aktivbereich[menucode,0]+2,Yposition[MenuNr]-k+38,
                                                                    xmark-2,yposition[MenuNr]-k+38);
                                                               ShowCursor;
                                                               if SubMenuAktiv[MenuNr-1]=false then MenuNr:=MenuNr-1;
                                                               If MenuNr<1 then MenuNr:=SubPoints[MenuCode];
                                                               If MenuNr=SepPos-1 then Dec(MenuNr);
                                                               ystart:=menunr*20-20;
                                                               Balken:=true;
                                                         end
                                                    else Begin MenuNr:=AltMenu;
                                                               YStart:=AltStart;
                                                               Balken:=False;
                                                         end;

                                   end
                              else begin if (wahl2=#27) then Stop:=true;
                                         if (Wahl2=#13) then TastWahl:=True;
                                         posi2:=Pos(Wahl2,UnterMenu[MenuCode]);
                                         if wahl<>#13 then menunr:=Posi2;
                                         verschieb:='m';
                                         Balken:=false;
                                   end;
                           if (Posi1>0) or (Posi2>0) then
                              begin TastWahl:=True;
                                    verschieb:='m';
                              end;
                     end;
                     MenuNummer:=MenuNr;
{---------------------------------------------------------------------------}
             GetPosBut(Button, x, y);
             if ((Button=1) and (not Invers)) or ((Button=0) and (Invers))
                then Release:=True
                else Release:=false;
      Until (
            ((Button=1) and ((y>38) and (y<ymark) and (x>aktivbereich[menucode,0]) and (x<xmark))) or
            ((Button=1) and ((y>ymark) or (x<aktivbereich[menucode,0]) or (x>xmark))) or
            ((Button=1) and ((y<38) and ((x>aktivbereich[menucode+1,0]) or (x<aktivbereich[menucode,0]))))
            )
            or ((Stop) or (Tastwahl));
      If ((Button=1) and ((y>38) and (y<ymark) and (x>aktivbereich[menucode,0]) and (x<xmark)))
         or (TastWahl)
         then begin mainmenuindex:=menucode;
                    submenuindex:=menunr;
              end
         else begin mainmenuindex:=0;
                    submenuindex:=0;
              end;
      if Stop then
         begin mainmenuindex:=0;
               submenuindex:=0;
         end;
end;

Procedure SubMenuAktivieren(MenuCode : Integer; SubPoints : Subanzahl; SubMenusStr : SubMenuType;
          AktivBereich : MenuBereichType; var mainmenuindex,submenuindex : integer);
Var I, Item, YCode, posstr, Laenge, Laengster, LeerPos, yindex, xindex : Integer;
    SepControl : Boolean;
begin Laengster:=0;
      SepControl:=False;
      YIndex:=SubPoints[MenuCode]*20+38;
      I:=1;
      Repeat
            repeat
                  LeerPos:=Pos(' ',SubMenuStr[MenuCode,I]);
                  If LeerPos<=1 then Delete(SubMenuStr[MenuCode,I],LeerPos,1);
            until (LeerPos>1) or (leerpos=0);
            Inc(i);
      Until (I>SubPoints[MenuCode]) or (I>9);
      I:=1;
      Repeat
            Laenge:=TextWidth(SubMenuStr[MenuCode,I]);
            If Laenge>Laengster then Laengster:=Laenge;
            Inc(I);
      Until (I>SubPoints[MenuCode]) or (I>9);
      XIndex:=AktivBereich[MenuCode,0]+Laengster+20;
      HideCursor;
      Size:=ImageSize(AktivBereich[menucode,0],38,xindex,yindex);
      setwritemode(normalput);
      setcolor(black);
      GetMem(Vorher, Size);
      GetImage(AktivBereich[MenuCode,0],38,Xindex,yIndex, Vorher^);
      Line(AktivBereich[MenuCode,0],38+1,Aktivbereich[MenuCode,0],Yindex-1);
      Line(AktivBereich[Menucode,0],Yindex,XIndex,YIndex);
      Line(Xindex,38+1,Xindex,Yindex-1);
      setwritemode(XorPut);
      setfillstyle(solidfill,white);
      bar(Aktivbereich[menucode,0]+1,38+1,Xindex-1,yindex-1);
      SetTextStyle(0,0,0);
      SetTextJustify(LeftText,BottomText);
      Item:=1;
      Repeat
            YCode:=Item*20+35;
            Posstr:=Pos('--',SubMenustr[MenuCode,Item]);
            if Posstr<> 0 then begin SetWriteMode(NormalPut);setcolor(Linecol);
                                     Line(Aktivbereich[MenuCode,0]+1,ycode-5,Xindex-1,ycode-5);
                                     SetWriteMode(XorPut);
                                     setcolor(LineCol);
                                     SepPos:=((ycode-5) div 20);
                                     SepControl:=true;
                               end
                          else begin OutMenuTextXY(AktivBereich[MenuCode,0]+5,YCode,SubMenuStr[MenuCode,Item]);
                                     If Sepcontrol=false then SepPos:=0;
                               end;
            Inc(item);
      Until (item>9) or (item>subpoints[menucode]);
      Ort:=Aktivbereich[MenuCode,0]+1;
      Showcursor;
      SetColor(white);
      SubMenuAuswahl(seppos,xindex,yindex,menucode,subpoints,aktivbereich,mainmenuindex,submenuindex);
      yindexalt:=yindex;
End;

Begin SetWriteMode(XORPut);
      verschieb:='m';
      mainmenuindex:=0;
      SetColor(white);
      for j:=0 to 10 do MenuAktiv[j]:=false;
      Repeat
            if (not Keypressed)
               then begin GetPosBut(Button,X,Y);
                          menuclick:=mouseclick;
                    end
               else MenuClick:=False;
            I:=1;
            If (Y>20) and (Y<38) and (MenuClick) and (Not Keypressed)
               then begin Repeat
                           If ((x>AktivBereich[I,0]) and
                              (x<AktivBereich[I,1]) and (menuaktiv[I]=false)) then
                              begin
                                   Menuaktiv[i]:=true;
                                   Case I of
                                        1 : OutMessage('Programmablauf');
                                        2 : OutMessage('Legt Programmeinstellungen fest');
                                        3 : OutMessage('NotenlÑngen');
                                        4 : OutMessage('PausenlÑngen');
                                        5 : OutMessage('Spielt das StÅck');
                                        6 : OutMessage('Online Hilfe');
                                   End;
                                   k:=0;
                                   repeat
                                         if (menuaktiv[k]) and (menuaktiv[i]) and (k<>i) then
                                         begin hidecursor;
                                               SubMenuDeaktivieren(k,SubPoints,Submenustr,AktivBereich);
                                               menuclick:=false;
                                               For j:=21 to 37 do Line(aktivBereich[k,0],J,AktivBereich[k,1],J);
                                               showcursor;
                                               menuaktiv[k]:=false;
                                         end;
                                         inc(k);
                                   until k>9;
                                   SetColor(white);
                                   HideCursor;
                                   For j:=21 to 37 do Line(aktivBereich[I,0],J,AktivBereich[I,1],J);
                                   Bedienung:=False;
                                   SubMenuAktivieren(I,SubPoints,SubMenuStr,AktivBereich,mainmenuindex,submenuindex);
                                   altmenu:=I;
                                   ShowCursor;
                              end;
                              Inc(I);
                          Until I>mainpoints;
                    end
               else begin if (Keypressed) or ((Verschieb='l') or (Verschieb='r')) then
                              begin if (verschieb='m') then Wahl:=ReadKey;
                                    if Wahl=#0 then
                                       begin if (verschieb='m') then Wahl:=ReadKey;
                                             Choice:=AltTaste(Wahl);
                                             Posi:=Pos(Choice,HauptMenu);
                                             If menuaktivtest then
                                                begin if verschieb='l' then Posi:=AltMenu-1;
                                                      if verschieb='r' then Posi:=AltMenu+1;
                                                      if posi<1 then Posi:=mainpoints;
                                                      if posi>mainpoints then Posi:=1;
                                                end;
                                             if (Posi>0) and (MenuAktiv[Posi]=false){ ) and (not(((verschieb='l')
                                                or (verschieb='r')) and (menuaktivtest=false)))} then
                                                begin
                                                     Menuaktiv[Posi]:=true;
                                                     Case Posi of
                                                          1 : OutMessage('Programmablauf');
                                                          2 : OutMessage('Legt Programmeinstellungen fest');
                                                          3 : OutMessage('NotenlÑngen');
                                                          4 : OutMessage('PausenlÑngen');
                                                          5 : OutMessage('Spielt das StÅck');
                                                          6 : OutMessage('Online Hilfe');
                                                     End;
                                                     k:=0;
                                                     repeat
                                                           if (menuaktiv[k]) and (menuaktiv[Posi]) and (k<>Posi) then
                                                           begin hidecursor;
                                                                 SubMenuDeaktivieren(k,SubPoints,Submenustr,AktivBereich);
                                                                 menuclick:=false;
                                                                 For j:=21 to 37 do Line(aktivBereich[k,0],J,
                                                                                         AktivBereich[k,1],J);
                                                                 showcursor;
                                                                 menuaktiv[k]:=false;
                                                           end;
                                                           inc(k);
                                                     until k>9;
                                                     SetColor(white);
                                                     HideCursor;
                                                     For j:=21 to 37 do Line(aktivBereich[Posi,0],J,AktivBereich[PosI,1],J);
                                                     Bedienung:=True;
                                                     SubMenuAktivieren(PosI,SubPoints,SubMenuStr,AktivBereich,mainmenuindex,
                                                                       submenuindex);
                                                     altmenu:=PosI;
                                                     ShowCursor;
                                                end;
                                       end;
                              end;
                    end;
               z:=0;
               l:=1;
               Repeat
                     if menuaktiv[l] then
                     begin inc(z);
                           altmenu:=l;
                     end;
                     inc(l);
               Until l>9;
               if (z>0) and (z<2) and (verschieb='m') then
                        begin hidecursor;
                              SubMenuDeaktivieren(altmenu,SubPoints,Submenustr,AktivBereich);
                              For j:=21 to 37 do Line(aktivBereich[altmenu,0],J,AktivBereich[altmenu,1],J);
                              showcursor;
                              menuaktiv[altmenu]:=false;
                        end;
      Until mainmenuindex>0;
End;