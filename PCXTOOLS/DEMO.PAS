Program DemoPCX;
Uses Dos,Graph,MyUtil,Crt;

Var Bild : TPCXBild;             {Record in MyUtil definiert}

Begin Graphik_Ein('C:\TP\BGI');  {GraphikModus initialisieren}
      Bild.FName:='A:\Comp.prw'; {Name des auf Diskette gespeicherten Bildes
                                  im GetImage Format --> PCX_PAS.PAS}
      PreparePCX(Bild);          {PCX Bild einlesen --> Heap}
      ShowPCX(100,100,Bild);     {PCX Bild an Koordinaten (x,y) ausgeben}
      DisposePCX(Bild);          {PCX Bild vom Heap l”schen}

      Repeat Until Keypressed;
      Graphik_Aus;               {GraphikModus beenden}
End.