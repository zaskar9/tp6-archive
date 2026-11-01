HWTEST - HARDWARE TESTER
========================
"HardwareTester 1.0", October 1993: a system information and test
program, forerunner of MGCCDOC (Dec 1993). It was found among the
COMPOSER files and has nothing to do with the music editor.

COMPTEST.EXE  24 Oct 1993. Text-mode menu in MyObject windows, menu
              items read from MENU.DAT. Three tests:
              1 system information, gathered in a short graphics
                pass and listed in a window: DOS version, date,
                time, free and total space on C:, graphics driver
                and mode, mode range, resolution, palette size,
                mouse present, number of mouse buttons;
              2 graphics demo: random rectangles, growing circles,
                random bars, random lines, the palette, random
                pixels, "GAME OVER !";
              3 mouse test: a drawn mouse with one box per button,
                the pressed button lights up red, the pointer
                position is shown; Q ends it.
              The BGI driver is loaded from A:\.
COMPTEST.PAS  reconstructed source, November 2026, from a
              disassembly. All strings, coordinates, colours, delays
              and the control flow are those of the binary; names
              are invented. Uses MYOBJECT and MOUSE from UNITS.
              Recompiled with Turbo Pascal 6.0 it is byte-identical
              to COMPTEST.EXE. Oddities kept: a window that is set up
              but never drawn, the position text covered at once by
              a black bar, the number of colours taken from
              GetPaletteSize, unused variables.
MENU.DAT      the four menu entries, 31 Aug 1993: Test durchfuehren,
              Graphikdemonstration, Mousedemonstration, Programm
              beenden. The file had been filed as an old launcher
              menu in MENUE\OLD; its date and its four entries, which
              match the four menu cases of the program, place it
              here.
OLD\COMPTEST.EXE, OLD\COMPTEST.PAS
              the build of 14 Oct 1993 and its reconstruction, also
              byte-identical. Differs only in the mouse test: no
              position display, no abort with Q, the right button
              ends it.
