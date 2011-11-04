^e:: 
	Run, "%programfiles%\Microsoft Office\OFFICE14\OUTLOOK.EXE" /c ipm.note /m lehmanad1@gcc.edu ;Will send Andrew the e-mail, change if you so desire.
	Sleep 3000 		;waits for program to load
	Send #			;opening the file will unwittingly activate the windows key, kill it now!
	SendInput, WARNING {TAB}			;message
	WinMaximize, WARNING - Message (HTML) 		;Maximizes Window, for upcoming click, needed SendInput before for WinName
	SendInput, THERE IS AN OBSTACLE IN THE WAY	;message
	Click, 40, 193					;clicks on send. NOTE: May need to send/receive all in order to send it.
^z::	ExitApp