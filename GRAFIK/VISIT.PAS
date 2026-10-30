PROGRAM Visitenkarte;
USES CRT;

BEGIN

    ClrScr;
    GOTOXY(22,7);
    WRITELN('*   M I C H A E L    G R O S S N I K L A U S    *');
    WRITELN('                     *                                               *');
    WRITELN('                     *            A D L E R S T R .   7              *');
    WRITELN('                     *                                               *');
    WRITELN('                     *             4 0 5 2    B A S E L              *');
    WRITELN('                     *                                               *');
    WRITELN('                     *          0 6 1 / 3 1 2 , 5 7 , 6 5            *');
    GOTOXY(20,6);
    WRITE('  ************************************************* ');
    GOTOXY(20,14);
    WRITE('  ************************************************* ');
    REPEAT UNTIL KEYPRESSED;
END.