;Code by Andrew Lehman
;Yes, he actually tried to do something

#a::
{
GoldGet(){
	WinGetText, gold, Active Window Info (Shift-Alt-Tab to freeze display)
	sleep 75
	godPos := InStr(gold, "days")
	StringTrimLeft, goldTrim, gold, goldPos - 1
	StringSplit, goldParsed, goldTrim, %A_Space%
	MsgBox % goldParsed1
	return  goldParsed1
}
}