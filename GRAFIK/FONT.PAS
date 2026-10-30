PROGRAM UserFont;
USES CRT, GRAPH;

VAR Graphiktreiber, Graphikmodus, GRFehler : INTEGER;
    Pfad, Font : STRING;
    FontNr,a : INTEGER;

BEGIN
   FontNr:=0;
   FontNr:=InstallUserFont('SANSERIF.CHR');
   If GraphResult = GrOk Then BEGIN
                                    Graphiktreiber:=Detect;
                                    InitGraph(Graphiktreiber,Graphikmodus,'C:\TP\BGI');
                                    SetTextStyle(FontNr,HorizDir,3);
                                    OutText('Erfolgreich installiert !');
                               END;
   Delay(2000);
   a:=0;
   Repeat
         SetTextStyle(a,0,3);
         Inc(a);
         OutTextXY(10,10+a*20,'Michael');
   Until a>20;
   Repeat Until Keypressed;
END.




