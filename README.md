# Assorted-Scripts
Just an assortment of scripts I wrote for Windows. A place to save them for use afar.  

# Descriptions
- ## Toggle Loudness Equalization.bat
  Do NOT run as Administrator.  
  Runs continuously and checks every %SECONDS% if audio volume of %DEVICE_NAME% changed, then if it is above or below %TOGGLE_VOLUME%. Then sets registry key value for Loudness Equalization accordingly.
  #### Registry keys and values need to be changed before use on a different computer - probably.
  #### Requires svcl.exe from NirSoft.com. Get here: https://www.nirsoft.net/utils/sound_volume_command_line.html
  
- ## Repair Windows errors.bat
  Run as Administrator.  
  Script for repairing Windows errors via SFC and DISM.
  
- ## Clean WinSxS.bat
  Run as Administrator.  
  Script for reducing size of WinSxS folder.
  #### Run with parameter "4" if you don't know what is going to happen.
  
- ## Optimize or defrag disks.bat
  Run as Administrator.  
  Immediately executes the Task: "\Microsoft\Windows\Defrag\ScheduledDefrag" via schtasks.  
  Despite its name, the Task will "optimize" instead of "defragment" SSDs.
  
- ## pip upgrade all.bat
  Maybe run as Administrator. Depends on your Python installation.  
  Nothing special: Upgrades PIP and updates all Python packages.
