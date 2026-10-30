UNITS - SHARED UNITS
====================
Units that several programs use. Identical copies of MOUSE.PAS,
WRITING.PAS, MYOBJECT.PAS and MYUTIL.PAS also sit inside the project
folders that need them (COMPOSER, FORMEL, PCGRADES, SPORTTAG), so that
each project compiles from its own folder.

MOUSE.PAS    unit MOUSE    (Jun 1993)  mouse driver interface (int 33h)
WRITING.PAS  unit WRITING  (May 1993)  text output in graphics mode
MYOBJECT.PAS unit MyObject (Aug 1993)  "Rahmen" and "Hintergrund"
                                        objects for text-mode screens
MYUTIL.PAS   unit MyUtil   (Feb 1994)  main graphics library: PCX
                                        loading (tPCXBild), frames,
                                        PRW pictures. MYUTIL.MEN and
                                        MYUTIL.PRW belong to it.
MENUOBJ.PAS  unit MenuObj  (Mar 1994)  menus on top of MyUtil
MUSIK.PAS    unit Musik    (Feb 1993)  PC speaker notes: Ton, Pause
MUSIK2.PAS   unit Musik    (Dec 1993)  newer version of the same unit

Used by: COMPOSER, DRAW, FORMEL, MENUE, MGCCDOC, MYTUTOR, PCGRADES,
SPORTTAG, SPIELE (TIC, MUEHLE), GRAFIK (many), SNDBLS (SBTEST).
