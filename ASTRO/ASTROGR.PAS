PROGRAM Aszendent;

USES CRT, GRAPH, WRITING, STARUNIT, STARS;

CONST Sternzeichen: ARRAY[1..12] OF STRING =
                    ('Widder','Stier','Zwillinge','Krebs','Lîwe','Jungfrau','Waage',
                    'Skorpion','SchÅtze','Steinbock','Wassermann','Fische');

VAR Grund            : StarGround;
    Rahmen           : StarFrame;
    Copyr            : StarFrame;
    Stargr           : StarField;
    I                : INTEGER;
    Taste            : CHAR;

{$I STARZEIC.INC}

BEGIN
     I:=0;
     StarGr.Init(1,1,640,480,150,150,490,300,49);
     Grund.Init(1,1,640,480);
     Copyr.Init(150,150,490,300,red);
     Copyr.Draw;
     SetTextStyle(4,0,0);
     SetTextJustify(CenterText, CenterText);
     OutTextXY(320,180,'PC Astro 2.5');
     SetTextStyle(0,0,0);
     OutTextXY(320,230,'by');
     OutTextXY(320,250,'Michael Gossniklaus (Syntax)');
     OutTextXY(320,270,'Fabian Kristmann (Idee)');
     Stargr.Zeichnen(true,0);
     Copyr.Refrish;
     Grund.Draw;
     Delay(1000);
     SetTextJustify(0,1);
     Repeat
           Sternzeichen_bestimmen;
           Taste:=ReadKey;
     Until Taste=#27;
     CloseGraph;
     TextColor(lightgray);
     TextBackGround(Black);
     ClrScr;
END.