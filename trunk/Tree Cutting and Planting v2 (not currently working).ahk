#d::ExitApp ; This will exit out of the script at any time by Pressing Win+d
#p::Pause ; Pauses the script
#space::

; start with axe selected

Loop 5
{	
	
	PixelGetColor, color, 644, 478
	if color = 0xAD8568
	{
		loop 10
		{
			Send {Down}
			PixelGetColor, color, 19, 349
			while color=0x0000FF
			{
				Sleep 500
				PixelGetColor, color, 19, 349
			}
			PixelGetColor, color, 18, 318
			while color=0x0000C0
			{
				Sleep 30000
				PixelGetColor, color, 18, 318
			}
		}
	}

	PixelGetColor, color, 645, 381
	if color = 0xA48263
	{
		loop 10
		{
			Send {Up}
			PixelGetColor, color, 19, 349
			while color=0x0000FF
			{
				Sleep 500
				PixelGetColor, color, 19, 349
			}
			PixelGetColor, color, 18, 318
			while color=0x0000C0
			{
				Sleep 30000
				PixelGetColor, color, 18, 318
			}
		}
	}
	
	Send 5 {Down} {Up}
	PixelGetColor, color, 18, 318
	while color=0x0000C0
	{
		Sleep 30000
		PixelGetColor, color, 18, 318
	}

	Loop 9
	{
		Send 1 {Right} 2
		PixelGetColor, color, 18, 318
		while color=0x0000C0
		{
			Sleep 30000
			PixelGetColor, color, 18, 318
		}
	
		PixelGetColor, color, 644, 478
		if color = 0xAD8568
		{
			loop 10
			{
				Send {Down}
				PixelGetColor, color, 19, 349
				while color=0x0000FF
				{
					Sleep 500
					PixelGetColor, color, 19, 349
				}
				PixelGetColor, color, 18, 318
				while color=0x0000C0
				{
					Sleep 30000
					PixelGetColor, color, 18, 318
				}
			}
		}

		PixelGetColor, color, 645, 381
		if color = 0xA48263
		{
			loop 10
			{
				Send {Up}
				PixelGetColor, color, 19, 349
				while color=0x0000FF
				{
					Sleep 500
					PixelGetColor, color, 19, 349
				}
				PixelGetColor, color, 18, 318
				while color=0x0000C0
				{
					Sleep 30000
					PixelGetColor, color, 18, 318
				}
			}
		}	

		PixelGetColor, color, 598, 432
		if color = 0xAD8568
		{
			loop 10
			{
				Send {Left}
				PixelGetColor, color, 19, 349
				while color=0x0000FF
				{
					Sleep 500
					PixelGetColor, color, 19, 349
				}
				PixelGetColor, color, 18, 318
				while color=0x0000C0
				{
					Sleep 30000
					PixelGetColor, color, 18, 318
				}
			}
		}
		Send 5 {Down} {Up} {Left}
		PixelGetColor, color, 18, 318
		while color=0x0000C0
		{
			Sleep 30000
			PixelGetColor, color, 18, 318
		}

	}
	Send 1 {Up} 2
	PixelGetColor, color, 18, 318
	while color=0x0000C0
	{
		Sleep 30000
		PixelGetColor, color, 18, 318
	}

	PixelGetColor, color, 644, 478
	if color = 0xAD8568
	{
		loop 10
		{
			Send {Down}
			PixelGetColor, color, 19, 349
			while color=0x0000FF
			{
				Sleep 500
				PixelGetColor, color, 19, 349
			}
			PixelGetColor, color, 18, 318
			while color=0x0000C0
			{
				Sleep 30000
				PixelGetColor, color, 18, 318
			}
		}
	}
	Send 5 {Down} 1 {Up} {Up}
	PixelGetColor, color, 18, 318
	while color=0x0000C0
	{
		Sleep 30000
		PixelGetColor, color, 18, 318
	}

	PixelGetColor, color, 644, 478
	if color = 0xAD8568
	{
		loop 10
		{
			Send {Down}
			PixelGetColor, color, 19, 349
			while color=0x0000FF
			{
				Sleep 500
				PixelGetColor, color, 19, 349
			}
			PixelGetColor, color, 18, 318
			while color=0x0000C0
			{
				Sleep 30000
				PixelGetColor, color, 18, 318
			}
		}
	}

	PixelGetColor, color, 645, 381
	if color = 0xA48263
	loop 10
	{
		{
			Send {Up}
			PixelGetColor, color, 19, 349
			while color=0x0000FF
			{
				Sleep 500
				PixelGetColor, color, 19, 349
			}
			PixelGetColor, color, 18, 318
			while color=0x0000C0
			{
				Sleep 30000
				PixelGetColor, color, 18, 318
			}
		}
	}
	Send 5 {Down} {Up}
	
	
	Loop 9
	{
		Send 1 {Left} 2
		PixelGetColor, color, 644, 478
		if color = 0xAD8568
		{
			loop 10
			{
				Send {Down}
				PixelGetColor, color, 19, 349
				while color=0x0000FF
				{
					Sleep 500
					PixelGetColor, color, 19, 349
				}
				PixelGetColor, color, 18, 318
				while color=0x0000C0
				{
					Sleep 30000
					PixelGetColor, color, 18, 318
				}
			}
		}	
		PixelGetColor, color, 645, 381
		if color = 0xA48263
		{
			loop 10
			{
				Send {Up}
				PixelGetColor, color, 19, 349
				while color=0x0000FF
				{
					Sleep 500
					PixelGetColor, color, 19, 349
				}
				PixelGetColor, color, 18, 318
				while color=0x0000C0
				{
					Sleep 30000
					PixelGetColor, color, 18, 318
				}
			}
		}
		PixelGetColor, color, 694, 433
		if color = 0xAD8568
		{
			loop 10
			{
				Send {Right}
					PixelGetColor, color, 19, 349
				while color=0x0000FF
				{
					Sleep 500
					PixelGetColor, color, 19, 349
				}
				PixelGetColor, color, 18, 318
				while color=0x0000C0
				{
					Sleep 30000
					PixelGetColor, color, 18, 318
				}
			}
		}
		Send 5 {Down} {Up} {Right}
	}
	Send 1 {Up} 2
	PixelGetColor, color, 18, 318
	while color=0x0000C0
	{
		Sleep 30000
		PixelGetColor, color, 18, 318
	}

	PixelGetColor, color, 644, 478
	if color = 0xAD8568
	{
		loop 10
		{
			Send {Down}
			PixelGetColor, color, 19, 349
			while color=0x0000FF
			{
				Sleep 500
				PixelGetColor, color, 19, 349
			}
			PixelGetColor, color, 18, 318
			while color=0x0000C0
			{
				Sleep 30000
				PixelGetColor, color, 18, 318
			}
		}
	}
	Send 5 {Down} 1 {Up} {Up} 2
	PixelGetColor, color, 18, 318
	while color=0x0000C0
	{
		Sleep 30000
		PixelGetColor, color, 18, 318
	}

}