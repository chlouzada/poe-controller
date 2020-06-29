#SingleInstance Force
#Persistent

; Border Color 0x424242

; CoordMode, Mouse, Screen
CoordMode, ToolTip, Screen

hX := 0
hY := 0

lastFindX := 0
lastFindY := 0

FindLoot() {
  global
  sizeItemBorder := 0
  ImageSearch, hX, hY, lastFindX, lastFindY, A_ScreenWidth, A_ScreenHeight, img\itemBorder.png
  itemX := hX + 5 
  itemY := hY + 5 
  if (ErrorLevel = 2)
    ToolTip, Could not conduct the search.
  else if (ErrorLevel = 1) {
    ToolTip, Not Found. Reset...
    lastFindX := 0
    lastFindY := 0
    Sleep, 500
    ToolTip
  } else {
    While True {
      PixelGetColor, pixelColor, hX, hY
      if (pixelColor = 0x424242) {
        sizeItemBorder := sizeItemBorder + 1
        hY := hY + 1
      } else
        break
    }
    lastFindY := hY + sizeItemBorder
    ToolTip, %lastFindHorizontal%
    MouseMove, itemX, itemY
  }
}

F1::FindLoot()
F4::Reload