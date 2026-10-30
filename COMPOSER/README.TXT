COMPOSER - MUSIC EDITOR
=======================
The largest project. Graphical note editor for PC speaker music,
January to May 1994.

Main program:  PROJ0001.PAS (program Music), with 15 include files:
  MUSYMBOL MUSMESSA MUSWITCH MUSMOUSE MUSCTAST MUSCNOTE MUSCCOPY
  MUSCREEN MUSCBILD MUSCINIT MUICNMEN MUCERROR MUSDATEI MUOPTION
  MULIZENZ (.INC)
Units:         DLGBOX.PAS (dialog boxes), MENU.PAS (menus, 29 KB),
               MYUTIL.PAS, MOUSE.PAS (copies of UNITS)
Data:          MAINMENU.MEN (menu), COMPTTL.PCX / COMPTTL.TPP (title)
Tests:         FARBTEST.PAS, SYMBTEST.PAS, TASTTEST.PAS
Drivers/fonts: *.BGI, *.CHR (copies of BGI)

Text-mode tools in this folder:
  COMPOSER.PAS  program Composer (May 1994), text mode, uses unit
                Musik. COMPOSER.EXE is the Sept 1993 build.
  SND2CMP.PAS   converts the older .SND song format to .CMP
                (with TONZUWEI.INC)
  OLD\COMPTEST.EXE  older build (Oct 1993); COMPTEST.EXE in the
                root is the newer one.

SONGS\   34 song files (.CMP) and 4 older ones (.SND): Allemein,
          Amazing, Fanfare, Freude, Hook, Jingle, Jurassic, New Year,
          Raiders, Schindler, Star Wars, Swanee, Tetris, ...
PC_LAUT\ distribution set "PC laut": COMPOSER.EXE plus 16 songs.

Players: SNDBLS\SBTEST.PAS (via unit Musik) and
         SNDBLS\INTERRPT.PAS (via Sound Blaster).
