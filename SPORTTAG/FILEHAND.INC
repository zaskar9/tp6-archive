{

Modul File_Handling    SPORTSTAG-PROGRAMM   Version 1.02

}
type str80 = string[80];
var data : text;


procedure file_zum_lesen_oeffnen(var fnam:filename);
var    ok : boolean;
begin  repeat gotoxy(40,5); clreol; readln(fnam);
              writeln;
              if fnam= ''
               then ok:= true
               else begin assign(data,fnam);
                          {$I-} reset(data) {$I+};
                          ok:= (ioresult=0);
                          if not ok then begin gotoxy(1,10); clreol;
                                               write(fnam,' nicht vorhanden !')
                                         end;
                    end;
       until ok;
       gotoxy(1,10); clreol
end;

procedure file_zum_schreiben_oeffnen(var fnam:filename);
var    ok : boolean;
       ant: char;
begin  repeat gotoxy(40,5); clreol; readln(fnam);
              writeln;
              if fnam= ''
               then ok:=false
               else begin assign(data,fnam);
                          {$I-} reset(data) {$I-};
                          ok:= (ioresult=0);
                          if ok
                           then
                             begin gotoxy(1,10); clreol;
                                   write(fnam,' schon vorhanden ! ');
                                   write('Ueberschreiben ?  (j/n) ');
                                   ant:=ReadKey;ant:=upcase(ant);
                                   if ant='J' then begin ok:=false;
                                                         rewrite(data)
                                                   end;
                             end
                           else rewrite(data);
                    end;
       until not ok;
       gotoxy(1,10); clreol
end;

function o_blanc(s:str4):str4;
const blanc = ' ';
var i : integer;
    st: str4;
begin st:=''; i:=1;
      while i<=4 do begin if s[i]<>blanc then st:=concat(st,s[i]);
                          i:=i+1;
                    end;
      if st='' then st:='0';
      o_blanc:=st;
end;

procedure string_int(var sch:schueler; ins: str80);
var i,pos,code : integer;
    st         : string[8];
begin with sch do
        begin klasse:=copy(ins,1,2);
              name:=copy(ins,4,23);
              st:=copy(ins,25,28);
              val(o_blanc(st),jahrg,code);
              g:=ins[30];
              spart:=copy(ins,32,35);
              for i:=1 to 4 do
               begin pos:=i*5+32;
                     st:=copy(ins,pos,pos+3);
                     val(o_blanc(st),l[i],code);
               end;

        end;
 end;


procedure file_lesen;
var fnam  : filename;
    i,j   : integer;
    c     : str80;
    savex, savey : Integer;
    kname      : string[2];
begin clrscr;
      Titel('SchÅlerfile lesen');
      GotoXY(1,5);write('SchÅlerliste          Filename: ');
      file_zum_lesen_oeffnen(fnam);
      if fnam<>'' then
       begin writeln;
             i:=0;
             while not eof(data) do
              begin readln(data,c);
                    for j:=length(c) to 80 do c:=concat(c,' ');
                    i:=i+1;
                    string_int(s[i],c);
                    write(s[i].klasse,' ',s[i].name,' ',s[i].jahrg:4,' ');
                    write(s[i].g,' ',s[i].spart,' ');
                    for j:=1 to 4 do write(s[i].l[j]:4,' ');
                    writeln;
              end;
             anzs:=i;
             writeln;
             writeln('Anzahl SchÅler: ',anzs);
             writeln;

             kname:='__'; j:=1;
             for i:=1 to anzs do
              with s[i] do
               begin if klasse<>kname then
                       begin kname:=klasse;
                             write(kname:3);
                             k[j].name:=kname;
                             j:=j+1;
                       end;
               end;
             anzk:=j-1;
             writeln;
             writeln('Anzahl Klassen: ',anzk);
             writeln;
             close(data);
             taste
       end;
end;

procedure file_schreiben;
var fnam: filename;
    i,k : integer;

begin clrscr;
      Titel('SchÅlerfile speichern');
      GotoXY(1,5);write('SchÅlerliste          Filename:');
      file_zum_schreiben_oeffnen(fnam);
      if fnam<>'' then
       begin for i:= 1 to anzs do
             begin with s[i] do
                    begin write(data,klasse:2,' ',name:20,' ');
                          write(data,jahrg:4,' ',g:1,' ',spart:4,' ');
                          for k:=1 to 4 do write(data,l[k]:4,' ');
                          writeln(data);
                    end;
              end;
              writeln;
              writeln('Anzahl SchÅler:',anzs);
              writeln;
              close(data);
              taste;
        end;
end;

procedure leistungen_neg_setzen;
var i,k : integer;
    ant : char;
begin clrscr;
      Titel('Leistungswerte initialisieren');
      gotoxy(5,10);write('Diese Prozedur setzt alle Leistungen auf -1');
      gotoxy(5,12);write('Soll das wirklich durchgefÅhrt werden   (J/N) ? ');
      ant:=ReadKey; ant:=upcase(ant);
      if ant='J' then
       begin gotoxy(5,13);write('Wirklich   (J/N) ? ');
             ant:=ReadKey; ant:=upcase(ant);
             if ant='J' then
               for i:= 1 to anzs do for k:=1 to 4 do s[i].l[k]:=-1;
       end;
      gotoxy(5,18);write('Fertig !   ');
      taste;
end;

procedure sportart_in(x,y:integer;var spart:str4);
const Enter=#13;Esc=#27;BS=#8;Left=#75;Right=#77;
Var Taste:char;
    i: integer;
    s: String;
begin s:=spart;
      i:=1;
      gotoxy(x-1+i,y);Write(spart);
      repeat gotoxy(x-1+i,y);
             Taste:=upcase(ReadKey);
             if (Taste=Left) and (i>1) then i:=i-1
               else if (Taste=Right) and (i<4) then i:=i+1
                 else if (i=1) and (Taste in ['6','8','1'])
                        then begin write(Taste); s[i]:=Taste; i:=i+1 end
                   else if (i=2) and (Taste in ['W','H'])
                          then begin write(Taste); s[i]:=Taste; i:=i+1 end
                     else if (i=3) and (Taste in ['B','S','J','3','5'])
                            then begin write(Taste); s[i]:=Taste; i:=i+1 end
                       else if (i=4) and (Taste in ['8','1','2'])
                              then begin write(Taste); s[i]:=Taste end
      until Taste in [Enter,Esc];
      if Taste=Enter then spart:=s;
end;


procedure eingabe_disziplinen;
var kl: str2;
    gs: char;
    x,y,i,zeile : integer;
    spart,vorgabe:str4;
begin clrscr;
      Titel('Disziplinen eingeben');
      klasse_geschlecht(5,10,kl,gs);
      clrscr;
      Titel('Disziplinen eingeben');
      writeln;
      writeln('Kurzstrecke    : 60m (6), 80m (8), 100m (1)');
      writeln('Sprung         : Hochsprung (H), Weitsprung (W)');
      writeln('Wurf           : Ballwurf (B), Schleuderball (S),');
      writeln('                 Kugel 3kg (3), Kugel 5kg (5), Speer (J)');
      writeln('Langstrecke    : 800m (8), 1000m (1), 1200m (2)');

      gotoxy(5,10);write('Grundeinstellungen, falls noch keine Disziplinen');
      gotoxy(5,11);write('eingegeben wurden:        (Enter: keine Vorgabe) ');
      gotoxy(5,14);write('Vorgabedisziplinen:');
      vorgabe:='    ';
      sportart_in(5+24,14,vorgabe);
      gotoxy(1,40);write('Vorgabe: ',vorgabe);
      gotoxy(1,10);ClrEol;
      gotoxy(1,11);ClrEol;
      gotoxy(1,14);ClrEol;

      x:=1;y:=8;
      for i:=1 to anzs do
       with s[i] do
        begin if (klasse=kl) then
               begin gotoxy(x,y);write(klasse:2,' ',name:20);
                     if (vorgabe<>'    ') and (spart='    ')
                       then spart:=vorgabe;
                     sportart_in(x+24,y,spart);
                     y:=y+1; if y>22 then begin x:=40;y:=8 end
               end;
        end;
      taste;

end;



procedure menue_file_handling(VAR WahlInt : INTEGER);

VAR Menu                        : RAHMEN;

begin MenuTitel('Menu File Handling');
      GotoXY(1,25);
      Menu.Init(40,10,75,16,'FILEHAND.MEN',blue,red,white,true);
      Menu.Draw(blue);
      Wahlint:=Menu.Lightbar(lightgray,black,1);
      Menu.Cancel('∞',blue);
end;

procedure file_handling;
begin repeat titelzeile;
             menue_file_handling(WahlInt);
             case wahlint of
                  1 :  file_lesen;
                  2 :  file_schreiben;
                  3 :  leistungen_neg_setzen;
                  4 :  eingabe_disziplinen;
             end;
             if wahlint in[1..4] then HinterGrund_mit_Titel;
      until (wahlint=5) or (wahlint=0);
end;



