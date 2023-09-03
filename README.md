# Assorted-Scripts
Just an assortment of scripts I wrote. A place to save them for use afar.

# Descriptions
- Toggle Loudness Equalization.bat --- Runs continiously and checks every %SECONDS% if audio volume of %DEVICE_NAME% changed, then if it is above or below %TOGGLE_VOLUME% and in turn switches registry key value for Loudness Equalization.
    Registry values need to be changed before use on a different computer. (Needs svcl.exe from NirSoft.com: https://www.nirsoft.net/utils/sound_volume_command_line.html)
- Repair Windows errors.bat --- Script for repairing Windows errors via SFC and DISM. Run with parameter "3" if you don't know what is going to happen.
- Clean WinSxS.bat --- Script for reducing size of WinSxS folder. Run with parameter "4" if you don't know what is going to happen.
- Optimize or defrag disks.bat --- Immediately executes the Task: "\Microsoft\Windows\Defrag\ScheduledDefrag" via schtasks. Despite its name, it will optimize instead of defragment SSDs.
- pip upgrade all.bat --- Upgrades PIP and updates all Python packages.
