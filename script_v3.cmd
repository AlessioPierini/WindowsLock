@Echo off
@title WinTask

REM ==============================================================
REM Impostare la data e creare la cartella ed il file per l'audit
REM ==============================================================

Set mydate_0=%Date%
Set mydate_1=%mydate_0:/=-%
Set mydate=%mydate_1: =_%
if not exist "C:\Audit\" mkdir C:\Audit
echo --AZIONE ESEGUITA--                   ------DATA------     -UTENTE- >> C:\Audit\Audit_%mydate%.txt

REM ==============================================================
REM Fare un check dei nomi e delle password, ricorda che puoi
REM aggiungere utenti andando ad inserire alcune righe:
REM if %user%== UTENTE goto PW5/6/7 
REM if NOT %user%==UTENTE
REM :PW5/6/7 
REM echo Inserisci la Password:
REM set/p "pass=>"
REM if %pass%== PASSWORD goto VALID
REM if NOT %pass%== PASSWORD goto NVAL2
REM ==============================================================

:PWCHK
cls
color 07
echo Inserisci Username:
set/p "user=>"
if %user%== Admin goto PW1
if %user%== Utente1 goto PW2
if %user%== Utente2 goto PW3
if %user%== Utente3 goto PW4
if NOT %user%== Admin if NOT %user%== Utente1 if NOT %user%== Utente2 if NOT %user%== Utente3 goto NVAL

:PW1
echo Inserisci la Password:
set/p "pass=>"
if %pass%== Admin goto VALID2
if NOT %pass%== Admin goto NVAL2

:PW2
echo Inserisci la Password:
set/p "pass=>"
if %pass%== PW1 goto VALID
if NOT %pass%== PW1 goto NVAL2

:PW3
echo Inserisci la Password:
set/p "pass=>"
if %pass%== PW2 goto VALID
if NOT %pass%== PW2 goto NVAL2

:PW4
echo Inserisci la Password:
set/p "pass=>"
if %pass%== PW3 goto VALID
if NOT %pass%== PW3 goto NVAL2

REM ==============================================================
REM Scelte diversificate per gli utenti e per gli Admin
REM infatti l'admin è l'unico che può chiudere il programma e
REM visionare l'audit
REM ==============================================================

:LOOP
color 0f
CHOICE /N /C:123 /M "Rendere visibile [1], invisibile [2] o LOGOUT [3]?"
IF ERRORLEVEL 3 goto USC
IF ERRORLEVEL 2 goto INV
IF ERRORLEVEL 1 goto VIS 

:LOOP2
color 0f
CHOICE /N /C:12345 /M "Rendere visibile [1], invisibile [2], LOGOUT [3], USCIRE [4], AUDIT [5]?"
IF errorlevel 5 goto ADT
IF ERRORLEVEL 4 goto EXT
IF ERRORLEVEL 3 goto USC
IF ERRORLEVEL 2 goto INV2
IF ERRORLEVEL 1 goto VIS2
	
REM ==============================================================
REM Casistiche che avvengono in base alle scelte prese sopra
REM ogni scelta viene tracciata nell'audit
REM ==============================================================

:INV
color 0b
nircmd.exe win trans class Shell_TrayWnd 0
nircmd.exe win hide class progman
echo Impostata traspatenza nel:             "%mydate%" da "%user%" >> C:\Audit\Audit_%mydate%.txt
attrib +h +s C:\Audit\Audit_%mydate%.txt
cls
goto LOOP

:VIS
color 0a
nircmd.exe win trans class Shell_TrayWnd 255
nircmd.exe win show class progman
echo Tolta trasparenza nel:                 "%mydate%" da "%user%" >> C:\Audit\Audit_%mydate%.txt
attrib +h +s C:\Audit\Audit_%mydate%.txt
cls
goto LOOP

:INV2
color 0b
nircmd.exe win trans class Shell_TrayWnd 0
nircmd.exe win hide class progman
echo Impostata traspatenza nel:             "%mydate%" da "%user%" >> C:\Audit\Audit_%mydate%.txt
attrib +h +s C:\Audit\Audit_%mydate%.txt
cls
goto LOOP2

:VIS2
color 0a
nircmd.exe win trans class Shell_TrayWnd 255
nircmd.exe win show class progman
echo Tolta trasparenza nel:                 "%mydate%" da "%user%" >> C:\Audit\Audit_%mydate%.txt
attrib +h +s C:\Audit\Audit_%mydate%.txt
cls
goto LOOP2

:NVAL
echo Utente errato nel:                     "%mydate%" di "%user%" >> C:\Audit\Audit_%mydate%.txt
color 0c
echo Nome utente errato o inesistente!
attrib +h +s C:\Audit\Audit_%mydate%.txt
TIMEOUT /t 1
goto USC

:NVAL2
echo Password errata nel:                   "%mydate%" di "%user%" >> C:\Audit\Audit_%mydate%.txt
color 0c
echo Password errata!
attrib +h +s C:\Audit\Audit_%mydate%.txt
TIMEOUT /t 1
goto USC

:VALID
echo Login eseguito correttamente nel:      "%mydate%" di "%user%" >> C:\Audit\Audit_%mydate%.txt
color 02
echo Login eseguito correttamente!
attrib +h +s C:\Audit\Audit_%mydate%.txt
goto LOOP

:VALID2
echo Login eseguito correttamente nel:      "%mydate%" di "%user%" >> C:\Audit\Audit_%mydate%.txt
color 02
echo Login eseguito correttamente!
attrib +h +s C:\Audit\Audit_%mydate%.txt
goto LOOP2

:ADT
echo Audit visualizzato correttamente:      "%mydate%" da "%user%" >> C:\Audit\Audit_%mydate%.txt
start C:\Audit\Audit_%mydate%.txt
attrib +h +s C:\Audit\Audit_%mydate%.txt
cls
goto LOOP2

:USC
echo Logout eseguito correttamente nel:     "%mydate%" di "%user%" >> C:\Audit\Audit_%mydate%.txt
goto PWCHK

:EXT
echo Programma chiuso nel:                  "%mydate%" da "%user%" >> C:\Audit\Audit_%mydate%.txt
exit