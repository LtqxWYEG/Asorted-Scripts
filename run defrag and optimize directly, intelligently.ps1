

write-host "================================================================================"
write-host "               Optimizes or defragments all drives. (Except USB)"
write-host "--------------------------------------------------------------------------------"
write-host "                                                                 By Distelzombie"
write-host `n
write-host '  [-] Immediately runs: "defrag.exe /c /a /h /o /u /v /$"'
write-host "      /c = AllVolumes"
write-host "      /a = Analyze"
write-host "      /h = NormalPriority"
write-host "      /o = Optimize"
write-host "      /u = PrintProgress"
write-host "      /v = Verbose"
write-host "      /$ = Tells defrag.exe that it is being called from the task scheduler."
write-host "      Respects results of previous runs via scheduler."
write-host "      I.e.: Avoids unnecessary execution of retrim if it has been done recently."
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

CLS
write-host `n
defrag.exe /c /a /h /o /u /v /$
write-host `n
write-host `n

pause