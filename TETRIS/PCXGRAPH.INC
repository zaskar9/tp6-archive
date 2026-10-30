procedure ReadGraphFile(Pfad : String; VAR Name : Pointer; VAR Groesse : Word);
var gi : file of integer;
    g : file;
    img : word;
    Breite, Hoehe : Integer;

Begin assign(gi,Pfad);
      reset(gi);
      read(gi,breite,hoehe);
      Close(gi);
      img:=Imagesize(0,0,breite,hoehe);
      getmem(Name,img);
      assign(g,Pfad);
      reset(g,img);
      blockread(g,Name^,1);
      close(g);
      Groesse:=img;
end;