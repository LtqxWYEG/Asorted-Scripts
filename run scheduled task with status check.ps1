

function task_status
{
    $sched_task_status = $(schtasks /query /tn "\Microsoft\Windows\Defrag\ScheduledDefrag" | Out-String)
    [string]$sched_task_status
    # The variable isn't being set to a single string, but an "array of lines" which are by default concatenated with spaces.
    # The whole "$(COMMAND | Out-String)" thing is there to respect the existance of new-line characters in the source.
    # Otherwise the string variable would loose its table-like formatting
}


write-host "================================================================================"
write-host "                          Run Scheduled Task on Demand"
write-host "--------------------------------------------------------------------------------"
write-host "                                                                 By Distelzombie"
write-host `n
write-host '  [-] Immediately runs: "\Microsoft\Windows\Defrag\ScheduledDefrag"'
write-host "      Optimizes or defragments all drives. Except those connected via USB."
write-host `n
write-host "      Prerequisites: Task '\Microsoft\Windows\Defrag\ScheduledDefrag'"
write-host "      Must be set (Under 'settings') to 'Allow task to be run on demand'"
write-host `n
write-host `n
write-host `n
write-host "                    - - - - - - CTRL+C to exit. - - - - - - "
write-host "--------------------------------------------------------------------------------"
write-host "  NOTE: Run as Administrator! Could take up to 30 minutes even with a SSD/NVME"
write-host "================================================================================"
write-host `n
write-host `n
timeout /t 10

$done = 0
$seconds = 0
$minutes = 0
while ($done -eq 0)
{
    $sched_task_status = task_status
    if (
    ($sched_task_status | select-string "Disabled"              -list | % {$_.Matches} | % {$_.Value}) -or `
    ($sched_task_status | select-string "No more runs"          -list | % {$_.Matches} | % {$_.Value}) -or `
    ($sched_task_status | select-string "Not scheduled"         -list | % {$_.Matches} | % {$_.Value}) -or `
    ($sched_task_status | select-string "Terminated"            -list | % {$_.Matches} | % {$_.Value}) -or `
    ($sched_task_status | select-string "Service not available" -list | % {$_.Matches} | % {$_.Value}) -or `
    ($sched_task_status | select-string "Task not ready"        -list | % {$_.Matches} | % {$_.Value}))
    {
        write-host `n
        write-host "================================================================================"
        write-host "  ERROR: Task is probably disabled!"
        write-host "Press WIN+R, then enter: 'taskschd.exe'. -> and look for the task yourself."
        write-host "Here it is: '\Microsoft\Windows\Defrag\ScheduledDefrag'. Then activate it."
        write-host "================================================================================"
        timeout /t 10 /NOBREAK
        CLS
    }
    elseif ($sched_task_status | select-string "Queued" -list | % {$_.Matches} | % {$_.Value})
    {
        CLS
        $queued = 1
        while ($queued -eq 1)  # Write working until task is finished.
        {
            write-host $sched_task_status
            write-host `n
            write-host "--------------------------------------------------------------------------------"
            write-host "                     The task is currently queued to run."
            write-host "            If it doesn't start after a while, check 'taskschd.exe'"
            write-host "        and then look here: '\Microsoft\Windows\Defrag\ScheduledDefrag'"
            write-host '            (Although, "normal" waiting times can be hours long.)'
            write-host "--------------------------------------------------------------------------------"
            write-host "Time spend waiting:" $minutes "minutes and" $seconds "seconds"
            write-host `n
            $sched_task_status = task_status
            timeout /t 10 /NOBREAK
            $seconds += 10
            if ($seconds -ge 60)
            {
                $minutes += 1
                $seconds -= 60  # IF might at some point leave 1 because some desync or whatever ...
                $queued = 0
            }
            CLS
            if (($sched_task_status | select-string "Queued" -list | % {$_.Matches} | % {$_.Value}) -ne "Queued")
            {
                write-host `n
                write-host "Task has reached end of queue ..."
                $queued = 0
            }
        }
    }
    else
    <# if (($sched_task_status | select-string "Already Running" | % { $_.Matches } | % { $_.Value }) -or `
    ($sched_task_status | select-string "Running" | % { $_.Matches } | % { $_.Value }) -or `
    ($sched_task_status | select-string "Ready" | % { $_.Matches } | % { $_.Value })) #>  # No! Bad dev! Bad! Go in your room!
    {
        $possible = 1
        if ($sched_task_status | select-string "Ready" -list | % {$_.Matches} | % {$_.Value})
        {
            $start_task = 1
            while ($start_task -eq 1)  # Try to start until started
            {
                write-host `n
                write-host "Trying to run Task, if it isn't already ..."
                schtasks /run /tn "\Microsoft\Windows\Defrag\ScheduledDefrag" > NUL
                $sched_task_status = task_status
                while (($sched_task_status | select-string "Ready" -list | % {$_.Matches} | % {$_.Value}) -ne "Ready")
                {
                    write-host `n
                    write-host "Working ..."
                    if ($sched_task_status | select-string "Ready" -list | % {$_.Matches} | % {$_.Value})
                    {
                        $start_task = 0
                        $possible = 0  # Set done
                        return  # Everything done! Flee now, fool!
                    }
                    $sched_task_status = task_status
                    timeout /t 10 /NOBREAK
                }
                timeout /t 10 /NOBREAK
            }
        }
    }
    write-host `n
    write-host "================================================================================"
    write-host "  ERROR: Task status not within bounds."
    write-host "Press WIN+R, then enter: 'taskschd.exe'. -> and look for the task yourself."
    write-host "Here it is: '\Microsoft\Windows\Defrag\ScheduledDefrag'. Then activate it."
    write-host "================================================================================"
    #write-host "            --------NO ACTION ERROR! Not enough pandemonium!--------"
}

write-host "All's finished! You may now close this window with the X, or press 'CTRL+C'."
write-host "I don't care. Keep it open, do whatever."
pause

