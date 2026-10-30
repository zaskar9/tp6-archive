PROGRAM Drawing;
USES Graph, Crt, Mouse;

VAR a, b, Button, gd, gm, i, x, y, x1, y1       : INTEGER;
    Taste                                       : CHAR;

{$I CURSOR.INC  }
{$I UNDELINE.INC}{*}
{$I DRAWRECT.INC}{*}
{$I CIRCDRAW.INC}{*}
{$I FREEDRAW.INC}{*}
{$I DRAWLINE.INC}{*}
{$I SPACFILL.INC}{*}
{$I ENDOF.INC   }
{$I DELETE.INC  }
{$I DRAWGUM.INC }{*}
{$I DRAWMENU.INC}
{$I DRAWSCR.INC }

BEGIN
     ClrScr;
     gd:=detect;
     gm:=0;
     InitGraph(gd,gm,'');
     ClearDevice;
     InitScreen;
     Menu;
     CloseGraph;
END.




