Program Test;
Uses Crt, Dos, Musik;

TYPE NoteDat=Record
                TonHoehe,Laenge:Integer;
                Nummer : byte;
             End;

const SB=$220; {SoundBlaster-I/O-Adresse}
      {FilterRegisterTabelle}
      FRT:array[0..8]of byte=(0,1,2,8,9,10,16,17,18);
      {Lautst„rkeRegisterTabelle}
      LRT:array[0..8]of byte=(3,4,5,11,12,13,19,20,21);
      {ParameterVoreinstellung}
      PVT:array[0..7]of byte=(2,10,20,0,240,240,2,1);
      Fakt=0.9;

var osc         : word;
    ptab        : array[2..9] of word;
    I,TonZahler : integer;
    Lied        : Array[0..250] of NoteDat;
    Ende        : Integer;

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
const OGW=3; {OktaveGrundwert}
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

procedure SetSoundParam(p:byte); {p=OscillatorNummer}
Var j               : byte;
begin
      {Einstellen KlangParameter}
      for J:=1 to 4 do begin
          out((32*j)+FRT[p],ptab[2*j]);
          out((32*j)+LRT[p],ptab[2*j+1]);
      end;
end;

Procedure neuvec;
begin
     NextNote(Lied[TonZahler].Tonhoehe,Lied[TonZahler].Nummer);
     delay(Round(Lied[TonZahler].Laenge*Fakt));
end;

Procedure Einlesen(Dateiname:String; Var Anzahl : Integer);
Var Zahler,Platz,Oktav,W,K,Fehler,Pause : Integer;
    Txt,Note,Teil2,Okt,Verz : String;
    Lange : Char;
    Datei : Text;
Begin Zahler:=0;
      Assign(Datei,Dateiname);
      Reset(Datei);
      Repeat
            ReadLn(Datei,Txt);
            Platz:=POS(',',Txt );
            Note:=COPY(Txt,0,Platz-1);
            Teil2:=COPY(Txt,Platz+1,Length(Txt));
            Platz:=POS(',',Teil2);
            Okt:=COPY(Teil2,0,Platz-1);
            Verz:=COPY(Teil2,Platz+1,Length(Teil2));
            MEM[SEG(Lange):OFS(Lange)]:=MEM[SEG(Verz):OFS(Verz)+1];
            Case UpCase(Lange) Of
                 'G' : Pause:=4000;
                 'D' : Pause:=3000;
                 'H' : Pause:=2000;
                 'P' : Pause:=1500;
                 'V' : Pause:=1000;
                 'L' : Pause:=0750;
                 'B' : Pause:=0666;
                 'A' : Pause:=0500;
                 'T' : Pause:=0333;
                 'S' : Pause:=0250;
                 'K' : Pause:=0100;
                 'U' : Pause:=2500;
            End;
            For I:=1 to Length(Note) do Note[I]:=UpCase(Note[I]);
            Val(okt,Oktav,Fehler);
            Ton(Note,Oktav,W);
            If Note='F'   then K:=0;
            If Note='FIS' then K:=1;
            If Note='G'   then K:=2;
            If Note='GIS' then K:=3;
            If Note='A'   then K:=4;
            If Note='AIS' then K:=5;
            If Note='H'   then K:=6;
            If Note='C'   then K:=7;
            If Note='CIS' then K:=8;
            If Note='D'   then K:=9;
            If Note='DIS' then K:=10;
            If Note='E'   then K:=11;
            Lied[Zahler].TonHoehe:=W;
            Lied[Zahler].Laenge:=Pause;
            Lied[Zahler].Nummer:=K;
            Inc(Zahler);
      Until EOF(datei);
      Anzahl:=Zahler-1;
End;

Begin
     Einlesen('A:\RAIDERS.CMP',Ende);
     TonZahler:=1;
     osc:=0;
     clrscr;
     for I:=0 to 255 do out(I,0);
     {Voreinstellung ParameterTabellen}
     for I:=0 to 7 do ptab[i+2]:=PVT[I];
     for I:=0 to 8 do SetSoundParam(I);
     Repeat Neuvec;
            Inc(TonZahler);
     Until TonZahler>Ende;
     TonZahler:=1;
End.



