@echo off

rem --------------------------------------------------------------------------------
rem NOTES: if operators:
rem    EQU : Equal
rem    NEQ : Not equal
rem    LSS : Less than <
rem    LEQ : Less than or Equal <=
rem    GTR : Greater than >
rem    GEQ : Greater than or equal >=

rem --------------------------------------------------------------------------------
rem Settings:
set DEV=0
set SECONDS=3
set TOGGLE_VOLUME=80.0
set DEVICE_NAME=Speakers
set KEY_NAME="HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\MMDevices\Audio\Render\{a20f5e1a-5262-4cc1-a60f-9a4c3bb3bde8}\FxProperties"
set VALUE_NAME="{E0A941A0-88A2-4df5-8D6B-DD20BB06E8FB},4"

rem --------------------------------------------------------------------------------
rem Initialize some variables...
for /F "tokens=3" %%a in ('reg query %KEY_NAME% /v %VALUE_NAME%') do set VALUE_VALUE=%%a
for /F "tokens=*" %%i in ('.\svcl.exe /Stdout /GetPercent %DEVICE_NAME%') do set OLDVOLUME=%%i

:LOOP
    CLS
    echo.
    echo ================================================================================
    echo                         Toggle Loudness Equalization
    echo ================================================================================
    echo                                                                  By Distelzombie
    echo.
    echo   [-] Checks audio volume of %DEVICE_NAME% every %SECONDS% seconds
    echo       and switches registry key value for Loudness Equalization
    echo.
    echo   Highlight window and press P to pause.
    echo   CTRL+C to exit.
    echo.
    echo.
    echo --------------------------------------------------------------------------------
    echo   NOTE: Do NOT run as Administrator!
    echo         Needs svcl.exe from NirSoft.com
    echo --------------------------------------------------------------------------------
    echo.
    echo.
    
    
    if %DEV%==1 (
        echo Current Volume     = %VOlUME%
        echo Registry Key Value = %VALUE_VALUE%
    )
    if %VALUE_VALUE% EQU 0x1 echo Loudness Equalization is ON
    if %VALUE_VALUE% EQU 0x0 echo Loudness Equalization is OFF
    for /F "tokens=*" %%i in ('.\svcl.exe /Stdout /GetPercent %DEVICE_NAME%') do set VOLUME=%%i
    if %VOLUME% NEQ %OLDVOLUME% (
        echo Volume changed ...
        goto CHECK
        )
    choice /T %SECONDS% /C pc /D c /N /M "Press P to pause ..."
    if %errorlevel% EQU 1 pause
    if %errorlevel% EQU 2 goto LOOP
    rem timeout /T %SECONDS% /NOBREAK >nul
    goto LOOP

:CHECK
    if %VOLUME% GEQ %TOGGLE_VOLUME% goto OFF
    if %VOLUME% LEQ %TOGGLE_VOLUME% goto ON
    goto LOOP

:OFF
    if %VALUE_VALUE% EQU 0x1 (
        echo Switching Loudness Equalization OFF ...
        reg add %KEY_NAME% /v %VALUE_NAME% /t REG_DWORD /d 0x0 /f
        for /F "tokens=3" %%a in ('reg query %KEY_NAME% /v %VALUE_NAME%') do set VALUE_VALUE=%%a
        )
    for /F "tokens=*" %%i in ('.\svcl.exe /Stdout /GetPercent %DEVICE_NAME%') do set OLDVOLUME=%%i
    timeout /T %SECONDS% /NOBREAK >nul
    goto LOOP

:ON
    if %VALUE_VALUE% EQU 0x0 (
        echo Switching Loudness Equalization ON ...
        reg add %KEY_NAME% /v %VALUE_NAME% /t REG_DWORD /d 0x1 /f
        for /F "tokens=3" %%a in ('reg query %KEY_NAME% /v %VALUE_NAME%') do set VALUE_VALUE=%%a
        )
    for /F "tokens=*" %%i in ('.\svcl.exe /Stdout /GetPercent %DEVICE_NAME%') do set OLDVOLUME=%%i
    timeout /T %SECONDS% /NOBREAK >nul
    goto LOOP

pause