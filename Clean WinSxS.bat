@echo off

:ENTER
CLS
echo. 
echo ================================================================================
echo                   Script for reducing size of WinSxS folder
echo ================================================================================
echo                                                                  By Distelzombie
echo.
echo   [1] DISM /online /Cleanup-Image /StartComponentCleanup
echo   [2] DISM /online /Cleanup-Image /StartComponentCleanup /ResetBase
echo   [3] DISM /online /Cleanup-Image /SPSuperseded 
echo   [4] or [4p] Run all.                 (Add the "p" to pause inbetween commands)
echo   [r] for a report of the WinSxS component store.       (/AnalyzeComponentStore)
echo   ### "/AnalyzeComponentStore" does not show how much space can be freed ###
echo.
echo          Enter to start everything ("4")  --  Space or CTRL+C to exit.
echo.
echo --------------------------------------------------------------------------------
echo NOTE: Run as Administrator!
echo.
echo    DISM /online /Cleanup-Image /StartComponentCleanup
echo Clean up and compress components.
echo.
echo    DISM /online /Cleanup-Image /StartComponentCleanup /ResetBase
echo This command removes all superseded versions of every component
echo in the component store:
echo.
echo    DISM /online /Cleanup-Image /SPSuperseded 
echo Remove any backup components needed for uninstallation of the service pack.
echo A service pack is a collection of cumulative updates for a particular release
echo of Windows.
echo Warning:   The service pack cannot be uninstalled after this command is completed.
echo.
echo --------------------------------------------------------------------------------
echo.

set run=1
set ask=0
set /p ask="(Default: 4 [Enter]) Choose: " || SET "ask=4"
rem IF NOT DEFINED ask SET "4"

if %ask%==1 goto DISM1
if %ask%==2 goto DISM2
if %ask%==3 goto DISM3
if %ask%==4 goto ALL
if %ask%==r goto REP
if %ask%==4p goto ALL
rem echo %ask% | findstr /i /c:"2" >nul && goto DISM || echo %ask% | findstr /i /c:"3" >nul && goto BOTH || goto ENTER
rem It's such a beauty... sadly it needs too much input handling. (ie: ask="32" or "23" would run the checks multiple times)
goto ENTER


:ALL
echo.
echo.
echo ================================================================================
echo                               Starting all checks...


:DISM1
echo ================================================================================
echo.
echo.
echo.
echo                  Starting DISM.exe with just /StartComponentCleanup...
echo.
echo %ask% | findstr /i /c:"p" >nul && pause || echo.
@echo on
DISM /online /Cleanup-Image /StartComponentCleanup
@echo off
echo.
echo.
echo.
echo %ask% | findstr /i /c:"4" >nul && goto DISM2 || goto END
goto END


:DISM2
echo ================================================================================
echo.
echo.
echo.
echo                        Starting DISM.exe with /ResetBase...
echo.
echo %ask% | findstr /i /c:"p" >nul && pause || echo.
@echo on
DISM /online /Cleanup-Image /StartComponentCleanup /ResetBase
@echo off
echo.
echo.
echo.
echo %ask% | findstr /i /c:"4" >nul && goto DISM3 || goto END
goto END


:DISM3
echo ================================================================================
echo.
echo.
echo.
echo                       Starting DISM.exe with /SPSuperseded...
echo.
echo %ask% | findstr /i /c:"p" >nul && pause || echo.
@echo on
DISM /online /Cleanup-Image /SPSuperseded 
@echo off
echo.
echo.
echo.
echo.
echo.
echo.
goto END


:REP
echo ================================================================================
echo.
echo.
echo.
echo                                 Creating report...
@echo on
DISM /online /Cleanup-Image /AnalyzeComponentStore
@echo off
echo.
echo.



:END
echo --------------------------------------------------------------------------------
echo -----------------------------------All done!------------------------------------
echo --------------------------------------------------------------------------------
pause
goto ENTER
