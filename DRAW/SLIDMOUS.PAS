PROGRAM Sliding_Piece_Puzzle;   {nur mit Maus als Eingabe}

USES CRT,GRAPH,MOUSE;

CONST    X0=20; Y0=50;   Breite=70; Hoehe=140; Abstand=10;Distanz=Breite+Abstand;
         COL1=4; COL2=2; COL3=1; COL4=15; COL5=14;
         DEMO1:ARRAY[1..50] OF CHAR =
           ('6','6','o','7','7','o','5','1','2','6','7','l','3','4',
           '9','8','5','7','7','u','6','6','u','2','1','7','6','u',
           '1','2','3','4','5','6','6','r','7','7','r','1','2',
           '3','4','5','7','6','l','8','9','5');
         DEMO2:ARRAY[1..95] OF CHAR =
           ('6','6','o','7','7','o','5','1','2','7','7','o','5','4','3',
           '9','8','6','6','r','7','7','r','5','4','3','8','9','6','6','l',
           '9','8','6','6','u','7','7','u','9','8','6','6','o','3','4',
           '7','7','l','6','6','l','3','4', '6','6','l','3','4','8','9','5',
           '7','7','o','6','6','o','1','2','6','6','o','2','1','4','3','5',
           '7','7','r','6','6','r','1','2','4','3','5','7','7','l','9','8','5');

VAR  A                                    : ARRAY[-1..6,-1..7] OF INTEGER;
     Atxt                                 : ARRAY[-1..6,-1..7] of String[2];
     NrTxt                                : Array[1..9] of STRING[1];
     XO,XU,YO,YU                          : ARRAY[1..9] OF WORD;
     Piece,Piecealt,ZUG,Zugzahl           : INTEGER;
     Graphdriver,Graphmode                : INTEGER;
     ButtonStatus,HorizX,VertikY          : INTEGER;
     Zugtxt                               : STRING;
     Taste1                               : CHAR;
     Demonstration,Spielende,Geschafft    : BOOLEAN;
     Eingabe_okay,Eingabe                 : BOOLEAN;
     SPIEL1                               : BOOLEAN;

LABEL Anfang;

PROCEDURE  Maus_und_Graphikinitialisierung;
    VAR Status,AnzTasten :INTEGER;

       PROCEDURE SetCursorToKreuz;
         CONST
              Kreuz : GraphicCursor =
                     (screenMask: ($FC3F,$FC3F,$FC3F,$FC3F,$FC3F,$FC3F,
                                   0,0,0,0,$FC3F,$FC3F,$FC3F,$FC3F,$FC3F,$FC3F);
                      cursorMask: (0,384,384,384,384,384,384,
                                   $7E7E,$7E7E,384,384,384,384,384,384,0);
                      hotX: 8;
                      hotY: 8);
        BEGIN
        SetGraphiccursor(Kreuz);
        END;

   BEGIN
     Flagreset(Status,AnzTasten);
     IF Status = 0 THEN
                      BEGIN
                         ClrScr;
                         WRITELN('Keine Maus da !!!!!');
                         WRITELN('Programm beendet.');
                         Delay(5000);
                         HALT;
                       END;
  {  SETcursorToKreuz;}
    SetHorizontalLimits(0,639);
    SetVerticalLimits(0,479);

    Graphdriver:=detect;
    InitGraph(graphdriver, graphmode,'C:\tp\bgi');

  END;


  PROCEDURE Titelbild_und_Musik;
    VAR k,i,x1,x2,y1,y2,a,b            : INTEGER;
        s,inc,x,y,dd,p                 : REAL;
   BEGIN

      s:=getmaxy*0.6;
      i:=1; REPEAT
               SETCOLOR(2);
               LINE(i,TRUNC(s+0.5),i*5-getmaxx*25 DIV 16,getmaxy);
               i:=i+10;
           UNTIL i>=getmaxx;
      inc:=2; REPEAT
                 LINE(0,ROUND(s),getmaxx,ROUND(s));
                 s:=s+inc;inc:=inc*1.2;
              UNTIL s>getmaxy;
      a:=getmaxy div 5;b:=40;
      p:=PI/180;
      SETCOLOR(4);
      SETFILLSTYLE(0,0);
      FOR k:=1 TO 2 DO
          BEGIN
            IF k=2 THEN a:=-a;
            i:=0; REPEAT
                     x:=getmaxx/8+i*1.2;
                     y:=getmaxy*3/8+a*sin(p*i);
                     dd:=b*SIN(p*i/2);
                     x1:=ROUND(x+20+dd);  x2:=ROUND(x+20-dd);
                     SOUND(x1);DELAY(50);
                     y1:=ROUND(y+dd);y2:=ROUND(y-dd);
                     SOUND(y1);DELAY(50);
                     RECTANGLE(x1,y1,x2,y2);
                     BAR(x1-1,y1-1,x2+1,y2+1);
                     i:=i+4;
                  UNTIL i>360;
          END;
      SETCOLOR(15);
      SETTEXTSTYLE(1,0,2);
       OUTTEXTxy(0,0,'Michael Vowe presents:');
       OUTTEXTxy(300,0,'SLIDING PIECE PUZZLES');
       NOSOUND;

       REPEAT
           GetPosBut(ButtonStatus,HorizX,VertikY);
       UNTIL ButtonStatus=1;

       ClearDevice;
    END;


   PROCEDURE MENU1;
     BEGIN
      SETCOLOR(2);
      SETTEXTSTYLE(3,0,6);
        OUTTEXTxy(10,50,'SLIDING PIECE PUZZLES');
      SETTEXTSTYLE(0,0,2);
        OUTTEXTxy(0,150,'You are welcome!');
        OUTTEXTxy(0,180,'Du hast die Wahl zwischen zwei Puzzles.');
        OUTTEXTxy(0,230,'W„hle bitte aus !');

        OUTTEXTxy(0,270,'Puzzle 1 (leicht)');
        OUTTEXTxy(0,320,'Puzzle 2 (etwas schwieriger)');
        Rectangle(470,260,510,290);
        Rectangle(470,310,510,340);

        Setcolor(14);
      SETTEXTSTYLE(0,0,1);
        OUTTEXTxy(250,420,'Created by Michael Vowe, Therwil, Switzerland');

        SetCursorPos(480,270);
        Showcursor;
        REPEAT
           GetPosBut(ButtonStatus,HorizX,VertikY);
        UNTIL ButtonStatus=1;

        Spiel1:=TRUE;
        IF (VertikY >310) AND (VertikY <340) THEN SPIEL1:=FALSE;

        SetCursorPos(200,150);
        HideCursor;
        ClearDevice;
        Demonstration:=FALSE;
    END;

  PROCEDURE Ausgangsstellung;
   VAR   I,J                 :INTEGER;

   BEGIN
         Spielende:=FALSE; Geschafft:=FALSE;
         SETCOLOR(2);
         IF SPIEL1 THEN
                     Outtextxy(0,10,'Ein einfaches SLIDING PIECE PUZZLE')
                   ELSE
                     Outtextxy(0,10,'Ein nicht so einfaches SLIDING PIECE PUZZLE');
         Outtextxy(440,50,'Die Teile sind so zu');
         Outtextxy(440,70,'schieben, dass PIECE 5');

         IF Spiel1 THEN BEGIN
                          SetColor(14);
                          Outtextxy(440,90,'in die rechte obere');
                          END
                   ELSE BEGIN
                         SetColor(14);
                         Outtextxy(440,90,'in die rechte untere');
                        END;
         SetColor(2);
         Outtextxy(440,110,'Ecke kommt.');
         Outtextxy(440,130,'Jedes Teil wird mit dem');
         Outtextxy(440,150,'Mauszeiger und der linken');
         Outtextxy(440,170,'Taste angew„hlt und auto-');
         Outtextxy(440,190,'matisch verschoben.');
         Outtextxy(440,210,'Bei Zweideutigkeiten muss');
         Outtextxy(440,230,'die Maus entsprechend ver-');
         Outtextxy(440,250,'schoben werden.');
         Outtextxy(440,270,'Durch Drcken der rechten');
         Outtextxy(440,290,'Maus-Taste kann man vor-');
         Outtextxy(440,310,'zeitig aufgeben.');

         XO[1]:=X0;                      YO[1]:=Y0;
         XU[1]:=XO[1]+Breite;            YU[1]:=YO[1]+Hoehe+Abstand;
         XO[2]:=X0+Distanz;              YO[2]:=Y0;
         XU[2]:=XO[2]+Breite;            YU[2]:=YO[2]+Hoehe+Abstand;
         XO[3]:=X0+3*Distanz;            YO[3]:=Y0;
         XU[3]:=XO[3]+2*Breite+Abstand;  YU[3]:=YO[3]+Breite;
         XO[4]:=X0+3*Distanz;            YO[4]:=Y0+Distanz;
         XU[4]:=XO[4]+2*Breite+Abstand;  YU[4]:=YO[4]+Breite;
         XO[5]:=X0;                      YO[5]:=Y0+2*abstand+Hoehe;
         XU[5]:=XO[5]+2*Breite+Abstand;  YU[5]:=YO[5]+Hoehe+Abstand;
         XO[6]:=X0+2*Distanz;            YO[6]:=Y0+2*abstand+Hoehe;
         XU[6]:=XO[6]+Breite;            YU[6]:=YO[6]+Breite;
         XO[7]:=X0+2*Distanz;            YO[7]:=Y0+3*Distanz;
         XU[7]:=XO[7]+Breite;            YU[7]:=YO[7]+Breite;
         XO[8]:=X0+3*Distanz;            YO[8]:=Y0+2*abstand+Hoehe;
         XU[8]:=XO[8]+Breite;            YU[8]:=YO[8]+Abstand+Hoehe;
         XU[9]:=XO[9]+Breite;            YU[9]:=YO[9]+abstand + Hoehe;
         XO[9]:=X0+4*Distanz;            YO[9]:=Y0+2*Abstand+Hoehe;
         XU[9]:=XO[9]+Breite;            YU[9]:=YO[9]+abstand + Hoehe;

         IF NOT Spiel1 THEN BEGIN
              XO[8]:=X0+3*Distanz;            YO[8]:=Y0;
              XU[8]:=XO[8]+Breite;            YU[8]:=YO[8]+Abstand+Hoehe;
              XO[9]:=X0+4*Distanz;            YO[9]:=Y0;
              XU[9]:=XO[9]+Breite;            YU[9]:=YO[9]+abstand + Hoehe;
              XO[3]:=X0+3*Distanz;            YO[3]:=Y0+2*abstand+Hoehe;
              XU[3]:=XO[3]+2*Breite+Abstand;  YU[3]:=YO[3]+Breite;
              XO[4]:=X0+3*Distanz;            YO[4]:=Y0+3*Distanz;
              XU[4]:=XO[4]+2*Breite+Abstand;  YU[4]:=YO[4]+Breite;
                            END;
         SETFILLSTYLE(1,COL1);
           BAR(XO[1],YO[1],XU[1],YU[1]);
           BAR(XO[2],YO[2],XU[2],YU[2]);
         SETFILLSTYLE(1,COL2);
           BAR(XO[3],YO[3],XU[3],YU[3]);
           BAR(XO[4],YO[4],XU[4],YU[4]);
         SETFILLSTYLE(1,Col3);
           BAR(XO[5],YO[5],XU[5],YU[5]);
         SETFILLSTYLE(1,COL4);
           BAR(XO[6],YO[6],XU[6],YU[6]);
           BAR(XO[7],YO[7],XU[7],YU[7]);
         SETFILLSTYLE(1,Col5);
           BAR(XO[3],YO[8],XU[8],YU[8]);
           BAR(XO[9],YO[9],XU[9],YU[9]);
        SETCOLOR(7);
           RECTANGLE(X0-abstand,Y0-Abstand,X0+5*Distanz,Y0+4*Distanz);

        FOR I:=-1 TO 6 DO  FOR J:=-1 TO 7 DO A[I,J]:=-1;

        A[1,1]:=1; A[1,2]:=2; A[1,3]:=0; A[1,4]:=3; A[1,5]:=3;
        A[2,1]:=1; A[2,2]:=2; A[2,3]:=0; A[2,4]:=4; A[2,5]:=4;
        A[3,1]:=5; A[3,2]:=5; A[3,3]:=6; A[3,4]:=8; A[3,5]:=9;
        A[4,1]:=5; A[4,2]:=5; A[4,3]:=7; A[4,4]:=8; A[4,5]:=9;

        IF NOT SPIEL1 THEN BEGIN
                                A[1,4]:=8; A[1,5]:=9;
                                A[2,4]:=8; A[2,5]:=9;
                                A[3,4]:=3; A[3,5]:=3;
                                A[4,4]:=4; A[4,5]:=4;
                           END;

       SETCOLOR(13);
       SETTEXTSTYLE(0,0,2);
       FOR I:=1 TO 9 DO
                 BEGIN
                    STR(I,Nrtxt[I]);
                    OutTextxy(XO[I]+abstand,YO[I]+abstand,nrtxt[I]);
                 END;
      SETTEXTSTYLE(0,0,1);
      ZUG:=0;Zugzahl:=0;Piece:=1;
      IF Demonstration THEN
                           BEGIN
                             SETTEXTSTYLE(0,0,2);
                             OutTextxy(60,430,'DEMONSTRATION');
                             SETTEXTSTYLE(0,0,1);
                           END;
    Taste1:=#32;
    END;


   PROCEDURE Teil_wird_verschoben(NR,Richtung,Zeile,Spalte:INTEGER);
   VAR    COL :INTEGER;
    BEGIN
        IF (NR=1) OR (NR=2) THEN COL:=COL1;
        IF (NR=8) OR (NR=9) THEN COL:=COL5;
        IF (NR=3) OR (NR=4) THEN COL:=COL2;
        IF (NR=6) OR (NR=7) THEN COL:=COL4;
        IF NR=5             THEN COL:=COL3;

        SetFILLSTYLE(1,0);
        BAR(XO[NR],YO[NR],XU[NR],YU[NR]);

        If Richtung=1 THEN
            BEGIN
             IF (NR=1) OR (NR=2) OR (NR=8) OR (NR=9) THEN
                    BEGIN
                       A[Zeile,Spalte]:=0; A[Zeile,Spalte+1]:=NR;
                       A[Zeile+1,Spalte]:=0; A[Zeile+1,Spalte+1]:=NR;
                    END;

             IF (NR=3) OR (NR=4) THEN
                    BEGIN
                       A[Zeile,Spalte]:=0; A[Zeile,Spalte+2]:=NR;
                       A[Zeile,Spalte+1]:=0; A[Zeile,Spalte+3]:=NR;
                    END;

             IF NR=5  THEN
                    BEGIN
                       A[Zeile,Spalte]:=0; A[Zeile,Spalte+2]:=NR;
                       A[Zeile+1,Spalte]:=0; A[Zeile+1,Spalte+2]:=NR;
                    END;

            IF (NR=6) OR (NR=7)  THEN
                   BEGIN
                      A[Zeile,Spalte]:=0; A[Zeile,Spalte+1]:=NR;
                   END;

            XO[NR]:=XO[NR]+Distanz; XU[NR]:=XU[NR]+Distanz;
            IF (NR=3) OR (NR=4) THEN
                   BEGIN
                      XO[NR]:=XO[NR]+Distanz;  XU[NR]:=XU[NR]+Distanz;
                   END;
           END;

       If Richtung=2 THEN
           BEGIN
              IF (NR=1) OR (NR=2) OR (NR=8) OR (NR=9) THEN
                    BEGIN
                       A[Zeile,Spalte]:=0; A[Zeile,Spalte-1]:=NR;
                       A[Zeile+1,Spalte]:=0; A[Zeile+1,Spalte-1]:=NR;
                    END;

             IF (NR=3) OR (NR=4) THEN
                    BEGIN
                       A[Zeile,Spalte]:=0; A[Zeile,Spalte-1]:=NR;
                       A[Zeile,Spalte+1]:=0; A[Zeile,Spalte-2]:=NR;
                    END;

             IF NR=5  THEN
                   BEGIN
                      A[Zeile,Spalte+1]:=0; A[Zeile,Spalte-1]:=NR;
                      A[Zeile+1,Spalte+1]:=0; A[Zeile+1,Spalte-1]:=NR;
                   END;

             IF (NR=6) OR (NR=7)  THEN
                    BEGIN
                       A[Zeile,Spalte]:=0; A[Zeile,Spalte-1]:=NR;
                    END;

             XO[NR]:=XO[NR]-Distanz;     XU[NR]:=XU[NR]-Distanz;
             IF (NR=3) OR (NR=4) THEN
                   BEGIN
                      XO[NR]:=XO[NR]-Distanz;  XU[NR]:=XU[NR]-Distanz;
                   END;
           END;

        If Richtung=3 THEN
           BEGIN
              IF (NR=1) OR (NR=2) OR (NR=8) OR (NR=9) THEN
                     BEGIN
                        A[Zeile,Spalte]:=0; A[Zeile-2,Spalte]:=NR;
                        A[Zeile+1,Spalte]:=0; A[Zeile-1,Spalte]:=NR;
                     END;

              IF (NR=3) OR (NR=4) THEN
                     BEGIN
                        A[Zeile,Spalte]:=0; A[Zeile-1,Spalte]:=NR;
                        A[Zeile,Spalte+1]:=0; A[Zeile-1,Spalte+1]:=NR;
                     END;

              IF NR=5  THEN
                    BEGIN
                       A[Zeile+1,Spalte]:=0; A[Zeile-1,Spalte]:=NR;
                       A[Zeile+1,Spalte+1]:=0; A[Zeile-1,Spalte+1]:=NR;
                    END;

              IF (NR=6) OR (NR=7)  THEN
                    BEGIN
                       A[Zeile,Spalte]:=0; A[Zeile-1,Spalte]:=NR;
                    END;

              YO[NR]:=YO[NR]-Distanz;   YU[NR]:=YU[NR]-Distanz;
              IF (NR=1) OR (NR=2) OR (NR=8) OR (NR=9) THEN
                     BEGIN
                        YO[NR]:=YO[NR]-Distanz;  YU[NR]:=YU[NR]-Distanz;
                     END;
            END;

        If Richtung=4 THEN
            BEGIN
               IF (NR=1) OR (NR=2) OR (NR=8) OR (NR=9) THEN
                     BEGIN
                        A[Zeile,Spalte]:=0; A[Zeile+2,Spalte]:=NR;
                        A[Zeile+1,Spalte]:=0; A[Zeile+3,Spalte]:=NR;
                     END;

               IF (NR=3) OR (NR=4) THEN
                     BEGIN
                        A[Zeile,Spalte]:=0; A[Zeile+1,Spalte]:=NR;
                        A[Zeile,Spalte+1]:=0; A[Zeile+1,Spalte+1]:=NR;
                     END;

              IF NR=5  THEN
                    BEGIN
                       A[Zeile,Spalte]:=0; A[Zeile+2,Spalte]:=NR;
                       A[Zeile,Spalte+1]:=0; A[Zeile+2,Spalte+1]:=NR;
                    END;

              IF (NR=6) OR (NR=7)  THEN
                    BEGIN
                       A[Zeile,Spalte]:=0; A[Zeile+1,Spalte]:=NR;
                    END;

               YO[NR]:=YO[NR]+Distanz;  YU[NR]:=YU[NR]+Distanz;
               IF (NR=1) OR (NR=2) OR (NR=8) OR (NR=9) THEN
                      BEGIN
                         YO[NR]:=YO[NR]+Distanz;  YU[NR]:=YU[NR]+Distanz;
                      END;
             END;

         If Richtung=5 THEN
             BEGIN
                IF (NR=3) OR (NR=4) THEN
                      BEGIN
                         A[Zeile,Spalte]:=0; A[Zeile,Spalte+2]:=NR;
                      END;
                XO[NR]:=XO[NR]+Distanz;   XU[NR]:=XU[NR]+Distanz;
             END;

         If Richtung=6 THEN
               BEGIN
                  IF (NR=3) OR (NR=4) THEN
                        BEGIN
                           A[Zeile,Spalte+1]:=0; A[Zeile,Spalte-1]:=NR;
                        END;
                 XO[NR]:=XO[NR]-Distanz;  XU[NR]:=XU[NR]-Distanz;
               END;

         If Richtung=7 THEN
               BEGIN
                  IF (NR=1) OR (NR=2) OR (NR=8) OR (NR=9) THEN
                         BEGIN
                            A[Zeile+1,Spalte]:=0; A[Zeile-1,Spalte]:=NR;
                         END;
                  YO[NR]:=YO[NR]-Distanz;   YU[NR]:=YU[NR]-Distanz;
                END;

         If Richtung=8 THEN
               BEGIN
                  IF (NR=1) OR (NR=2) OR (NR=8) OR (NR=9) THEN
                         BEGIN
                            A[Zeile,Spalte]:=0; A[Zeile+2,Spalte]:=NR;
                         END;
                  YO[NR]:=YO[NR]+Distanz;  YU[NR]:=YU[NR]+Distanz;
               END;

         SETFILLSTYLE(1,col);
         BAR(XO[NR],YO[NR],XU[NR],YU[NR]);

         SETCOLOR(13);
         SETTEXTSTYLE(0,0,2);
         OutTextxy(XO[NR]+abstand,YO[NR]+abstand,nrtxt[NR]);
         SETTEXTSTYLE(0,0,1);

         IF SPIEL1 THEN
              IF (A[1,4]=5) AND (A[1,5]=5) AND (A[2,4]=5) AND (A[2,5]=5)
                                               THEN Geschafft:=TRUE;
         IF NOT SPIEL1 THEN
               IF (A[3,4]=5) AND (A[3,5]=5) AND (A[4,4]=5) AND (A[4,5]=5)
                                               THEN Geschafft:=TRUE;
  END;

PROCEDURE  Zweite_Eingabe_Maus(moegl1,moegl2:STRING; VAR Taste2:CHAR);
VAR Button,ButtonPressCount,HorizXlast,VertikYlast:INTEGER;
BEGIN
       ShowCursor;
{     Button:=0;
     GetButPres(Button,ButtonStatus,ButtonPressCount,HorizXlast,VertikYlast);
}
        GetPosBut(Buttonstatus,HorizXlast,VertikYlast);

    REPEAT
       Taste2:=#32;

     REPEAT
        GetPosBut(Buttonstatus,HorizX,VertikY);
     UNTIL (HorizX<>HorizXlast) OR (VertikY<>VertikYlast);

     IF ((moegl1='l') OR (Moegl2='l')) AND (HorizXlast>HorizX)   THEN Taste2:='l';
     IF ((moegl1='r') OR (Moegl2='r')) AND (HorizXlast<HorizX)   THEN Taste2:='r';
     IF ((moegl1='u') OR (Moegl2='u')) AND (VertikYlast<VertikY) THEN Taste2:='u';
     IF ((moegl1='o') OR (Moegl2='o')) AND (VertikYlast>VertikY) THEN Taste2:='o';
   UNTIL (Taste2=moegl1) OR (Taste2=moegl2);

  HideCursor;
END;

  PROCEDURE Verschiebungsrichtung_ermitteln(NUR:INTEGER);
  VAR   Okay,gefunden                 : BOOLEAN;
        I,J,K,Zeile,Spalte,Richtung   : INTEGER;
        R                             : ARRAY[1..2] OF WORD;
        r1txt,r2txt,ztxt,stxt,richtxt : STRING;
        Taste2                        : CHAR;

   BEGIN
        Okay:=FALSE;gefunden:=FALSE;

        FOR K:=1 TO 2 DO R[K]:=0; K:=0;
        Richtung:=0;
        FOR I:=1 TO 4 DO
              BEGIN
                 FOR J:=1 TO 5 DO
                      BEGIN
                         IF (not gefunden) AND (A[I,J] = NUR) THEN
                                        BEGIN
                                            Gefunden:=TRUE;
                                            ZEILE:=I;Spalte:=J;
                                        END;
                      END;
              END;

        IF (NUR=1) OR (NUR=2) OR (NUR=8) OR (NUR=9) THEN
            BEGIN
              IF (A[zeile,spalte+1]=0) AND (A[zeile+1,spalte+1]=0) THEN Richtung:=1;
              IF (A[zeile,spalte-1]=0) AND (A[zeile+1,spalte-1]=0) THEN Richtung:=2;
              IF (A[zeile-2,spalte]=0) AND (A[zeile-1,spalte]=0)   THEN Richtung:=3;
              IF (A[zeile+2,spalte]=0) AND (A[zeile+3,spalte]=0)   THEN Richtung:=4;
              IF Richtung = 0 THEN
                                BEGIN
                                            IF A[zeile-1,spalte]=0 THEN Richtung:=7;
                                            IF A[zeile+2,spalte]=0 THEN Richtung:=8;
                                END;
            END;

        IF (NUR=3) OR (NUR=4) THEN
            BEGIN
              IF (A[zeile,spalte+2]=0) AND (A[zeile,spalte+3]=0)   THEN Richtung:=1;
              IF (A[zeile,spalte-2]=0) AND (A[zeile,spalte-1]=0)   THEN Richtung:=2;
              IF (A[zeile-1,spalte]=0) AND (A[zeile-1,spalte+1]=0) THEN Richtung:=3;
              IF (A[zeile+1,spalte]=0) AND (A[zeile+1,spalte+1]=0) THEN Richtung:=4;
              IF Richtung = 0 THEN
                               BEGIN
                                           IF A[zeile,spalte+2]=0  THEN Richtung:=5;
                                           IF A[zeile,spalte-1]=0  THEN Richtung:=6;
                               END;
            END;

        IF NUR=5  THEN
           BEGIN
             IF (A[zeile,spalte+2]=0) AND (A[zeile+1,spalte+2]=0)   THEN Richtung:=1;
             IF (A[zeile,spalte-1]=0) AND (A[zeile+1,spalte-1]=0)   THEN Richtung:=2;
             IF (A[zeile-1,spalte]=0) AND (A[zeile-1,spalte+1]=0)   THEN Richtung:=3;
             IF (A[zeile+2,spalte]=0) AND (A[zeile+2,spalte+1]=0)   THEN Richtung:=4;
           END;

       IF (NUR=6) OR (NUR=7) THEN
           BEGIN
             IF A[zeile,spalte+1]=0 THEN
                              BEGIN
                                  Richtung:=1;K:=K+1;R[K]:=Richtung;
                              END;
             IF A[zeile,spalte-1]=0 THEN
                              BEGIN
                                  Richtung:=2;K:=K+1;R[K]:=Richtung;
                              END;
             IF A[zeile-1,spalte]=0 THEN
                              BEGIN
                                   Richtung:=3;K:=K+1;R[K]:=Richtung;
                              END;
             IF A[zeile+1,spalte]=0 THEN
                              BEGIN
                                   Richtung:=4;K:=K+1;R[K]:=Richtung;
                             END;
           END;

  {    STR(zeile,ztxt);      str(Spalte,stxt);
       OUTTEXTXY(0,420,'zeile: '+ztxt+' Spalte: '+ stxt);
  }
      IF R[2]<>0 THEN
            BEGIN
              CASE R[1] OF
                        1: r1txt:='rechts';
                        2: r1txt:='links';
                        3: r1txt:='oben';
                        4: r1txt:='unten';
                      END;
              CASE R[2] OF
                        1: r2txt:='rechts';
                        2: r2txt:='links';
                        3: r2txt:='oben';
                        4: r2txt:='unten';
                      END;

              Richtung:=R[1];
              Eingabe_okay:=FALSE;
              WHILE NOT Eingabe_okay DO
                  BEGIN
                    IF NOT Demonstration
                     THEN
                        BEGIN
                          Outtextxy(0,440,'Welche  Richtung ? Nach '+r1txt+' oder nach '+r2txt+' ?');
                          Zweite_Eingabe_Maus(Copy(r1txt,1,1),Copy(r2txt,1,1),Taste2);

                         { Taste2:=READKEY;}
                        END
                     ELSE
                        BEGIN
                          ZUG:=ZUG+1;
                          IF SPIEL1 THEN TASTE2:=DEMO1[Zug]
                                    ELSE TASTE2:=DEMO2[Zug];
                        END;

                    CASE Taste2 OF
                        'r', #77: IF (R[1]=1) OR (R[2]=1) THEN BEGIN Richtung:=1; Eingabe_okay:=TRUE; END;
                        'l', #75: IF (R[1]=2) OR (R[2]=2) THEN BEGIN Richtung:=2; Eingabe_okay:=TRUE; END;
                        'o', #72: IF (R[1]=3) OR (R[2]=3) THEN BEGIN Richtung:=3; Eingabe_okay:=TRUE; END;
                        'u', #80: IF (R[1]=4) OR (R[2]=4) THEN BEGIN Richtung:=4; Eingabe_okay:=TRUE; END;
                        ELSE Eingabe_Okay:=FALSE;
                        END;
                  END;
              IF PIECEalt = NUR THEN ZUGzahl:=Zugzahl-1;
            END;

       IF Richtung<>0 then Okay:=TRUE;
       IF OKAY=FALSE THEN
                 BEGIN
                    OUTTEXTXY(0,400,'Dieses Teil kann nicht verschoben werden.');
                    DELAY(2000);
                 END;

       IF OKAY=TRUE THEN
                   BEGIN
                     {  STR(Richtung,richtxt);
                        OUTTEXTXY(0,400,'kann verschoben werden nach '+ richtxt); }

                     Teil_wird_verschoben(NUR,Richtung,Zeile,Spalte);
                   END;

  END;

 Procedure kontrolle;
  var i,j:integer;
   begin
     for I:=-1 to 6 do begin
          for j:=-1 to 7 do begin
                               str(a[i,j],atxt[i,j]);
                            end;
                       end;
    SetFILLSTYLE(1,0);
    BAR(419,100,630,450);

    for I:=-1 to 6 do begin
          for j:=-1 to 7 do begin
                    outtextxy(420+(j+2)*20,100+(i+2)*20,atxt[i,j]);
                            end;
                      end;
  end;

  PROCEDURE Eingabe_ueber_Tastatur;
   BEGIN
      IF NOT Demonstration THEN BEGIN
                                    SetFILLSTYLE(1,0);
                                    BAR(0,390,500,470);
                                  END;
        Eingabe_okay:=FALSE;
        WHILE NOT Eingabe_okay DO
          BEGIN
             IF NOT Demonstration THEN Taste1:=READKEY
                                  ELSE
                                      BEGIN
                                        ZUG:=ZUG+1;
                                        IF SPIEL1 THEN TASTE1:=DEMO1[Zug]
                                                  ELSE TASTE1:=DEMO2[Zug];
                                        DELAY(300);
                                      END;
            Piecealt:=Piece;
            Eingabe_okay:=TRUE;
            CASE Taste1 OF
               '1': PIECE:=1;
               '2': PIECE:=2;
               '3': PIECE:=3;
               '4': PIECE:=4;
               '5': PIECE:=5;
               '6': PIECE:=6;
               '7': PIECE:=7;
               '8': PIECE:=8;
               '9': PIECE:=9;
               #27: BEGIN
                         Spielende:=TRUE;
                          OutTextxy(10,400,'Vorzeitiges Spielende!');
                     END;
            ELSE Eingabe_Okay:=FALSE;
          END;
         END;
       IF NOT SPIELENDE THEN BEGIN
                                 Verschiebungsrichtung_ermitteln(Piece);
                                 Zugzahl:=Zugzahl+1;
                             END;
       { Kontrolle;}
    END;


  PROCEDURE Eingabe_mit_der_Maus;
  VAR  XALT,YALT,S1,Z1,SP,ZE:INTEGER;
       STEIN,SS,ZZ:STRING;
   BEGIN
      ShowCursor;
      Piecealt:=Piece;

      SetFILLSTYLE(1,0);
       BAR(0,390,500,470);

       Eingabe_okay:=FALSE;
        WHILE NOT Eingabe_okay DO
          BEGIN
             XALT:=0; YALT:=0;
             REPEAT
                GetPosBut(ButtonStatus,HorizX,VertikY);
                if (xalt<>HorizX) or (yalt<>VertikY) THEN
                                     BEGIN
                                       xalt:=HorizX;yalt:=VertikY;
                                       s1:=(HorizX - X0) DIV 71;
                                       Sp:=(HorizX-X0-s1*ABSTAND) DIV 70 +1;
                                       z1:=(VertikY - Y0) DIV 71;
                                       ZE:=(VertikY-Y0-z1*ABSTAND) DIV 70 +1;
                                       Str(A[ZE,SP],Stein);
                                    {  str(sp,ss); str(ze,zz);
                                       setcolor(4);
                                       bar(400,350,480,450);
                                       outtextxy(410,440,ss);
                                       outtextxy(450,420,Stein);
                                       outtextxy(450,440,zz);
                                    }
                                    END;
             UNTIL (ButtonStatus=1) OR (ButtonStatus=2);

            IF ButtonStatus=1 THEN
                            BEGIN
                            PIECE:=A[ZE,SP];
                            IF  (PIECE >0) AND (PIECE <10) THEN Eingabe_Okay:=TRUE;
                            END;
            IF ButtonStatus=2 THEN
                          BEGIN
                            Eingabe_okay:=TRUE;
                            Spielende:=TRUE;
                            OutTextxy(10,400,'Vorzeitiges Spielende!');
                          END;
         END;

       IF NOT SPIELENDE THEN BEGIN
                                 HideCursor;
                                 Verschiebungsrichtung_ermitteln(Piece);
                                 Delay(200);
                                 Zugzahl:=Zugzahl+1;
                             END;
       { Kontrolle;}
    END;

  PROCEDURE JA_NEIN_Abfrage(X1,Y1,X2,Y2,X3,Y3,X4,Y4:INTEGER);
  VAR Eingabe :BOOLEAN;
   BEGIN
       Rectangle(X1,Y1,X2,Y2);
       Rectangle(X3,Y3,X4,Y4);
       SetCursorPos(550,330);
       ShowCursor;ShowCursor;
       Eingabe:=FALSE;
       REPEAT
         GetPosBut(ButtonStatus,HorizX,VertikY);
         If (Buttonstatus=1) AND
            (HorizX >X1) AND (HorizX<X2) AND (VertikY>Y1) AND (VertikY<Y2)
             THEN BEGIN  Eingabe:=TRUE; Taste1:='n' END;
         If (Buttonstatus=1) AND
            (HorizX >X3) AND (HorizX<X4) AND (VertikY>Y3) AND (VertikY<Y4)
             THEN BEGIN  Eingabe:=TRUE; Taste1:='j' END;
       UNTIL Eingabe;
                      HideCursor;


   END;

{--------------------------------------------------------------------------}

BEGIN
      Maus_und_Graphikinitialisierung;

      Titelbild_und_Musik;
      Menu1;

 ANFANG:
      Ausgangsstellung;
      IF Demonstration THEN HideCursor ELSE ShowCursor;
    REPEAT
        IF DEMONSTRATION THEN BEGIN
                             Eingabe_ueber_Tastatur;
                               END
                         ELSE  BEGIN
                               Eingabe_mit_der_Maus;
                               END;
    UNTIL spielende OR geschafft;

    STR(Zugzahl,Zugtxt);
    IF Geschafft THEN OUTTEXTXY(450,410,'Geschafft in '+Zugtxt+' Zgen!');
    DELAY(1500);
    SETCOLOR(14);
    IF NOT Demonstration THEN
                   BEGIN
                      Outtextxy(10,420,'Willst Du eine m”gliche L”sung sehen?   JA     NEIN');
                      Ja_Nein_Abfrage(370,400,425,440,320,400,360,440);

                     {    Taste1:=READKEY;}
                     IF (TASTE1 ='j') OR (Taste1='J') THEN
                                        BEGIN
                                          ClearDevice;
                                          Demonstration:=TRUE;
                                          GOTO Anfang;
                                        END;
                   END;
    SETFILLSTYLE(1,0);
    BAR(0,395,639,470);
    OutTextXY(0,420,'Willst Du Dich an dem anderen Puzzle versuchen ?      JA    NEIN');
    Ja_Nein_Abfrage(470,400,525,440,420,400,460,440);

 {   Taste1:=READKEY;}
      IF (TASTE1 ='j') OR (Taste1='J') THEN
                                        BEGIN
                                          ClearDevice;
                                          SetCursorPos(200,150);
                                          Demonstration:=FALSE;
                                          Spiel1:= NOT SPIEL1;
                                          GOTO Anfang;
                                        END
                                     ELSE    CLOSEGRAPH;


END.

