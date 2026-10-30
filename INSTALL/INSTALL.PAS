Program Install;
{$M 2000,0,65000}
Uses Crt, Dos, Graph;
Var Nummer, Treiber, Modus, Breite, Hoehe : Integer;
    blaetter, turbo : Pointer;
    GrTurbo,GrBlaetter : Word;
    StrNummer : string;
    taste : Char;

procedure ReadGraphFile(Pfad : String; VAR Name : Pointer; VAR Groesse : Word);
var gi : file of integer;
    g : file;
    img : word;
Begin assign(gi,Pfad);
      reset(gi);
      read(gi,breite,hoehe);
      Close(gi);
      img:=Imagesize(0,0,breite,hoehe);
      getmem(Name,img);
      assign(g,Pfad);
      reset(g,img);
      blockread(g,Name^,1);
      close(g);
      Groesse:=img;
end;

procedure fenster;
begin Setfillstyle(1,white);
      bar(100,300,540,400);
      setcolor(black);
      rectangle(100,300,540,400);
      rectangle(102,302,538,398);
end;

procedure closefenster;
begin Setfillstyle(1,black);
      bar(100,300,540,400);
      setcolor(black);
      rectangle(100,300,540,400);
      rectangle(102,302,538,398);
end;

begin DetectGraph(treiber, modus);
      InitGraph(Treiber, modus, 'C:\');
      ReadGraphFile('A:\TURBO.PRW',turbo,GrTurbo);
      putimage(20,30,turbo^,0);
      setactivepage(0);
      freemem(turbo,GrTurbo);
      SetTextStyle(1,0,0);
      OutTextXY(40,160,'Willkommen zur Turbo Pascal 6.0');
      OutTextXY(40,200,'Installation!');
      SetTextJustify(1,2);
      SetTextStyle(0,0,0);
      OutTextXY(320,340,'Bitte eine Taste drÅcken');
      setfillstyle(solidfill,white);
      Taste:=readKey;
      ClearDevice;
      {$I-}
      mkdir('\TP');
      ChDir('C:\TP');
      {$I+}
      For Nummer:=1 To 4 Do
          Begin fenster;
                Str(nummer,StrNummer);
                OutTextXY(320,325,'Legen Sie bitte die Diskette #'+StrNummer);
                OutTextXY(320,345,'ins Laufwerk A:\ Ihres Computers');
                OutTextXY(320,365,'ein und drÅcken Sie eine Taste');
                taste:=readkey;
                closefenster;
                SwapVectors;
                EXEC('C:\DOS\XCOPY.EXE','A:\*.* /S');
                SwapVectors;
                Sound(440);Delay(100);
                NoSound;
                ClearDevice;
          End;
      Fenster;
      OutTextXY(320,325,'Die Turbo Pascal 6.0 Installation ist');
      OutTextXY(320,345,'nun beendet.');
      OutTextXY(320,365,'DrÅcken Sie bitte eine Taste.');
      Taste:=ReadKey;
      CloseFenster;
      Fenster;
      OutTextXY(320,345,'Bitte Diskette #1 einlegen.');
      Taste:=ReadKey;
      CloseFenster;
      CloseGraph;
End.