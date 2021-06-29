@Echo off
@title WinTask

:LOOP
color 0f
CHOICE /N /C:123 /M "Rendere visibile [1], invisibile [2] o uscire [3]?"

IF ERRORLEVEL 3 goto USC
IF ERRORLEVEL 2 goto INV
IF ERRORLEVEL 1 goto VIS 
	

:INV
color 0b
nircmd.exe win trans class Shell_TrayWnd 0
goto LOOP

:VIS
color 0a
nircmd.exe win trans class Shell_TrayWnd 255
goto LOOP

:USC
exit