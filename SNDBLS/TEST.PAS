Program Test_SndBls;
Uses Crt,SndBls;

Var Ton                                                              : SoundBlaster;
    Channel,Multiple,Verkuerz,Huelltyp,Vibrato,Tremolo,
    Daempffaktor,Hochtondaempf,Decay,Attack,Release,Sustain,Waveform : Byte;

Begin Channel:=       0;
      Multiple:=      1;
      Verkuerz:=      1;
      Huelltyp:=      1;
      Vibrato:=       0;
      Tremolo:=       1;
      Daempffaktor:=  6;
      Hochtondaempf:= 0;
      Attack:=       10;
      Decay:=         1;
      Sustain:=       5;
      Release:=      10;
      Waveform:=      1;

      Ton.Reset;

      Ton.Init(Channel,Multiple,Verkuerz,Huelltyp,Vibrato,Tremolo,Daempffaktor,
               Hochtondaempf,Decay,Attack,Release,Sustain,Waveform);
      Ton.Init(1,1,1,1,0,0,4,0,1,10,10,5,1);

      Ton.Blast_On(0,577,1,0,0);
      Delay(2000);
      Ton.Blast_On(1,579,1,0,0);
      Delay(2000);
      Ton.Blast_Off(0);
      Delay(4000);
      Ton.Blast_Off(1);

      Ton.Reset;
End.