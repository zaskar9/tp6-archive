INSTALL - TURBO PASCAL 6.0 INSTALLER
====================================
Own graphical installer for the Turbo Pascal 6.0 floppy disks,
18 Feb 1994. Shows a splash picture (A:\TURBO.PRW), asks for each
disk ("Legen Sie bitte die Diskette # ins Laufwerk A:\ ein") and
copies it with C:\DOS\XCOPY.EXE A:\*.* /S to C:\TP.

INSTALL.PAS   program Install
INSTALL.EXE   build with the splash picture
INSTALL2.EXE  second build of the same program without the splash
