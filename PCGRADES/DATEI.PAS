{$A+,B-,D+,E+,F-,G-,I+,L+,N-,O-,R+,S+,V+,X-}
{$M 16384,0,655360}
PROGRAM Klasse;
USES CRT, DOS, PRINTER;

TYPE
    Class=RECORD
                Name                                 : STRING;
                Note                                 : ARRAY[1..8] OF REAL;
                Anzahl                               : INTEGER;
          END;
    Filemodus=(FOpen,FClose);
    Outmodus=(Prn,Scr);

VAR
   Datei                                             : FILE OF CLASS;
   Datensatz                                         : ARRAY[1..26] OF CLASS;
   Taste                                             : CHAR;
   Dateiname, ClassName                              : STRING;
   Status                                            : FILEMODUS;
   AnzDaten, AnzNoten                                : INTEGER;
   Aux                                               : OUTMODUS;
   Laenge                                            : Integer;
   Gespeichert                                       : Boolean;


{$I A:\BACKGROU.INC}  {1}
{$I A:\MACHRAHM.INC}  {2}
{$I A:\COPYRIGH.INC}  {3}
{$I A:\OUTPUTIN.INC}  {4}
{$I A:\HELP.INC    }  {5}
{$I A:\LOAD.INC    }  {6}
{$I A:\SAVE.INC    }  {7}
{$I A:\DATINPUT.INC}  {8}
{$I A:\DATOUTPU.INC}  {9}
{$I A:\DURCHSCH.INC} {10}
{$I A:\HINZUFUE.INC} {11}
{$I A:\ZEUGNIS.INC } {12}
{$I A:\DATSUCHE.INC} {13}
{$I A:\LOESCHEN.INC} {14}
{$I A:\AUSWAHL.INC } {15}
{$I A:\ENTSCHEI.INC} {16}


BEGIN
   ClrScr;
   Gespeichert:=false;
   Status:=FClose;
   Aux:=Scr;
   Copyright;
   dateiname:='';
   Repeat
          WahlVerarbeiten;
   Until Taste=#27;
   Delay(500);
   TextColor(7);
   TextBackGround(0);
   ClrScr;
END.







