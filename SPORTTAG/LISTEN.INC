{

Modul Listen_schreiben      SPORTSTAG-PROGRAMM       Version 2.0

}

type tliste = array[1.. max_schueler] of integer;

function sportzahl(sart:char):integer;
begin case sart of
       'K' : sportzahl:=1;
       'S' : sportzahl:=2;
       'W' : sportzahl:=3;
       'L' : sportzahl:=4
      end
end;

procedure sortieren(var liste:tliste;k:integer);
var i,j,c : integer;
    zw    : tliste;

 function vergleich(a,b:integer):boolean;
  begin if (k=1) or (k=4)
          then begin if (a>b) and (b>0) then vergleich:=true
                                        else vergleich:=false;
                     if (a=0) and (b>0) then vergleich:=true
               end
          else begin if a<b then vergleich:=true
                            else vergleich:=false
               end;
  end;

begin for i:=1 to anzs do begin liste[i]:=i; zw[i]:=s[i].l[k] end;
      for i:=1 to anzs-1 do
       for j:=i+1 to anzs do
         begin if vergleich(zw[i],zw[j]) then begin c:=zw[i];
                                                    zw[i]:=zw[j];
                                                    zw[j]:=c;
                                                    c:=liste[i];
                                                    liste[i]:=liste[j];
                                                    liste[j]:=c
                                              end;
          end
end;

procedure code_angabe;
begin write(lst,'Bitte Angabe der Sportdisziplinen gem„ss');
      writeln(lst,' folgender Tabelle:');
      writeln(lst);
      writeln(lst,'Kurzstrecke    : 60m (6), 80m (8), 100m (1)');
      writeln(lst,'Sprung         : Hochsprung (H), Weitsprung (W)');
      writeln(lst,'Wurf           : Ballwurf (B), Schleuderball (S),');
      writeln(lst,'                 Kugel 3kg (3), Kugel 5kg (5), Speer (J)');
      writeln(lst,'Langstrecke    : 800m (8), 1000m (1), 1200m (2)');
end;

procedure kl_eingabe;
begin gotoxy(1,14);
      write('Optionen fr die Eingabe der Klassen:');
      gotoxy(40,14); write('Klasse      :  z.B.  4a, 5c, ...');
      gotoxy(40,15); write('Klassenstufe:  z.B.  2K, 3K, OS, ...');
      gotoxy(40,16); write('ganze Schule:  z.B.  AL');
end;

procedure list_befragung;
var kl: str2;
    gs: char;
    i,zeile : integer;
begin mon_listentitel(1,1,'Klassenliste zur Befragung');
      klasse_geschlecht(1,6,kl,gs);
      clrscr;
      if printerflag then begin Monitor_Aus; am_drucken; Printer_Ein end;
      lst_listentitel('Klassenliste',kl,gs,' ',' ');
      code_angabe;
      writeln(lst);
      write(lst,'Kl Name Vorname          Jg  G Code':35);
      writeln(lst,'KS    SP    WU    LS   ':35);
      writeln(lst);
      zeile:=5;
      for i:=1 to anzs do
       begin with s[i] do
             begin if (klasse=kl) and (g=gs) then
                    begin write(lst,klasse:2,' ',name,' ');
                          write(lst,jahrg:4,' ',g,' ',spart:4);
                          writeln(lst,'|.....|.....|.....|.....|':35);
                          writeln(lst);
                          zeile:=zeile+1;
                          if zeile>24 then
                            begin Readln;
                                  zeile:=1;
                                  ClrScr;
                            end;
                    end;
             end;
       end;
      for i:=1 to 2 do
       begin write(lst,kl:2,' .....................................');
             writeln(lst,'|.....|.....|.....|.....|':30);
             writeln(lst);
       end;
      if printerflag
        then begin eject; Printer_Aus; Monitor_Ein end
        else taste
end;

procedure absenzenliste;
var i,j,sum : integer;
begin mon_listentitel(1,1,'Absenzenliste');
      clrscr;
      if printerflag then begin Monitor_Aus; am_drucken; Printer_Ein end;
      lst_listentitel('Absenzenliste',' ',' ',' ',' ');
      writeln(lst);
      writeln(lst,'Kl Name                  Jg  G     ':35);
      writeln(lst);
      for i:=1 to anzs do
       begin with s[i] do
             begin sum:=0;
                   for j:=1 to 4 do sum:=sum+l[j];
                   if (sum=-4) and (klasse<>'OS') then
                    begin write(lst,klasse:2,' ',name,' ');
                          write(lst,jahrg:4,' ',g,' ',' ':4);
                          writeln(lst,'.............................':35);
                          writeln(lst);
                    end;
             end;
       end;
      if printerflag
        then begin eject; Printer_Aus; Monitor_Ein end
        else taste
end;


procedure list_leistung_eintragen;
var kl: str2;
    gs,sart,dis: char;
    i,k : integer;
begin mon_listentitel(1,1,'Sportstag Klassenlisten');
      klasse_geschlecht(1,6,kl,gs);
      sportart_disziplin(1,8,sart,dis);
      clrscr;
      if printerflag then begin Monitor_Aus; am_drucken; Printer_Ein end;
      lst_listentitel('Klassenliste',kl,gs,sart,dis);
      k:=sportzahl(sart);
      writeln(lst);
      writeln(lst,'                              1.V.   2.V.   3.V   ':75);
      writeln(lst);
      for i:=1 to anzs do
       begin with s[i] do
             begin if (klasse=kl) and (g=gs) and (spart[k]=dis) then
                    begin writeln(lst,name:25,'|......|......|......|':50);
                          writeln(lst)
                    end;
             end;
       end;
      writeln(lst);writeln(lst);
      write(lst,'Unterschrift des Wettkampfrichters:');
      writeln(lst,'................................':42);
      if printerflag
        then begin eject; Printer_Aus; Monitor_Ein end
        else taste
end;


function ok(a,b:str2):boolean;
begin if a=b then ok:=true
             else if (b[2]='K') and (a[1]=b[1])
                then ok:=true
                else if b='AL' then ok:=true else ok:=false
end;

Function ListenDrucken(kl:str2;
                      gs:Char;
                      j1,j2:Integer;
                      sart,dis:Char;
                      lPruef:Boolean):Boolean;
Var EintragDa   : Boolean;
    i,k,rg,rang : integer;
    leist       : integer;
    liste       : tliste;
Begin if not lPruef then
         if printerflag then begin Monitor_Aus;
                                   am_drucken; Printer_Ein
                             end;

      k:=sportzahl(sart);
      sortieren(liste,k);
      rang:=1;rg:=1;leist:=0;
      EintragDa:=false;
      if not lpruef then lst_listentitel('Rangliste',kl,gs,sart,dis);
      for i:=1 to anzs do
       with s[liste[i]] do
        if ok(klasse,kl) and (g=gs) and (dis=spart[k]) and
           (j1<=jahrg) and (jahrg<=j2) and(l[k]>=0) then
          begin EintragDa:=EintragDa or true;
                if not lPruef then
                  begin if l[k]<>leist
                         then begin rg:=rang;
                                    write(lst,rg:3,'.  ',name:20,' ',klasse:2,'     ');
                              end
                         else write(lst,' ':3,'   ',name:20,' ',klasse:2,'     ');
                         leistung_out(wherex,wherey,sart,l[k]);
                         writeln(lst,pl[k]:7,' Pkt.');
                         rang:=rang+1;leist:=l[k];
                  end;
          end;
      
      if not lPruef then
        begin writeln(lst);
              if printerflag
                 then begin eject; Printer_Aus; Monitor_Ein end
                 else begin taste; Monitor_Aus; end;
        end;

      ListenDrucken:=EintragDa
end;

procedure Alle_Listen;
var kl : str2;
    gs : char;
    j1,j2 : integer;
    ok : Boolean;
begin mon_listentitel(1,1,'Alle Listen drucken');
      kl_eingabe;
      Klasse_Geschlecht(1,6,kl,gs);
      jahrgang(1,10,j1,j2);
      clrscr;
      if ListenDrucken(kl,gs,j1,j2,'K','6',true)
             then ok:=ListenDrucken(kl,gs,j1,j2,'K','6',false);
      if ListenDrucken(kl,gs,j1,j2,'K','8',true)
             then ok:=ListenDrucken(kl,gs,j1,j2,'K','8',false);
      if ListenDrucken(kl,gs,j1,j2,'K','1',true)
             then ok:=ListenDrucken(kl,gs,j1,j2,'K','1',false);
      if ListenDrucken(kl,gs,j1,j2,'S','H',true)
             then ok:=ListenDrucken(kl,gs,j1,j2,'S','H',false);
      if ListenDrucken(kl,gs,j1,j2,'S','W',true)
             then ok:=ListenDrucken(kl,gs,j1,j2,'S','W',false);
      if ListenDrucken(kl,gs,j1,j2,'W','B',true)
             then ok:=ListenDrucken(kl,gs,j1,j2,'W','B',false);
      if ListenDrucken(kl,gs,j1,j2,'W','S',true)
             then ok:=ListenDrucken(kl,gs,j1,j2,'W','S',false);
      if ListenDrucken(kl,gs,j1,j2,'W','3',true)
             then ok:=ListenDrucken(kl,gs,j1,j2,'W','3',false);
      if ListenDrucken(kl,gs,j1,j2,'W','5',true)
             then ok:=ListenDrucken(kl,gs,j1,j2,'W','5',false);
      if ListenDrucken(kl,gs,j1,j2,'W','J',true)
             then ok:=ListenDrucken(kl,gs,j1,j2,'W','J',false);
      if ListenDrucken(kl,gs,j1,j2,'L','8',true)
             then ok:=ListenDrucken(kl,gs,j1,j2,'L','8',false);
      if ListenDrucken(kl,gs,j1,j2,'L','1',true)
             then ok:=ListenDrucken(kl,gs,j1,j2,'L','1',false);
      if ListenDrucken(kl,gs,j1,j2,'L','2',true)
             then ok:=ListenDrucken(kl,gs,j1,j2,'L','2',false);
      ClrScr;
End;

procedure einzel_rangliste;
var kl         : str2;
    gs,sart,dis: char;
    i,k,rg,rang: integer;
    j1,j2,leist: integer;
    liste      : tliste;
begin mon_listentitel(1,1,'Einzel Rangliste');
      kl_eingabe;
      klasse_geschlecht(1,6,kl,gs);
      sportart_disziplin(1,8,sart,dis);
      jahrgang(1,10,j1,j2);
      clrscr;
      if printerflag then begin Monitor_Aus; am_drucken; Printer_Ein end;
      lst_listentitel('Rangliste',kl,gs,sart,dis);
      k:=sportzahl(sart);
      sortieren(liste,k);
      rang:=1;rg:=1;leist:=0;
      for i:=1 to anzs do
       with s[liste[i]] do
        if ok(klasse,kl) and (g=gs) and (dis=spart[k]) and
           (j1<=jahrg) and (jahrg<=j2) and(l[k]>=0) then
          begin if l[k]<>leist
                 then
                  begin rg:=rang;
                        write(lst,rg:3,'.  ',name:20,' ',klasse:2,'     ');
                  end
                 else   write(lst,' ':3,'   ',name:20,' ',klasse:2,'     ');
                leistung_out(wherex,wherey,sart,l[k]);
                writeln(lst,pl[k]:7,' Pkt.');
                rang:=rang+1;leist:=l[k];
          end;
      writeln(lst);
      if printerflag
        then begin eject; Printer_Aus; Monitor_Ein end
        else taste
end;

procedure jahrgangsliste;
var kl         : str2;
    gs         : char;
    i,j1,j2    : integer;
begin mon_listentitel(1,1,'Schlerinnen- uns Schlerliste mit Jahrgang');
      kl_eingabe;
      klasse_geschlecht(1,6,kl,gs);
      jahrgang(1,10,j1,j2);
      clrscr;
      if printerflag then begin Monitor_Aus; am_drucken; Printer_Ein end;
      lst_listentitel('Jahrgangsliste',kl,gs,' ',' ');
      for i:=1 to anzs do
       with s[i] do
        if ok(klasse,kl) and (g=gs) then
          begin writeln(lst,' ':3,'   ',name:20,' ',klasse:2,'     ',Jahrg:4);
          end;
      writeln(lst);
      if printerflag
        then begin eject; Printer_Aus; Monitor_Ein end
        else taste
end;



procedure klassen_sortieren(anfang,ende:integer;geschlecht:char);
var i,j:integer;
    sortiert:boolean;

 function vorher(i,j:integer):boolean;
 begin vorher:=false;
       if geschlecht='M' then begin if k[i].mitm>k[j].mitm then vorher:=true
                              end;
       if geschlecht='B' then begin if k[i].mitb>k[j].mitb then vorher:=true
                              end;
 end;

procedure tauschen(var m1,m2:klasse);
 var m:klasse;
 begin m:=m1; m1:=m2; m2:=m end;

 begin j:=ende;
      repeat sortiert:=true;
             j:=j-1;
             for i:=anfang to j do
              if vorher(i+1,i) then
                begin tauschen(k[i+1],k[i]);
                      sortiert:=false
                end
      until sortiert;
 end;


procedure klassen_rangliste;
var stufe,geschlecht:char;
    i,anfang,ende,rang,mittel:integer;
begin mon_listentitel(1,1,'Rangliste Klassen');
      gotoxy(1,10);write('Geschlecht : ');
      geschlecht:=readchar(['m','M','b','B']);
      geschlecht:=upcase(geschlecht);
      clrscr;
      if printerflag then begin Monitor_Aus; am_drucken; Printer_Ein end;
      lst_listentitel('Klassenranglisten  ',' ',geschlecht,' ',' ');
      writeln(lst);
      stufe:='_';
      i:=0;
      while (i<=anzk) and (ende<anzk) do
       begin repeat i:=i+1 until (k[i].name[1]<>stufe) or (i>anzk);
             anfang:=i;stufe:=k[i].name[1];
             repeat i:=i+1 until (k[i].name[1]<>stufe) or (i>anzk);
             ende:=i-1;
             if anfang<=anzk then klassen_sortieren(anfang,ende,geschlecht);
             rang:=0;
             for i:=anfang to ende do
              begin rang:=rang+1;
                    if geschlecht='M' then mittel:=k[i].mitm;
                    if geschlecht='B' then mittel:=k[i].mitb;
                    if mittel>0 then
                     begin write(lst,' ':10,rang:2,'.   ');
                           write(lst,k[i].name:2);
                           write(lst,mittel:10);
                           writeln(lst,' Pkt.');
                     end;
              end;
             writeln(lst);
       end;
      if printerflag
        then begin eject; Printer_Aus; Monitor_Ein end
        else taste
end;

procedure klassenliste;
var i,j : integer;
begin mon_listentitel(1,1,'Klassenliste (unsortiert)');
      clrscr;
      if printerflag then begin Monitor_Aus; am_drucken; Printer_Ein end;
      lst_listentitel('Klassenliste (unsortiert)',' ',' ',' ',' ');
      write(lst,'Kl':4,' M: ':10,'K':5,'S':5,'W':5,'L':5,'Mit':5);
      writeln(lst,' B: ':10,'K':5,'S':5,'W':5,'L':5,'Mit':5);
      writeln(lst);
      for i:=1 to anzk do
       with k[i] do
        begin write(lst,name:4,' ':10);
              for j:=1 to 4 do write(lst,sm[j]:5);
              write(lst,' ':15);
              for j:=1 to 4 do write(lst,sb[j]:5);
              writeln(lst);
              write(lst,' ':14);
              for j:=1 to 4 do write(lst,am[j]:5);
              write(lst,' ':15);
              for j:=1 to 4 do write(lst,ab[j]:5);
              writeln(lst);
              write(lst,' ':14);
              for j:=1 to 4 do write(lst,dm[j]:5);
              write(lst,mitm:5,' ':10);
              for j:=1 to 4 do write(lst,db[j]:5);
              writeln(lst,mitb:5); writeln(lst);
        end;
      if printerflag
        then begin eject; Printer_Aus; Monitor_Ein end
        else taste
end;

procedure menue_listen;
begin anzeige_printerstatus;
end;

procedure listen_menu(VAR w : Integer);
var menu  : rahmen;
begin
     Menu.Init(40,10,76,21,'LISTEN.MEN',blue,red,white,true);
     Menu.Draw(blue);
     w:=Menu.Lightbar(lightgray, black, 1);
     Menu.Cancel('°',blue);
end;

procedure listen_schreiben;
begin repeat titelzeile;
             MenuTitel('Menu Listen');
             menue_listen;
             listen_menu(Wahlint);
             case wahlint of
                  1 : list_befragung;
                  2 : list_leistung_eintragen;
                  3 : einzel_rangliste;
                  4 : klassen_rangliste;
                  5 : Alle_listen;
                  6 : klassenliste;
                  7 : absenzenliste;
                  8 : jahrgangsliste;
                  9 : printerflag:=not printerflag;
             end;
             if Wahlint in[1..8] then Hintergrund_mit_Titel;
      until (wahlInt=10) or (wahlint=0);
      Grund.Rebuild(4,19,26,22,blue);
end;



