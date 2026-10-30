Program Bugtest;
Uses Crt, Dos;

{$I TETRBUGS.INC}

Begin ClrScr;
      Bug(100,45,'Test');
      Write('Test erfolgreich !');
      Repeat Until Keypressed;
End.