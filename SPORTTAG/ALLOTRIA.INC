{

  Modul ALLOTRIA       geh”rt zum Sportstagsprogramm SPORTDAY.PAS

}

type time_min = record min,sec:integer end;
     time_sec = record sec,hsec:integer end;
     strecke  = record m,cm:integer end;
     buchstabenmenge = set of char;

function readchar(menge: buchstabenmenge):char;
var x,y:integer;
    c:char;
begin x:=wherex; y:=wherey;
      repeat gotoxy(x,y); c:=readkey;
             if c<>#27 then write(c)
      until c in menge;
      readchar:=c
end;

procedure Fenster_mit_Schatten(x0,y0,x1,y1,hintergrund,schatten:integer);
const Fill=#219; Blank=#32;
var i,j:integer;
begin TextColor(schatten);
      for i:=y0+1 to y1+1 do begin GotoXY(x1+1,i);write(Fill) end;
      for j:=x0+2 to x1+1 do begin GotoXY(j,y1+1);Write(Fill) end;
      TextBackground(hintergrund);
      for i:=y0 to y1 do
        for j:=x0 to x1 do begin GotoXY(j,i);Write(Blank) end;
end;

Procedure Titelzeile;
Begin
     Write('');
End;

procedure Hintergrund_mit_Titel;

begin Grund.Init(1,1,80,25,'°');
      Grund.draw(blue);
      write(' Dies Gymnasticus 2.0');
      GotoXY(3,25);write('Copyright Basel 1993  All Rights reserved');
end;

procedure titel(t:string);
begin TextBackground(cyan);
      TextColor(black);
      GotoXY(1,1);ClrEol;Write(t);
      TextBackground(Hintergrundfarbe);
      TextColor(Schriftfarbe);
end;

procedure MenuTitel(t:string);
const Fill=#219; Blank=#32;
var i,Min:integer;
begin Fenster_mit_Schatten(16,4,76,6,blue,black);
      TextBackground(blue);
      TextColor(white);
      GotoXY(30,5);Write(t);
end;

procedure am_drucken;
begin TextBackground(red);
      TextColor(White);
      GotoXY(45,24);Write('Am Drucken. Bitte warten!');
      GotoXY(45,24);
      TextBackground(Hintergrundfarbe);
      TextColor(Schriftfarbe);
end;

procedure taste;
var t:char;
begin gotoXY(55,25);
      write('  < DrЃcke eine Taste >  ');
      repeat until keypressed;
      t:=ReadKey
end;

procedure eject;
begin if printerflag then writeln(lst,chr(12))
end;

procedure anzeige_printerstatus;
begin if printerflag
        then begin Fenster_mit_Schatten(4,19,25,21,red,black);
                   gotoxy(5,20);
                   TextBackground(red);
                   TextColor(black);
                   write(' Ausgabe auf Printer')
             end
        else begin Fenster_mit_Schatten(4,19,25,21,red,black);
                   gotoxy(5,20);
                   TextBackground(red);
                   TextColor(black);
                   write('Ausgabe auf Terminal')
             end;
      TextBackground(Hintergrundfarbe);
      TextColor(Schriftfarbe);
      GotoXY(1,25);
end;


procedure Printer_Ein;
begin Assign(lst,'LPT1');Rewrite(lst);
end;

procedure Printer_Aus;
begin Close(lst)
end;

procedure Monitor_Ein;
begin Assign(lst,'CON');Rewrite(lst);
end;

procedure Monitor_Aus;
begin Close(lst)
end;

procedure mon_listentitel(x,y:integer;titel:str60);
var i:integer;
begin ClrScr;
      TextBackground(cyan);
      TextColor(black);
      GotoXY(x,y);ClrEol;Write(titel);
      TextBackground(Hintergrundfarbe);
      TextColor(Schriftfarbe);
      anzeige_printerstatus;
end;

procedure lst_listentitel(titel:str60;kl:str2;gs,sart,dis:char);
var i:integer;
begin if printerflag then Printer_Ein
                     else Monitor_Ein;
      if (Kl='AL') or (Kl='al') or (Kl='Al') then Write(lst,titel,'  Alle Klassen')
                                             else write(lst,titel,'  ',kl);
      case gs of
       'M' : write(lst,'   M„dchen');
       'B' : write(lst,'   Knaben');
       'U' : write(lst,' ');
      end;
      case sart of
       'K' : case dis of
              '6' : write(lst,'   60 m Lauf');
              '8' : write(lst,'   80 m Lauf');
              '1' : write(lst,'   100 m Lauf')
             end;
       'S' : case dis of
              'H' : write(lst,'   Hochsprung');
              'W' : write(lst,'   Weitsprung')
             end;
       'W' : case dis of
              'B' : write(lst,'   Ballwurf');
              'S' : write(lst,'   Schleuderball');
              '3' : write(lst,'   Kugel 3kg');
              '5' : write(lst,'   Kugel 5kg');
              'J' : write(lst,'   Speer')
             end;
       'L' : case dis of
              '8' : write(lst,'    800 m Lauf');
              '1' : write(lst,'   1000 m Lauf');
              '2' : write(lst,'   1200 m Lauf')
             end;
      end;
      writeln(lst);
      for i:=1 to 78 do write(lst,'_');
      writeln(lst); writeln(lst);
end;



procedure klasse_geschlecht(x,y:integer;var kl:str2; var gs:char);
begin gotoxy(x,y);
      write('Welche Klasse      ===> ');readln(kl);
      kl[1]:=upcase(kl[1]); kl[2]:=upcase(kl[2]);
      gotoxy(x,y+1); write('Geschlecht (m,b,u) ===> ');
      gs:=readchar(['m','M','b','B','u','U',#27]); gs:=upcase(gs)
end;

procedure sportart_disziplin(x,y:integer;var sart,dis:char);
begin gotoxy(x,y);
      write('Sportart (K,S,W,L)     ===> ');
      sart:=readchar(['k','K','s','S','w','W','l','L',#27]); sart:=upcase(sart);
      gotoxy(x,y+1);write('Disziplin ');
      case sart of
       'K': begin write('(6,8,1)      ===>');
                  dis:=readchar(['6','8','1',#27])
            end;
       'S': begin write('(H,W)        ===>');
                  dis:=readchar(['h','H','w','W',#27])
            end;
       'W': begin write('(B,S,3,5,J)  ===>');
                  dis:=readchar(['b','B','s','S','3','5','j','J',#27])
                  end;
       'L': begin write('(8,1,2 )     ===>');
                  dis:=readchar(['8','1','2',#27])
            end
      end;
      dis:=upcase(dis);
end;


function zahl(z:char;n:integer):boolean;
const c=48;
var   i:integer;
begin i:=ord(z)-c;
      if ((i>=0) and (i<=n)) or (z='-') then zahl:=true else zahl:=false
end;

procedure jahrgang(x,y:integer;var j1,j2:integer);
const c = 48;
var a,b:char;
begin gotoxy(x,y);
      write('Jahrg„nge  von 19__ bis 19__');
      repeat gotoxy(x+17,y); a:=ReadKey; write(a) until zahl(a,9);
      repeat gotoxy(x+18,y); b:=ReadKey; write(b) until zahl(b,9);
      j1:=1900+10*(ord(a)-c)+ord(b)-c;
      repeat gotoxy(x+26,y); a:=ReadKey; write(a) until zahl(a,9);
      repeat gotoxy(x+27,y); b:=ReadKey; write(b) until zahl(b,9);
      j2:=1900+10*(ord(a)-c)+ord(b)-c;
end;


function time_in_min_sec(x,y:integer;f:boolean):integer;
const c = 48;
var t:time_min;
    a,b:char;
begin gotoxy(x,y);
      if f then write('__:__');
      repeat gotoxy(x  ,y); a:=ReadKey; write(a) until zahl(a,5);
      if a='-'
       then begin write('-:--');time_in_min_sec:=-1; end
       else
      begin
       repeat gotoxy(x+1,y); b:=ReadKey; write(b) until zahl(b,9);
       t.min:=10*(ord(a)-c)+ord(b)-c;
       repeat gotoxy(x+3,y); a:=ReadKey; write(a) until zahl(a,5);
       repeat gotoxy(x+4,y); b:=ReadKey; write(b) until zahl(b,9);
       t.sec:=10*(ord(a)-c)+ord(b)-c;
       time_in_min_sec:=60*t.min+t.sec;
      end;
end;

function time_in_sec_hsec(x,y:integer;f:boolean):integer;
const c = 48;
var t:time_sec;
    a,b:char;
begin gotoxy(x,y);
      if f then write('__,__');
      repeat gotoxy(x  ,y); a:=ReadKey; write(a) until zahl(a,5);
      if a='-'
       then begin write('-,--');time_in_sec_hsec:=-1; end
       else
      begin
       repeat gotoxy(x+1,y); b:=ReadKey; write(b) until zahl(b,9);
       t.sec:=10*(ord(a)-c)+ord(b)-c;
       repeat gotoxy(x+3,y); a:=ReadKey; write(a) until zahl(a,9);
       repeat gotoxy(x+4,y); b:=ReadKey; write(b) until zahl(b,9);
       t.hsec:=10*(ord(a)-c)+ord(b)-c;
       time_in_sec_hsec:=100*t.sec+t.hsec;
      end;
end;

function strecke_in(x,y:integer;f:boolean):integer;
const c = 48;
var s:strecke;
    a,b:char;
begin gotoxy(x,y);
      if f then write('__.__ ');
      repeat gotoxy(x  ,y); a:=ReadKey; write(a) until zahl(a,9);
      if a='-'
       then begin write('-.--');strecke_in:=-1; end
       else
      begin
       repeat gotoxy(x+1,y); b:=ReadKey; write(b) until zahl(b,9);
       s.m:=10*(ord(a)-c)+ord(b)-c;
       repeat gotoxy(x+3,y); a:=ReadKey; write(a) until zahl(a,9);
       repeat gotoxy(x+4,y); b:=ReadKey; write(b) until zahl(b,9);
       s.cm:=10*(ord(a)-c)+ord(b)-c;
       strecke_in:=100*s.m+s.cm;
      end;
end;

function leistung_in(x,y:integer;sart:char;f:boolean):integer;
var l:integer;
begin case sart of
       'K' : l:=time_in_sec_hsec(x,y,f);
       'S' : l:=strecke_in(x,y,f);
       'W' : l:=strecke_in(x,y,f);
       'L' : l:=time_in_min_sec(x,y,f)
      end;
      leistung_in:=l
end;

procedure time_out_min_sec(x,y,time:integer);
var t:time_min;
begin gotoxy(x,y);
      if time=-1
       then write(lst,'--:-- Min.')
       else
        begin t.min:=time div 60;
              t.sec:=time mod 60;
              write(lst,t.min:2,':',t.sec div 10,t.sec mod 10,' Min.');
        end;
end;

procedure time_out_sec_hsec(x,y,time:integer);
var t:time_sec;
begin gotoxy(x,y);
      if time=-1
       then write(lst,'--,-- s')
       else
        begin t.sec:=time div 100;
              t.hsec:=time mod 100;
              write(lst,t.sec:2,',',t.hsec div 10,t.hsec mod 10,' s');
        end;
end;

procedure strecke_out(x,y,str:integer);
var st:strecke;
begin gotoxy(x,y);
      if str=-1
       then write(lst,'--.-- m')
       else
        begin st.m:=str div 100;
              st.cm:=str mod 100;
              write(lst,st.m:2,'.',st.cm div 10,st.cm mod 10,' m');
        end;
end;

procedure leistung_out(x,y:integer;sart:char;l:integer);
begin case sart of
       'K' : time_out_sec_hsec(x,y,l);
       'S' : strecke_out(x,y,l);
       'W' : strecke_out(x,y,l);
       'L' : time_out_min_sec(x,y,l)
      end;
end;



procedure Musik_und_Titel;
begin  TextBackground(green);
       ClrScr;
       TextColor(Blue);
       GotoXY(1,2);
       Write('             Sportstag-Verwaltung  programmiert vom Informatikkurs Wd 1987 HoG');
       TextColor(red);
       gotoxy(5,5);write(' ЫЫЫЫЫЫ');
       gotoxy(5,6);write('Ы');
       gotoxy(5,7);write(' ЫЫЫЫЫ ');
       gotoxy(5,8);write('      Ы');
       gotoxy(5,9);write('ЫЫЫЫЫЫ ');
       gotoxy(13,6);write('ЫЫЫЫЫЫ ');
       gotoxy(13,7);write('Ы     Ы');
       gotoxy(13,8);write('ЫЫЫЫЫЫ ');
       gotoxy(13,9);write('Ы      ');
       gotoxy(13,10);write('Ы      ');
       gotoxy(21,7);write(' ЫЫЫЫЫ ');
       gotoxy(21,8);write('Ы     Ы');
       gotoxy(21,9);write('Ы     Ы');
       gotoxy(21,10);write('Ы     Ы');
       gotoxy(21,11);write(' ЫЫЫЫЫ ');
       gotoxy(29,8);write('ЫЫЫЫЫЫ ');
       gotoxy(29,9);write('Ы     Ы');
       gotoxy(29,10);write('ЫЫЫЫЫЫ ');
       gotoxy(29,11);write('Ы  Ы   ');
       gotoxy(29,12);write('Ы   ЫЫ ');
       gotoxy(37,9);write('ЫЫЫЫЫЫЫ');
       gotoxy(37,10);write('   Ы   ');
       gotoxy(37,11);write('   Ы   ');
       gotoxy(37,12);write('   Ы   ');
       gotoxy(37,13);write('   Ы   ');
       gotoxy(45,10);write(' ЫЫЫЫЫЫ ');
       gotoxy(45,11);write('Ы       ');
       gotoxy(45,12);write(' ЫЫЫЫЫ ');
       gotoxy(45,13);write('      Ы');
       gotoxy(45,14);write('ЫЫЫЫЫЫ ');
       gotoxy(53,11);write('ЫЫЫЫЫЫЫ');
       gotoxy(53,12);write('   Ы   ');
       gotoxy(53,13);write('   Ы   ');
       gotoxy(53,14);write('   Ы   ');
       gotoxy(53,15);write('   Ы   ');
       gotoxy(61,12);write(' ЫЫЫЫЫ ');
       gotoxy(61,13);write('Ы     Ы');
       gotoxy(61,14);write('ЫЫЫЫЫЫЫ');
       gotoxy(61,15);write('Ы     Ы');
       gotoxy(61,16);write('Ы     Ы');
       gotoxy(69,13);write(' ЫЫЫЫЫ ');
       gotoxy(69,14);write('Ы     Я');
       gotoxy(69,15);write('Ы  ЫЫЫЫ');
       gotoxy(69,16);write('Ы     Ы');
       gotoxy(69,17);write(' ЫЫЫЫЫ ');
       TextColor(blue);
       gotoxy( 6,19);write('Ы     Ы    ЫЫЫЫЫ     ЫЫЫЫЫ     ');
       gotoxy( 6,20);write('Ы     Ы   Ы     Ы   Ы     Я    ');
       gotoxy( 6,21);write('ЫЫЫЫЫЫЫ   Ы     Ы   Ы  ЫЫЫЫ    ');
       gotoxy( 6,22);write('Ы     Ы   Ы     Ы   Ы     Ы       H O L B E I N - G Y M N A S I U M');
       gotoxy( 6,23);write('Ы     Ы    ЫЫЫЫЫ     ЫЫЫЫЫ                                B A S E L');
       TextColor(green);
       gotoXY(79,25);repeat until keypressed;
       TextBackGround(Hintergrundfarbe);
       TextColor(Schriftfarbe);
end;



