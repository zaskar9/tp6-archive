{ WIN.PAS - reconstructed source of WIN.EXE (13 Oct 1993)               }
{                                                                       }
{ A "Windows 3.1" window drawn in BGI graphics over a moving star       }
{ field, with a system-menu box, a minimize button that reacts to a    }
{ mouse click, and a mouse cursor that hides over the client area.      }
{ OBERFL01.PAS of 31 Dec 1993 is the later form of this experiment.     }
{                                                                       }
{ The original source is lost. This file was reconstructed in November  }
{ 2026 from a disassembly of WIN.EXE (Turbo Pascal 6.0 build, 27248     }
{ bytes). Everything that is in the binary is reproduced exactly; the   }
{ names of the program, the object, its methods and the variables are   }
{ taken from OBERFL01.PAS and ASTROGR.PAS where they fit (Fenster,      }
{ Rahmen, TitleBar, MenuPlug, PopUpPlug, Wind, Stargr, gd, gm) and      }
{ invented otherwise (Titel, InPopUp, Gedrueckt). Verified: compiled    }
{ with Turbo Pascal 6.0 (TPC.EXE, no switches, STARS from ASTRO and     }
{ MOUSE from UNITS) this file gives an EXE that is byte for byte        }
{ identical to WIN.EXE. The four bytes of Unbenutzt exist only because  }
{ the EXE has four unused bytes of variables before X.                  }
{                                                                       }
{ Units: CRT, GRAPH and DOS from Turbo Pascal 6.0, MOUSE from the UNITS }
{ folder, STARS (the star field object, 13 Oct 1993) from ASTRO. The    }
{ BGI driver is loaded from the current directory.                      }

Program Oberflaeche;
Uses Crt, Graph, Dos, Mouse, Stars;

TYPE Fenster=OBJECT
               x1,x2,y1,y2 : Integer;
               Titel       : String;
               Constructor Init(a1,b1,a2,b2 : Integer; Text : String);
               Procedure Rahmen; Virtual;
               Procedure TitleBar; Virtual;
               Procedure MenuPlug; Virtual;
               Procedure PopUpPlug(Gedrueckt : Boolean); Virtual;
               Function InPopUp(X,Y : Integer) : Boolean;
             End;

Var Unbenutzt    : Array[1..4] of Byte;   { unused; type and name unknown }
    X, Y, Button : Integer;
    gd, gm       : Integer;
    Wind         : Fenster;
    Stargr       : StarField;

Constructor Fenster.Init(a1,b1,a2,b2 : Integer; Text : String);
Begin x1:=a1;
      x2:=a2;
      y1:=b1;
      y2:=b2;
      Titel:=Text;
End;

Procedure Fenster.Rahmen;
Begin SetColor(Black);
      Rectangle(x1,y1,x2,y2);
      Rectangle(x1+2,y1+2,x2-2,y2-2);
      SetColor(LightGray);
      Rectangle(x1+1,y1+1,x2-1,y2-1);
End;

Procedure Fenster.TitleBar;
Begin SetColor(Black);
      Line(x1+2,y1+22,x2-2,y1+22);
      SetFillStyle(SolidFill,Blue);
      Bar(x1+3,y1+3,x2-3,y1+21);
      SetTextJustify(CenterText,CenterText);
      SetTextStyle(DefaultFont,HorizDir,0);
      SetColor(White);
      OutTextXY((x2-x1) DIV 2+x1,y1+13,Titel);
End;

Procedure Fenster.MenuPlug;
Begin SetColor(Black);
      Line(x1+22,y1+2,x1+22,y1+22);
      SetColor(Black);
      Rectangle(x1+9,y1+9,x1+14,y1+12);
      SetColor(White);
      Line(x1+10,y1+10,x1+13,y1+10);
      SetFillStyle(SolidFill,LightGray);
      FloodFill(x1+5,y1+5,Black);
      SetColor(DarkGray);
      Line(x1+10,y1+13,x1+15,y1+13);
      Line(x1+15,y1+10,x1+15,y1+13);
End;

Procedure Fenster.PopUpPlug(Gedrueckt : Boolean);
Begin SetColor(Black);
      Line(x2-22,y1+2,x2-22,y1+22);
      SetFillStyle(SolidFill,LightGray);
      FloodFill(x2-5,y1+5,Black);
      If Gedrueckt=False then SetColor(White)
                         else SetColor(DarkGray);
      Line(x2-21,y1+3,x2-4,y1+3);
      Line(x2-21,y1+4,x2-21,y1+20);
      If Gedrueckt=False then SetColor(DarkGray)
                         else SetColor(White);
      Line(x2-3,y1+3,x2-3,y1+21);
      Line(x2-4,y1+4,x2-4,y1+21);
      Line(x2-21,y1+21,x2-5,y1+21);
      Line(x2-20,y1+20,x2-5,y1+20);
      SetColor(Black);
      Line(x2-15,y1+10,x2-9,y1+10);
      Line(x2-14,y1+11,x2-10,y1+11);
      Line(x2-13,y1+12,x2-11,y1+12);
      PutPixel(x2-12,y1+13,Black);
End;

Function Fenster.InPopUp(X,Y : Integer) : Boolean;
Var A, B : Integer;
Begin InPopUp:=False;
      A:=x2-22;
      B:=y1+22;
      If (X>=A) and (x2-3>=X) and (y1+3<=Y) and (Y<=B) then InPopUp:=True
                                                       else InPopUp:=False;
End;

Begin DetectGraph(gd,gm);
      InitGraph(gd,gm,'');
      ClearDevice;
      SetFillStyle(SolidFill,White);
      Bar(1,1,640,480);
      Wind.Init(100,100,600,400,'Windows 3.1');
      Wind.Rahmen;
      Wind.TitleBar;
      Wind.MenuPlug;
      Wind.PopUpPlug(False);
      SetFillStyle(SolidFill,Black);
      Bar(103,123,597,397);
      Stargr.Init(103,123,597,397,0,0,0,0,40);
      ShowCursor;
      Repeat
            Repeat
                  GetPosBut(Button,X,Y);
                  If (X<600) and (X>100) and (Y>120) and (Y<400) then HideCursor
                                                                 else ShowCursor;
                  Stargr.Zeichnen(False,0);
            Until Button=1;
            If Wind.InPopUp(X,Y) then
               begin HideCursor;
                     Wind.Init(100,100,600,400,'Windows 3.1');
                     Wind.PopUpPlug(True);
                     Delay(500);
                     Wind.PopUpPlug(False);
                     ShowCursor;
               end;
      Until KeyPressed;
      HideCursor;
      CloseGraph;
End.
