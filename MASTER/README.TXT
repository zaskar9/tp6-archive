MASTER - MASTER MIND
====================
Master Mind game in VGA graphics (640x480), two versions. The original
sources are lost; MASTER.PAS and MMIND.PAS are reconstructions (see
below).

MASTER.EXE    "PROFESSIONAL MASTER MIND", 31 Oct 1993.
              Strings: "Michael Grossniklaus, All Rights Reserved,
              Basel 1993", "YOU BROKE THE HIDDEN CODE !", "DO YOU
              TRY AGAIN ? (Y/N)", "ENTER YOUR NAME:", "HALL OF
              FAME". Loads the BGI driver from C:\TP\BGI. Scores in
              MASTER.INI.
MMIND.EXE     rebuilt version of 9 Apr 1994, 113 KB. The same game on
              grey 3D panels, the lettering as bitmaps linked into
              the EXE (80 KB of the file), scores in MASTER.SCR.
              Loads the BGI driver from the current directory.
DELMASTE.EXE  3 Oct 1993: resets the hall of fame by truncating
              MASTER.INI. Source reconstructed: DELMASTE.PAS.

MASTER.PAS    reconstructed source of MASTER.EXE, October 2026. Made
              from a disassembly with the help of the source/EXE pairs
              in this archive and the MOUSE and WRITING units, which
              the game uses. All strings, coordinates, colours, delays
              and the control flow are those of the binary; names and
              comments are new. Compiled with Turbo Pascal 6.0 it gives
              a byte-identical MASTER.EXE (verified in October 2026,
              see "Rebuilding" below). Its evaluation routine agrees
              with standard Master Mind scoring for all 1679616
              code/guess pairs. Four slips of the original are kept and
              marked "sic"; all are harmless.
              How the game works: 10 columns of 4 holes, a palette of
              six colours below, feedback pegs above each column.
              Left click picks a colour and a hole, both buttons give
              up. Score = 1000 - seconds played - 20 * moves.

MMIND.PAS     reconstructed source of MMIND.EXE, October 2026, made the
              same way starting from MASTER.PAS. Uses the MyUtil unit
              of Feb 1994 (UNITS\MYUTIL.PAS) for the mouse, the name
              input and the screen blanking (VGA_Aus/VGA_Ein while a
              screen is drawn), and two units of its own, MMTEXT.PAS
              and MMLOGO.PAS, that hold nothing but the five bitmaps as
              external procedures ({$L}; object files made with BINOBJ
              from the .TPP files below, see the comments there). The
              unit and procedure names are invented. Built with range
              checking on, like the EXE. Compiled with Turbo Pascal 6.0
              it gives a byte-identical MMIND.EXE (verified in October
              2026).
              Differences to MASTER.PAS: procedure Rahmen draws raised
              or sunken grey panels; Bewertung and ZeigeBewertung work
              with arrays; the palette is drawn with Bar; holes and
              code pegs are flood-filled against light grey; the error
              message uses MaxX/MaxY; score = 1000 - 10 * seconds -
              50 * moves, where moves is set to 0 when the code was
              broken (so only a game of well under two minutes scores
              at all); the entry count is clamped to 25 after reading
              more than 30 records; the last three cases of Bewertung
              set the wrong flags (sic). Needs MYUTIL.PAS or .TPU from
              UNITS to compile.

The five bitmaps of MMIND.EXE, cut out of the EXE with the length each
file has in it (a few hundred bytes of leftovers follow some of them,
as in the .PRW files of PCXTOOLS). Format: GetImage/PutImage buffer of
the EGAVGA driver, the .TPP format of PCXTOOLS\PCX_PAS.PAS (word
width-1, word height-1, then per row the four planes, intensity plane
first). Dark grey lettering on light grey, "Mind" in light blue. Next
to each .TPP is a .PNG rendering made in 2026.

  PROFESS.TPP   "professional"              279 x  56   title
  MMGROSS.TPP   "MasterMind"                519 x  86   title
  AUTOR.TPP     "by Michael Grossniklaus"   499 x 101   title
  MMKLEIN.TPP   "MasterMind"                389 x  65   above the board
  HALLFAME.TPP  "Hall of Fame"              384 x  61   hall of fame

Rebuilding (October 2026, DOSBox-X with the Turbo Pascal 6.0 disks):
copy TPC.EXE, TURBO.TPL, GRAPH.TPU and BINOBJ.EXE into a folder with
the .PAS and .TPP files of this directory and MOUSE.PAS, WRITING.PAS
and MYUTIL.PAS from UNITS, then
  BINOBJ PROFESS.TPP  PROFESS.OBJ  Professional
  BINOBJ AUTOR.TPP    AUTOR.OBJ    Autor
  BINOBJ HALLFAME.TPP HALLFAME.OBJ HallFame
  BINOBJ MMGROSS.TPP  MMGROSS.OBJ  MMGross
  BINOBJ MMKLEIN.TPP  MMKLEIN.OBJ  MMKlein
  TPC /B MASTER.PAS
  TPC /B MMIND.PAS
The two EXEs come out identical to the originals (same MD5). Free
Pascal in Turbo Pascal mode compiles MMIND.PAS but rejects MASTER.PAS:
its palette and hole ranges share their border values (80..160,
160..240, ...), which Turbo Pascal 6 accepts and Free Pascal reports
as duplicate case labels. What the
comparison could not settle: Farbe is a Word in MMIND.PAS because the
range checks say so, in MASTER.PAS the type leaves no trace; the two
unused bytes before GraphDriver (Dummy0) and the 1310 unused bytes at
the end of the variables of MMIND (Unbenutzt) have unknown names and
types.

Hall of fame files: 10 records of 258 bytes each
(Name: String; Punkte: Integer).
MASTER.INI       Michael 796
MASTER.SCR       Michael 520, 500, 490, 440 (for MMIND.EXE)
OLD\MASTER.INI   "batsch" 561 and 38
