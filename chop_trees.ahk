; This causes an existing player to look for trees on the map,
; and cut them down to build up a supply of wood.
; 
; To setup this script:
;  [1] Press Control+Alt+S to start the macro
;  [2] If this is your first time using this macro, then complete the Setup Wizard
;
; Created by: Oliver Spryn

; -------------------------------
; Configuration
; -------------------------------

; ------------------------------- Part 1 | Configured by user during setup -------------------------------
windowName = "" ; The user's Toadwater username, which makes up the title of the Toadwater Window

; A loop creating the variables inv1 - inv20, each to be used for an inventory item
loop 20 {
  inv%A_Index% = 
}

; ------------------------------- Part 2 | System configuration -------------------------------
SysGet, windowBorder, 31 ; The height, in pixels, of the window border enclosing the Toadwater application
Sysget, menuHeight, 15 ; The height, in pixels, of the Toadwater application menu
SysGet, workableArea, MonitorWorkArea ; The area, in pixels, that a window may consume (screen height - task bar height)
screenWidth := workableAreaRight ; The width of the screen that a window may consume, in pixels
screenHeight := workableAreaBottom ; The height of the screen that a window may consume, in pixels
configFolder = %A_MyDocuments%\Toadwater Accelerator ; The folder location of the Accelerator's configuration file
configFile = %configFolder%\config.ahk ; The location of the Accelerator's configuration file

; ------------------------------- Part 3 | Application specifications -------------------------------
inventorySpacing = 14 ; The amount of space, in pixels, between each of the items in the inventory
dockBarWidth = 166 ; The width, in pixels, of the right-side dock bar
cellSize = 77 ; The width and height, in pixels, of a cell, when the game is configured as instructed above

cellPaddingX := Round(Mod(((screenWidth - dockBarWidth) / 2) - Round(cellSize / 2), cellSize)) ; Compute the padding added by partially hidden cells in the X direction
cellPaddingY := Round(Mod(((screenHeight - (windowBorder + menuHeight)) / 2) - Round(cellSize / 2), cellSize)) ; Compute the padding added by partially hidden cells in the Y direction 
cellsX := Floor((screenWidth - dockBarWidth - (cellPaddingX * 2)) / cellSize) ; The number of visibile cells to evaluate in the X direction
cellsY := Floor((screenHeight - (windowBorder + menuHeight) - (cellPaddingY * 2)) / cellSize) ; The number of visibile cells to evaluate in the Y direction

healthGood = 00C000 ; Health meter color indicator, good
healthFair = 00C0C0 ; Health meter color indicator, fair
healthPoor = 0000C0 ; Health meter color indicator, poor

; ------------------------------- Part 4 | Variables manipulated by the macro -------------------------------
itemLoc = 0 ; A generic variable to store the location of an inventory item
wizardStep = 1 ; A tracking variable to hold which step of the setup wizard the user is currently on

hoverCellX = 0 ; The x position of the cell number that the mouse currently hovering over
hoverCellY = 0 ; The y position of the cell number that the mouse currently hovering over

; -------------------------------
; Function library
; -------------------------------

; Create and manipulate the welcome page
welcome(action) {
  mainText = Welcome to the Toadwater Accelerator Setup Wizard!`n`nThese series of steps will guide you through the process of configuring this marco for your system.`nThrough out this short, three minute process, you will:`n`n - Supply your Toadwater username`n - Enter your current list of inventory items`n - Arrange the Toadwater workspace for optimal usage
  secondaryText = Click "Next" to continue.
  
  if (action = "create") {
    Gui, Add, Text, x10 y60 BackgroundTrans, %mainText% ; ClassNN = "Static2" according to Window Spy
    Gui, Add, Text, x10 y397 BackgroundTrans, %secondaryText% ; ClassNN = "Static3" according to Window Spy
  } else if (action = "hide") {
    GuiControl, hide, Static2
    GuiControl, hide, Static3
  } else {
    GuiControl, show, Static2
    GuiControl, show, Static3
  }
}

; Create and manipulate the username entry form
username(action) {
  mainText = Please enter your Toadwater username:
  
  if (action = "create") {
    Gui, Add, Text, x10 y60, %mainText% ; ClassNN = "Static4" according to Window Spy
    Gui, Add, Edit, x10 y100 ; ClassNN = "Edit1" according to Window Spy
  } else if (action = "hide") {
    GuiControl, hide, Static4
    GuiControl, hide, Edit1
  } else {
    GuiControl, show, Static4
    GuiControl, show, Edit1
  }
}

; Create and manipulate the inventory item listing
inventory(action) {
  mainText = Please log into your Toadwater account, and consult your list of inventory items. Write them in the`norder they appear in the text inputs below. Leave any empty inventory spaces blank:

  if (action = "create") {
    Gui, Add, Text, x10 y60, %mainText% ; ClassNN = "Static5" according to Window Spy
  
  ; Text ClassNN ranges from Static6 to Static25 and input ClassNN ranges from Edit2 to Edit21
    loop 20 {
      if (A_Index <= 8) {
        textX = 10
        inputX = 30
        textY := 113 + ((A_Index - 1) * 40)
        inputY := 110 + ((A_Index - 1) * 40)
      } else if (A_Index >= 9 && A_Index <= 16) {
        textX = 200
        inputX = 230
        textY := 113 + ((A_Index - 9) * 40)
        inputY := 110 + ((A_Index - 9) * 40)
      } else {
        textX = 400
        inputX = 430
        textY := 113 + ((A_Index - 17) * 40)
        inputY := 110 + ((A_Index - 17) * 40)
      }
      
      Gui, Add, Text, x%textX% y%textY%, %A_Index%.
      Gui, Add, Edit, x%inputX% y%inputY%
    }
  } else if (action = "hide") {
    GuiControl, hide, Static5
    
    loop 20 {
      static := A_Index + 5
      edit := A_Index + 1
      
      GuiControl, hide, Static%static%
      GuiControl, hide, Edit%edit%
    }
  } else {
    GuiControl, show, Static5
    
    loop 20 {
      static := A_Index + 5
      edit := A_Index + 1
      
      GuiControl, show, Static%static%
      GuiControl, show, Edit%edit%
    }
  }
}

; Create and manipulate inventory listing review page
review(action) {
; Globalize the scope of the needed variables for use within this function
  global windowName, inv1, inv2, inv3, inv4, inv5, inv6, inv7, inv8, inv9, inv10, inv11, inv12, inv13, inv14, inv15, inv16, inv17, inv18, inv19, inv20

  mainText = Please verify that your settings are correct. You can make changes to these settings by clicking the "Back"`nbutton.
  secondaryText = Username:
  tertiaryText = Inventory:

  if (action = "create") {
    Gui, Add, Text, x10 y60, %mainText% ; ClassNN = "Static26" according to Window Spy
    
    Gui, Add, Text, x10 y100, %secondaryText%  ; ClassNN = "Static27" according to Window Spy
    Gui, Add, Text, x20 y120, %windowName% ; ClassNN = "Static28" according to Window Spy
    
    Gui, Add, Text, x200 y100, %tertiaryText% ; ClassNN = "Static29" according to Window Spy
    
  ; Text ClassNN ranges from Static30 to Static49
    loop 20 {
      if (A_Index <= 15) {
        textX := 210
        textY := 120 + ((A_Index - 1) * 20)
      } else {
        textX := 410
        textY := 120 + ((A_Index - 16) * 20)
      }
      
      Gui, Add, Text, x%textX% y%textY%, 
    }
  } else if (action = "hide") {  
    GuiControl, hide, Static26
    GuiControl, hide, Static27
    GuiControl, hide, Static28
    GuiControl, hide, Static29
    
    loop 20 {
      static := A_Index + 29
      edit := A_Index + 22
      
      GuiControl, hide, Static%static%
      GuiControl, hide, Edit%edit%
    }
  } else {
  ; Since the below values are linked to variables, they must be manually updated each time :(
    GuiControl, show, Static26
    GuiControl, show, Static27
    GuiControl, show, Static28
    GuiControl, move, Static28, w150 ; And we need to re-adjust the width! Why???
    GuiControl,, Static28, %windowName%
    GuiControl, show, Static29
    
    loop 20 {
      static := A_Index + 29
      edit := A_Index + 22
      
      GuiControl, show, Static%static%
      GuiControl, show, Edit%edit%
      
      if (inv%A_Index% != "") {
        value := inv%A_Index%
        GuiControl, move, Static%static%, w150 ; And we need to re-adjust the width! Why???
        GuiControl,, Static%static%, %A_Index%. %value%
      } else {
        GuiControl,, Static%static%, 
      }
    }
  }
}

; Create and manipulate the Toadwater layout instructions page
layout(action) {
  mainText = Please open your Toadwater client, and follow the directions below:`n`n  [1] Enter your username and password in the Toadwater login window, and tick the "Remember Password"`n       checkbox.`n`n  [2] Close all sub-windows and docks inside of Toadwater, such as construction, textile, etc...`n`n  [3] Open the "Inventory" window by going to View > Inventory, and dock it in the top right corner of the`n       Toadwater window.`n`n  [4] Open the "Info Center" window by going to View > Info Center, and dock it in right below the docked`n       "Inventory" window.
  
  if (action = "create") {
    Gui, Add, Text, x10 y60, %mainText% ; ClassNN = "Static50" according to Window Spy
  } else if (action = "hide") {
    GuiControl, hide, Static50
  } else {
    GuiControl, show, Static50
  }
}

; Create and manipulate the finish page
finish(action) {
  mainText = The Toadwater Accelerator now has enough information about your system to play this game automatically.`nYou will not be required to run through this setup again, as your configuration has been saved to:`n%A_MyDocuments%\Toadwater Accelerator\config.ahk`n`nClick "Finish" below, and the Accelerator will close your existing Toadwater window, log in again as you,`nand being gameplay.
  
  if (action = "create") {
    Gui, Add, Text, x10 y60, %mainText% ; ClassNN = "Static51" according to Window Spy
  } else if (action = "hide") {
    GuiControl, hide, Static51
  } else {
    GuiControl, show, Static51
  }
}

; Find the position of a particular item in the inventory listing
findItem(itemName) {
; Globalize the scope of the needed variables for use within this function
  global inv1, inv2, inv3, inv4, inv5, inv6, inv7, inv8, inv9, inv10, inv11, inv12, inv13, inv14, inv15, inv16, inv17, inv18, inv19, inv20
    
  loop 20 {   
  ; See where the "itemName" appears
    if (inv%A_Index% = itemName) {
      return %A_Index%
      break
    }
  }
}

; Select a particular item from the inventory list
selectTool(itemName) {
; Globalize the scope of the needed variables for use within this function
  global screenPlayPadding, inventorySpacing, inventoryClick

; Select the item
  itemLoc := findItem(itemName)
  inventoryItem := screenPlayPadding + (inventorySpacing * itemLoc)
  Click %inventoryClick%, %inventoryItem%
}

; -------------------------------
; Pre-gamplay setup
; -------------------------------

; Listen for Control+Alt+S to start the script
^!s::

; Set the coordinate mode relative to the entire screen
CoordMode, Mouse, Screen

; -------------------------------
; Information setup wizard
; -------------------------------

if (!FileExist(configFile)) {
; Create the setup dialog window
  Gui, -SysMenu ; Create the dialog, and hide the minimize, maximize, and close buttons
  Gui, Color, White ; Set the background color to white
  Gui, Margin, 0, 0 ; Remove the inner margin of the window
  
; Create the window borders and buttons
  Gui, Add, Progress, w640 h50 ; Add a progess bar to the top of the page. This will be used as a backdrop color for the title.
  Gui, Add, Progress, w640 h50 x0 y430 backgroundDefault disabled ; Add a progess bar to the bottom of the page. This will be used as a backdrop color for the button bar.
  
  Gui, Font, s16 w100, Arial ; Set the font properties for the title
  Gui, Add, Text, x10 y15 BackgroundTrans, Toadwater Accelerator Setup Wizard ; Create the title in the correct loctaion
  Gui, Font, s10 ; Clear the font properties
  
  Gui, Add, Button, x300 y440 w100 disabled, &Back ; ClassNN = "Button1" according to Window Spy
  Gui, Add, Button, x400 y440 w100, &Next ; ClassNN = "Button2" according to Window Spy
  Gui, Add, Button, x525 y440 w100, &Cancel ; ClassNN = "Button3" according to Window Spy
  
; Create the welcome page
  welcome("create")
  
; Create and hide the username entry form
  username("create")
  username("hide")
  
; Create and hide the inventory item listing
  inventory("create")
  inventory("hide")
    
; Create and hide inventory listing review page
  review("create")
  review("hide")
  
; Create and hide the Toadwater layout instructions page
  layout("create")
  layout("hide")
  
; Create the finish page
  finish("create")
  finish("hide")
  
; Show the dialog window
  Gui, Show, w640 h480, Toadwater Accelerator Setup Wizard
  return
  
; Actions to perform when the "Next" button is clicked
  ButtonNext:
  ; Actions if this is step 1
    if (wizardStep = 1) {
    ; Hide the welcome page
      welcome("hide")
      
    ; Show the username page
      username("show")  
      GuiControl, enabled, Button1
      ControlFocus Edit1
      
    ; Increment the wizard step counter
      wizardStep++
  ; Actions if this is step 2
    } else if (wizardStep = 2) {
    ; Keep the username in a variable
      ControlGetText, windowName, Edit1
      
    ; Make sure that the input was not empty
      if (windowName != "") {
      ; Hide the username page
        username("hide")
        
      ; Show the inventory page
        inventory("show")
        ControlFocus Edit2
        
      ; Increment the wizard step counter
        wizardStep++
      } else {
        MsgBox, , Invalid input, Please enter your Toadwater username.
        ControlFocus Edit1
      }
  ; Actions if this is step 3
    } else if (wizardStep = 3) {
    ; Keep the inventory items in their own variables
      loop 20 {
        editIndex := A_Index + 1
        ControlGetText, inv%A_Index%, Edit%editIndex%
      }
      
    ; Hide the inventory page
      inventory("hide")
          
    ; Show the review page
      review("show")
      
    ; Increment the wizard step counter
      wizardStep++
  ; Actions if this is step 4
    } else if (wizardStep = 4) {
    ; Hide the review page
      review("hide")
      
    ; Show the layout page
      layout("show")
    
    ; Increment the wizard step counter
      wizardStep++
  ; Actions if this is step 5
    } else if (wizardStep = 5) {
    ; Hide the layout page
      layout("hide")
      
    ; Show the finish page
      finish("show")
      
    ; Save the configuration into a plain-text file, inside of My Documents > Toadwater Accelerator
      FileCreateDir, %configFolder%
      FileAppend, %windowName%`n, %configFile%
      
      loop 20 {
        value := inv%A_Index%
        FileAppend, %value%`n, %configFile%
      }
      
    ; Hide the old navigation buttons, and replace them with a "Finish" button
      GuiControl, hide, Button1
      GuiControl, hide, Button2
      GuiControl, hide, Button3
      
      Gui, Add, Button, x525 y440 w100, &Finish
    }
  return
  
; Actions to perform when the "Back" button is clicked
  ButtonBack:
  ; Actions if this is step 1
    if (wizardStep = 1) {
    ; Can't go to step 0!!!
  ; Actions if this is step 2
    } else if (wizardStep = 2) {
    ; Hide the username page
      username("hide")
      
    ; Show the welcome page
      welcome("show")
      GuiControl, disabled, Button1
      
    ; Decrement the wizard step counter
      wizardStep--
  ; Actions if this is step 3
    } else if (wizardStep = 3) {
    ; Hide the inventory page
      inventory("hide")
      
    ; Show the username page
      username("show")
      ControlFocus Edit1
      
    ; Decrement the wizard step counter
      wizardStep--
  ; Actions if this is step 4
    } else if (wizardStep = 4) {
    ; Hide the review page
      review("hide")
      
    ; Show the inventory page
      inventory("show")
      
    ; Decrement the wizard step counter
      wizardStep--
  ; Actions if this is step 5
    } else if (wizardStep = 5) {
    ; Hide the layout page
      layout("hide")
      
    ; Show the review page
      review("show")
      
    ; Decrement the wizard step counter
      wizardStep--
    }
  return
  
; Actions to perform when the "Cancel" button is clicked
  ButtonCancel:
   MsgBox, 4, Exit Setup?, Are you sure you wish to exit the setup?
   IfMsgBox Yes
     ExitApp
  return
  
; Actions to perform when the "Finish" button is clicked
  ButtonFinish:
  ; Close the setup wizard
    Gui, Destroy
    
  ; Send an odd keystroke (one the user would never think to press), to continue executing the code
    Send ^!j
  return
} else {
; Parse the config file created by the setup
  FileRead, configContents, %configFile%
  
  Loop, parse, configContents, `n
  {
    if (A_Index = 1) {
      windowName = %A_LoopField%
    } else {
      value := A_Index - 1 ; The counter will be +1 of all of the inventory items, since the first parsed item was the username
      inv%value% = %A_LoopField%
    }
  }
}

; -------------------------------
; Login
; -------------------------------

; Continue the macro after this keystroke, triggered by the program
^!j::

; Close any existing Toadwater windows, then open, focus on, and maximize on a new Toadwater window
if (WinExist("TWC (%windowName%)")) {
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

; Log the user in
Send ^l
Send {Enter}

; -------------------------------
; Action
; -------------------------------

; Identify where the walking staff is in the inventory, and select it
selectTool("Toadwater Staff")

; Move the mouse to the vertical center of the top-left cell, and track the location of the focused cell
;MouseMove, 0, screenPlayPadding + (cellSize / 2)

; Recursively look for a tree by scanning from the center, out to locate the closest tree
;loop {
; For the first 2 cells, go left one and then up one, then continue the pattern below
;  if (hoverCellX = 0) {
;    hoverCellX := Floor(cellsX / 2) - 1
;    
;  }
;  
;   MouseMove, (hoverCellX - 1) * cellSize, screenPlayPadding + (cellSize / 2) + (cellSize * (hoverCellY - 1)), 0
;}