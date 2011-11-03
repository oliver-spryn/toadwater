#d::ExitApp ; This will exit out of the script at any time by Pressing Win+d
#p::Pause ; Pauses the script
#e::

; Start by standing on a tree with plain ground to the left

; Start with you Shovel (or hands I think will work too) selected

; The "PixelGetColor, var, 1#, 2#" should have 1# and 2# be the position of the 1st box of the queue line (the bar that turns red for each action you do)


loop 10 ; This is the number of outhouses you want/have to build
{
	loop 100 ; This loop digs a hole for a level one outhouse
	{
		Send {Left}
		PixelGetColor, color, 26, 753	
		while color=0x0000FF
		{
			Sleep 500
			PixelGetColor, color, 26, 753
		}
	}
	
	Send 0 ; The number of the slot in your inventory the holds your outhouse
	PixelGetColor, color, 26, 753
	while color=0x0000FF
	{
		Sleep 500
		PixelGetColor, color, 26, 753
	}
	
	Send {Left}
	PixelGetColor, color, 26, 753
	while color=0x0000FF
	{
		Sleep 500
		PixelGetColor, color, 26, 753
	}

	Send 1 ; This is the number of the slot your staff is in
	PixelGetColor, color, 26, 753
	while color=0x0000FF
	{
		Sleep 500
		PixelGetColor, color, 26, 753
	}
	
	loop 20 ; The number of times you are going to enter the outhouse (aka poo)
	{
		loop 5 ; The number of times you eat (aka, how much you want to fill your poo meter before you poo
		{
			Send e
			PixelGetColor, color, 26, 753
			while color=0x0000FF
			{
				Sleep 500
				PixelGetColor, color, 26, 753
			}	
		}
		
		Send {Left}
		PixelGetColor, color, 26, 753
		while color=0x0000FF
		{
			Sleep 500
			PixelGetColor, color, 26, 753
		}
		Send {Right}
	}
	
	Send 4 ; This is the number of the slot your shovel is in
		; If you don't have a shovel, your hands might work so you just need to deselect your staff
	
	PixelGetColor, color, 26, 753
	while color=0x0000FF
	{
		Sleep 500
		PixelGetColor, color, 26, 753
	}

	loop 50 ; This loop digs up your poop
	{
		Send {Left}
		PixelGetColor, color, 26, 753
		while color=0x0000FF
		{
			Sleep 500
			PixelGetColor, color, 26, 753
		}
	}
}

return