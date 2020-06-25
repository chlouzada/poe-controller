#SingleInstance Force
#Persistent

CoordMode, Mouse, Screen

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
; CONFIG
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

defaultCenterX = 960
defaultCenterY = 470

UpPOV := "Ctrl"
DownPOV := "p"
LeftPOV := "i"
RightPOV := "Tab"

utilityFlask := 5
lifeFlask := 1
manaFlask := 2

FlaskAutoToggle := true
FlaskAutoDuration := 4000
FlaskAutoDelay := 500
FlaskAutoPosition := 345

JoyMultiplier := 8
JoyMultiplierPrecision := 0.3

JoystickNumber := 1

JoyThreshold = 5
InvertYAxis := false
TriggerThreshold = 10

SetTimerDelay := 5

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
; END OF CONFIG
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; toggleJoyLeft := true

JoyThresholdUpper := 50 + JoyThreshold
JoyThresholdLower := 50 - JoyThreshold
if InvertYAxis
	YAxisMultiplier = -1
else
	YAxisMultiplier = 1

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
; FUCTIONS
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

FlaskLife(){
	global lifeFlask
	Send, %lifeFlask%
}

FlaskMana(){
	global manaFlask
	Send, %manaFlask%
}

FlaskUtility(){
	global utilityFlask
	Send, %utilityFlask%
}

FlaskAuto(){
global FlaskAutoDelay
global FlaskAutoDuration
global FlaskAutoPosition
IfWinActive, Path of Exile
  If (A_TickCount > tc_flask + FlaskAutoDuration ) {
    Sleep, %FlaskAutoDelay%
    Send, %FlaskAutoPosition%
    tc_flask := A_TickCount
  }
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
; LABELS
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

SetTimer, WatchJoyLeft, %SetTimerDelay%
SetTimer, WatchJoyRight, %SetTimerDelay%
SetTimer, WatchPOV, %SetTimerDelay%

WatchJoyLeft:
MouseNeedsToBeMoved := false  ; Set default.
SetFormat, float, 03
GetKeyState, JoyX, %JoystickNumber%JoyX
GetKeyState, JoyY, %JoystickNumber%JoyY
if JoyX > %JoyThresholdUpper%
{
	MouseNeedsToBeMoved := true
	DeltaX := JoyX - JoyThresholdUpper
}
else if JoyX < %JoyThresholdLower%
{
	MouseNeedsToBeMoved := true
	DeltaX := JoyX - JoyThresholdLower
}
else
	DeltaX = 0
if JoyY > %JoyThresholdUpper%
{
	MouseNeedsToBeMoved := true
	DeltaY := JoyY - JoyThresholdUpper
}
else if JoyY < %JoyThresholdLower%
{
	MouseNeedsToBeMoved := true
	DeltaY := JoyY - JoyThresholdLower
}
else
	DeltaY = 0
if MouseNeedsToBeMoved
{
	SetMouseDelay, -1
	x := 960 + DeltaX * JoyMultiplier 
	y := 470 + DeltaY * JoyMultiplier  * YAxisMultiplier
	MouseMove, x, y, 0
}
return

WatchJoyRight:
MouseNeedsToBeMoved := false
SetFormat, float, 03
GetKeyState, JoyX, %JoystickNumber%JoyZ
GetKeyState, JoyY, %JoystickNumber%JoyR
if JoyX > %JoyThresholdUpper%
{
	MouseNeedsToBeMoved := true
	DeltaX := JoyX - JoyThresholdUpper
}
else if JoyX < %JoyThresholdLower%
{
	MouseNeedsToBeMoved := true
	DeltaX := JoyX - JoyThresholdLower
}
else
	DeltaX = 0
if JoyY > %JoyThresholdUpper%
{
	MouseNeedsToBeMoved := true
	DeltaY := JoyY - JoyThresholdUpper
}
else if JoyY < %JoyThresholdLower%
{
	MouseNeedsToBeMoved := true
	DeltaY := JoyY - JoyThresholdLower
}
else
	DeltaY = 0
if MouseNeedsToBeMoved
{
	SetMouseDelay, -1  ; Makes movement smoother.
	MouseMove, DeltaX * JoyMultiplierPrecision, DeltaY * JoyMultiplierPrecision * YAxisMultiplier, 0, R
}
return


WatchPOV:
; Old
; POV := GetKeyState("JoyPOV")
; KeyToHoldDownPrev := KeyToHoldDown
; if (POV < 0)   ; No angle to report
;     KeyToHoldDown := ""
; else if (POV > 31500)               ; 315 to 360 degrees: Forward
;     KeyToHoldDown := "Ctrl"
; else if POV between 0 and 4500      ; 0 to 45 degrees: Forward
;     KeyToHoldDown := "Ctrl"
; else if POV between 4501 and 13500  ; 45 to 135 degrees: Right
;     KeyToHoldDown := "Numpad6"
; else if POV between 13501 and 22500 ; 135 to 225 degrees: Down
;     KeyToHoldDown := "Numpad2"
; else                                ; 225 to 315 degrees: Left
;     KeyToHoldDown := "Numpad4"
; if (KeyToHoldDown = KeyToHoldDownPrev)
;     return
; SetKeyDelay -1
; if KeyToHoldDownPrev
;     Send, {%KeyToHoldDownPrev% up}
; if KeyToHoldDown  
;     Send, {%KeyToHoldDown% down}
POV := GetKeyState("JoyPOV")
KeyToHoldDownPrev := KeyToHoldDown
if (POV < 0)
	KeyToHoldDown := ""
else if (POV = 0) ;	Up
    KeyToHoldDown := UpPOV
else if (POV = 9000) ; Left
    KeyToHoldDown := LeftPOV
else if POV = 18000 ; Down
    KeyToHoldDown := DownPOV
else ; Right
    KeyToHoldDown := RightPOV
if (KeyToHoldDown = KeyToHoldDownPrev)
    return
SetKeyDelay -1
if KeyToHoldDownPrev
    Send, {%KeyToHoldDownPrev% up}
if KeyToHoldDown  
    Send, {%KeyToHoldDown% down}
return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
; LABELS
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

WaitForButtonUp2:
if GetKeyState("Joy2")
    return
Click, up, left
SetTimer, WaitForButtonUp2, Off
return

WaitForButtonUp7:
if GetKeyState("Joy7")
    return
Click, up, left
SetTimer, WaitForButtonUp7, Off
return

WaitForButtonUp8:
if GetKeyState("Joy8")
    return
Click, up, right
SetTimer, WaitForButtonUp8, Off
return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
; JOY REMAP
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Joy1:: ; SQUARE
Send, t
return

Joy2:: ; X
if GetKeyState("Joy7") ;; Unclick Protect
    return
Click, down, left
SetTimer, WaitForButtonUp2, %SetTimerDelay%
return

Joy3:: ; CIRCLE
FlaskUtility()
return

Joy4:: ; TRIANGLE
FlaskLife()
return

Joy5:: ; LT1
FlaskMana()
return

Joy7:: ; LT2
Click, down, left
SetTimer, WaitForButtonUp7, %SetTimerDelay%
return

Joy8:: ; RT2
Click, down, right
if FlaskAutoToggle
	FlaskAuto()
SetTimer, WaitForButtonUp8, %SetTimerDelay%
return

Joy9:: ; SHARE
Send, {Space}
return

Joy10:: ; OPTIONS
Send, {Esc}
return

; Joy11:: ;; NO USE
; if toggleJoyLeft
; 	SetTimer, WatchJoyLeft, Off
; else
; 	SetTimer, WatchJoyLeft, %SetTimerDelay%
; toggleJoyLeft := !toggleJoyLeft
; return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
; HOTKEY
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

F3::ExitApp
F4::Reload