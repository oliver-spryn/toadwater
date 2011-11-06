; This framework includes many of the calculations and logic necessary 
; to allow developers to easily and efficently, develop a marco for
; Toadwater. Many of the difficulties Toadwater can give a developer has
; been compsenated within this framework.
;
; Created by: Oliver Spryn

; -------------------------------
; Function library
; -------------------------------

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
  
  return 0
}

; Select a particular item from the inventory list
selectTool(itemName) {
; Find the item
  itemLoc := findItem(itemName)

; Just to make sure we don't accidently select an active tool, select another tool before selecting the one we want
  if (itemLoc = 1) {
    Send 2
    Send 1
  } else if (itemLoc < 10) {
    Send 1
    Send %itemLoc%
  } else if (itemLoc = 10) {
    Send 1
    Send 0
  } else if (itemLoc < 20) {
    itemInv := itemLoc - 10
    
    Send 1
    Send {Shift Down}
    Send %itemLoc%
    Send {Shift Up}
  } else {
    Send 1
    Send {Shift Down}
    Send 0
    Send {Shift Up}
  }

; ----------- Here for good measure, but a simple keystroke replaces the need for a mouse click -----------
; Globalize the scope of the needed variables for use within this function
; global windowBorder, menuHeight, inventorySpacing, inventoryClick
;
; Find the item
; itemLoc := findItem(itemName)
;
; Just to make sure we don't accidently select an active tool, select another tool before selecting the one we want
; if (itemLoc = 1) {
;   securityItem := (windowBorder + menuHeight) + (inventorySpacing * (itemLoc + 1))
;   Click %inventoryClick%, %securityItem%
; } else {
;   securityItem := (windowBorder + menuHeight) + (inventorySpacing * (itemLoc - 1))
;   Click %inventoryClick%, %securityItem%
; }
; 
; sleep 750
; 
; inventoryItem := (windowBorder + menuHeight) + (inventorySpacing * itemLoc)
; Click %inventoryClick%, %inventoryItem%
}

; Find the mumber of items that we have for a particular inventory item
itemNum(object) {
; Globalize the scope of the needed variables for use within this function
  global inv1, inv2, inv3, inv4, inv5, inv6, inv7, inv8, inv9, inv10, inv11, inv12, inv13, inv14, inv15, inv16, inv17, inv18, inv19, inv20
 
; Is the object even in the inventory?
  itemLoc := findItem(object)

  if (itemLoc != 0) {
  ; Grab the text from Window Spy
    WinGetText, inventory, Active Window Info (Shift-Alt-Tab to freeze display)
    sleep 75
    keywordPos := InStr(inventory, "Hoard")
    StringTrimLeft, inventoryTrim, inventory, keywordPos - 1
    StringSplit, parsedInventory, inventoryTrim, `n
    
    parserItem := itemLoc + 1
    parserReturn := parsedInventory%parserItem%
    return parserReturn
  } else {
    return 0
  }
}

; Move the mouse to a particular x and y cell
mouseMove(x, y) {
; Globalize the scope of the needed variables for use within this function
  global hoverCellX, hoverCellY, cellPaddingX, cellSize, windowBorder, menuHeight, cellPaddingY
  
  hoverCellX = %x%
  hoverCellY = %y%
  
; The +10 or +30 are for good measure, just be sure it is not clicking off the tile in the x or y directions
  MouseMove, cellPaddingX + 10 + ((x - 1) * cellSize), windowBorder + menuHeight + cellPaddingY + 30 + ((y - 1) * cellSize)
}

; Click a certain x and y cell
click(x, y) {
  mouseMove(x, y)
  Click
}

; Get the hexadecimal color under the pointer
getColor() {
; This is mainly used whenever evaluating color-coded information on the dockbar
  WinGetText, color, Active Window Info (Shift-Alt-Tab to freeze display)
  sleep 75
  colorPos := InStr(color, "0x")
  StringTrimLeft, colorTrim, color, colorPos - 1
  StringSplit, colorParsed, colorTrim, %A_Space%
  return colorParsed1
}

; Focus the PixelGetColor to a particular X and Y cell
cellColor(x, y) {
; Globalize the scope of the needed variables for use within this function
  global cellPaddingX, cellSize, windowBorder, menuHeight, cellPaddingY
  
; The +10 or +30 are for good measure, just be sure it is not clicking off the tile in the x or y directions
  PixelGetColor, pixelColor, cellPaddingX + 10 + ((x - 1) * cellSize), windowBorder + menuHeight + cellPaddingY + 30 + ((y - 1) * cellSize)
  
  return pixelColor
}

; Get the color code for a corresponding cell
getColorCode(x, y) {
  cellColor(x, y)
  sleep 1000
  MsgBox % getColor()
}

; Check and see if the current cell contains a specific object
is(object, x, y) {
  mouseMove(x, y)
  sleep 100
  
  if (getColor() = object) {
    return true
  } else {
    return false
  }
}

; Locate the closest x and y position of a given object
locate(object) {
; Globalize the scope of the needed variables for use within this function
  global cellsX, cellsY, hoverCellX, hoverCellY, locationX, locationY

; Recursively look for a the object by scanning from the center, out to locate the closest one
  mouseMove(Ceil(cellsX / 2), Ceil(cellsY / 2))
  
; Calculate the number of times the loop below must execute
  if (cellsX >= cellsY) {
    loops := Floor(cellsX / 2)
  } else {
    loops := Floor(cellsY / 2)
  }
  
  loop %loops% {
  ; Track the outer loop A_Index value
    loopCount := A_Index
    
  ; For the first two moves round, it will be a tad different...
    if (loopCount = 1) {
    ; Moving left one
      mouseMove(hoverCellX - 1, hoverCellY)
      
    ; Check and see if this is the object
      if (is(object) = true) {
        break
      }
      
    ; Moving up
      mouseMove(hoverCellX, hoverCellY - 1)
      
    ; Check and see if this is the object
      if (is(object) = true) {
        break
      }
  ; All other loops can be solved with this algorthim...
    } else {
    ; Moving up
      moveUp := loopCount + (loopCount - 1)
         
      loop %moveUp% {
      ; Don't go off the gameplay area
        if (hoverCellY - 1 >= 1) {
          mouseMove(hoverCellX, hoverCellY - 1)
        } else {
          break
        }
        
      ; Check and see if this is the object
        if (is(object) = true) {
          breakLoop = true
          break
        }
      }
    
    ; Did we find a it yet?
      if (breakLoop) {
        breakLoop = false
        break
      }
    }
  
  ; Moving right
    moveRight := 2 * loopCount
    
    loop %moveRight% {
    ; Don't go off the gameplay area
      if (hoverCellX + 1 <= cellsX) {
        mouseMove(hoverCellX + 1, hoverCellY)
      } else {
        break
      }
      
    ; Check and see if this is the object
      if (is(object) = true) {
        breakLoop = true
        break
      }
    }
  
  ; Did we find a it yet?
    if (breakLoop) {
      breakLoop = false
      break
    }
    
  ; Moving down
    moveDown := 2 * loopCount
    
    loop %moveDown% {   
    ; Don't go off the gameplay area
      if (hoverCellY + 1 <= cellsY) {
        mouseMove(hoverCellX, hoverCellY + 1)
      } else {
        break
      }
    
    ; Check and see if this is the object
      if (is(object) = true) {
        breakLoop = true
        break
      }
    }
  
  ; Did we find a it yet?
    if (breakLoop) {
      breakLoop = false
      break
    }
    
  ; Moving left
    moveLeft := (2 * loopCount) + 1
    
    loop %moveLeft% {
    ; Don't go off the gameplay area
      if (hoverCellX - 1 >= 1) {
        mouseMove(hoverCellX - 1, hoverCellY)
      } else {
        break
      }
      
    ; Check and see if this is the object
      if (is(object) = true) {
        breakLoop = true
        break
      }
    }
  
  ; Did we find a it yet?
    if (breakLoop) {
      breakLoop = false
      break
    }
  }
  
; Did the loop break on the targeted object, or did it happen to end on the targeted object?
  if (is(object) = true) {
    locationX = hoverCellX
    locationY = hoverCellY
  } else {
    locationX = 0
    locationY = 0
  }
}

; Monitor the progress bars
monitor(bar) {
; Globalize the scope of the needed variables for use within this function
  global windowBorder, menuHeight, screenWidth, dockBarWidth, healthGood, healthFair, healthPoor, pooMeter, queueMeter
  
  if (bar = "health") {
    WinGetText, health, Active Window Info (Shift-Alt-Tab to freeze display)
    sleep 75
    StringSplit, healthSplit, health, %A_Space%/%A_Space%
    StringSplit, healthParsed, healthSplit, `n
    
    loop {
      if (healthParsed%A_Index% = "") {
        lastOne := A_Index - 1
        barInfo := healthParsed%lastOne%
        break
      }
    }
    MsgBox % healthParsed1
    
    if (barColor = healthGood) {
      return "good"
    } else if (barColor = healthFair) {
      return "fair"
    } else {
      return "poor"
    }
  } else if (bar = "poo") {
    barX := screenWidth - dockBarWidth + 115
    barY := 595 + windowBorder + menuHeight
    barColor := getColor("critical")
    
    MouseMove, %barX%, %barY%
    sleep 1000
    
    if (barColor = pooMeter) {
      return "poor"
    } else {
      return "good"
    }
  } else {
    barX := screenWidth - dockBarWidth + 5
    barY := 605 + windowBorder + menuHeight
    barColor := getColor("critical")
    
    MouseMove, %barX%, %barY%
    sleep 1000
    
    if (barColor = queueMeter) {
      return "poor"
    } else {
      return "good"
    }
  }
}

; Wait until the queue is empty
queueEmpty() {
  loop {
    if (monitor("queue") = "good") {
      return true
      break
    }
  }
}

; Get the locus (overall gameplay coordinates) from the information bar
getLocus() {
  WinGetText, locus, Active Window Info (Shift-Alt-Tab to freeze display)
  sleep 75
  keywordPos := InStr(locus, "Health:")
  StringTrimLeft, locusTrim, locus, keywordPos - 1
  StringSplit, locusParsed, locusTrim, %A_Space%
  
  StringSplit, xParsed, locusParsed1, `n
  xLocus := SubStr(xParsed2, 1, StrLen(xParsed2) - 1)
  StringUpper, xUpper, locusParsed2
  
  yLocus := SubStr(locusParsed4, 1, StrLen(locusParsed4) - 1)
  StringSplit, yLocus, locusParsed5, `n
  StringUpper, yUpper, yLocus1
  
  return xLocus A_Space xUpper A_Space yLocus A_Space yUpper
}

; Go to a given cell, avoid obsticles, and maintain health
goTo(x, y) {
; Globalize the scope of the needed variables for use within this function
  global cellsX, cellsY, hoverCellX, hoverCellY, inv1, inv2
  
; Select the walking staff
  selectTool("Toadwater Staff")
  
; Calculate the location of the targeted tile, relative to the current position
  cellXDiff := x - Ceil(cellsX / 2)
  cellYDiff := y - Ceil(cellsY / 2)
  cellXDist := Abs(cellXDiff)
  cellYDist := Abs(cellYDiff)
  
; Change travel in the x direction first...
  loop %cellXDist% {
  ; Check the health, are we okay for go?
    if (monitor("health") = "good" || monitor("health") = "fair") {
    ; Move right
      if (cellXDiff > 0) {
        Send {right}
    ; Move left
      } else {
        Send {left}
      }
   ; Nope, health needs attention. Switch between two tools in our inventory, and we will magically build health (Seriously!)
    } else {
      loop {
        selectTool(inv1)
        sleep 1500
        selectTool(inv2)
        sleep 1500
        
        if (monitor("health") = "good" || monitor("health") = "fair") {
          break
        }
      }
    }
  }
  
; ... then in the y direction
  loop %cellYDist% {
  ; Check the health, are we okay for go?
    if (monitor("health") = "good" || monitor("health") = "fair") {
    ; Move down
      if (cellYDiff > 0) {
        Send {down}
    ; Move up
      } else {
        Send {up}
      }
   ; Nope, health needs attention. Switch between two tools in our inventory, and we will magically build health (Seriously!)
    } else {
      loop {
        selectTool(inv1)
        sleep 1500
        selectTool(inv2)
        sleep 1500
        
        if (monitor("health") = "good" || monitor("health") = "fair") {
          break
        }
      }
    }
  }
}