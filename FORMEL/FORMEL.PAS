PROGRAM Formelsammlung;
USES CRT, MOUSE, GRAPH, WRITING;

TYPE Inter=(Stop,Norm);

VAR I,x,y,Button                        : INTEGER;
    Taste                               : CHAR;
    Datei                               : TEXT;
    Ende                                : INTER;

{$I OKAY.INC    }
{$I GRAPHICS.INC}
{$I FORTRAN.INC }
{$I MACHRAHM.INC}
{$I BACKGROU.INC}
{$I COPYRIGH.INC}
{$I ZYLINDER.INC}
{$I PRISMA.INC  }
{$I UNTERMEN.INC}
{$I UNITMENU.INC}
{$I FORMMENU.INC}

BEGIN
     x:=0;y:=0;
     Ende:=Norm;
     TextBackGround(black);
     ClrScr;
     Hintergrund;
     Copyright;
     Menu;
END.




