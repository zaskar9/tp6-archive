Program Muehle;
Uses Crt,Graph, MyUtil;

Var X,Y : Array[1..24] of Integer;
    Lage: Array[1..24] of Integer;
    Spieler1, Spieler2 : String;
    Spielfertig        : Boolean;
    ZugZahl            : Integer;


      Procedure Initialisierung;
      Var i:Integer;
      Begin X[ 1]:=300; Y[ 1]:=150;
            X[ 2]:=450; Y[ 2]:=150;
            X[ 3]:=600; Y[ 3]:=150;
            X[ 4]:=600; Y[ 4]:=300;
            X[ 5]:=600; Y[ 5]:=450;
            X[ 6]:=450; Y[ 6]:=450;
            X[ 7]:=300; Y[ 7]:=450;
            X[ 8]:=300; Y[ 8]:=300;
            X[ 9]:=350; Y[ 9]:=200;
            X[10]:=450; Y[10]:=200;
            X[11]:=550; Y[11]:=200;
            X[12]:=550; Y[12]:=300;
            X[13]:=550; Y[13]:=400;
            X[14]:=450; Y[14]:=400;
            X[15]:=350; Y[15]:=400;
            X[16]:=350; Y[16]:=300;
            X[17]:=400; Y[17]:=250;
            X[18]:=450; Y[18]:=250;
            X[19]:=500; Y[19]:=250;
            X[20]:=500; Y[20]:=300;
            X[21]:=500; Y[21]:=350;
            X[22]:=450; Y[22]:=350;
            X[23]:=400; Y[23]:=350;
            X[24]:=400; Y[24]:=300;
            for i:=1 to 24 do Lage[i]:=0;
            ZugZahl:=0;
      end;


      Procedure Spielfeld;
      Var i:Integer;
          si:string;
      Begin SetColor(7);
            SetTextstyle(4,0,5);
            OutTextXY(100,30,'Mhle');
            Setfillstyle(1,red);
            Bar(270,120,630,480);
            Setcolor(white);
            Rectangle(X[1],Y[1],X[5],Y[5]);
            Rectangle(X[9],Y[9],X[13],Y[13]);
            Rectangle(X[17],Y[17],X[21],Y[21]);
            Line(X[8],Y[8],X[24],Y[24]);
            Line(X[20],Y[20],X[4],Y[4]);
            Line(X[22],Y[22],X[6],Y[6]);
            Line(X[2],Y[2],X[18],Y[18]);
            SetTextStyle(SmallFont,HorizDir,0);
            for i:=1 to 24 do
              begin Str(i:1,si);
                    OuttextXY(X[i]+3,Y[i],si)
              end
      end;

      Procedure ZeichneKnopf(i:Integer);
      Var aktColor:Integer;
          si:string;
      Begin aktColor:=GetColor;
            if Lage[i]=1
               then begin SetColor(lightgray);
                          Circle(X[i],Y[i],18);
                          SetFillStyle(SolidFill,lightgray);
                          FloodFill(X[i],Y[i],lightgray)
                    end;
            if Lage[i]=-1
               then begin SetColor(black);
                          Circle(X[i],Y[i],18);
                          SetFillStyle(SolidFill,black);
                          FloodFill(X[i],Y[i],black)
                    end;
            if Lage[i ]=0
               then begin {Hier l”schen}
                    end;
            SetColor(white);
            SetTextStyle(SmallFont,HorizDir,0);
            Str(i:1,si);
            OuttextXY(X[i]+3,Y[i],si);
            SetColor(aktColor);
      End;

      Procedure SpielFeldNeuZeichnen;
      Var i:Integer;
      Begin for i:=1 to 24 do ZeichneKnopf(i)
      End;


      Procedure Name_eingeben;
      Begin SetTextstyle(2,0,5);
            InTextXY(20,100,'1. Spieler: ',Spieler1);
            InTextXY(20,120,'2. Spieler: ',Spieler2);

      End;

      Procedure Zug(AktSpieler:String);
      Var Nr1,Nr2,SpCode:Integer;

          Function ZugIO:Boolean;
          Var ok: Boolean;
          Begin ok:=true;
                if ok and (ZugZahl>18) then
                           if (Nr1<1) or (Nr1>24) then ok:=false;
                if ok then if (Nr2<1) or (Nr2>24) then ok:=false;

                if ok and (ZugZahl>18) then
                           if Lage[Nr1]<>SpCode then ok:=false;
                if ok then if Lage[Nr2]<>0 then ok:=false;

                ZugIO:=ok
          End;

      Begin ZugZahl:=ZugZahl+1;
            repeat SetViewPort(18,180,250,300,true);
                   ClearViewPort;
                   SetViewPort(0,0,GetMaxX,GetMaxY,true);
                   OutTextXY(20,200,'Am Zug : '+AktSpieler);
                   if ZugZahl >18 then
                         InIntXY(20,220,'Ihren Zug von : ',Nr1);
                   InIntXY(20,240,'          zu  : ',Nr2);
                   if AktSpieler=Spieler1 then SpCode:=1 else SpCode:=-1
            until ZugIO;
            if (ZugZahl>18) then Lage[Nr1]:=0;
            Lage[Nr2]:=SpCode;
            SpielFeldNeuZeichnen
      End;

      Procedure Pruefen;
      Begin
            Spielfertig:=false;
      End;

      Procedure Punktezaehlen;
      Begin
      End;

      Procedure Rangliste;
      Begin
      End;

Begin ClrScr;
      Graphik_ein('C:\Tp\Bgi');
      Initialisierung;
      Spielfertig:=false;
      Spielfeld;
      Name_eingeben;
      repeat Zug(Spieler1);
             Pruefen;
             if not Spielfertig then
                 begin Zug(Spieler2);
                       Pruefen
                 end;
      until Spielfertig;
      Graphik_aus
End.

