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

toggleJoyLeft := true

flaskDuration := 4000
flaskDelay := 500
flaskNumber := 345

JoyMultiplier := 8
JoyMultiplierPrecision := 0.3

JoystickNumber := 1

JoyThreshold = 5
InvertYAxis := false

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
; END OF CONFIG
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

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

ReleaseKey(key) {
	GetKeyState, state, %key%
	if state = D
		Send {%key% up}
	else
		return false
	return true
}

PressKey(key) {
	GetKeyState, state, %key%
	if state = U
		Send {%key% down}
	else
		return false
	return true
}

ReleaseClick(btn) {
	GetKeyState, state, %btn%
	if state = D
		Click, btn, up
	else
		return false
	return true
}

PressClick(btn) {
	GetKeyState, state, %btn%
	if state = U
		Click, btn, down
	else
		return false
	return true
}

AutoFlask(){
IfWinActive, Path of Exile
  If (A_TickCount > tc_flask + flaskDuration ) {
    Sleep, %flaskDelay%
    Send, %flaskNumber%
    tc_flask := A_TickCount
  }
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
; LABELS
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

SetTimer, WatchJoyLeft, 10
SetTimer, WatchJoyRight, 5
SetTimer, WatchPOV, 5


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
POV := GetKeyState("JoyPOV")
KeyToHoldDownPrev := KeyToHoldDown
if (POV < 0)   ; No angle to report
    KeyToHoldDown := ""
else if (POV > 31500)               ; 315 to 360 degrees: Forward
    KeyToHoldDown := "Ctrl"
else if POV between 0 and 4500      ; 0 to 45 degrees: Forward
    KeyToHoldDown := "Ctrl"
else if POV between 4501 and 13500  ; 45 to 135 degrees: Right
    KeyToHoldDown := "Numpad6"
else if POV between 13501 and 22500 ; 135 to 225 degrees: Down
    KeyToHoldDown := "Numpad2"
else                                ; 225 to 315 degrees: Left
    KeyToHoldDown := "Numpad4"
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
Send, {q up}
SetTimer, WaitForButtonUp7, Off
return

WaitForButtonUp8:
if GetKeyState("Joy8")
    return
Click, up
SetTimer, WaitForButtonUp8, Off
return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
; JOY REMAP
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Joy2::
Click, down, left
SetTimer, WaitForButtonUp2, 10
return

Joy1::
Send, {Space}
return

Joy5::
Send, 1
return

Joy7::
Send, {q down}
SetTimer, WaitForButtonUp7, 10
return

Joy8::
Click, down
SetTimer, WaitForButtonUp8, 10
return

Joy11::
if toggleJoyLeft
	SetTimer, WatchJoyLeft, Off
else
	SetTimer, WatchJoyLeft, 5
toggleJoyLeft := !toggleJoyLeft
return

; Hotkeys

F3::ExitApp
F4::Reload