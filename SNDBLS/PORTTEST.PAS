PROGRAM Port_Test;
Uses Crt, Dos;

Var P200,P210,P220,P230,P240,P250 : Integer;

Begin Clrscr;
      P200:=Port[$200];
      P210:=Port[$210];
      P220:=Port[$220];
      P230:=Port[$230];
      P240:=Port[$240];
      P250:=Port[$250];
      Writeln('Port 200: ',P200);
      Writeln('Port 210: ',P210);
      Writeln('Port 220: ',P220);
      Writeln('Port 230: ',P230);
      Writeln('Port 240: ',P240);
      Writeln('Port 250: ',P250);
      Repeat Until Keypressed;
End.