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
}

; Select a particular item from the inventory list
selectTool(itemName) {
; Globalize the scope of the needed variables for use within this function
  global windowBorder, menuHeight, inventorySpacing, inventoryClick

; Select the item
  itemLoc := findItem(itemName)
  inventoryItem := (windowBorder + menuHeight) + (inventorySpacing * itemLoc)
  Click %inventoryClick%, %inventoryItem%
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

; Get the hexadecimal color under the pointer
getColor(type = "fast") {
  if (type = "fast") {
    MouseGetPos mouseX, mouseY
    PixelGetColor color, %mouseX%, %mouseY%, RGB
    return color
  } else {
    WinGetText, color, Active Window Info (Shift-Alt-Tab to freeze display)
    sleep 75
    colorPos := InStr(color, "0x")
    StringTrimLeft, colorTrim, color, colorPos - 1
    StringSplit, colorParsed, colorTrim, %A_Space%
    return colorParsed1
  }
}

; Get the color code for a corresponding cell
getColorCode(x, y) {
  MouseMove(x, y)
  sleep 1000
  MsgBox % getColor()
}

; Check and see if the current cell contains a specific object
is(object) {
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
  global cellsX, cellsY, loops, loopCount, hoverCellX, hoverCellY, breakLoop, moveUp, moveRight, moveDown, moveLeft, locationX, locationY

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
  global windowBorder, menuHeight, screenWidth, dockBarWidth, healthGood, healthFair, healthPoor

  if (bar = "health") {
    barY := 575 + windowBorder + menuHeight
    barX := screenWidth - dockBarWidth + 15
    
    MouseMove, %barX%, %barY%
    sleep 1000
    
    if (getColor() = healthGood) {
      return "good"
    } else if (getColor() = healthFair) {
      return "fair"
    } else {
      return "poor"
    }
  }
}

; Find the 

; Go one cell away from a targeted location, usually to perform some action on the cell
goBy(x, y) {
; Globalize the scope of the needed variables for use within this function
  global cellsX, cellsY, hoverCellX, hoverCellY
  
; Calculate the location of the targeted tile, relative to the current position
  if (x > cellsX) {
    goX := x - cellsX
  } else {
    goX := cellsX - x
  }
  MsgBOx % goX
  if (y - 1 > cellsY) {
    y := y - 1 - cellsY
  } else {
    y := cellsY - y - 1
  }

; Go in the x direction
  loop %goX% {
    if (goX > cellsX) {
      mouseMove(hoverCellX + 1, hoverCellY)
      Click
    } else {
       mouseMove(hoverCellX - 1, hoverCellY)
    }
  }
  
; Go in the y direction
  loop %x% {
    if (y > cellsY) {
      mouseMove(hoverCellX, hoverCellY + 1)
      Click
    } else {
       mouseMove(hoverCellX, hoverCellY - 1)
    }
  }
}