{$A+,B-,D+,E+,F-,G-,I+,L+,N-,O-,R+,S+,V+,X-}
{$M 60000,0,655360}
program Sportstag;
{
  Programm zur Erstellung der Wettkampflisten, Ranglisten, ...
  Sporttag.

  UnterstÅtzt werden 4 Disziplinen
     Kurzstreckenlauf (60m, 80m, 100m)
     Sprung (Hoch, Weit)
     Wurf (Schleuderball, Ball, Speer, 3kg, 5kg)
     Langstreckenlauf (800m, 1000m, 1200m)

  Die Resultate werden nach Liste Sportschule Magglingen in Punkte
  umgerechnet.


  Version 2.0 (c) 1993 Informatikkurs 1 (Wd) Holbein-Gymnasium Basel

}
uses crt, printer, sportobj;

const max_schueler = 800;
      max_klassen  = 50;
      Hintergrundfarbe = LightGray;
      Schriftfarbe     = Black;

type filename = string[30];
     str4     = string[4];
     schueler = record klasse: string[2];
                       name  : string[20];
                       jahrg : integer;
                       g     : char;
                       spart : str4;
                       l     : array[1..4] of integer;
                       pl    : array[1..4] of integer;
                end;

     klasse   = record name  : string[2];
                       sm,sb : array[1..4] of integer;
                       am,ab : array[1..4] of integer;
                       dm,db : array[1..4] of integer;
                       mitm,mitb : integer;
                end;

     str2     = string[2];
     str60    = string[60];


var  wahl                    : char;
     Grund                   : Hintergrund;
     s                       : array[1..max_schueler] of schueler;
     k                       : array[1..max_klassen] of klasse;
     anzs,anzk,wahlint       : integer;
     printerflag             : boolean;
     pflag                   : boolean;
     lst                     : Text;
     




{$I allotria.inc}
{$I filehand.inc}
{$I listen.inc}
{$I resultat.inc}

procedure ausstieg;

begin
     TextColor(black);
     Fenster_mit_Schatten(9,19,43,21,magenta,black);
     gotoxy(10,20); write('Sind alle Files gesichert ? (J/N)');
     GotoXY(1,25);
     Write(chr(7));
end;

procedure hauptmenu(VAR Entscheidung : INTEGER);

VAR Menu                    : Rahmen;

begin MenuTitel('Hauptmenu');
      GotoXY(1,25);
      Menu.Init(35,10,70,15,'HAUPT.MEN',blue,red,white,true);
      Menu.Draw(blue);
      wahlInt:=Menu.Lightbar(lightgray,black,1);
      Entscheidung:=wahlInt;
      Menu.Cancel('∞',blue);
end;

begin
      printerflag:=false; {Monitor_Ein;}
      {Musik_und_Titel; wahl:=Readkey;}
      repeat
        HinterGrund_mit_Titel;
        repeat
               hauptmenu(wahlInt);
               case wahlInt of
               1 : file_handling;
               2 : eingabe_resultate;
               3 : listen_schreiben;
               end;
        until (wahlint=4);
        ausstieg;
        wahl:=upcase(readkey);
      until wahl='J';
      close(lst);
      TextBackground(Black);TextColor(white);Lowvideo;
      ClrScr;
end.



