#Install Scripts
## Run this from the root repo directory (current working folder)
## Run as admin

$psModules = "$env:SystemRoot\System32\WindowsPowerShell\v1.0\Modules"
$currentDirectory = [System.Environment]::CurrentDirectory
$psm1List = Get-ChildItem -Path $currentDirectory -Filter *.psm1

foreach ($script in $psm1List)
{    
    $scriptName = [System.IO.Path]::GetFileNameWithoutExtension($script)
    $dirCheckPath = Join-Path -Path $psModules -ChildPath $scriptName 
    
    if ($false -eq (Test-Path $dirCheckPath))
    {
        New-Item -ItemType Directory -Path $dirCheckPath
    }

    Copy-Item -Path $script -Destination $dirCheckPath
    Get-ChildItem -Path $dirCheckPath
}

