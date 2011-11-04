#Include framework\include.ahk

^!f:: ; starts the script

; you must start with a 7x7 ground free of anything
; start in the top left of your area

selectTool("Toadwater Staff")

; -----------------------------------------------------------------------------------------
; -----------------------------------------------------------------------------------------
; -----------------------------------------------------------------------------------------
; 				CUT TREES (IF ANY) AND PLANT
; -----------------------------------------------------------------------------------------
; -----------------------------------------------------------------------------------------
; -----------------------------------------------------------------------------------------


; Plant two fir trees
if (itemNum("Balsam Fir Seeds") > 0) {
; Going down
  plantX := Ceil(cellsX / 2) + 1
  plantY := Ceil(cellsY / 2)
  goX := Ceil(cellsX / 2)
  goY := Ceil(cellsY / 2) + 1
  
; Plan trees on the way down...
  selectTool("Balsam Fir Seeds")
  queueEmpty()
  click(plantX, plantY)
  queueEmpty()
  goTo(goX, goY)
  queueEmpty()
  selectTool("Balsam Fir Seeds")
  queueEmpty()
  click(plantX, plantY)
  queueEmpty()
  
; Going right
  goX := Ceil(cellsX / 2) + 1
  goY := Ceil(cellsY / 2)
  
  goTo(goX, goY)
  queueEmpty()
  selectTool("Blister Shovel")
  queueEmpty()
  
  loop 35 {
    click(goX, goY)
    sleep 20000
  }
  
  sleep 15*60*1000 ; Wait for those trees to grow up
} else {
  MsgBox, We couldn't find any more seeds
}