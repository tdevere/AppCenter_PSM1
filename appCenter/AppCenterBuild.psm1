function Get-AppCenterRepoConfig
{
    <#
    .Synopsis
    Returns the repository build configuration status of the app.

    .Description
    Returns the repository build configuration status of the app. https://openapi.appcenter.ms/#/build/repositoryConfigurations_list

    .Parameter ApiUserToken
    User API tokens work across all apps and apps that you're associated with. https://docs.microsoft.com/en-us/appcenter/api-docs/#creating-an-app-center-user-api-token

    .Example
    Get-AppCenterRepoConfig -ApiUserToken ***** -owner_name **** -app_name ****
    #>

    param (
        [string] $ApiUserToken, 
        [string]$owner_name, 
        [string]$app_name
        )    

    $Uri = "https://api.appcenter.ms/v0.1/apps/$owner_name/$app_name/repo_config"

    $results = curl.exe -X GET $Uri -H "Content-Type: application/json" -H "accept: application/json" -H "X-API-Token: $ApiUserToken" | ConvertFrom-Json

    return $results
}

function Get-AppCenterRepoConfigByList
{
        
    <#
    .Synopsis
    Returns the repository build configuration status of the app.

    .Description
    Returns the repository build configuration status of the app. https://openapi.appcenter.ms/#/build/repositoryConfigurations_list

    .Parameter ApiUserToken
    User API tokens work across all apps and apps that you're associated with. https://docs.microsoft.com/en-us/appcenter/api-docs/#creating-an-app-center-user-api-token

    .Example
    # Retrieves list of App Center apps. Requires Environment variable 
    Get-AppCenterApps -ApiUserToken $env:ApiUserToken -Orgname YourOrgHere -AppName YourAppHere

    .Example
    # Pass a Json list of owner_name $app_name  Note: Get-AppCenterApps
    1. $apps = Get-AppCenterApps -ApiUserToken $env:ApiUserToken
    2. Get-AppCenterRepoConfigByList -ApiUserToken $env:ApiUserToken -ListOfOwnerApps ($apps | Select-Object -Property name, @{Name="owner_name"; expr={$_.owner.name}})
    
    owner_name      app_name   Uri                                                                          Results
    ----------      --------   ---                                                                          -------
    ProjectOne      proj1      https://api.appcenter.ms/v0.1/apps/Examples_/Examples_Proj1/repo_config      {@{type=github; state=active; repo_url=https://github.com/sample/proj1.git; id=...
    ProjectTwo      proj2      https://api.appcenter.ms/v0.1/apps/Examples_/Examples_Proj2/repo_config      {@{type=github; state=active; repo_url=https://github.com/sample/proj2.git; id=...

    #>
    param ([string] $ApiUserToken,     
    $ListOfOwnerApps)
    
    $Global:RepoList = New-Object 'Collections.Generic.List[psobject]' #Variable storing Orgs and Apps list

    if ($null -ne $ListOfOwnerApps)
    {
        foreach ($item in $ListOfOwnerApps)
        {
            $owner_name = $item.owner_name
            $app_name = $item.name

            if ($null -ne $owner_name -and $null -ne $name)
            {
                $Uri = "https://api.appcenter.ms/v0.1/apps/$($owner_name)/$($app_name)/repo_config"
                $outV
                if ([System.Uri]::TryCreate($Uri, [System.UriKind]::Absolute, [ref]$null))
                {
                    Write-Host "Go"
                    try
                    {
                        $results = curl.exe -X GET $Uri -H "Content-Type: application/json" -H "accept: application/json" -H "X-API-Token: $ApiUserToken" | ConvertFrom-Json

                        $obj = 
                        [PSCustomObject]@{
                            owner_name = $owner_name 
                            app_name = $app_name
                            Uri = $Uri
                            Results = $results
                        }

                        $Global:RepoList.Add($obj)

                    }
                    catch
                    {
                        $obj = 
                        [PSCustomObject]@{
                            owner_name = $owner_name 
                            app_name = $app_name
                            Uri = $Uri
                            Results = $Error[0]
                        }

                        $Global:RepoList.Add($obj)
                    }
                }
            }
        }
    }

    return $Global:RepoList
}

function Get-AppCenterServiceConnections
{
    <#
 .Synopsis
  Retrieves list of App Center Service Connections.

 .Description
  Retrieves list of App Center Service Connections.

 .Parameter ApiUserToken
  User API tokens work across all organizations and apps that you're associated with. https://docs.microsoft.com/en-us/appcenter/api-docs/#creating-an-app-center-user-api-token

 .Parameter storeName
  Valid store names: "apple", "googleplay"

 .Example
    PS C:\> Get-AppCenterServiceConnections -storeName "apple" -ApiUserToken $env:ApiUserToken
                                                                                                                            
    displayName    :                                                                                                        
    id             : ******                                                                   
    serviceType    : apple                                                                                                  
    data           : @{username=tdevere@microsoft.com; expires=2022-09-11 21:57:37 +0000}
    credentialType : credentials
    isValid        : True
    is2FA          : True



    PS C:\> Get-AppCenterServiceConnections -storeName "googleplay" -ApiUserToken $env:ApiUserToken

    displayName    : Google Play Service Connection
    id             : ******
    serviceType    : googleplay
    data           :
    credentialType : credentials
    isValid        : True
    is2FA          : False

#>
    param 
    (
        [Parameter(Mandatory)]
        [string] $storeName,
        [Parameter(Mandatory)]
        $ApiUserToken
    )

    $headers = @{    
        "X-API-Token" = $ApiUserToken
    }

    $results = Invoke-WebRequest -Method Get -Uri "https://api.appcenter.ms/v0.1/user/serviceConnections?serviceType=$storeName&credentialType=credentials" -Headers $headers -ContentType "application/json" | ConvertFrom-Json  

    return $results
}

Export-ModuleMember -Function Get-AppCenterRepoConfig
Export-ModuleMember -Function Get-AppCenterRepoConfigByList 
Export-ModuleMember -Function Get-AppCenterServiceConnections