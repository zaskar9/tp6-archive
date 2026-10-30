PROGRAM PCX_PAS;
USES CRT, dos , graph;

TYPE Dateikopf = record
       PCXdat:   Byte;
       Dummy1:   Array[1..3] of Byte;
       Bildformat : Array[1..4] of Integer;
       Dummy2: Array[13..128] of Byte;
     end;

VAR i,j:Integer;
    Treiber, Modus:Integer;
    Breite, Hoehe:Integer;
    Zeile:Integer;
    gb: File of Byte;
    gdtk: File of Dateikopf;
    g:File;
    dtk:Dateikopf;
    b, Wert:Byte;
    Zaehler, Offset:Word;
    Startadresse: ^Byte;
    img: Word;
    Puffer:pointer;
    Datei : String;

BEGIN
  If ParamCount>0 then Datei:=ParamStr(1)
                  else begin WriteLn('Falscher oder fehlender Parameter!');
                             WriteLn('Syntax:  PCX_PAS [Laufwerk:] [NAME]');
                             WriteLn('Achtung: Endung ®.PCX¯ nicht angeben!');
                             Exit;
                       end;
  ClrScr;
  {$I-}
  Assign(gdtk,Datei+'.pcx');
  Reset(gdtk);
  {$I+}
  IF IOResult<>0 then
     begin WriteLn('Allgemeiner Fehler beim lesen der angegebenen Datei.');
           WriteLn('Achtung: Endung ®.PCX¯ nicht angeben!');
           Exit;
     end;
  Read(gdtk,dtk);
  Close(gdtk);
  If Dtk.PCXdat<>10 Then
    Begin Writeln('Dies ist keine PCX-Datei!');
    delay(5000);
          halt
    End;
  Breite:=Dtk.Bildformat[3]-Dtk.Bildformat[1]+1;
  Hoehe:=Dtk.Bildformat[4]-Dtk.Bildformat[2]+1;
  DetectGraph(Treiber,Modus);
  InitGraph(Treiber,Modus,'c:\tp\bgi');
  Assign(gb,Datei+'.pcx');
  Reset(gb);
  For i:=1 to 128 do Read(gb,b);
  For i:=0 to Hoehe-1 do
    Begin For j:=1 to 4 do
            Begin Case j of
                    1: Begin Port[$03C4]:=$02;
                             Port[$03C5]:=1;
                       end;
                    2: Begin Port[$03C4]:=$02;
                             Port[$03C5]:=2;
                       End;
                    3: Begin Port[$03C4]:=$02;
                             Port[$03C5]:=4;
                       End;
                    4: Begin Port[$03C4]:=$02;
                             Port[$03C5]:=8;
                       End
                  End;
                  Zeile:=0;
                  Offset:=$0000;
                  Startadresse:=ptr($A000+i*5,Offset);
                  Repeat Read(gb,b);
                         If b>=$C0
                           Then Begin Zaehler:=b-$C0;
                                      read(Gb,Wert);
                                End
                           Else Begin Wert:=b;
                                      Zaehler:=1;
                                End;
                         Fillchar(Startadresse^,Zaehler,Wert);
                         Zeile:=Zeile+8*Zaehler;
                         Offset:=Offset+Zaehler;
                         Startadresse:=ptr($A000+i*5,Offset);
                  Until Zeile>=Breite;
            End;
    End;
  Close(gb);
  img:=imagesize(dtk.Bildformat[1],dtk.Bildformat[2],dtk.Bildformat[3]+1,dtk.Bildformat[4]+1);
  If img=0
    Then Begin CloseGraph;
               Writeln('PCX-Datei zu gross');
               halt;
         End;
  GetMem(Puffer,img);
  GetImage(dtk.Bildformat[1],dtk.Bildformat[2],dtk.Bildformat[3]+1,dtk.Bildformat[4]+1,puffer^);
  PutImage(0,200,puffer^,0);
  Assign(g,Datei+'.tpp');
  Rewrite(g,img);
  Blockwrite(g,Puffer^,1);
  Close(g);
  Freemem(puffer,img);
  CloseGraph;
  ClrScr;
  Write('PCX-Datei als TPP-Datei gespeichert. Laden --> MYUTIL.PAS');
  Writeln;
END.
