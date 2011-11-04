#Include framework\include.ahk
#d::ExitApp ; This will exit out of the script at any time by Pressing Win+d
#p::Pause ; Pauses the script
#f:: ; starts the script

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
loop
{
    while (itemNum("Class 1 Outhouse Materials") < 13)
    {
    	if (13 - itemNum("Class 1 Outhouse Materials") < itemNum("Grade 1 Plank"))
    	{
    		while (itemNum("Balsam Fir Wood") < 13 - itemNum("Grade 1 Plank"))
    		{
    			Send {Right}
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
    					      }
    					}
    					
    					selectTool("Balsam Fir Seeds")
    					
    					Send {Left}
    					
    					selectTool("Toadwater Staff")
    					queueEmpty()
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
                              }
                        }
                        
    					selectTool("Balsam Fir Seeds")
    					Send {Right}
    					selectTool("Toadwater Staff")
    					queueEmpty()
    				}
    				Send {Down}
    			}
    			selectTool("Toadwater Staff")
    			loop 5
    			{
    				Send {Up}
    				queueEmpty()
    			}
    		}
    	}
    	else
    	{
    		selectTool("Balsam Fir Wood")
    		woodNum = itemNum("Balsam Fir Wood")
    		
    		loop %woodNum% ; runs for the number of pieces of wood that you have
    		{
    			Send p ; whittles planks
    			queueEmpty()
    		} 
    	}
    	selectTool("Balsam Fir Wood")
    	woodNum = itemNum("Balsam Fir Wood")
    	
    	loop %woodNum%
    	{
    		Send o ; builds outhouses
    		queueEmpty()
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
    }
    
    mouseMove(Ceil(cellsX / 2), Ceil(cellsY / 2) - 1) ; checks for eating tree, if not, it plants a tree there.
    selectTool("Balsam Fir Seeds")
    Send {Down}
    
    while (itemNum("Dried Poo") < 1110) ; while less than 1110 
    {
        outhouses = itemNum("Class 1 Outhouse Materials")
        
    	loop %outhouses%
    	{
    		selectTool("Blister Shovel")
    		loop 100
    		{
    			Send {Left}
    			queueEmpty()
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
    			}
    			Send {Left}
    			queueEmpty()
    			Send {Right}
    			queueEmpty()
    		}
    		selectTool("Blister Shovel")
    		loop 50
    		{
    			Send {Left}
    			queueEmpty()
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
    		    x = 30
                y = 45
    			loop 10
    			{
    			     loop 10
    			     {
    			         IfwinExists, Crop View
    			         {
    			             ControlClick x%x% y%y%, Crop View
        			         x := x + 55
        			         queueEmpty()
    	       		     }
    			     }
    			     x = 30
                     y = y + 45
    			}    
        			Send {Left}
    	       		queueEmpty()
    		    }
        mouseMove(Ceil(cellsX / 2) + 1, Ceil(cellsY / 2))
    		    
    	if (is(ground)) ; sees if ground to right is blank and if not run check for fully grown radish
    	{
    		selectTool("Dried Poo")
    		loop 10
    		{
    			Send {Right}
    			queueEmpty()
    		}
    		selectTool("Radish Seed")
    		Send {Right}
    		selectTool("Toadwater Staff")
    		queueEmpty()
    	}
    	Send {Right}
    }
    
    Send {Left} {Up}
    queueEmpty()
    
    loop 5
    {
        mouseMove(Ceil(cellsX / 2) + 1, Ceil(cellsY / 2))
    
    	if (is(radish)) ; checks to see if fully grown radish is to right and if so, will get the radish
    		{
    			Send {Right}
    			meX = Ceil(cellsX / 2)
                meY = Ceil(cellsY / 2)
                
                click(meX, meY) ; clicks position of avatar
    			<Radish Collect>
    			Send {Left}
    			{Status Check}
    		}
        
        mouseMove(Ceil(cellsX / 2) + 1, Ceil(cellsY / 2))
    		
    	if (is(ground)) ; sees if ground to right is blank and if not run check for fully grown radish
    	{
    		<Select Dried Poo>
    		loop 10
    		{
    			Send {Right}
    			queueEmpty()
    		}
    		    x = 30
                y = 45
                loop 10
                {
                     loop 10
                     {
                         IfwinExists, Crop View
                         {
                             ControlClick x%x% y%y%, Crop View
                             x := x + 55
                             queueEmpty()
                         }
                     }
                     x = 30
                     y = y + 45
                } 
    		Send {Right}
    		selectTool("Toadwater Staff")
    		queueEmpty()
    	}
    	Send {Up}
    }
    
    loop 5
    {
    	Send {Left}
    	queueEmpty()
    }
}
