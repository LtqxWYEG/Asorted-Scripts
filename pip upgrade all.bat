@echo off
python -m pip install --upgrade pip
pip list --outdated
pause
for /F "skip=2 delims= " %%i in ('pip list --outdated') do pip install --upgrade %%i
pause

REM In powershell use:  pip freeze | %{$_.split('==')[0]} | %{pip install --upgrade $_}
