@echo off

:ENTER
CLS
echo.
echo ================================================================================
echo                        Script for repairing Windows errors
echo ================================================================================
echo                                                                  By Distelzombie
echo   NOTE: Run as Administrator!
echo.
echo   1.) SFC /scannow
echo   2.) DISM /StartComponentCleanup and /RestoreHealth
echo   3.) Then SFC again
echo.
echo   "Space and Enter" or CTRL+C to exit.
echo.
echo.
echo --------------------------------------------------------------------------------
echo WARNING! "DISM /RestoreHealth" can revert some changes you've made to Windows'
echo privacy and security settings. Remember to check them afterwards!
echo.
echo DISM /StartComponentCleanup cleans the WinSXS folder. That can resolve issues.
echo.
echo Explanation for why 3.): It makes sense to run "SFC /scannow" a second time
echo afterwards because DISM could repair something that held the first SFC back 
echo from repairing something else.
echo --------------------------------------------------------------------------------
echo.
echo.

set run=1
goto ENTER


echo.
echo.
echo ================================================================================
echo                               Starting all checks...


:SFC
echo ================================================================================
echo.
echo.
echo.
echo                                Starting SFC.exe...
echo.
@echo on
sfc /scannow
@echo off
echo.
echo.
echo.
set /a run=run+1
if %run%==3 goto END


echo ================================================================================
echo.
echo.
echo.
echo                  Starting DISM.exe with /StartComponentCleanup...
echo.
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
@echo on
dism /Online /Cleanup-image /RestoreHealth
@echo off
echo.
echo.
echo.
goto SFC


:END
echo --------------------------------------------------------------------------------
echo -----------------------------------All done!------------------------------------
echo --------------------------------------------------------------------------------
pause
goto ENTER
