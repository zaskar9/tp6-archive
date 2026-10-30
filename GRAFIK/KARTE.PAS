PROGRAM Ausgabe;
USES CRT, GRAPH, WRITING;

VAR Name, Adresse, Ort, Tel                       : STRING;
    Grafiktreiber, Grafikmodus, GRFehler          : INTEGER;
    Pfad                                          : STRING[10];
    Wert                                          : BOOLEAN;

{FUNCTION ReadChar(VAR Letter : CHAR) : INTEGER;

         VAR SpecialKey : BOOLEAN;

         BEGIN
              SpecialKey:=False;
              IF Letter = #0 THEN BEGIN
                                   SpecialKey:=TRUE;
                              END;
              READCHAR:=ORD(Letter);
         END;

FUNCTION ReadStringXY(x, y : INTEGER; Text : STRING):STRING;

         VAR a, b, c, d, I, Z          : INTEGER;
             Sign, Letter              : CHAR;
             Output, Tale              : STRING;
             ScanCode, Index, Laenge   : INTEGER;

          BEGIN
               ReadStringXY:='';
               Output:='';
               I:=0;
               OutTextXY(x,y,Text);
               c:=TextWidth(Text);
               d:=TextHeight(Text);
               a:=c+x;
               b:=y;
               SetColor(white);
               Repeat
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
               (*Eingabe entfernen*)
               Laenge:=Length(Output);
               Delete(Output,Laenge,1);
               ReadStringXY:=Output;
          END;}
BEGIN
   ClrScr;
   Pfad:='C:\TP\BGI';
   Grafiktreiber:=detect;
   InitGraph(Grafiktreiber,Grafikmodus,Pfad);
   GRFehler:=Graphresult;
   IF GRFehler <> 0 THEN Halt;
   SetTextStyle(1,0,5);
   ReadStringXY(00,10,'Name   : ',Name);
   ReadStringXY(00,070,'Strasse  : ',Adresse);
   ReadStringXY(00,130,'PLZ/Ort : ',Ort);
   ReadStringXY(00,190,'Telephon: ',Tel);
   DELAY(5000);
   ClearDevice;
   Rectangle(5,5,634,474);
   SetTextJustify(1,1);
   OutTextXY(320,70,Name);
   OutTextXY(320,130,Adresse);
   OutTextXY(320,190,Ort);
   OutTextXY(320,250,Tel);
   Repeat Until Keypressed;
   CloseGraph;
END.
