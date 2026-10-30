{$A+,G+,N+,X+}
{$E-,F-,I-,L-,R-,S-,V-,B-,D-}
Program Mandelbrot;
Uses Crt,Dos,MyUtil;
const lim:extended=100.0;
      maxiterat:word=100;

type rgbrectyp=record
                 r,g,b:byte;
               end;
     palettetyp=array[1..100]of rgbrectyp;
     mcgaobj=object
               xmax,ymax,firstpaletteset,palettesetcount:word;
               oldmode:byte;
               gork:boolean;
               palette:palettetyp;
               regs:registers;
               constructor init;
               procedure putpixel(x,y:word;color:byte); virtual;
               procedure storergbpal(pal:palettetyp);
               procedure setrgbpal;
               destructor done; virtual;
             end;
     mcgaobjptr=^mcgaobj;
     limitrec=record
                left,right,top,bottom:double;
              end;
     pslow_mandobj=^slow_mandobj;
     slow_mandobj=object(mcgaobj)
                    limits:limitrec;
                    xscreen,yscreen,xscrstart,yscrstart:word;
                    constructor init;
                    function calculate(cr,ci:extended):word; virtual;
                    function mapping:boolean;
                  end;
     pfast_mandobj=^fast_mandobj;
     fast_mandobj=object(slow_mandobj)
                   function calculate(cr,ci:extended):word; virtual;
                 end;
const apfpalette:palettetyp=((r:0;g:0;b:0),(r:29;g:27;b:30),(r:32;g:21;b:23),
                             (r:33;g:21;b:24),(r:35;g:18;b:21),(r:37;g:16;b:19),
                             (r:39;g:14;b:17),(r:41;g:12;b:15),(r:43;g:10;b:13),
                             (r:45;g:8;b:11),(r:45;g:11;b:0),(r:46;g:7;b:5),
                             (r:46;g:7;b:12),(r:46;g:7;b:19),(r:46;g:7;b:24),
                             (r:46;g:7;b:27),(r:46;g:13;b:24),(r:46;g:15;b:22),
                             (r:46;g:17;b:20),(r:46;g:19;b:18),(r:46;g:21;b:16),
                             (r:46;g:23;b:14),(r:46;g:25;b:12),(r:46;g:27;b:10),
                             (r:46;g:29;b:8),(r:46;g:31;b:6),(r:46;g:33;b:4),
                             (r:46;g:35;b:2),(r:46;g:37;b:0),(r:46;g:35;b:9),
                             (r:45;g:33;b:11),(r:44;g:31;b:13),(r:43;g:29;b:15),
                             (r:42;g:27;b:17),(r:41;g:25;b:19),(r:40;g:23;b:18),
                             (r:41;g:21;b:20),(r:42;g:19;b:22),(r:44;g:17;b:14),
                             (r:45;g:15;b:26),(r:45;g:13;b:28),(r:45;g:11;b:30),
                             (r:45;g:9;b:32),(r:45;g:7;b:34),(r:45;g:5;b:36),
                             (r:45;g:3;b:38),(r:45;g:1;b:40),(r:45;g:0;b:42),
                             (r:44;g:0;b:41),(r:43;g:0;b:40),(r:42;g:0;b:39),
                             (r:41;g:0;b:38),(r:40;g:0;b:37),(r:39;g:0;b:36),
                             (r:38;g:0;b:35),(r:37;g:0;b:34),(r:36;g:0;b:33),
                             (r:35;g:0;b:32),(r:34;g:0;b:31),(r:33;g:0;b:30),
                             (r:32;g:0;b:29),(r:31;g:0;b:28),(r:30;g:0;b:27),
                             (r:29;g:0;b:26),(r:28;g:0;b:25),(r:27;g:1;b:24),
                             (r:26;g:2;b:23),(r:25;g:3;b:22),(r:24;g:4;b:21),
                             (r:23;g:5;b:20),(r:22;g:6;b:19),(r:21;g:7;b:18),
                             (r:20;g:8;b:17),(r:19;g:9;b:16),(r:18;g:10;b:15),
                             (r:17;g:11;b:14),(r:16;g:12;b:13),(r:15;g:12;b:12),
                             (r:14;g:11;b:11),(r:13;g:09;b:14),(r:12;g:08;b:14),
                             (r:11;g:07;b:14),(r:10;g:06;b:14),(r:10;g:05;b:14),
                             (r:09;g:04;b:14),(r:09;g:03;b:13),(r:08;g:02;b:12),
                             (r:08;g:01;b:11),(r:07;g:00;b:10),(r:07;g:01;b:10),
                             (r:06;g:02;b:09),(r:06;g:03;b:09),(r:05;g:04;b:08),
                             (r:05;g:05;b:08),(r:04;g:05;b:07),(r:04;g:04;b:07),
                             (r:03;g:03;b:06),(r:03;g:02;b:06),(r:03;g:01;b:05),
                             (r:00;g:00;b:00));
constructor mcgaobj.init;
begin regs.ah:=$1A; regs.al:=0;
      intr($10,regs);
      gork:=(regs.al=$1A)and((regs.bl=7)or(regs.bl=8)or(regs.bh=7)or(regs.bl=8));
      if not gork then fail;
      regs.ah:=$0F;
      intr($10,regs);
      oldmode:=regs.al;
      xmax:=0; ymax:=0;
      regs.ah:=0; regs.al:=$12;
      intr($10,regs);
      regs.ah:=0; regs.al:=$13;
      intr($10,regs);
      xmax:=319; ymax:=199;
end;

procedure mcgaobj.storergbpal;
begin palette:=pal;
end;

procedure mcgaobj.setrgbpal;
begin with regs do
         begin ah:=$10; al:=$12;
               bx:=firstpaletteset;
               cx:=palettesetcount;
               es:=seg(palette);
               dx:=ofs(palette);
         end;
      intr($10,regs);
end;

procedure mcgaobj.putpixel;
begin mem[$A000:320*y+x]:=color;
end;

destructor mcgaobj.done;
begin regs.ah:=0; regs.al:=oldmode;
      intr($10,regs);
end;

constructor slow_mandobj.init;
var i:word;
begin mcgaobj.init;
      if not gork then fail;
      with limits do
         begin left:=-1.0; right:=2.2;
               top:=1.4; bottom:=-1.4;
         end;
      xscrstart:=0; yscrstart:=0;
      yscreen:=succ(ymax);
      xscreen:=succ(xmax);
      firstpaletteset:=1;
      palettesetcount:=100;
      storergbpal(apfpalette);
      setrgbpal;
end;

function slow_mandobj.calculate;
var iterat:integer;
    x,y,sqrx,sqry:extended;
begin iterat:=0; x:=0.0; y:=0.0;
      sqrx:=0; sqry:=0;
      repeat inc(iterat);
             y:=x*y; y:=y+y-ci;
             x:=sqrx-sqry-cr;
             sqrx:=sqr(x); sqry:=sqr(y);
      until (iterat=maxiterat)or(sqrx+sqry>lim);
      calculate:=iterat;
end;
function slow_mandobj.mapping;
var yscr,xscr:integer;
    iterat:word;
    x,y,delta_x,delta_y:extended;
begin with limits do
         begin delta_x:=(right-left)/xscreen;
               delta_y:=(top-bottom)/yscreen;
               y:=top;
               for yscr:=yscrstart to yscrstart+yscreen-1 do
                   begin x:=left;
                         for xscr:=xscrstart to xscrstart+xscreen do
                             begin putpixel(xscr,yscr,calculate(x,y));
                                   x:=x+delta_x;
                             end;
                             y:=y-delta_y;
                             if keypressed then
                                begin if readkey=#0 then readkey;
                                      mapping:=false;
                                      exit;
                                end;
                   end;
         end;
         mapping:=true;
end;

function fast_mandobj.calculate; assembler;
  asm
    mov cx,maxiterat
    fld ci
    fld cr
    fld lim
    fldz
    fldz
    fldz
    fldz
    @1:
      fmulp
      fadd st,st
      fsub st,st(5)
      fld st
      fxch st(2)
      fsub st,st(3)
      fsub st,st(5)
      fld st
      fmul st,st(1)
      fxch st(3)
      fmul st,st(2)
      fst st(4)
      fadd st,st(3)
      fcomp st(5)
    wait
    fstsw ax
    test ah,1
    loopnz @1
    finit
    neg cx
    add cx,maxiterat
    mov ax,cx
end;

function no80x87:boolean; assembler;
asm
   finit
   wait
   fstsw ax
end;

var pmand:pslow_mandobj;

begin checkbreak:=false;
      clrscr;
      if no80x87 then
         begin write('Kein Coprocessor installiert.');
               readkey;
               halt;
         end;
      TextBackGround(lightgray);
      clrScr;
      TextColor(red);
      GotoXY(15,3); Write('Coprocessor Demonstration anhand der Mandelbrotmenge');
      TextColor(Black);
      GotoXY(10,6); write('Zuerst "langsame" Ausgabe mit von Turbo Pascal erzeugtem Code,');
      GotoXY(15,7); write('mit beliebiger Taste wechseln zur schnelleren Ausgabe');
      GotoXY(25,8); write('mit direkter 80x87-Programmierung');
      GotoXY(27,10);write('Start mit beliebiger Taste...');
      GotoXY(1,25);
      if readkey=#0 then readkey;
      pmand:=new(pslow_mandobj,init);
      if pmand<>nil then
         begin if pmand^.mapping then readkey;
               dispose(pslow_mandobj(pmand),done);
               pmand:=new(pfast_mandobj,init);
               if pmand^.mapping then readkey;
               dispose(Pfast_mandobj(pmand),done);
         end
         else writeln('Keine VGA-Karte angeschlossen!');
end.