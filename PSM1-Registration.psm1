#Install Scripts
## Run this from the root repo directory (current working folder)
## May need to run as admin to get past permissions on %SystemRoot% path

<#
 .Synopsis
  Register or Unregister all PSM1 modules within a single directory. 

 .Description
  Register or Unregister all PSM1 modules within a single directory. Also show list of currently instaled PSM1 modules. 

 .Parameter userprofilePSModulesPath
  Default value is "$env:userprofile\Documents\WindowsPowerShell\Modules". If you override this, make sure the path is within the PS Module Path
 
  .Parameter userprofilePSModulesPath
  Default value is "[System.Environment]::CurrentDirectory". If you override this, make sure  the path within the root directory of the PSM1 modules.
 
  .Example 
   Unregister-ALLPSM1 -userprofilePSModulesPath "$env:userprofile\Documents\WindowsPowerShell\Modules" -PSM1Module_Directory [System.Environment]::CurrentDirectory

 .Example
   Register-AllPSM1 -userprofilePSModulesPath "$env:userprofile\Documents\WindowsPowerShell\Modules" -PSM1Module_Directory [System.Environment]::CurrentDirectory
 
 .Example
  # Select Organization Names only
  Get-AppCenterOrg | Select-Object -Property name
 
  .Example
  Show-AllPSM1 -userprofilePSModulesPath "$env:userprofile\Documents\WindowsPowerShell\Modules" -PSM1Module_Directory [System.Environment]::CurrentDirectory
#>


function Unregister-ALLPSM1
{
    #Clean up existing PSM1 modules
    param ([string] $ApiUserToken = $env:ApiUserToken,
    $userprofilePSModulesPath = "$env:userprofile\Documents\WindowsPowerShell\Modules", 
    [string]$PSM1Module_Directory = [System.Environment]::CurrentDirectory)


    if (Test-Path $userprofilePSModulesPath)
    {
        if (Test-Path $PSM1Module_Directory)
        {
            $psm1List = Get-ChildItem -Path $PSM1Module_Directory -Filter *.psm1

            if ($null -ne $psm1List)
            {
                foreach ($script in $psm1List)
                {    
                    $scriptName = [System.IO.Path]::GetFileNameWithoutExtension($script)
                    $dirCheckPath = Join-Path -Path $userprofilePSModulesPath -ChildPath $scriptName 
                    
                    if ($false -eq (Test-Path $dirCheckPath))
                    {
                        Write-Host "Creating Directory: $dirCheckPath"
                        New-Item -ItemType Directory -Path $dirCheckPath
                    }
                    else
                    {
                        
                        Write-Host "Directory Exists: $dirCheckPath"
                        Write-Host "Coping $script.FullName to $dirCheckPath"
                        $UnregisterResult = Remove-Item -Path $script.FullName
                        Write-Host "Unregister Complete: $UnregisterResult.FullName" 
                    }
                }
            }
            else
            {
                Write-Host "No PSM1 Modules Found in: $psm1List"
                Write-Host "Nothing to unregister"
            }
            
        }
        else
        {
            Write-Host "PSM1Module_Directory not found: $PSM1Module_Directory"
            Write-Host "Nothing to unregister"
        }
    }
    else 
    {
        Write-Host "userprofilePSModulesPath not found: $userprofilePSModulesPath"
        Write-Host "Nothing to unregister"
    }
}

function Register-AllPSM1
{
    param ([string] $ApiUserToken = $env:ApiUserToken,
    $userprofilePSModulesPath = "$env:userprofile\Documents\WindowsPowerShell\Modules",
    [string]$PSM1Module_Directory = [System.Environment]::CurrentDirectory)


    if (Test-Path $userprofilePSModulesPath)
    {
        if (Test-Path $PSM1Module_Directory)
        {
            $psm1List = Get-ChildItem -Path $currentDirectory -Filter *.psm1

            if ($null -ne $psm1List)
            {
                foreach ($script in $psm1List)
                {    
                    $scriptName = [System.IO.Path]::GetFileNameWithoutExtension($script)
                    $dirCheckPath = Join-Path -Path $psModules -ChildPath $scriptName 
                    
                    if ($false -eq (Test-Path $dirCheckPath))
                    {
                        Write-Host "Creating Directory: $dirCheckPath"
                        New-Item -ItemType Directory -Path $dirCheckPath
                    }
                    else
                    {
                        Write-Host "Directory Exists: $dirCheckPath"
                        Write-Host "Register $script.FullName to $dirCheckPath"
                        $RegisterResult = Copy-Item -Path $script.FullName -Destination $dirCheckPath
                        Write-Host "Register Complete: $RegisterResult.FullName" 
                    }
                }
            }
            else
            {
                Write-Host "No PSM1 Modules Found in: $psm1List"
            }
            
        }
        else
        {
            Write-Host "PSM1Module_Directory not found: $PSM1Module_Directory"
        }
    }
    else 
    {
        Write-Host "userprofilePSModulesPath not found: $userprofilePSModulesPath"
    }
}

function Show-AllPSM1
{
    param ([string] $ApiUserToken = $env:ApiUserToken,
    $userprofilePSModulesPath = "$env:userprofile\Documents\WindowsPowerShell\Modules", 
    [string]$PSM1Module_Directory = [System.Environment]::CurrentDirectory)

    if (Test-Path $userprofilePSModulesPath)
    {
        if (Test-Path $PSM1Module_Directory)
        {
            $psm1List = Get-ChildItem -Path $currentDirectory -Filter *.psm1
            $psm1List.FullName
        }
        else
        {
            Write-Host "PSM1Module_Directory not found: $PSM1Module_Directory"
        }
    }
    else 
    {
        Write-Host "userprofilePSModulesPath not found: $userprofilePSModulesPath"
    }
}

Export-ModuleMember -Function Show-AllPSM1
Export-ModuleMember -Function Register-AllPSM1
Export-ModuleMember -Function Unregister-ALLPSM1