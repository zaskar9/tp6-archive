{

Modul Eingabe_Resultate     SPORTSTAG-PROGRAMM      Version 2.0

}


function punkte_geben(sart,dis:char;leistung:integer):integer;
var v10,v90,vn : real;
    tg         : real;
    wert       : integer;
begin if leistung<0
      then wert:=-1
      else
      begin
      case sart of
       'K' : case dis of
              '6' : begin v10:=60/1090;
                          v90:=60/733.333;
                          if leistung<>0 then vn:=60/leistung else vn:=0
                    end;
              '8' : begin v10:=80/1400;
                          v90:=80/950;
                          if leistung<>0 then vn:=80/leistung else vn:=0
                    end;
              '1' : begin v10:=100/1740;
                          v90:=100/1200;
                          if leistung<>0 then vn:=100/leistung else vn:=0
                    end;
             end;
       'S' : case dis of
              'H' : begin v10:=sqrt(101.5);
                          v90:=sqrt(169);
                          vn:=sqrt(leistung)
                    end;
              'W' : begin v10:=sqrt(320);
                          v90:=sqrt(585);
                          vn:=sqrt(leistung)
                    end;
             end;
       'W' : case dis of
              'B' : begin v10:=sqrt(1645);
                          v90:=sqrt(5230);
                          vn:=sqrt(leistung)
                    end;
              'S' : begin v10:=sqrt(1400);
                          v90:=sqrt(3980);
                          vn:=sqrt(leistung)
                    end;
              '3' : begin v10:=sqrt(570);
                          v90:=sqrt(1380);
                          vn:=sqrt(leistung)
                    end;
              '5' : begin v10:=sqrt(519);
                          v90:=sqrt(1229);
                          vn:=sqrt(leistung)
                    end;
              'J' : begin v10:=sqrt(1250);
                          v90:=sqrt(4034);
                          vn:=sqrt(leistung)
                    end;
             end;
       'L' : case dis of
              '8' : begin v10:=800/244.3;
                          v90:=800/136.1;
                          if leistung<>0 then vn:=800/leistung else vn:=0
                    end;
              '1' : begin v10:=800/331.0;
                          v90:=800/182.33;
                          if leistung<>0 then vn:=800/leistung else vn:=0
                    end;
              '2' : begin v10:=800/423.2;
                          v90:=800/235.1;
                          if leistung<>0 then vn:=800/leistung else vn:=0
                    end;
             end;
      end;
      tg:=(v90-v10)/80;
      wert:=round( (vn-v10)/tg + 10 );
      if wert>100 then wert:=100
                  else if wert<0 then wert:=0;
      end;
      punkte_geben:=wert;
end;

procedure punkte_ermitteln;
var l,pkt:integer;
    sart,dis:char;
begin clrscr;
      Titel('Punkte verteilen:');
      sportart_disziplin(5,10,sart,dis);
      gotoxy(5,14);write('Leistung:');
      repeat l:=leistung_in(15,14,sart,true);
             pkt:=punkte_geben(sart,dis,l);
             gotoxy(5,16);ClrEol;write('Punkte: ',pkt);
             gotoxy(5,22);Write('Abbrechen mit <ESC>   ');taste;
             gotoXY(5,22);ClrEol;
      until readkey=#27
end;

procedure eingabe_der_leistungen;
var i,k,x,y:integer;
    kl:str2;
    gs,sart,dis:char;
begin clrscr;
      Titel('Eingabe der Leistung:');
      klasse_geschlecht(5,10,kl,gs);
      sportart_disziplin(5,12,sart,dis);
      clrscr;
      lst_listentitel('Klasse ',kl,gs,sart,dis);
      case sart of
       'K' : k:=1;
       'S' : k:=2;
       'W' : k:=3;
       'L' : k:=4
      end;
      x:=1;y:=6;
      for i:=1 to anzs do
       with s[i] do
        begin if (klasse=kl) and (g=gs) and (spart[k]=dis) then
               begin gotoxy(x,y);write(klasse:2,' ',name:20);
                     leistung_out(x+24,y,sart,l[k]);
                     l[k]:=leistung_in(x+24,y,sart,false);
                     y:=y+1; if y>22 then begin x:=40;y:=6 end
               end;
        end;
      taste;
end;

procedure korrektur_von_eingegebenen_leistungen;
var i,k,x,y:integer;
    kl:str2;name_schueler:string[20];
    gs,sart,dis:char;
begin clrscr;
      Titel('Korrektur der Eingabe der Leistung:');
      klasse_geschlecht(5,10,kl,gs);
      sportart_disziplin(5,12,sart,dis);
      case sart of
       'K' : k:=1;
       'S' : k:=2;
       'W' : k:=3;
       'L' : k:=4
      end;
      repeat clrscr;
             lst_listentitel('Klasse ',kl,gs,sart,dis);
             x:=1;y:=6;
             for i:=1 to anzs do
             with s[i] do
             begin if (klasse=kl) and (g=gs) and (spart[k]=dis) then
                    begin gotoxy(x,y);write(klasse:2,' ',name:20);
                          leistung_out(x+24,y,sart,l[k]);
                          y:=y+1; if y>20 then begin x:=40;y:=6 end
                    end;
             end;
             lowvideo;
             gotoxy(1,22);write('Welcher SchÅler ? ');read(name_schueler);
             normvideo;
             if name_schueler<>'' then
             for i:=1 to anzs do
             with s[i] do
             begin if (klasse=kl) and (g=gs) and (spart[k]=dis) and
                     (copy(name,1,length(name_schueler))=name_schueler) then
                    begin x:=1;y:=23;
                          gotoxy(x,y);write(klasse:2,' ',name:20);
                          leistung_out(x+24,y,sart,l[k]);
                          l[k]:=leistung_in(x+24,y,sart,false);
                    end;
             end;
      until name_schueler='';
      taste;
end;

function klassennummer(nam:str2):integer;
var i:integer;
begin i:=0;
      repeat i:=i+1
      until  (i=anzk+1) or (k[i].name=nam);
      klassennummer:=i
end;


procedure umrechnung_leistung_punktzahl;
var i,j,m: integer;
begin clrscr;
      Titel('Umrechnung der Leistungen in Punktzahlen:');
      for j:=1 to anzk do
        for m:=1 to 4 do
          begin k[j].sm[m]:=0; k[j].ab[m]:= 0;
                k[j].sb[m]:= 0; k[j].am[m]:= 0;
                k[j].dm[m]:= 0; k[j].db[m]:= 0;
          end;
      for i:=1 to anzs do
       with s[i] do
        begin gotoxy(70,1);write(i:3);
              pl[1]:=punkte_geben('K',spart[1],l[1]);
              pl[2]:=punkte_geben('S',spart[2],l[2]);
              pl[3]:=punkte_geben('W',spart[3],l[3]);
              pl[4]:=punkte_geben('L',spart[4],l[4]);
              j:=klassennummer(klasse);
              with k[j] do
               begin
                for m:=1 to 4 do
                 if pl[m]>=0 then
                       begin if g='M' then
                               begin sm[m]:=sm[m]+pl[m];
                                     am[m]:=am[m]+1;
                                     if am[m]>0 then
                                       dm[m]:=round(sm[m]/am[m])
                               end
                                      else
                               begin sb[m]:=sb[m]+pl[m];
                                     ab[m]:=ab[m]+1;
                                     if ab[m]>0 then
                                       db[m]:=round(sb[m]/ab[m])
                               end;
                       end;
               end;
        end;

      for i:=1 to anzk do
       with k[i] do
        begin mitm:=0; mitb:=0;
              for j:=1 to 4 do mitm:=mitm+dm[j]; mitm:=round(mitm/4);
              for j:=1 to 4 do mitb:=mitb+db[j]; mitb:=round(mitb/4);
        end;
      writeln;
end;

procedure menue_eingabe_resultate(VAR w : INTEGER);
var Menu : Rahmen;
begin MenuTitel('Menu Eingabe Resultate');
      GotoXY(1,25);
      Menu.Init(33,10,75,16,'EINGABE.MEN',blue,red,white,true);
      Menu.Draw(blue);
      w:=Menu.Lightbar(lightgray,black,1);
      Menu.Cancel('∞',blue);
end;

procedure eingabe_resultate;
begin repeat titelzeile;
             menue_eingabe_resultate(wahlint);
             case wahlint of
                  1 : eingabe_der_leistungen;
                  2 : korrektur_von_eingegebenen_leistungen;
                  3 : umrechnung_leistung_punktzahl;
                  4 : punkte_ermitteln;
             end;
             if wahlint in[1..4] then Hintergrund_mit_Titel;
      until (wahlint=5) or (wahlint=0);
end;



