; This framework includes many of the calculations and logic necessary 
; to allow developers to easily and efficently, develop a marco for
; Toadwater. Many of the difficulties Toadwater can give a developer has
; been compsenated within this framework.
;
; Created by: Oliver Spryn

; -------------------------------
; Configuration
; -------------------------------
wizardStep = 1 ; A tracking variable to hold which step of the setup wizard the user is currently on
toadwaterInstall = %A_ProgramFiles%\Toadwater ; The path of the Toadwater installation
configFolder = %toadwaterInstall%\Toadwater Accelerator ; The folder location of the Accelerator's configuration file
configFile = %configFolder%\config.txt ; The location of the Accelerator's configuration file

; -------------------------------
; Pre-install setup
; -------------------------------

; Ensure that this program is being run as the administrator
if (!A_IsAdmin) {
  MsgBox, 4, Macro access confirmation, The Toadwater Accelerator macro needs to be run with administrator privileges.`n`nDo you wish to allow this macro to have administrator privileges?
  
; Restart with admin privileges
  IfMsgBox Yes
    Run *RunAs %A_ScriptFullPath%
  
  ExitApp
}

; -------------------------------
; Function library
; -------------------------------

; Create and manipulate the welcome page
welcome(action) {
  mainText = Welcome to the Toadwater Accelerator Setup Wizard!`n`nThese series of steps will guide you through the process of configuring this marco for your system.`nThrough out this short process, you will:`n`n - Supply your Toadwater username`n - Enter your current list of inventory items`n - Prepare Toadwater for optimal usage`n - Authorize the replacement default images
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
    
    Gui, Font, h100 w100 cFF0000, Arial ; Set the font properties for the important text
    Gui, Add, Text, x400 y270 BackgroundTrans, In order for this script to run by`nitself your inventory must contain: ; ClassNN = "Static26" according to Window Spy
    Gui, Font, s10 c000000 ; Clear the font properties
  } else if (action = "hide") {
    GuiControl, hide, Static5
    
    loop 20 {
      static := A_Index + 5
      edit := A_Index + 1
      
      GuiControl, hide, Static%static%
      GuiControl, hide, Edit%edit%
    }
    
    GuiControl, hide, Static26
  } else {
    GuiControl, show, Static5
    
    loop 20 {
      static := A_Index + 5
      edit := A_Index + 1
      
      GuiControl, show, Static%static%
      GuiControl, show, Edit%edit%
    }
    
    GuiControl, show, Static26
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
    Gui, Add, Text, x10 y60, %mainText% ; ClassNN = "Static27" according to Window Spy
    
    Gui, Add, Text, x10 y100, %secondaryText%  ; ClassNN = "Static28" according to Window Spy
    Gui, Add, Text, x20 y120, %windowName% ; ClassNN = "Static29" according to Window Spy
    
    Gui, Add, Text, x200 y100, %tertiaryText% ; ClassNN = "Static30" according to Window Spy
    
  ; Text ClassNN ranges from Static31 to Static50
    loop 20 {
      if (A_Index <= 15) {
        textX := 210
        textY := 120 + ((A_Index - 1) * 20)
      } else {
        textX := 410
        textY := 120 + ((A_Index - 16) * 20)
      }
      
      Gui, Add, Text, x%textX% y%textY% w240, 
    }
  } else if (action = "hide") {  
    GuiControl, hide, Static27
    GuiControl, hide, Static28
    GuiControl, hide, Static29
    GuiControl, hide, Static30
    
    loop 20 {
      static := A_Index + 30
      edit := A_Index + 22
      
      GuiControl, hide, Static%static%
      GuiControl, hide, Edit%edit%
    }
  } else {
  ; Since the below values are linked to variables, they must be manually updated each time :(
    GuiControl, show, Static27
    GuiControl, show, Static28
    GuiControl, show, Static29
    GuiControl, move, Static29, w240 ; And we need to re-adjust the width! Why???
    GuiControl,, Static29, %windowName%
    GuiControl, show, Static30
    
    loop 20 {
      static := A_Index + 30
      edit := A_Index + 22
      
      GuiControl, show, Static%static%
      GuiControl, show, Edit%edit%
      
      if (inv%A_Index% != "") {
        value := inv%A_Index%
        GuiControl, move, Static%static%, w240 ; And we need to re-adjust the width! Why???
        GuiControl,, Static%static%, %A_Index%. %value%
      } else {
        GuiControl,, Static%static%, 
      }
    }
  }
}

; Create and manipulate the Toadwater layout instructions page
layout(action) {
  mainText = Please open your Toadwater client, and follow the directions below:`n`n  [1] Enter your username and password in the Toadwater login window, and tick the "Remember Password"`n       checkbox.`n`n  [2] Close all sub-windows and docks inside of Toadwater, such as construction, textile, etc...`n`n  [3] Open the "Inventory" window by going to View > Inventory, and dock it in the top right corner of the`n       Toadwater window.`n`n  [4] Open the "Info Center" window by going to View > Info Center, and dock it in right below the docked`n       "Inventory" window.`n`n  [5] Adjust the game's color settings by going to Game > Options, and tick the "Always show color tiles"`n       checkbox.
  
  if (action = "create") {
    Gui, Add, Text, x10 y60, %mainText% ; ClassNN = "Static51" according to Window Spy
  } else if (action = "hide") {
    GuiControl, hide, Static51
  } else {
    GuiControl, show, Static51
  }
}

; Authorization to download replacement images page
authorize(action) {
  global toadwaterInstall
  
  mainText = In order for the Toadwater Accelerator to better locate key objects on your screen, the installer will replace`nthe default icons for several Toadwater objects with ones the macro will better recognize.`nThese objects include:`n`n    - Balsam Fir Tree`n    - Radish Crop Growth from 0 - 100 percent`n    - Ground Fertilization from 0 - 100 percent`n    - The Outhouse`n    - The Ground`n`n`n`n`n`n`n`n`n`n`n`n`nClick "Next" to authorize this action.
  
  if (action = "create") {
    Gui, Add, Text, x10 y60, %mainText% ; ClassNN = "Static52" according to Window Spy
  } else if (action = "hide") {
    GuiControl, hide, Static52
  } else {
    GuiControl, show, Static52
  }
}

; Create and manipulate the finish page
finish(action) {
  global configFile

  mainText = The Toadwater Accelerator now has enough information about your system to play this game automatically.`nYou will not be required to run through this setup again, as your configuration has been saved to:`n%configFile%`n`nClick "Finish" below, and the Accelerator will close your existing Toadwater window, log in again as you,`nand being gameplay.
  
  if (action = "create") {
    Gui, Add, Text, x10 y60, %mainText% ; ClassNN = "Static53" according to Window Spy
  } else if (action = "hide") {
    GuiControl, hide, Static53
  } else {
    GuiControl, show, Static53
  }
}

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
  
; Create the authorization page
  authorize("create")
  authorize("hide")
  
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
      
    ; Show the authorize page
      authorize("show")
    
    ; Increment the wizard step counter
      wizardStep++
  ; Actions if this is step 6
    } else if (wizardStep = 6) {
    ; Disable the Next/Back buttons
      GuiControl, disabled, Button1
      GuiControl, disabled, Button2
      
    ; Transfer the images
      FileRemoveDir, %toadwaterInstall%\Images, 1
      FileCopyDir, images, %toadwaterInstall%\Images, 1
      
    ; Hide the authorize page
      authorize("hide")
      
    ; Show the finish page
      finish("show")
      
    ; Save the configuration into an plain text file, inside of My Documents > Toadwater Accelerator
      FileCreateDir, %configFolder%
      FileAppend, %windowName%|, %configFile%
      
      loop 20 {
        value := inv%A_Index%
        
        if (A_Index <= 19) {
          FileAppend, %value%|, %configFile%
        } else {
          FileAppend, %value%, %configFile%
        }
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
  ; Actions if this is step 6
    } else if (wizardStep = 6) {
    ; Hide the authorize page
      authorize("hide")
      
    ; Show the layout page
      layout("show")
      
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
; Send an odd keystroke (one the user would never think to press), to continue executing the code
  Send ^!j
}

; Continue with the script...
^!j::