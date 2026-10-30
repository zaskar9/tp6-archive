PROGRAM Test;
USES CRT,GRAPH;

VAR Graphiktreiber, Graphikmodus, GRFehler : INTEGER;
    Pfad                                   : STRING;
    Zahl,Zeichen                           : STRING;
    Ziffer,Code                            : INTEGER;
    Taste                                  : CHAR;
    Resultat, Eingabe                      : STRING;

FUNCTION ReadChar(VAR Letter : CHAR) : INTEGER;

         VAR SpecialKey : BOOLEAN;

         BEGIN
              SpecialKey:=False;
              IF Letter = #0 THEN BEGIN
                                   SpecialKey:=TRUE;
                              END;
              ReadChar:=ORD(Letter);
         END;

PROCEDURE ReadStringXY(x, y : INTEGER; Text : STRING; VAR Out : STRING);

         VAR a, b, c, d, I, Zeichen : INTEGER;
             Sign, Letter           : CHAR;
             Tale,Output            : STRING;
             ScanCode, Index, Laenge: INTEGER;

          BEGIN
               Output:='';
               Tale:='';
               I:=0;
               OutTextXY(x,y,Text);
               c:=TextWidth(Text);
               d:=TextHeight(Text);
               a:=c+x;
               b:=y;
               SetColor(white);
               Repeat
                     WHILE (Not Keypressed) And (ScanCode<>13) DO
                           BEGIN
                                OutTextXY(a,b,'_');
                                IF (Not Keypressed) And (ScanCode<>13)  THEN
                                BEGIN
                                     Delay(500);
                                     Setcolor(black);
                                     OutTextXY(a,b,'_');
                                END;
                                IF (Not Keypressed) And (ScanCode<>13)  THEN
                                BEGIN
                                     Delay(500);
                                     SetColor(white);
                                END;
                           END;
                     Sign:=ReadKey;
                     ScanCode:=ReadChar(Sign);
                     IF ScanCode=8 THEN BEGIN
                                             Index:=Length(Output);
                                             IF Index>=0 THEN BEGIN
                                                                  Tale:=Copy(Output,Index,1);
                                                                  Delete(Output,Index,1);
                                                                  SetColor(Black);
                                                                  a:=a-TextWidth(Tale);
                                                                  OutTextXY(a,b,Tale);
                                                             END;
                                        END
                                   ELSE BEGIN
                                             SetColor(white);
                                             OutTextXY(a,b,Sign);
                                             a:=a+TextWidth(Sign);
                                             Output:=Concat(Output,Sign);
                                        END;
               Until ScanCode=13;
               SetColor(black);
               OutTextXY(a-TextWidth(sign),b,Sign);
               (*Eingabe entfernen*)
               Laenge:=Length(Output);
               Delete(Output,Laenge,1);
               Out:=OutPut;
               SetColor(white);
          END;

BEGIN
   ClrScr;
   Pfad:='C:\TP\BGI';
   Graphiktreiber:=detect;
   InitGraph(Graphiktreiber,Graphikmodus,Pfad);
   GRFehler:=Graphresult;
   IF GRFehler <> 0 THEN Halt;
   SetTextStyle(1,0,0);
   Eingabe:='Ihre Eingabe: ';
   Resultat:='Das Ergebnis: ';
   ReadStringXY(100,100,'Zahl: ',Zahl);
   OutTextXY(100,200,Eingabe);OutTextXY(310+Length(Eingabe),200,Zahl);
   Val(Zahl,Ziffer,Code);
   Str(Ziffer*2,Zeichen);
   OutTextXY(100,300,Resultat);OutTextXY(310+Length(resultat),300,Zeichen);
   Taste:=ReadKey;
   CloseGraph;
END.
