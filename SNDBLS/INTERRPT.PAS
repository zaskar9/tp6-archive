Program Test_IRQ_Modus;
Uses Dos,SndBls,Crt;

Const Freq : Array[0..12]of Integer=(0,343,363,385,408,432,458,485,514,544,577,611,647);
      Faktor=0.005;

Type Ton=Record
            Frequenz : Integer;
            Oktave   : Byte;
            Pause    : Integer;
            MaxToene : Integer;
         End;

Var oldvect                                : Pointer;
    Kanal_On,Play                          : Array[0..8]of Boolean;
    Laenge,Nr                              : Array[0..8]of Integer;
    Stimme                                 : Array[0..8,1..200]of Ton;
    Snd                                    : SoundBlaster;
    Datei                                  : Array[0..8]of Text;
    A,I,J,K,Platz,Test,Oktave,Fehler,Pause : Integer;
    Strng,Note,Teil2,Okt,Verz              : String;
    Lange                                  : Char;

{$I INIT.INC}

procedure interrupt_08h; interrupt;
begin asm cli end;
      For I:=0 to 2 do
          if Kanal_On[I] then
          begin
             if Play[I]=true
                then begin Snd.Blast_On(I,Stimme[I,Nr[I]].Frequenz,Stimme[I,Nr[I]].Oktave,1,0);
                           Laenge[I]:=Stimme[I,Nr[I]].Pause;
                           Play[I]:=False;
                     end
                else begin Dec(Laenge[I],1);
                           If Laenge[i]<=0
                              then begin delay(5);
                                         Inc(Nr[I]);
                                         Snd.On_Blaster($b0+I,0);
                                         Play[I]:=True;
                                   End
                              else delay(7);
                     end;
          end;
      asm sti end;
      port[$20]:=$20;
end;

begin ClrScr;

      Snd.Reset;
      Snd.Init(0,0,0,1,0,0,10,0,1,8,15,0,3);
      Snd.Init(1,0,0,1,0,0,10,0,1,8,15,0,3);
      Snd.Init(2,2,0,1,0,0,0,0,0,15,0,15,0);
      For I:=0 to 8 do
          begin Play[I]:=True;
                Kanal_On[I]:=False;
                Nr[I]:=1;
          end;
      Kanal_On[0]:=true; Kanal_On[1]:=true; Kanal_On[2]:=true;
      Assign(Datei[0],'C:\TPWORK\SBLASTER\VL1.CMP');
      Assign(Datei[1],'C:\TPWORK\SBLASTER\VL2.CMP');
      Assign(Datei[2],'C:\TPWORK\SBLASTER\HN1.CMP');

      Init;

      asm cli end;
      getintvec($08,oldvect);
      setintvec($08,addr(interrupt_08h));
      port[$40]:=$FF;
      port[$40]:=$FF;
      asm sti end;

      Repeat Until (Nr[0]>Stimme[0,1].MaxToene-1)AND(Nr[1]>Stimme[1,1].MaxToene-1)AND(Nr[2]>Stimme[2,1].MaxToene-1);

      asm cli end;
      setintvec($08,oldvect);
      port[$40]:=$00;
      port[$40]:=$00;
      asm sti end;
      Snd.Reset;
end.