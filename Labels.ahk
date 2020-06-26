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

;; Hotkey support label

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