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
  Script for repairing Windows errors via SFC and DISM. (As compiled from internet)
  
- ## Clean WinSxS.bat
  Run as Administrator.  
  Script for reducing size of WinSxS folder.
  #### Run with parameter "4" if you don't know what is going to happen.
  #### Or just press enter when asked to choose. It will run with "4".
  
- ## Run scheduled task - Optimize and defrag disks.bat
  Run as Administrator.  
  Immediately executes the Task: "\Microsoft\Windows\Defrag\ScheduledDefrag" via schtasks.  
  Despite its name, the Task will "optimize" instead of "defragment" SSDs.

- ## run defrag and optimize directly, intelligently.ps1
  Runs defrag.exe with flag /$ or -$. (And other, of course: /a /o /h /v /u etc...) Presumably in "scheduler"- or automatic-mode.
  Not finding anything exact about it in the internet; I believe the flag does tell defrag.exe to respect the results of prior runs and also record what it has been doing during the current run.
  I assume, since that flag is used in ScheduledDefrag task, that this information is saved as events in the events log - as you can see if you look at the history of the task via task scheduler.
  Microsofts documentation seems to hint at a somewhat intelligent behaviour when defrag.exe is executed by a schedule. Probably to prevent unnecessary wear and tear of SSDs.
  By my observation - if I run defrag.exe without /$ it will always perform a retrim - therefore my assumptions.

- ## run scheduled task with status check.ps1
  A WIP of a script to run a task via the scheduler with realtime status update. Currently runs ScheduledDefrag task inconsistently, for some reason.
  Mostly causes the task to become queued for hours. May be dependant on the type of task, since it seems that ScheduledDefrag is somewhat intelligently refusing to do damage to SSDs by repeatedly trimming or whatever.
  
- ## pip upgrade all.bat
  Maybe run as Administrator. Depends on your Python installation.  
  Nothing special: Upgrades PIP and updates all Python packages.
