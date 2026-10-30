{$M 8000, 0, 4000}
PROGRAM Soundblaster;
USES Crt, Dos;

const SB=$220; {SoundBlaster-I/O-Adresse}
               {NotenwerteTabelle}
      NWT:array[0..11]of word=(343,363,385,408,432,458,485,514,544,577,611,647);
               {FilterRegisterTabelle}
      FRT:array[0..8]of byte=(0,1,2,8,9,10,16,17,18);
               {Lautst„rkeRegisterTabelle}
      LRT:array[0..8]of byte=(3,4,5,11,12,13,19,20,21);
               {ParameterVoreinstellung}
      PVT:array[0..7]of byte=(0,0,16,1,240,240,4,1);
               {ArrangementTabelle}
      ART:array[0..1,0..7]of byte=((1,0,1,0,3,0,3,0), {Bass}
                                  (1,2,3,2,1,2,3,4)); {Chorus}

VAR taste                                         : CHAR;
    maxakk, akkx, I, j, note, octav, step, pmcnt  : INTEGER;
    osc, count, tempo                             : WORD;
    filex                                         : TEXT;
    fline, Noten                                  : STRING[32];
    akk                                           : ARRAY[1..46,1..4] of BYTE;
    oldvec                                        : POINTER;
    ptab                                          : ARRAY[2..9] OF WORD;

procedure out(xreg, xdat : byte);
var t               : word;
begin
     {wert-> DSP-Chip}
     Port[SB+$8]:=xreg;
     for t:= 0 to 100 do begin end;
     Port[SB+$9]:=xdat;
     for t:= 0 to 100 do begin end;
end;

procedure NextNote(note : byte);
const OGW=3; {OktaveGrundwert}
Var n               : word; {Notenwert}
begin
     dec(note); {0..n}
     n:=note-((note DIV 12)*12);
     n:=NWT[n];
     n:=n+(((note DIV 12)+OGW)SHL 10);
     out($A0+osc,Lo(n));
     out($B0+osc,Hi(n));    {note off}
     out($B0+osc,Hi(n)+32); {note on }
     Inc(osc); {n„chster Oscillator}
     if osc=9 then osc:=0;
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

procedure Takt;
begin
     if ART[0,step]>0 then NextNote(akk[akkx,ART[0,step]]);    {Bass}
     if ART[1,step]>0 then NextNote(akk[akkx,ART[1,step]]+12); {Chorus}
     note:=1+random(4); {Melodie immer}
     NextNote(akk[akkx,note]+(octav*12));
             {evtl. KlangVariationen aktivieren}
     if pmcnt<9 then SetSoundParam(pmcnt);
     Inc(pmcnt);
end;

procedure CreateNewSounds;
begin
     ptab[2]:=Random(20)AND 3;
     ptab[6]:=(Random(10)+6)SHL 4;
     if Random(20)<2 then ptab[3]:=1
                     else ptab[3]:=0;
     if ptab[2]>1 then begin
        ptab[8]:=Random(5)+4;
        ptab[4]:=Random(20)+16;
     end else begin
        ptab[8]:=Random(8)+1;
        ptab[4]:=Random(28)+1;
     end;
end;

procedure Routine;
begin
     Inc(count);
     if count=tempo then begin
        count:=0;
        Takt; {8 im akkord}
        step:=(step+1)AND 7;
        if step=0 then begin
           octav:=1+Random(3);
           Inc(akkx); {n„chster Akkord}
           if akkx>maxakk then begin
              {Wiederholung aller Akkorde}
              akkx:=1; pmcnt:=0;
              {neue Klangvariationen bilden}
              CreateNewSounds;
           end;
        end;
     end;
End;

Procedure ReadAccordFile;
begin
     Assign(filex,ParamStr(1));
     Reset(filex);
     akkx:=0; {mommentAkkord}
     Repeat
           Inc(akkx);
           Readln(filex, fline);
           for I:=1 to 4 Do begin
               osc:=Pos(Fline[(2*I)-1],Noten);
               If I>1 then
                  if osc<=akk[akkx,I-1] then osc:=osc+12;
               akk[akkx,I]:=osc;
           end;
     Until (Eof(filex)) OR (fline='');
     maxakk:=akkx;
     Close(filex);
end;

{$F+}
procedure NeuInt1C; interrupt;
begin
     If mem[0:$4FF]=0 then Routine;
     Port[$20]:=$20;
end;
{$F-}

{-------------------------------HauptProgramm--------------------------------}

begin
      if ParamStr(1)='' THEN Exit;
      if Paramstr(1)='x' then begin
         Mem[0:$4FF]:=Mem[0:$4FF]XOR 1;
         Exit;
      end; {Jukebox ein/aus}
      Noten:='CcDdEefGgAbH';
      {Rckstetzen aller Register}
      for I:=0 to 255 do out(I,0);
      {Voreinstellung ParameterTabellen}
      for I:=0 to 7 do ptab[i+2]:=PVT[I];
      for I:=0 to 8 do SetSoundParam(I);
      ReadAccordFile; {Einlesen der Akkorde}
      Randomize;
      osc:=0; akkx:=1; step:=0; count:=0; tempo:=4; pmcnt:=9;
      GetIntVec($1C, oldvec);
      if ParamStr(2)<>'test' then SetIntVec($1C,Addr(NeuInt1C));
      taste:=#0;
      {Hauptschleife}
      Repeat
            IF Keypressed then Taste:=ReadKey;
            if (Taste>'0') AND (taste<'9') then
            begin
                 tempo:=Ord(taste)-48;
                 count:=0; taste:=#0;
            end;
            if Paramstr(2)='test' then
            begin
                 Routine;
                 Delay(60);
            end;
      Until (Taste='r')OR(taste=#27);
      if taste='r' then Keep(0)
      else Setintvec($1C,oldvec);
end.

