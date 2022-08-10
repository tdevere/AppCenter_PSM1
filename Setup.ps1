#Install Scripts
## Run this from the root repo directory (current working folder)
## May need to run as admin to get past permissions on %SystemRoot% path

$psModules = "$env:userprofile\Documents\WindowsPowerShell\Modules"
$currentDirectory = [System.Environment]::CurrentDirectory
$psm1List = Get-ChildItem -Path $currentDirectory -Filter *.psm1

foreach ($script in $psm1List)
{    
    $scriptName = [System.IO.Path]::GetFileNameWithoutExtension($script)
    $dirCheckPath = Join-Path -Path $psModules -ChildPath $scriptName 
    
    if ($false -eq (Test-Path $dirCheckPath))
    {
        Write-Host "Creating Directory $dirCheckPath"
        New-Item -ItemType Directory -Path $dirCheckPath
    }

    Write-Host "Coping $script.FullName to $dirCheckPath"
    $copyResult = Copy-Item -Path $script.FullName -Destination $dirCheckPath
    Write-Host "Result of Copy: $copyResult"
    Get-ChildItem -Path $dirCheckPath
}

