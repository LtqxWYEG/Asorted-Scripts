@echo off

:ENTER
CLS
echo.
echo ================================================================================
echo                        Script for repairing Windows errors
echo ================================================================================
echo                                                                  By Distelzombie
echo.
echo   [1] SFC /scannow
echo   [2] or [2p] DISM /StartComponentCleanup and /RestoreHealth
echo   [3] or [3p] Both: First SFC, DISM SCC, DISM RH, then SFC again
echo   ### (If you want it to pause between checks, write "2p" or "3p") ###
echo.
echo   "Space and Enter" or CTRL+C to exit.
echo.
echo.
echo --------------------------------------------------------------------------------
echo WARNING! "DISM /RestoreHealth" will revert many settings you've made to Windows.
echo (Like privacy and security settings) Remember to re-apply them afterwards!
echo.
echo DISM /StartComponentCleanup cleans the WinSXS folder. That can resolve issues.
echo.
echo In case of [3]: It makes sense to run "SFC /scannow" a second time afterwards
echo because DISM could repair something that held the first SFC back from 
echo repairing something else.
echo --------------------------------------------------------------------------------
echo.
echo.

set run=1
set ask=0
set /p ask="Choose: "

if %ask%==1 goto SFC
if %ask%==2 goto DISM
if %ask%==3 goto BOTH
if %ask%==2p goto DISM
if %ask%==3p goto BOTH
rem echo %ask% | findstr /i /c:"2" >nul && goto DISM || echo %ask% | findstr /i /c:"3" >nul && goto BOTH || goto ENTER
rem It's such a beauty... sadly it needs too much input handling. (ie: ask="32" or "23" would run the checks multiple times)
goto ENTER


:BOTH
echo.
echo.
echo ================================================================================
echo                               Starting all checks...
rem goto SFC


:SFC
echo ================================================================================
echo.
echo.
echo.
echo                                Starting SFC.exe...
echo.
echo %ask% | findstr /i /c:"p" >nul && pause || echo.
@echo on
sfc /scannow
@echo off
echo.
echo.
echo.
set /a run=run+1
if %run%==3 goto END
echo %ask% | findstr /i /c:"3" >nul && goto DISM || goto END
goto END


:DISM
echo ================================================================================
echo.
echo.
echo.
echo                  Starting DISM.exe with /StartComponentCleanup...
echo.
echo %ask% | findstr /i /c:"p" >nul && pause || echo.
@echo on
dism /Online /Cleanup-image /ScanHealth
echo.
echo CTRL+C if no issues detected.
echo Commencing cleanup ...
dism /Online /Cleanup-image /StartComponentCleanup
@echo off
echo.
echo.
echo.
echo ================================================================================
echo.
echo.
echo.
echo                     Starting DISM.exe with /RestoreHealth...
echo.
echo %ask% | findstr /i /c:"p" >nul && pause || echo.
@echo on
dism /Online /Cleanup-image /RestoreHealth
@echo off
echo.
echo.
echo.
echo %ask% | findstr /i /c:"3" >nul && goto SFC || goto END


:END
echo --------------------------------------------------------------------------------
echo -----------------------------------All done!------------------------------------
echo --------------------------------------------------------------------------------
pause
goto ENTER