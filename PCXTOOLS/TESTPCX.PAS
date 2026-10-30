Program Test;
Uses MyUtil,Graph,Crt;

Type tPCXBild = Record Name     : Pointer;
                       FName    : String;
                       Groesse  : Word
                End;

Var Bild : tPCXBild;


procedure PreparePCX(Var Bild:tPCXBild);
var g : file;
    Breite, Hoehe : Integer;

Begin assign(g,Bild.FName);
      OutTextXY(10,10,'Lesen '+Bild.FName+' Vorher');
      {$I-} reset(g,1); {$I+}
      if IOResult=0
       then begin OutTextXY(10,20,'Lesen '+Bild.FName);
                  BlockRead(g,breite,2);
                  BlockRead(g,hoehe,2);
                  Bild.Groesse:=Imagesize(0,0,breite,hoehe);
                  getmem(Bild.Name,Bild.Groesse);
                  Seek(g,0);
                  blockread(g,Bild.Name^,Bild.Groesse);
                  close(g);
             end
        else begin
             end;
end;


Procedure ShowPCX(x,y:Integer;Bild:tPCXBild);
Begin PutImage(x,y,Bild.Name^,NormalPut)
End;

Begin
      Bild.FName:='A:\COPY.PRW';
      Graphik_Ein('c:\tp\bgi');
      PreparePCX(Bild);
      ShowPCX(100,100,Bild);
      Repeat until KeyPressed;
      Graphik_Aus;
End.