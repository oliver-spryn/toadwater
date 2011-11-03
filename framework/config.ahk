; This framework includes many of the calculations and logic necessary 
; to allow developers to easily and efficently, develop a marco for
; Toadwater. Many of the difficulties Toadwater can give a developer has
; been compsenated within this framework.
;
; Created by: Oliver Spryn

; -------------------------------
; Pre-gamplay setup
; -------------------------------

; Set the coordinate mode relative to the entire screen
CoordMode, Mouse, Screen

; Parse the config file created by the setup and use its variables, or otherwise create the empty variables here
if (FileExist(configFile)) {
  FileRead, configContents, %configFile%
  
  Loop, parse, configContents, |
  {
    if (A_Index = 1) {
      windowName = %A_LoopField%
    } else {
      value := A_Index - 1 ; The counter will be +1 of all of the inventory items, since the first parsed item was the username
      inv%value% = %A_LoopField%
    }
  }
} else {
  windowName = "" ; The user's Toadwater username, which makes up the title of the Toadwater Window
  
  ; A loop creating the variables inv1 - inv20, each to be used for an inventory item
  loop 20 {
    inv%A_Index% = 
  } 
}

; -------------------------------
; Login
; -------------------------------

; Create a waiting window
Gui, +AlwaysOnTop -SysMenu
Gui, Color, White
Gui, Add, Text, x0 y40 w300 Center cBlack, Logging you in... ; ClassNN = "Static1" according to Window Spy
Gui, Show, w300 h100 Center, Start up

; The actual title of the Toadwater window
parsedName = TWC (%windowName%)

; Close any existing Toadwater windows, then open, focus on, and maximize on a new Toadwater window
if (WinExist(parsedName)) {
  WinClose TWC (%windowName%)
  sleep 1000
  Run %A_ProgramFiles%\Toadwater\TWC.exe
} else if (WinExist("TWC")) {
  WinClose TWC
  sleep 1000
  Run %A_ProgramFiles%\Toadwater\TWC.exe
} else {
  Run %A_ProgramFiles%\Toadwater\TWC.exe
}

sleep 1000
WinActivate, TWC
WinClose, Login
WinMaximize, TWC

; Keep trying to login, as it doesn't always work the first time :(
loop {
  Send ^l
  Send {Enter}
  
  sleep 5000
  
  if (WinExist(parsedName)) {
    break
  }
}

; -------------------------------
; Configuration
; -------------------------------

; ------------------------------- Part 1 | System configuration -------------------------------
SysGet, windowBorder, 31 ; The height, in pixels, of the window border enclosing the Toadwater application
Sysget, menuHeight, 15 ; The height, in pixels, of the Toadwater application menu
SysGet, workableArea, MonitorWorkArea ; The area, in pixels, that a window may consume (screen height - task bar height)
screenWidth := workableAreaRight ; The width of the screen that a window may consume, in pixels
screenHeight := workableAreaBottom ; The height of the screen that a window may consume, in pixels

; ------------------------------- Part 2 | Application specifications -------------------------------
; Modify the waiting window
GuiControl, hide, Static1
Gui, Add, Text, x0 y30 w300 Center cBlack, Please wait while the marco is configured...`nDo not move your mouse during this process  ; ClassNN = "Static1" according to Window Spy

; Scan recursively for the left end (a.k.a the width) of the dock bar
MouseMove, screenWidth, screenHeight - 10
sleep 1000

loop {
; Move the mouse to the appropriate location
  MouseMove, screenWidth - A_Index, screenHeight - 10

; Parse the color from Window Spy
  WinGetText, color, Active Window Info (Shift-Alt-Tab to freeze display)
  sleep 100
  colorPos := InStr(color, "0x")
  StringTrimLeft, colorTrim, color, colorPos - 1
  StringSplit, colorParsed, colorTrim, %A_Space%
  
  if (colorParsed1 != 0xF0F0F0) {
    dockBarWidth := A_Index ; The width, in pixels, of the right-side dock bar
    break
  }
}

; Destroy the waiting window
Gui, Destroy

inventorySpacing = 14 ; The amount of space, in pixels, between each of the items in the inventory
inventoryClick := screenWidth - 100 ; The x-position of the inventory list
cellSize = 77 ; The width and height, in pixels, of a cell, when the game is configured as instructed above

cellPaddingX := Round(Mod(((screenWidth - dockBarWidth) / 2) - Round(cellSize / 2), cellSize)) ; Compute the padding added by partially hidden cells in the X direction
cellPaddingY := Round(Mod(((screenHeight - (windowBorder + menuHeight)) / 2) - Round(cellSize / 2), cellSize)) ; Compute the padding added by partially hidden cells in the Y direction 
cellsX := Floor((screenWidth - dockBarWidth - (cellPaddingX * 2)) / cellSize) ; The number of visibile cells to evaluate in the X direction
cellsY := Floor((screenHeight - (windowBorder + menuHeight) - (cellPaddingY * 2)) / cellSize) ; The number of visibile cells to evaluate in the Y direction

balsamFir = 0xA5ADBC ; The color of a targeted location that identifies a Balsam Fir Tree

healthGood = 0x00C000 ; Health meter color indicator, good
healthFair = 0x00C0C0 ; Health meter color indicator, fair
healthPoor = 0x0000C0 ; Health meter color indicator, poor

; ------------------------------- Part 3 | Variables manipulated by the macro -------------------------------

color = 0 ; The hexadecimal color under the mouse
hoverCellX = 0 ; The x position of the cell number that the mouse currently hovering over
hoverCellY = 0 ; The y position of the cell number that the mouse currently hovering over
loops = 0 ; The number of times the cell scanning algorthim must loop in order to cover every visible cell
loopCount = 0 ; A variable to hold the current A_Index value of a parent loop
breakLoop = 0 ; A variable containing directions to break out a parent loop
moveUp = 0 ; The amount of tiles going up that the mouse should hover over
moveLeft = 0 ; The amount of tiles going left that the mouse should hover over
moveDown = 0 ; The amount of tiles going down that the mouse should hover over
moveRight = 0 ; The amount of tiles going right that the mouse should hover over
locationX = 0 ; The x position of a targeted object
locationY = 0 ; The y position of a targeted object