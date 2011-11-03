#d::ExitApp ; This will exit out of the script at any time by Pressing Win+d
PixelGetColor, color, 26, 753	
while color=0x0000FF
{
	Sleep 500
	PixelGetColor, color, 26, 753
}

return