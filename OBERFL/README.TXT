OBERFL - WINDOW OBJECTS
=======================
Experiments with a window class in BGI graphics that imitates a
Windows 3.1 window with title bar and menu bar.

WIN.EXE       13 Oct 1993. Draws a window titled "Windows 3.1" at
              (100,100)-(600,400) over a black client area in which
              the star field of ASTRO\STARS.PAS moves. The system
              menu box and the minimize button are drawn with 3D
              edges; a click on the button shows it pressed for half
              a second; the mouse cursor is hidden over the client
              area. Ends with a key press. The source is lost; see
              WIN.PAS.
WIN.PAS       reconstructed source of WIN.EXE, November 2026, from a
              disassembly, with OBERFL01.PAS and ASTROGR.PAS as the
              template for the names. Object Fenster with the
              virtual methods Rahmen, TitleBar, MenuPlug, PopUpPlug
              and a hit test for the button. Uses STARS.PAS from
              ASTRO (same date as the EXE) and MOUSE.PAS from UNITS.
              Verified: recompiled with Turbo Pascal 6.0 it is
              byte-identical to WIN.EXE.
OBERFL01.PAS  program Oberflaeche, 31 Dec 1993: the later form of
              the experiment, without the star field and the mouse,
              with a menu bar, PopUpPlug and buttons.
OBJTEST.PAS   Turbo Vision test (Jul 1993)
