#d::ExitApp ; This will exit out of the script at any time by Pressing Win+d
#p::Pause ; Pauses the script
#f:: ; starts the script

; you must start with a 7x7 ground free of anything
; start in the top left of your area

<Script to make sure toadwater staff is selected>

; -----------------------------------------------------------------------------------------
; -----------------------------------------------------------------------------------------
; -----------------------------------------------------------------------------------------
; 				CUT TREES (IF ANY) AND PLANT
; -----------------------------------------------------------------------------------------
; -----------------------------------------------------------------------------------------
; -----------------------------------------------------------------------------------------

while <Check numOuthouse> ; run if less than than 12
{
	if <Check numPlank> ; run if less than (12-numOuthouse)
	{
		while <Check numWood> ; run if less than (12-numPlank)
		{
			Send {Right}
			loop 3
			{	
				loop 5
				{	
					Send {Right}
					<if Tree> ; if tree cut
					<Select Seeds>
					Send {Left}
					<Select Staff>
					<Status Check>
				}
				Send {Down}
				loop 5
				{	
					Send {Left}
					<if Tree> ; if tree cut
					<Select Seeds>
					Send {Right}
					<Select Staff>
					<Status Check>
				}
				Send {Down}
			}
			<Select Staff>
			loop 5
			{
				Send {Up}
				<Status Check>
			}
		}
	}
	else
	{
		<Select Wood>
		loop <numWood> ; runs for the number of pieces of wood that you have
		{
			Send p ; whittles planks
			<Status Check>
		} 
	}
	<Select Plank>
	loop <numPlank>
	{
		Send o ; builds outhouses
		<Status Check>
	}
}

; -----------------------------------------------------------------------------------------
; -----------------------------------------------------------------------------------------
; -----------------------------------------------------------------------------------------
; 			Dig Holes, Build Outhouse, Collect Poo
; -----------------------------------------------------------------------------------------
; -----------------------------------------------------------------------------------------
; -----------------------------------------------------------------------------------------

<Select Staff>
loop 5
{
	Send {Down}
	<Status Check>
}

<Check eating tree> ; checks for eating tree, if not, it plants a tree there.

while <Check numFertilizer> ; while less than 1110 
{
	loop <numOuthouses>
	{
		<Select Shovel>
		loop 100
		{
			Send {Left}
			<Status Check>
		}
		<Select Outhouse>
		Send {Left}
		<Select Staff>
		loop 20
		{
			loop 5
			{
				Send e
				<Status Check>
			}
			Send {Left}
			<Status Check>
			Send {Right}
			<Status Check>
		}
		<Select Shovel>
		loop 50
		{
			Send {Left}
			<Status Check>
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

<Select Staff>
loop 5
{
	if <Check Radish> ; checks to see if fully grown radish is to right and if so, will get the radish
		{
			Send {Right}
			<Click Me> ; clicks position of avatar
			<Radish Collect>
			Send {Left}
			<Status Check>
		}
	if <Check Ground> ; sees if ground to right is blank and if not run check for fully grown radish
	{
		<Select Dried Poo>
		loop 10
		{
			Send {Right}
			<Status Check>
		}
		<Select RSeed>
		Send {Right}
		<Select Staff>
		<Status Check>
	}
	Send {Right}
}

Send {Left} {Up}
<Status Check>

loop 5
{
	if <Check Radish> ; checks to see if fully grown radish is to right and if so, will get the radish
		{
			Send {Right}
			<Click Me> ; clicks position of avatar
			<Radish Collect>
			Send {Left}
			{Status Check}
		}
	if <Check Ground> ; sees if ground to right is blank and if not run check for fully grown radish
	{
		<Select Dried Poo>
		loop 10
		{
			Send {Right}
			<Status Check>
		}
		<Select RSeed>
		Send {Right}
		<Select Staff>
		<Status Check>
	}
	Send {Up}
}

loop 5
{
	Send {Left}
	<Status Check>
}

; -----------------------------------------------------------------------------------------
; -----------------------------------------------------------------------------------------
; -----------------------------------------------------------------------------------------
; 				CUT TREES (IF ANY) AND PLANT
; -----------------------------------------------------------------------------------------
; -----------------------------------------------------------------------------------------
; -----------------------------------------------------------------------------------------
