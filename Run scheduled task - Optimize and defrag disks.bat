@echo on

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
echo   NOTE: Run as Administrator! Could take up to 30 minutes even with a SSD/NVME
echo --------------------------------------------------------------------------------
echo.
echo.
pause



schtasks /run /i /tn "\Microsoft\Windows\Defrag\ScheduledDefrag"
echo.

for %%a in (schtasks /query /tn "\Microsoft\Windows\Defrag\ScheduledDefrag") do | find "disabled"
if %svc% echo ERROR: Service is disabled! | goto end
echo Status every ten seconds ...
:repeat
pause
goto end


echo ... working ...
timeout 10 | schtasks /query /tn "\Microsoft\Windows\Defrag\ScheduledDefrag" | find "Ready"
IF NOT %ERRORLEVEL% 3 goto :repeat
echo.pause
echo Optimization or defragmentation done!
echo.
:end
pause