#
# --- Created by LtqxWYEG aka Distelzombie aka The One Who Made This Script (More like 'compiled')
# --- Create NTFS hard links for all files in folder X, whose names match string Z, to folder Y. ---


function hardLinksForAll{
        param(
            [Parameter(Mandatory=$true,ParameterSetName='source')][string]$sourcePath,
            [Parameter(Mandatory=$true,ParameterSetName='target')][string]$targetPath,
            [Parameter(Mandatory=$true,ParameterSetName='filter')][string]$filter
            )
     
    Get-ChildItem -path $sourcePath -name |
    Select-String $filter -List |
    Out-String -Stream |
    Where {
            $_.Trim().Length -gt 0
        } 
        |out-file buffer

    get-content buffer |
    foreach{
        New-Item -ItemType HardLink -path "$sourcePath" -Value "$targetPath"
        }
        fsutil hardlink list "$targetpath$(& get-content buffer -totalcount 1)"

    if (-not $?){
            write-host "FALSE: File has no hardlinks!"
        }else{
            write-host "TRUE: File has hardlinks!"; remove-item buffer
        }
    }
}

hardLinksForAll -source "" -target "" -filter ""


#Bad Documentation:

<# $sourcePath = "path"    # FULL path to source directors
$targetPath = "path"    # FULL path! For new-item hardlink. ---END WITH \---
$filter =      "string"  # Matching string. MAYBE wildcards are allowed. "*string.exe" did not work. Remove: *

Get-ChildItem -path $sourcePath -name | # Returns all file names (-name) in $sourcePath, listet, one item per row. 
Select-String $filter -List |            # Checks if any of the item match the string from $filter, list format output. The "|" operator allows direkt execution of another function, which has the return value from the last one available as "$_". The "|" might symbolize the pipe used for data stream continues...
    Out-String -Stream |                # Takes the data from pipe (|) and returns it as a string
    Where { $_.Trim().Length -gt 0 } |  # Removes empty rows
    out-file buffer                     # Writes result to file "buffer". No need for file extension.
    
get-content buffer |    # Reads content of file "buffer"
    foreach{            # For each item in list of file names, create
    New-Item -ItemType HardLink -path "$sourcePath" -Value "$targetPath"}  # Create a hard link in $targetPath

fsutil hardlink list "$targetpath           # Lists all hard links of file "$targetPath" with added string from..
    $(& get-content buffer -totalcount 1)"  # $(& xxx) executes a function inside a parameter, which's result will be added as a String to the parameter.
    
if (-not $?){   # Negates the value of "$?". "$?" Contains the execution status of the last operation. It contains TRUE if the last command succeeded and FALSE if it failed.
    write-host "FALSE: File has no hardlinks!"}else{write-host "TRUE: File has hardlinks!"; remove-item buffer}  # Write result of if check in console and removes "buffer" file. #>
