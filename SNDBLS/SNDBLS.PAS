Unit SndBls;

Interface

Uses Crt;
Type SoundBlaster=Object
                    SB_Regs : Array[0..255]of Byte;
                    Function Detect:Boolean;
                    Procedure Reset;
                    Procedure On_Blaster(SB_Reg,SB_Data:Byte);
                    Function Off_Blaster(SB_Reg:Byte):Byte;
                    Procedure Init(Channel,Multiple,Verkuerz,Huelltyp,Vibrato,
                                   Tremolo,Daempffaktor,Hochtondaempf,Decay,
                                   Attack,Release,Sustain,Waveform:Byte);
                    Procedure Blast_On(Channel:Byte;Frequenz:Integer;Oktave,
                                       Linking,Feedback:Byte);
                    Procedure Blast_Off(Channel:Byte);
                  End;

Implementation

Procedure SoundBlaster.On_Blaster(SB_Reg,SB_Data:Byte);
Begin Port[$388]:=SB_Reg;
      Delay(1);
      Port[$389]:=SB_Data;
      Delay(1);
      SB_Regs[SB_Reg]:=SB_Data;
End;

Function SoundBlaster.Off_Blaster(SB_Reg:Byte):Byte;
Begin Off_Blaster:=SB_Regs[SB_Reg];
End;

Function SoundBlaster.Detect:Boolean;
Begin
End;

Procedure SoundBlaster.Reset;
Var I : Integer;
Begin For I:=0 to 255 do On_Blaster(i,0);
End;

Procedure SoundBlaster.Init(Channel,Multiple,Verkuerz,Huelltyp,Vibrato,Tremolo,
                            Daempffaktor,Hochtondaempf,Decay,Attack,Release,
                            Sustain,Waveform:Byte);
Const Zelle:Array[0..1,0..8]of Byte=(($00,$01,$02,$08,$09,$0A,$10,$11,$12),
                                     ($03,$04,$05,$0B,$0C,$0D,$13,$14,$15));
Var h20,h40,h60,h80,hE0 : Byte;
Begin h20:=Multiple+16*Verkuerz+32*Huelltyp+64*Vibrato+128*Tremolo;
      h40:=DaempfFaktor+64*Hochtondaempf;
      h60:=Decay+16*Attack;
      h80:=Release+16*Sustain;
      hE0:=Waveform;
      On_Blaster($20+Zelle[0,Channel],h20); On_Blaster($20+Zelle[1,Channel],h20);
      On_Blaster($40+Zelle[0,Channel],h40); On_Blaster($40+Zelle[1,Channel],h40);
      On_Blaster($60+Zelle[0,Channel],h60); On_Blaster($60+Zelle[1,Channel],h60);
      On_Blaster($80+Zelle[0,Channel],h80); On_Blaster($80+Zelle[1,Channel],h80);
      On_Blaster($01,$20);
      On_Blaster($E0+Zelle[0,Channel],hE0); On_Blaster($E0+Zelle[1,Channel],hE0);
End;

Procedure SoundBlaster.Blast_On(Channel:Byte;Frequenz:Integer;Oktave,Linking,Feedback:Byte);
Var hA0,hB0,hC0 : Byte;
Begin hA0:=Frequenz AND 255;
      hB0:=Trunc(Frequenz/256)+4*Oktave+32;
      hC0:=Linking+2*Feedback;
      On_Blaster($A0+Channel,hA0);
      On_Blaster($B0+Channel,hB0);
      On_Blaster($C0+Channel,hC0);
End;

Procedure SoundBlaster.Blast_Off(Channel:Byte);
Begin On_Blaster($B0+Channel,0);
End;

End.