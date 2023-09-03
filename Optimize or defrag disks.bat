@echo off

:ENTER
CLS
echo.
echo ================================================================================
echo                           Run Scheduled Task on Demand
echo ================================================================================
echo                                                                  By Distelzombie
echo.
echo   [-] Immediately runs: "\Microsoft\Windows\Defrag\ScheduledDefrag"
echo       Optimizes or defragments all drives. (Except USB)
echo.
echo   CTRL+C to exit.
echo.
echo.
echo --------------------------------------------------------------------------------
echo   WARNING! Could take up to 30 minutes even with a SSD/NVME
echo --------------------------------------------------------------------------------
echo.
echo.


schtasks /run /i /tn "\Microsoft\Windows\Defrag\ScheduledDefrag"
echo.
echo Status every ten seconds ...
:repeat
echo ... working ...
timeout 10 | schtasks /query /tn "\Microsoft\Windows\Defrag\ScheduledDefrag" | find "Ready"
if not %errorlevel% equ 0 goto :repeat
echo.
echo Optimization or defragmentation done!
echo.

pause