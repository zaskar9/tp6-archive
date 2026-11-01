TURBO PASCAL ARCHIVE 1992-1995
==============================

Programs written by Michael Grossniklaus in Turbo Pascal 6.0 on a
486 PC, July 1992 to April 1995. Most files date from 1993.
Reorganised into 8.3-named project folders in October 2026.
An untouched image of the original layout exists as an ISO file.

Every folder has its own README.TXT with details on its files.

FOLDERS
-------
UNITS     Shared units used by many programs: MOUSE, WRITING,
          MYOBJECT, MYUTIL, MENUOBJ, MUSIK, MUSIK2 (with .TPU).
BGI       Borland graphics drivers (.BGI) and fonts (.CHR) that
          came with Turbo Pascal 6.0. Not own work and therefore not
          in the repository, like the copies next to the graphics
          programs. Programs load them from C:\TP\BGI. Contents:
          ATT CGA EGAVGA HERC IBM8514 PC3270 (.BGI); GOTH GREEK LITT
          OLDENG ROMAN SANS SANSERIF SCRIPT SYMBOL TRIP (.CHR).
COMPOSER  Music editor (graphical, Jan-May 1994) with the song
          files in SONGS and the PC_LAUT distribution set.
TETRIS    "Professional Tetris" (Nov 1993 - Mar 1994).
PCGRADES  Grade management "Klasse" (Jun 1993 - Jan 1994) and the
          class reunion list "Zusammenkunft".
SPORTTAG  Sports day scoring program (Aug 1993 - Jan 1994).
FORMEL    Formula collection "Formelsammlung" (Jun/Jul 1993).
DRAW      Paint program with mouse (Jun-Oct 1993) and the mouse
          experiments that led to it; also the sliding puzzle.
MENUE     DOS program launcher "ProMenu" (Jul/Aug 1993) with its
          menu data files.
MGCCDOC   "MGCC Doctor" system information tool (Dec 1993).
MYTUTOR   Tutorial program for the MyUtil library (Mar 1994).
ASTRO     Zodiac sign and ascendant programs (Sep/Oct 1993).
ENGTRAIN  English vocabulary trainer (Feb 1993).
SNDBLS    Sound Blaster programming (Sep 1993 - Sep 1994).
MASTER    Master Mind game (Oct 1993 and Apr 1994). Both versions
          were reconstructed as source; with the hall-of-fame files
          and the bitmaps of the 1994 version.
PCXTOOLS  PCX and PRW image tools and the images in PICS.
INSTALL   Own graphical installer for the Turbo Pascal 6.0 disks.
OBERFL    Window object experiments ("Windows 3.1" look).
SPIELE    Single-file games.
MUSIK     PC speaker music programs.
GRAFIK    Graphics and math experiments (3D, Mandelbrot, fonts).
UEBUNGEN  Early exercise programs, mostly 1992 and early 1993.
TOOLS     Small utilities (SPEED benchmark, DARK).
SONSTIGE  Everything else (QBasic file, system files, text).
DUPLIKAT  Exact duplicates of files that exist elsewhere in the
          archive. Can be deleted.

The former folders COMPILED (compiled programs) and DEMO were
dissolved; their files now sit in the project folders.

Older or alternative versions of a program are kept in an OLD
subfolder of the project (COMPOSER\OLD, ENGTRAIN\OLD, FORMEL\OLD,
MASTER\OLD, MENUE\OLD, PCGRADES\OLD, SNDBLS\OLD).

PROGRAMS WITHOUT SOURCE
-----------------------
Nine executables had no .PAS file of the same name (not counting
the third-party tools in SPORTTAG). They were examined by string
extraction and disassembly in October and November 2026. All are
Turbo Pascal 6.0 builds. Six were reconstructed as source:

  TOOLS\DARK.PAS       reconstructed from DARK.EXE
  MASTER\DELMASTE.PAS  reconstructed from DELMASTE.EXE
  MASTER\MASTER.PAS    reconstructed from MASTER.EXE (the game)
  MASTER\MMIND.PAS     reconstructed from MMIND.EXE (the 1994 version
                       of the game; its bitmaps are cut out as .TPP)
  ASTRO\ASTRO.PAS      reconstructed from ASTRO.EXE (text-mode
                       original of ASTROGR.PAS)
  OBERFL\WIN.PAS       reconstructed from WIN.EXE (window over a
                       star field, forerunner of OBERFL01.PAS)

All six were checked by recompiling them with Turbo Pascal 6.0 in
DOSBox-X: each gives an EXE identical to the original, byte for byte.
See the README.TXT of MASTER, ASTRO, OBERFL and TOOLS.

Two turned out to be builds of existing sources under another
name: INSTALL2.EXE is INSTALL.PAS without the splash picture, and
SNDBLS\HOOK.EXE is INTERRPT.PAS (recompiled, it is byte-identical).
The remaining one, COMPTEST.EXE, is described in COMPOSER\README.TXT.

DATING NOTES
------------
Oldest source: UEBUNGEN\ENTBRI.PAS, 29 July 1992.
Newest source: UEBUNGEN\DNA.PAS, 7 April 1995.
The launcher data in MENUE (July 1993) lists the software that was
installed then: MS-DOS, MS Windows, Word fuer Windows 2.0b, Turbo
Pascal 6.0, Q-Basic, Norton AntiVirus and a few games.
Files dated 14 Feb 1997 were copied on that date; their content
is from 1993/1994.

FILE TYPES
----------
.PAS  Pascal source          .INC  include file ({$I})
.TPU  compiled unit          .BAK  editor backup of .PAS/.INC
.EXE  compiled program       .MEN  menu definition (own format)
.CMP  Composer song          .SND  older song format (see SND2CMP)
.PCX  picture                .PRW  own raw picture format from PCX
.NOT  grade file (PCGRADES)  .VOC  vocabulary lesson (ENGTRAIN)
.SPT  sports day data        .DAT  misc. data files
.BGI  graphics driver        .CHR  stroked font
.TPP  picture, PutImage format (PCX_PAS, MASTER)
.PNG  rendering of a .TPP, added in 2026
