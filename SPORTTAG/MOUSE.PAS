(********************************************************)
(*							*)
(*		 Mouse Driver Interface			*)
(*			   for				*)
(*		       TURBO Pascal			*)
(*							*)
(*		   Copyright (C) 1986 by		*)
(*		       Logitech Inc.			*)
(*							*)
(*   Version Switzerland by Crivelli Orio               *)
(********************************************************)
(*
Mouse Driver Interface

Short description:

 The procedures implemented in this module provide a
Turbo Pascal interface for the LOGITECH Mouse Driver.
This driver interface is compatible with the Microsoft
Mouse Driver interface, so this module can be used with
all the compatible mouse drivers.
 There is one additional function, DriverInstalled which
should be called to find out if the driver is installed
before calling any other mouse driver functions.
 For detailed description of these functions, please
refer to your mouse documentation:
e.g. LOGITECH Mouse Driver Programmer's Reference Manual
     Microsoft Mouse, Installation and Operation Manual
     File "MOUSE.DOC" on Logimouse Distribution Diskette

Microsoft is a registered trademark of Microsoft Corporation

TURBO Pascal is a registered trademark of Borland Int.
*)
UNIT MOUSE;
INTERFACE
USES DOS;

type RegType = Registers;
     GraphicCursor = record
		      screenMask,
		      cursorMask: ARRAY [0..15] OF word;
		      hotX, hotY: Integer;
	             end;
      (* The screenMask is first ANDed into the display,
	 then the cursorMask is XORed into the display.
	 The hot spot coordinates are relative to the
	 upper-left corner of the cursor image, and define
	 where the cursor actually 'points to'.
      *)


function DriverInstalled : boolean;
procedure FlagReset(VAR mouseStatus, numberOfButtons:Integer);
procedure ShowCursor;
procedure HideCursor;
procedure GetPosBut(VAR buttonStatus, horizontal, vertical:Integer);
procedure SetCursorPos(horizontal, vertical: Integer);
procedure GetButPres(button: Integer;
                       VAR buttonStatus, buttonPressCount,
			   horizontal, vertical: Integer);
procedure GetButRel(button: Integer;
		      VAR buttonStatus: Integer;
		      VAR buttonReleaseCount: Integer;
		      VAR horizontal ,vertical: Integer);
procedure SetHorizontalLimits(minPos, maxPos: Integer);
procedure SetVerticalLimits(minPos, maxPos: Integer);
procedure SetGraphicCursor(VAR cursor: GraphicCursor);
procedure SetTextCursor(selectedCursor,
			  screenMaskORscanStart,
			  cursorMaskORscanStop: Integer);
procedure ReadMotionCounters(VAR horizontal,vertical:Integer);
procedure LightPenOn;
procedure LightPenOff;

IMPLEMENTATION

  function DriverInstalled : boolean;
  const
    iret = 207;
  var
    driverOff, driverSeg : Integer;

  begin
   driverOff := MemW[0000:0204];
   driverSeg := MemW[0000:0206];
   if ((driverSeg <> 0) and (driverOff <> 0)) then
   begin
    if (Mem [driverSeg:driverOff] <> iret) then DriverInstalled := true
    else DriverInstalled := false
   end
   else
   DriverInstalled := false
  end;

  procedure FlagReset(VAR mouseStatus, numberOfButtons:Integer);
    (* Microsoft Mouse Driver System Call 0
	  Input : AX = 0 System Call 0

	  Output: AX --> mouse status
		   0 (FALSE): mouse hardware and software
			      not installed
		  -1 (TRUE) : mouse hardware and software
			      installed
		  BX --> number of mouse buttons
    *)
  var
     regSet : RegType;
  begin
   regSet.AX := 0;
   intr (51, regSet);
   mouseStatus := regSet.AX;
   numberOfButtons := regSet.BX;
  end;

  procedure ShowCursor;
    (* Microsoft Mouse Driver System Call 1
	  Input : AX = 1 System Call 1
    *)
  var
    regSet : RegType;
  begin
   regSet.AX := 1;
   intr (51, regSet);
  end;

  procedure HideCursor;
    (* Microsoft Mouse Driver System Call 2
	  Input : AX = 2 System Call 2
    *)
  var
    regSet : RegType;
  begin
   regSet.AX := 2;
   intr (51, regSet);
  end;

  procedure GetPosBut(VAR buttonStatus, horizontal, vertical:Integer);
    (* Microsoft Mouse Driver System Call 3
	  Input : AX = 3 System Call 3

	  Output: BX --> mouse button status
		  CX --> horizontal cursor position
		  DX --> vertical cursor position
    *)
  var
    regSet : RegType;
  begin
    regSet.AX := 3;
    intr (51, regSet);
    horizontal := regSet.CX;
    vertical := regSet.DX;
    buttonStatus := regSet.BX
  end;


  procedure SetCursorPos(horizontal, vertical: Integer);
    (* Microsoft Mouse Driver System Call 4
	  Input : AX = 4 System Call 4
		  CX <-- horizontal mouse cursor position
		  DX <-- vertical mouse cursor position
    *)
  var
    regSet : RegType;
  begin
    regSet.AX := 4;
    regSet.CX := horizontal;
    regSet.DX := vertical;
    intr (51, regSet);

  end;

  procedure GetButPres(button: Integer;
		       VAR buttonStatus, buttonPressCount,
			   horizontal, vertical: Integer);
    (* Microsoft Mouse Driver System Call 5
	  Input : AX = 5 System Call 5
		  BX <-- button
	  Output: AX --> current button status
		  BX --> count of button presses since
			 last call to this function
		  CX --> horizontal cursor position at
			 last press
		  DX --> vertical cursor position at
			 last press
    *)
  var
    regSet : RegType;
  begin
    regSet.AX := 5;
    regSet.BX := button;
    intr (51, regSet);
    buttonStatus     := regSet.AX;
    buttonPressCount := regSet.BX;
    horizontal       := regSet.CX;
    vertical	 := regSet.DX;
  end;

  procedure GetButRel(button: Integer;
		      VAR buttonStatus: Integer;
		      VAR buttonReleaseCount: Integer;
		      VAR horizontal ,vertical: Integer);
    (* Microsoft Mouse Driver System Call 6
	  Input : AX = 6 System Call 6
		  BX <-- button
	  Output: AX --> current button status
		  BX --> count of button releases since
			 last call to this function
		  CX --> horizontal cursor position at
			 last press
		  DX --> vertical cursor position at
			 last press
    *)
  var
    regSet : RegType;
  begin
    regSet.AX := 6;
    regSet.BX := button;
    intr (51, regSet);
    buttonStatus       := regSet.AX;
    buttonReleaseCount := regSet.BX;
    horizontal	 := regSet.CX;
    vertical	   := regSet.DX;
  end;

  procedure SetHorizontalLimits(minPos, maxPos: Integer);
    (* Microsoft Mouse Driver System Call 7
	  Input : AX = 7 System Call 7
		  CX <-- minimum horizontal position
		  DX <-- maximum horizontal position
    *)
  var
    regSet : RegType;
  begin
    regSet.AX := 7;
    regSet.CX := minPos;
    regSet.DX := maxPos;
    intr (51, regSet);
  end;

  procedure SetVerticalLimits(minPos, maxPos: Integer);
    (* Microsoft Mouse Driver System Call 8
	  Input : AX = 8 System Call 8
		  CX <-- minimum vertical position
		  DX <-- maximum vertical position
    *)
  var
    regSet : RegType;
  begin
    regSet.AX := 8;
    regSet.CX := minPos;
    regSet.DX := maxPos;
    intr (51, regSet);
  end;


      (* The screenMask is first ANDed into the display,
	 then the cursorMask is XORed into the display.
	 The hot spot coordinates are relative to the
	 upper-left corner of the cursor image, and define
	 where the cursor actually 'points to'.
      *)



  procedure SetGraphicCursor(VAR cursor: GraphicCursor);
    (* Microsoft Mouse Driver System Call 9
	  Input : AX = 9 System Call 9
		  BX    <-- cursor hot spot (horizontal)
		  CX    <-- cursor hot spot (vertical)
		  ES:DX <-- pointer to screen and cursor
			    masks
    *)
  var
    regSet : RegType;
  begin
    regSet.AX := 9;
    regSet.DX := Ofs (cursor.screenMask);
    regSet.ES := Seg (cursor.screenMask);
    regSet.BX := cursor.hotX;
    regSet.CX := cursor.hotY;
    intr (51, regSet);
  end;


  procedure SetTextCursor(selectedCursor,
			  screenMaskORscanStart,
			  cursorMaskORscanStop: Integer);
    (* Microsoft Mouse Driver System Call 10
	  Input : AX = 10 System Call 10
		  BX <-- cursor select
			 0: Software text cursor
			 1: Hardware text cursor
		  CX <-- screen mask value or
			 scan line start
		  DX <-- cursor mask value or
			 scan line stop

	  For the software text cursor, the second two
       parameters specify the screen and cursor masks.
       The screen mask is first ANDed into the display,
       then the cursor mask is XORed into the display.
	  For the hardware text cursor, the second two
       parameters contain the line numbers of the first
       and last scan line in the cursor to be shown on
       the screen.
    *)
  var
    regSet : RegType;
  begin
    regSet.AX := 10;
    regSet.BX := selectedCursor;
    regSet.CX := screenMaskORscanStart;
    regSet.DX := cursorMaskORscanStop;
    intr (51, regSet);
 end;


  procedure ReadMotionCounters(VAR horizontal,
				   vertical:Integer);
    (* Microsoft Mouse Driver System Call 11
	  Input : AX = 11 System Call 11
		  CX <-- horizontal count
		  DX <-- vertical count
    *)
  var
    regSet : RegType;
  begin
    regSet.AX := 11;
    intr (51, regSet);
    horizontal:=regSet.CX;
    vertical:=regSet.DX;
  end;

type
 PrivateHandlerType = RECORD
			CS:char; MovSegToMem:char; DS:char; DriverDSeg:Integer;
			(* Mov word ptr CS:DriverDSeg, DS; saves the driver's DS *)
			CS2:char; MovMemToSeg:char; DS2:char; PascalDSeg:Integer;
			(* Mov DS, word ptr PascalDSeg *)
			(* Set up Pascal DS *)
			PushAX, PushBX, PushCX, PushDX: char;
			NearCall: char;
			handlerProc: Integer;
			CS3:char; MovMemToSeg2:char; DS3:char; DriverDSeg2:Integer;
			(* Mov DS, word ptr CS:DriverDSeg *)
			FarRet : char;
		      END;
const PrivateHandler: PrivateHandlerType
		   = (CS:#46; MovSegToMem:#140; DS:#30; DriverDSeg:0;
		      CS2:#46; MovMemToSeg:#142; DS2:#30; PascalDSeg:0;
		      PushAx:#80; PushBX:#83; PushCX:#81; PushDX:#82;
		      NearCall:#232; handlerProc:0;
		      CS3:#46; MovMemToSeg2:#142; DS3:#30; DriverDSeg2:0;
		      FarRet:#203);

const DriverDSeg: Integer = 0;
(* when the eventhandler is called,
   the drivers data segment will be stored here *)
const PascalDSeg: Integer = 0;

(*
  PROCEDURE EventHandler (EventSet,   { condition mask	}
			  ButtonSet,  { button state	  }
			  horiz,      { horizontal cursor pos }
			  vert	{ vertical cursor pos   }
			  :Integer);
*)

  procedure SetEventHandler(mask    : Integer; (* should be of type EventSet *)
			    EventHandler : Integer);(* Ofs(procName) *)
  (* the procedure EventHandler must have 4 integer params, see above *)
    (* Microsoft Mouse Driver System Call 12
	  Input : AX = 12 System Call 12
		  CX    <-- call mask
		  ES:DX <-- address of handler routine

       Establish conditions and handler for mouse events.
       After this, when an event occurs that is in the
       mask, the handler is called with the event set that
       actually occurred, the current button status, and
       the cursor x and y.
    *)
  var
    regSet : RegType;
  begin
   {$R-}
   PrivateHandler.handlerProc := EventHandler - (Ofs(PrivateHandler.handlerProc)+2);
   PascalDSeg := Dseg;
   PrivateHandler.PascalDSeg := Ofs(PascalDSeg);
   PrivateHandler.DriverDSeg := Ofs(DriverDSeg);
   PrivateHandler.DriverDSeg2 := Ofs(DriverDSeg);
   (* turn off range checking to avoid runtime range error *)
   {$R+}

    regSet.AX := 12;
    regSet.CX := mask;
    regSet.ES := Cseg;
    regSet.DX := Ofs (PrivateHandler);
    intr (51, regSet);
  end;


  procedure LightPenOn;
    (* Microsoft Mouse Driver System Call 13
	  Input : AX = 13 System Call 13
    *)
  var
    regSet : RegType;
  begin
    regSet.AX := 13;
    intr (51, regSet);
  end;

  procedure LightPenOff;
    (* Microsoft Mouse Driver System Call 14
	  Input : AX = 14 System Call 14
    *)
  var
    regSet : RegType;
  begin
    regSet.AX := 14;
    intr (51, regSet);
  end;

  procedure SetMickeysPerPixel(horPix, verPix: Integer);
    (* Microsoft Mouse Driver System Call 15
	  Input : AX = 15 System Call 15
		  CX <-- horizontal mickey/pixel ratio
		  DX <-- vertical mickey/pixel ratio
    *)
  var
    regSet : RegType;
  begin
    regSet.AX := 15;
    regSet.CX := horPix;
    regSet.DX := verPix;
    intr (51, regSet);
  end;


  procedure ConditionalOff(left, top,
			   right, bottom: Integer);
    (* Microsoft Mouse Driver System Call 16
	  Input : AX = 16 System Call 16
		  CX <-- left
		  DX <-- top
		  SI <-- right
		  DI <-- bottom
    *)
  var
    regSet : RegType;
  begin
    regSet.AX := 16;
    regSet.CX := left;
    regSet.DX := top;
    regSet.SI := right;
    regSet.DI := bottom;
    intr (51, regSet);
  end;

  procedure SetSpeedThreshold(threshold: Integer);
    (* Microsoft Mouse Driver System Call 19
	  Input : AX = 19 System Call 19
		  DX <-- threshold in mickeys/second
    *)
  var
    regSet : RegType;
  begin
    regSet.AX := 19;
    regSet.DX := threshold;
    intr (51, regSet);
  end;

END.  {ENDE VON MOUSE.TPU}

