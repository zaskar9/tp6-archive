{$A+,B-,D+,E+,F-,G-,I+,L+,N-,O-,R-,S+,V+,X-}
{$M 65000,0,655360}
Program Music;
Uses Dos, Crt, Graph, Myutil, DlgBox, Menu;

Type DatAttr=Record
               Tempo : Array[1..2] of Integer;
               Schluessel : Integer;
             End;

Var HMenu,Hauptmenucode,Untermenucode,Button,x,y,AnzSwitch,IconNr  : Integer;
    MCodeLine, DateiState                                          : Boolean;
    ButtonCol,MenuMark,ItemCol,Menucol,HGrundCol,TitelCol,
    LineCol,ShadowCol,ConShad,TxtCol                               : Word;
    CompMenu                                                       : MenuList;
    MenuFarb                                                       : TMenuColor;
    DateiStr                                                       : String;
    Format                                                         : DatAttr;

{$I MUSYMBOL.INC}
{$I MUSMESSA.INC}
{$I MUSWITCH.INC}
{$I MUSMOUSE.INC}
{$I MUSCTAST.INC}
{$I MUSCNOTE.INC}
{$I MUSCCOPY.INC}
{$I MUSCREEN.INC}
{$I MUSCBILD.INC}
{$I MUSCINIT.INC}
{$I MUICNMEN.INC}
{$I MUCERROR.INC}

{$I MUSDATEI.INC}
{$I MUOPTION.INC}
{$I MULIZENZ.INC}

Begin {159'136; ohne TP: 476'032}
      Graphik_Ein('');
      VGA_Aus;
      SetVerticalLimits(0,GetMaxY);
      SetHorizontalLimits(0,GetMaxX);
      ProgInit;
      VGA_Ein;
      Copyright;
      HauptMenuCode:=0;
      UnterMenuCode:=0;
      DateiState:=False;
      Repeat
            GetPosBut(Button,x,y);
            If ((y>20) and (y<39)) or (Keypressed)
            then begin CompMenu.MenuAktivieren(HauptMenuCode,UnterMenucode,MCodeLine,TitelCol,TxtCol);
                       Case HauptMenucode of
                        1 : Case UnterMenuCode of
                            1 : Datei_Neu(DateiStr,Format);
                            5 : Datei_Schliessen;
                        End;
                        2 : Case UnterMenuCode of
                            1 : Optionen_Farben;
                            2 : Optionen_Statuszeile;
                            3 : ErrorMessage(5);
                        End;
                        5 : Case UnterMenuCode of
                            4 : Copyright;
                        end;
                        6 : Case UnterMenuCode of
                            1 : Lizenz_Registrierung;
                        End;
                       Else if HauptMenuCode<>0 then ErrorMessage(4);
                       End;
                 end
            else begin if (not MouseClick) or (hauptmenucode=0) then
                               begin HauptMenuCode:=0;
                                     UnterMenuCode:=0;
                               end;
                       IconMenu(IconNr);
                       Case IconNr of
                        1 : Datei_Neu(DateiStr,Format);
                       Else if (IconNr>1)and(IconNr<=10) then ErrorMessage(4);
                       End;
                 end;
      Until (HauptmenuCode=1) and (Untermenucode=7);
      Graphik_Aus;
End.




