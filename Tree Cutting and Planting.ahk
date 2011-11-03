#d::ExitApp ; This will exit out of the script at any time by Pressing Win+d
#p::Pause ; Pauses the script
#s::

; start with axe selected
; this script assumes that you have a square or rectangular shaped grove of trees that are of the same type or take the same number of swings to chop down
; NOTE: this script is not infinite
; find the pixel position of your first status bar block and press control+h. search for "19, 349" and replace with your "X, Y"
; find the pixel position of a position on your health bar block that will turn red and press control+h. search for "18, 318" and replace with your "X, Y"


Loop 7 ; the height of you grove of trees divided by 2, rounded down if not a whole number
{	
	loop 10 ; cuts down you first tree. should be the number of times you must swing your axe to chop it all the way down.
	{
		Send {Down}
		PixelGetColor, color, 19, 349
		while color=0x0000FF
		{
			Sleep 500
			PixelGetColor, color, 19, 349
		}
		PixelGetColor, color, 18, 318
		while color=0x0000FF
		{
			Sleep 30000
			PixelGetColor, color, 18, 318
		}
	}
	Send 5 ; inventory slot of seed
	Send {Down}
	Loop 9 ; the width of you grove of trees minus one (aka the number of trees left to your right)
	{
		Send 1 ; inventory slot number of your staff
		Send {Right}
		Send 2 ; inventory slot number of your axe
		loop 10 ; number of cuts it takes to cut down the tree
		{
			Send {Down}
			PixelGetColor, color, 19, 349
			while color=0x0000FF
			{
				Sleep 500
				PixelGetColor, color, 19, 349
			}
			PixelGetColor, color, 18, 318
			while color=0x0000FF
			{
				Sleep 30000
				PixelGetColor, color, 18, 318
			}

		}
		Send 5 ; inventory slot of seeds to be planted
		Send {Down}
	}
	Send 1 ; inventory slot of staff
	Send {Up}
	Send 2 ; inventory slot of axe
	loop 10 ; cuts first tree down in second row
	{
		Send {Down}
		PixelGetColor, color, 19, 349
		while color=0x0000FF
		{
			Sleep 500
			PixelGetColor, color, 19, 349
		}
		PixelGetColor, color, 18, 318
		while color=0x0000FF
		{
			Sleep 30000
			PixelGetColor, color, 18, 318
		}
	}
	Send 5 ; inventory slot of seeds
	Send {Down}
	Loop 9 ; width of trees minus one (aka number of trees left to cut in row)
	{
		Send 1 ; inventory slot of staff
		Send {Left}
		Send 2 ; inventory slot of axe
		loop 10 ; number of swings it takes to chop down tree
		{
			Send {Down}
			PixelGetColor, color, 19, 349
			while color=0x0000FF
			{
				Sleep 500
				PixelGetColor, color, 19, 349
			}
			PixelGetColor, color, 18, 318
			while color=0x0000FF
			{
				Sleep 30000
				PixelGetColor, color, 18, 318
			}
		}
		Send 5 ; slot number of your seeds
		Send {Down}
	}
	Send 1 ; inventory slot number of your staff
	Send {Up}
	Send 2 ; inventory slot of axe
}