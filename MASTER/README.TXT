MASTER - MASTER MIND
====================
Master Mind game in VGA graphics (640x480). The original source is
lost; MASTER.PAS is a reconstruction (see below).

MASTER.EXE    "PROFESSIONAL MASTER MIND", 31 Oct 1993.
              Strings: "Michael Grossniklaus, All Rights Reserved,
              Basel 1993", "YOU BROKE THE HIDDEN CODE !", "DO YOU
              TRY AGAIN ? (Y/N)", "ENTER YOUR NAME:", "HALL OF
              FAME". Loads the BGI driver from C:\TP\BGI.
MMIND.EXE     rebuilt version of 9 Apr 1994. Same game, scores in
              MASTER.SCR, and about 80 KB of bitmap data compiled
              in (a graphical title screen).
DELMASTE.EXE  3 Oct 1993: resets the hall of fame by truncating
              MASTER.INI. Source reconstructed: DELMASTE.PAS.

MASTER.PAS    reconstructed source of MASTER.EXE, October 2026. Made
              from a disassembly with the help of the source/EXE pairs
              in this archive and the MOUSE and WRITING units, which
              the game uses. All strings, coordinates, colours, delays
              and the control flow are those of the binary; names and
              comments are new. It compiles (checked with Free Pascal
              in Turbo Pascal mode) and its evaluation routine agrees
              with standard Master Mind scoring for all 1679616
              code/guess pairs. Two slips of the original are kept and
              marked "sic"; both are harmless.
              How the game works: 10 columns of 4 holes, a palette of
              six colours below, feedback pegs above each column.
              Left click picks a colour and a hole, both buttons give
              up. Score = 1000 - seconds played - 20 * moves.

Hall of fame files: 10 records of 258 bytes each
(Name: String; Score: Integer).
MASTER.INI       Michael 796
MASTER.SCR       Michael 520, 500, 490, 440 (for MMIND.EXE)
OLD\MASTER.INI   "batsch" 561 and 38
