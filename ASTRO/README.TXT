ASTRO - ZODIAC AND ASCENDANT
============================
ASTRO.EXE    "PC Astro 1.0", 1 Sept 1993, text mode. Asks for birth
             date (day.month) and time (hour.min) in a window and
             prints zodiac sign and ascendant. Credits on the title
             screen: Michael Gossniklaus (Syntax), Fabian Kristmann
             (Idee). The source is lost; see ASTRO.PAS.
ASTRO.PAS    reconstructed source of ASTRO.EXE, November 2026, from a
             disassembly, with ASTROGR.PAS and STARZEIC.INC as the
             template: the EXE is the text-mode original of that
             program. Same constant table, same global variables
             (minus the star field), the procedure has the same
             local variables and logic, with GotoXY/Write/ReadLn in
             place of the graphics calls. The windows come from
             UNITS\MYOBJECT.PAS (objects Rahmen and AstroGround),
             which also brings in MOUSE.PAS. Names are those of the
             successor. Verified: TPC /$A- /B ASTRO.PAS with Turbo
             Pascal 6.0 gives a byte-identical ASTRO.EXE. The $A-
             (byte alignment of data) is needed, the EXE was built
             with that setting.
ASTROGR.PAS  program Aszendent, 13 Oct 1993: graphical successor
             with a star field. Include STARZEIC.INC.
ASTROGR.EXE  build
STARS.PAS, STARUNIT.PAS (+ .TPU)   units for the star field
STARTEST.PAS unit test
