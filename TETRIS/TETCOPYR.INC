Procedure Copyright;
Var Img : Word;
Begin Img:=ImageSize(220,190,420,290);
      GetMem(HGrund, Img);
      GetImage(220,190,420,290,HGrund^);
      PutImage(220,190,Copyr^,0);
      Repeat
            Taste:=ReadKey;
      Until Taste=' ';
      Taste:='0';
      PutImage(220,190,HGrund^,0);
      FreeMem(Copyr,GrCopy);
      FreeMem(HGrund,Img);
End;