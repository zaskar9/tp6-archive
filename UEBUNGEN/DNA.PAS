{$A+,B-,D+,E+,F-,G-,I+,L+,N+,O-,R-,S+,V+,X-}
{$M 16384,0,655360}
Program DNA_Simulation;

USES crt;     {C,G,T,A}

VAR I, Z, x, y       : Byte;
    Str              : String;
    Dna              : Extended;

Begin
     ClrScr;
     x:=14;
     y:=0;
     DNA:=-59;
     Randomize;
     Repeat
           IF y<25 then Inc(y);
           dna:=dna+60;
           Str:='';
           delay(5);
           Z:=0;
           Repeat
                 Inc(Z);
                 I:=Random(5)+1;
                 Case I Of
                      1 : Str:=Str+'C';
                      2 : Str:=Str+'G';
                      3 : Str:=Str+'T';
                      4 : Str:=Str+'A';
                      5 : Begin
                               I:=Random(9)+1;
                               Case I Of
                               1 : Str:=Str+'C';
                               2 : Str:=Str+'G';
                               3 : Str:=Str+'T';
                               4 : Str:=Str+'A';
                               5 : Str:=Str+'C';
                               6 : Str:=Str+'G';
                               7 : Str:=Str+'T';
                               8 : Str:=Str+'A';
                               9 : Str:=Str+' ';
                               End;
                          End;
                 End;
                 IF Z MOD 10 = 0 THEN Str:=Str+' ';
           Until Z>59;
           GotoXY(2,y);
           Write(dna:10:0);
           GotoXY(x,y);
           Writeln(Str);
     Until Keypressed;
End.
