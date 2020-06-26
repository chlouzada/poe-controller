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
AutoPortal()
return

Joy6:: ; RT1
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

Joy11:: ; LS
Send,a
return

Joy12:: ; RS
return

; Steam
; Joy13:: ; PS
;return

Joy14::
ToolTip, 111
return