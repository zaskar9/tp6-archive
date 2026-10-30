10 REM * IDENTIFIZIRUNG VON STOFFEN *
20 REM * -------------------------- *
25 DIM M$(54), A(54, 3)
30 REM GOSUB 930
40 GOSUB 830
50 LET N = 1
60 CLS
70 REM * HAUPTSCHLEIFE *
80 PRINT
90 PRINT M$(N);
100 LET F = A(N, 1)
110 IF F = 0 THEN GOSUB 230
120 IF F = 1 THEN GOSUB 310
130 IF N <> 0 THEN GOTO 80
140 REM * SEITENENDE *
150 PRINT
160 PRINT "Mehr kann ich dazu nicht sagen."
170 PRINT "Mîchtest du einen neuen Versuvh machen? (J/N)"
190 INPUT A$
200 IF A$ = "J" THEN GOTO 40
210 PRINT "In Ordnung"
220 STOP
230 REM  * AUSGABEANWEISUNG *
240 PRINT : PRINT
250 GOSUB 690
260 LET P = A(N, 2)
270 IF P = 1 THEN GOSUB 360
280 IF P = 2 THEN GOSUB 590
290 LET P = A(N, 3)
300 RETURN
310 REM * FRAGESTELLUNG *
320 PRINT " ?": PRINT
330 GOSUB 740
340 LET N = A(N, R + 1)
350 CLS : RETURN
360 REM * FLAMMENTEST *
370 CLS
380 PRINT "Flammentest"
390 PRINT
400 PRINT "Auf Seite 27 findest Du genaueres Åber diesen Test."
420 PRINT
430 PRINT "Bist Du zu einem Ergebnis gekommen?"
450 GOSUB 740
460 IF R = 2 THEN GOSUB 480
470 RETURN
480 REM * BORAXPERLENTEST *
490 CLS
500 PRINT "Boraxperlentest"
510 PRINT
520 PRINT "Auf Seite 38/39 findest Du genaueres Åber diesen Test."
550 PRINT
560 GOSUB 690
570 CLS
580 RETURN
590 REM * SéUREREST-TEST *
600 CLS
610 PRINT "SÑureresttest": PRINT
620 PRINT
630 PRINT "Auf Seite 38/39 findest du genaueres Åber diesen Test."
660 PRINT
670 GOSUB 690
680 RETURN
690 REM * TASTENBELEGUNG *
700 PRINT "Zur Fortsetzung Leertaste drÅcken."
710 LET A$ = INKEY$
720 IF A$ <> " " THEN GOTO 710
730 RETURN
740 REM * ANTWORT JA/NEIN *
750 PRINT
760 LET R = 0
770 PRINT "J/N? (J=Ja N=Nein)"
780 INPUT A$
790 IF A$ = "J" THEN LET R = 1
800 IF A$ = "N" THEN LET R = 2
810 IF R = 0 THEN GOTO 780
820 RETURN
830 REM * EINLEITUNGSCHLEIFE *
840 CLS
850 PRINT "IDENTIFIZIERUNG VON STOFFEN"
860 PRINT "---------------------------"
870 PRINT
880 PRINT "Mach die folgenden Versuche mit jedem Stoff"
900 PRINT
910 GOSUB 690
920 CLS
930 REM * DATEN EINLESEN *
940 REM REDIM A(54, 3)
950 LET K = 1
960 READ A$
970 IF A$ = "Ende der Daten" THEN RETURN
980 LET M$(K) = A$
990 FOR I = 1 TO 3
1000 READ A(K, I)
1010 NEXT I
1020 LET K = K + 1
1030 GOTO 960
1040 REM * DATEN *
1050 DATA "Leitet er WÑrme oder elektrischen Strom",1,2,5
1055 DATA "Es ist ein Metall. Ist es magnetisch",1,3,4
1060 DATA "Es ist Eisen oder eisenhaltiges Metall.",0,0,0
1065 DATA "Mach den Flammentest.",0,1,0
1070 DATA "Schmilzt er leicht",1,6,17
1075 DATA "Es ist eine kovalente Verbindung oder ein Element.",0,0,7
1080 DATA "Ist es ein gelbes Pulver...",1,10,8
1085 DATA "...oder ein rîtlicher/gelber Feststoff...",1,11,9
1090 DATA "...oder ein lila/schwarzer Feststoff",1,12,13
1095 DATA "Es dÅrfte Schwefel sein.",0,0,0
1100 DATA "Es dÅrfte Phosphor sein.",0,0,0
1105 DATA "Es dÅrfte Jod sein.",0,0,0
1110 DATA "Es kînnte eine organische Verbindung sein.",0,0,14
1115 DATA "Erhitze den Stoff. Bildet sich Kohlenmonoxid",1,16,15
1120 DATA "Es ist kein organischer Stoff.",0,0,0
1125 DATA "Der Stoff ist organisch und enthÑlt Kohlenstoff.",0,0,0
1130 DATA "Es ist wahrscheinlich eine Ionenverbindung.",0,0,18
1135 DATA "Ist er lîslich",1,24,19
1140 DATA "Ist es ein schwarzes Pulver",1,20,23
1145 DATA "Erhitze den Stoff. Bildet sich Kohlendioxid",1,21,22
1150 DATA "Es ist Kohlenstoff.",0,0,0
1155 DATA "Es ist Kupferoxid",0,0,0
1160 DATA "Es ist ein unlîsliches Salz",0,0,29
1165 DATA "Ermittle dem PH-Wert",0,0,25
1170 DATA "Reagiert der Stoff sauer",1,42,26
1175 DATA "Reagiert der Stoff basisch",1,33,27
1180 DATA "Ist der Stoff neutral",1,28,25
1185 DATA "Es ist ein neutrales Salz",0,0,29
1190 DATA "Finde heraus, welches Metall der Stoff enthÑlt ",0,1,30
1195 DATA "Finde heraus, welchen SÑurerest der Stoff enthÑlt",0,2,31
1200 DATA "Verbinde Metall und SÑurerest,...",0,0,32
1205 DATA "...um den Namen der Verbindung herauszufinden",0,0,0
1210 DATA "Es kînnte das Oxid oder...",0,0,34
1215 DATA "...Hydroxid eines Metalls sein.",0,0,35
1220 DATA "Riecht er nach Ammoniak",1,54,3
1225 DATA "Mach den SÑureresttest",0,2,37
1230 DATA "Hast Du ein Ergebnis",1,39,38
1235 DATA "Es ist wahrscheinlich ein Oxid oder Hydroxid.",0,0,39
1240 DATA "Finde heraus, welches Metall der Stoff enthÑlt",0,1,40
1245 DATA "Verbinde Metall und SÑurerest...",0,0,41
1250 DATA "...oder Metall und Oxid/Hydroxid, um den Namen der Verbindung herauszufinden",0,0,0
1255 DATA "FÅge Zink hinzu. Bildet sich Wasserstoff",1,44,43
1260 DATA "Es ist ein saures Salz.",0,0,29
1265 DATA "Es ist eine SÑure.",0,0,45
1270 DATA "Mach den SÑureresttest",0,2,46
1275 DATA "Ist der SÑurerest ein Sulfat",1,49,47
1280 DATA "Ist er ein Chlorid...",1,50,48
1285 DATA "...oder ein Carbonat",1,51,52
1290 DATA "Es ist SchwefelsÑure.",0,0,0
1295 DATA "Es ist SalzsÑure.",0,0,0
1300 DATA "Es ist KohlensÑure.",0,0,0
1305 DATA "Es kînnte ein Nitrat...",0,0,53
1310 DATA "...oder ein Bromid oder Iodid sein.",0,0,0
1315 DATA "Es ist eine Ammoniumverbindung.",0,0,0
1320 DATA "Ende der Daten"











