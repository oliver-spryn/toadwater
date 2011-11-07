;#p::Pause
;#d::ExitApp
#Include framework\include.ahk

; you must start with a 7x7 ground free of anything
; start in the top left corner of your area
; WARNING: IF ANY OF YOUR TOOLS ARE CLOSE TO FAILING, WE RECOMMEND YOU RESTOCK BEFORE RUNNING THIS PROGRAM. WE CAN GUARANTEE YOU WONT DIE (WE HOPE) BUT NO PROMISES.
; to run this program, you must start with at least one of each of the following: class one outhouse, balsam fir seed, balsam fir wood, Grade 1 Plank, radish seeds, dried poo, toadwater staff, crude axe, shovel

selectTool("Toadwater Staff")
Send {Right}
; -----------------------------------------------------------------------------------------
; -----------------------------------------------------------------------------------------
; -----------------------------------------------------------------------------------------
; 				CUT TREES (IF ANY) AND PLANT
; -----------------------------------------------------------------------------------------
; -----------------------------------------------------------------------------------------
; -----------------------------------------------------------------------------------------
loop
{
    loop
    {	
	if (itemNum("Balsam Fir Seeds") < 37)
	{
		loop 6
		{
			Send {Down}
			queueEmpty()
			checkHealth()
		}
		selectTool("Blister Shovel")
		if (itemNum("Balsam Fir Seeds") < 37)
		{
			Send {Left}
			queueEmpty()
			checkHealth()
		}
		selectTool("Toadwater Staff")
		loop 6
		{
			Send {Up}
			queueEmpty()
			checkHealth()
		}	
	}
        if (itemNum("Class 1 Outhouse Materials") >= 12) ; the 12 means that when 11 outhouses are "used", there will be at least one left to save its inv spot
	{
          break
        }
       	if (itemNum("Grade 1 Plank") <= 13 - itemNum("Class 1 Outhouse Materials"))
    	{
    		loop
    		{
			if (itemNum("Balsam Fir Wood") >= 14 - itemNum("Grade 1 Plank"))
			{
	    		      break
    		        }
    			loop 3
    			{	
    				loop 5
    				{	
    					Send {Right}
    					
    					mouseMove(Ceil(cellsX / 2) - 1, Ceil(cellsY / 2))
    					
    					if (is(balsamFir))
    					{
    					      selectTool("Crude Axe")
    					      
    					      loop 10
    					      {
    					           Send {Right}
    					           queueEmpty()
						   checkHealth()
    					      }
    					}
    					
    					selectTool("Balsam Fir Seeds")
    					
    					Send {Left}
    					
    					selectTool("Toadwater Staff")
    					queueEmpty()
			                checkHealth()
    				}
    				Send {Down}
    				loop 5
    				{	
    					Send {Left}
    					
    					mouseMove(Ceil(cellsX / 2) - 1, Ceil(cellsY / 2))
                        
                        if (is(balsamFir))
                        {
                              selectTool("Crude Axe")
                              
                              loop 10
                              {
                                   Send {Right}
                                   queueEmpty()
				   checkHealth()
                              }
                        }
                        
    					selectTool("Balsam Fir Seeds")
    					Send {Right}
    					selectTool("Toadwater Staff")
    					queueEmpty()
					checkHealth()
    				}
    				Send {Down}
    			}
    			selectTool("Toadwater Staff")
    			loop 5
    			{
    				Send {Up}
    				queueEmpty()
				checkHealth()
    			}
    		}
    	}
    	
	selectTool("Balsam Fir Wood")
    	woodNum := itemNum("Balsam Fir Wood") - 1 ; subtracts one so that inventory place is saved for balsalm fir wood
    	loop %woodNum% ; runs for the number of pieces of wood that you have
    	{
    		Send p ; whittles planks
    		queueEmpty()
		checkHealth()
    	} 
    	
	selectTool("Grade 1 Plank")
    	plankNum := itemNum("Grade 1 Plank") - 1
    	
	loop %plankNum%
    	{
    		Send o ; builds outhouses
    		queueEmpty()
		checkHealth()
    	}
    }
    
    ; -----------------------------------------------------------------------------------------
    ; -----------------------------------------------------------------------------------------
    ; -----------------------------------------------------------------------------------------
    ; 			Dig Holes, Build Outhouse, Collect Poo
    ; -----------------------------------------------------------------------------------------
    ; -----------------------------------------------------------------------------------------
    ; -----------------------------------------------------------------------------------------
    
    selectTool("Toadwater Staff")
    loop 5
    {
    	Send {Down}
    	queueEmpty()
	checkHealth()
    }
    
    mouseMove(Ceil(cellsX / 2), Ceil(cellsY / 2) - 1) ; checks for the eating tree, if not, it plants a tree there.

    if(!is(balsamFir))
    {
	selectTool("Balsam Fir Seeds")
    Send {Down}
	selectTool("Toadwater Staff")
    }
    Send {Down}
    
    mouseMove(Ceil(cellsX / 2) - 1, Ceil(cellsY / 2)) ; checks for blank square to left for digging/outhouse
    
    if(!is(sand))
    {
	MsgBox The square to the dwarf's left does not compute as "diggable", if this is wrong, just unpause the script. If it is correct, make the hole diggable of find a different spot and restart the script from the beginning.
	Pause, On
    }
    loop 
    {
        if (itemNum("Dried Poo") >= 1101) ; this will save at least on spot for dried poo in the inventory
	{
          	break
        }
    
        outhouses := itemNum("Class 1 Outhouse Materials") - 1 ; this makes sure that atleast one outhouse is least in the inv to save its spot
        
    	loop %outhouses%
    	{
    		selectTool("Blister Shovel")
    		loop 100
    		{
    			Send {Left}
    			queueEmpty()
			checkHealth()
    		}
    		selectTool("Class 1 Outhouse Materials")
    		Send {Left}
    		selectTool("Toadwater Staff")
    		loop 20
    		{
    			loop 5
    			{
    				Send e
    				queueEmpty()
				checkHealth()
    			}
    			Send {Left}
    			queueEmpty()
			checkHealth()
    			Send {Right}
    			queueEmpty()
			checkHealth()
    		}
    		selectTool("Blister Shovel")
    		loop 50
    		{
    			Send {Left}
    			queueEmpty()
			checkHealth()
    		}
    	}
    }
    
    ; -----------------------------------------------------------------------------------------
    ; -----------------------------------------------------------------------------------------
    ; -----------------------------------------------------------------------------------------
    ; 				Fertilize and Plant Radishes
    ; -----------------------------------------------------------------------------------------
    ; -----------------------------------------------------------------------------------------
    ; -----------------------------------------------------------------------------------------
    
    selectTool("Toadwater Staff")
    loop 5
    {
        mouseMove(Ceil(cellsX / 2) + 1, Ceil(cellsY / 2))
        
    	if (is(radish)) ; checks to see if fully grown radish is to right and if so, will get the radish
    	{
    		Send {Right}
    		meX = Ceil(cellsX / 2)
    		meY = Ceil(cellsY / 2)
    			
    		click(meX, meY) ; clicks position of avatar
    		IfWinExist, Crop View
		{
			x = 30
        	        y = 45
    			loop 10
    			{
    			     	loop 10
    			     	{	         
    		        		ControlClick x%x% y%y%, Crop View
        		     		x := x + 55
        		     		queueEmpty()
					checkHealth()
    	       	     	 	}
			
    		     	}
    			x = 30
                	y := y + 55
    		}
		IfWinNotExist, Crop View
		{
			MsgBox Something went wrong and your cropview window isn't the do
			Pause, On
		}    
        	Send {Left}
    		queueEmpty()
		checkHealth()
    	}
        
	mouseMove(Ceil(cellsX / 2) + 1, Ceil(cellsY / 2))
    		    
    	if (is(ground)) ; sees if ground to right is blank and if not run check for fully grown radish
    	{
    		selectTool("Dried Poo")
    		loop 10
    		{
    			Send {Right}
    			queueEmpty()
			checkHealth()
    		}
		numGold := getGold()
		if (numGold < 100)
		{
			MsgBox You don't have enough gold to buy any radish seeds. Please sell unnesccesary inventory items and unpause the script.
			Pause, On
		}
		Send {Ctrl Down} b {Ctrl Up}
		queueEmpty()
		checkHealth()
		Click 269, 107
		Sleep 3000
		Send 100
		Send {Enter} {Enter}
		queueEmpty()
		checkHealth()
    		selectTool("Radish Seed")
    		Send {Right}
    		selectTool("Toadwater Staff")
    		queueEmpty()
		checkHealth()
    	}
    	Send {Right}
    }
    
    Send {Left} {Up}
    queueEmpty()
    checkHealth()
    
    loop 5
    {
        mouseMove(Ceil(cellsX / 2) + 1, Ceil(cellsY / 2))
    
    	if (is(radish)) ; checks to see if fully grown radish is to right and if so, will get the radish
    	{
    		Send {Right}
    		meX = Ceil(cellsX / 2)
    		meY = Ceil(cellsY / 2)
    			
    		click(meX, meY) ; clicks position of avatar
    		IfWinExist, Crop View
		{
			x = 30
        	        y = 45
    			loop 10
    			{
    			     	loop 10
    			     	{	         
    		        		ControlClick x%x% y%y%, Crop View
        		     		x := x + 55
        		     		queueEmpty()
					checkHealth()
    	       	     	 	}
			
    		     	}
    			x = 30
                	y := y + 55
    		}
		IfWinNotExist, Crop View
		{
			MsgBox Something went wrong and your cropview window isn't the do
			Pause, On
		}    
        	Send {Left}
    		queueEmpty()
		checkHealth()
    	}        
        
	mouseMove(Ceil(cellsX / 2) + 1, Ceil(cellsY / 2))
    		
    	if (is(ground)) ; sees if ground to right is blank and if not run check for fully grown radish
    	{
    		selectTool("Dried Poo")
    		loop 10
    		{
    			Send {Right}
    			queueEmpty()
			checkHealth()
    		}
		numGold := getGold()
		if (numGold < 100)
		{
			MsgBox You don't have enough gold to buy any radish seeds. Please sell unnesccesary inventory items and unpause the script.
			Pause, On
		}
		Send {Ctrl Down} b {Ctrl Up}
		queueEmpty()
		checkHealth()
		Click 269, 107
		Sleep 3000
		Send 100
		Send {Enter} {Enter}
		queueEmpty()
		checkHealth()
    		selectTool("Radish Seed")
    		Send {Right}
    		selectTool("Toadwater Staff")
    		queueEmpty()
		checkHealth()
    	}
    	Send {Up}
    }
    
    loop 5
    {
    	Send {Left}
    	queueEmpty()
	checkHealth()
    }
}
