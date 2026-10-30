UNIT WRITING;

INTERFACE
USES CRT,GRAPH;
FUNCTION ReadChar(VAR Letter : CHAR) : INTEGER;
PROCEDURE ReadStringXY(x, y : INTEGER; Text : STRING; VAR Out : STRING);

IMPLEMENTATION

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
END.