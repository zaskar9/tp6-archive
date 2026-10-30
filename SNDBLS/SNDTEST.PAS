Program Test_SndBlst;
Uses SndBlst;

Var SoundEffect : SoundBlaster;

Begin SoundEffect.Init($220);
      SoundEffect.Blast('C',0,1000);
End.

