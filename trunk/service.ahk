; This script will prevent Windows Me errors by automatically rebooting
; the computer and restarting necessary applications during specified 
; intervals

; -------------------------------
; Configuration
; -------------------------------

waitOnStartUp = 1 ; The amount of time, in minutes, to wait while booting up before logging into Toadwater
loginFailedTime = 5 ; The amount of time, in seconds, to wait before Toadwater login is considered a fail
rebootCycle = 2 ; The amount of time, in hours, that the script should wait before rebooting
winName = TWC (DT_spryno724_155) ; The title of the Toadwater dialog window, when logged in
okButtonX = 630 ; The x-position of the "OK" button for Toadwater login
okButtonY = 330 ; The y-position of the "OK" button for Toadwater login

; -------------------------------
; Pre-action computations
; -------------------------------

waitCalculate := waitOnStartUp * 1000 * 60 ; Convert minutes to milliseconds
loginCalculate := loginFailedTime * 1000 ; Convert seconds to milliseconds
rebootCalculate := rebootCycle * 1000 * 60 ; Convert hours to milliseconds

; -------------------------------
; Action
; -------------------------------

; Set the coordinate mode relative to the entire screen
CoordMode, Mouse, Screen

; Wait for a specified period of time before logging into Toadwater, to make sure all has booted up properly
Sleep, %waitCalculate%
WinActivate, TWC
WinClose, Login
WinMaximize, TWC
Click %okButtonX%, %okButtonY%

; Check and see if the login was a success, otherwise try it again
loop {
  Sleep, %loginCalculate%
  
; Login was successful!
  if WinExist(winName) {
    break
; Rats, try it again!
  } else {
    Send ^l
    Sleep, 1000
    Click %okButtonX%, %okButtonY%
  }
}

; Force a reboot using the Poweroff utility, after waiting for a specified period
Sleep, %rebootCalculate%
WinActivate, Poweroff 3.0.1.3
Send {Enter}