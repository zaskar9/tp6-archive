Unit SndBlst;

Interface

Uses Musik,Crt;

TYPE SoundBlaster=Object
                    SB : Word;
                    osc : Word;
                    ptab : Array[2..9]of Word;
                    Procedure Init(Address:Word);
                    Procedure Blast(Note:String;Oktave,Laenge:Integer);
                  end;

Implementation



Procedure SoundBlaster.Init(Address:Word);

Var I : Integer;

const {FilterRegisterTabelle}
         FRT:array[0..8]of byte=(0,1,2,8,9,10,16,17,18);
      {Lautst„rkeRegisterTabelle}
         LRT:array[0..8]of byte=(3,4,5,11,12,13,19,20,21);
      {ParameterVoreinstellung}
         PVT:array[0..7]of byte=(4,1,20,0,240,240,2,1);

procedure out(xreg, xdat : byte);
var t               : word;
begin
     {wert-> DSP-Chip}
     Port[SB+$8]:=xreg;
     for t:= 0 to 100 do begin end;
     Port[SB+$9]:=xdat;
     for t:= 0 to 100 do begin end;
end;

procedure SetSoundParam(p:byte); {p=OscillatorNummer}
Var j               : byte;
begin
      {Einstellen KlangParameter}
      for J:=1 to 4 do begin
          out((32*j)+FRT[p],ptab[2*j]);
          out((32*j)+LRT[p],ptab[2*j+1]);
      end;
end;

Begin SB:=Address;
      osc:=0;
      for I:=0 to 255 do out(I,0);
      {Voreinstellung ParameterTabellen}
      for I:=0 to 7 do ptab[i+2]:=PVT[I];
      for I:=0 to 8 do SetSoundParam(I);
end;


Procedure SoundBlaster.Blast(Note:String;Oktave,Laenge:Integer);
Var K,W,I : Integer;

procedure out(xreg, xdat : byte);
var t               : word;
begin
     {wert-> DSP-Chip}
     Port[SB+$8]:=xreg;
     for t:= 0 to 100 do begin end;
     Port[SB+$9]:=xdat;
     for t:= 0 to 100 do begin end;
end;

procedure NextNote(Wert,note : Integer);
const OGW=4; {OktaveGrundwert}
Var n : word; {Notenwert}
begin
     n:=Wert;
     n:=n+(((note DIV 12)+OGW)SHL 10);
     out($A0+osc,Lo(n));
     out($B0+osc,Hi(n));    {note off}
     out($B0+osc,Hi(n)+32); {note on }
     Inc(osc);
     If osc>0 then osc:=0;
end;

begin
     For I:=1 to Length(Note) do Note[I]:=UpCase(Note[I]);
     Ton(Note,Oktave,W);
     If Note='F'   then K:=0;  If Note='FIS' then K:=1;
     If Note='G'   then K:=2;  If Note='GIS' then K:=3;
     If Note='A'   then K:=4;  If Note='AIS' then K:=5;
     If Note='H'   then K:=6;
     If Note='C'   then K:=7;  If Note='CIS' then K:=8;
     If Note='D'   then K:=9;  If Note='DIS' then K:=10;
     If Note='E'   then K:=11;
     NextNote(W,K);
     Delay(Laenge);
end;

End.