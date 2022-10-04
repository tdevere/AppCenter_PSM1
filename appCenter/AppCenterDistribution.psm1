function Get-AppCenterDistributionGroups
{
  <#
 .Synopsis
 
 Returns a list of distribution groups in the Org or App specified.

 .Description
 Returns a list of distribution groups in the Org or App  specified. https://openapi.appcenter.ms/#/account/distributionGroups_list

 .Parameter ApiUserToken
 User API tokens work across all apps and apps that you're associated with. https://docs.microsoft.com/en-us/appcenter/api-docs/#creating-an-app-center-user-api-token

.Parameter AppName
 If AppName is not present, will use Orgname

 .Example
Get-AppCenterDistributionGroups -ApiUserToken ***** -OrgName "*****" -AppName "*****"

    id           : 00000000-0000-0000-0000-000000000000
    name         : Collaborators
    origin       : appcenter
    display_name : Collaborators
    is_public    : False

    #>

    param ([string] $ApiUserToken,
    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]    
    [string]$OrgName,
    [string]$AppName = $null)    

    if ($null -eq $AppName)
    {
        $Uri = "https://api.appcenter.ms/v0.1/orgs/$OrgName/distribution_groups"
    }
    else 
    {
        $Uri = "https://api.appcenter.ms/v0.1/apps/$OrgName/$AppName/distribution_groups"
    }

    $results = curl.exe -X GET $Uri -H "Content-Type: application/json" -H "accept: application/json" -H "X-API-Token: $ApiUserToken" | ConvertFrom-Json

    return $results
}

function Get-AppCenterDistributionGroupsDetails
{
  <#
 .Synopsis
 
 Returns a list of distribution groups in the org specified.

 .Description
 GReturns a list of distribution groups in the org specified. https://openapi.appcenter.ms/#/account/distributionGroups_detailsForOrg

 .Parameter ApiUserToken
 User API tokens work across all apps and apps that you're associated with. https://docs.microsoft.com/en-us/appcenter/api-docs/#creating-an-app-center-user-api-token

 .Example
 # Retrieves list of App Center apps. Requires Environment variable 
 
    Get-AppCenterDistributionGroupsDetails -ApiUserToken ***** -OrgName "*****"

    id                : c6648bf1-7cac-498b-b376-75b8d267f6d1
    name              : Microsoft_Internal
    origin            : appcenter
    display_name      : Microsoft_Internal
    is_public         : False
    total_apps_count  : 1
    total_users_count : 1
    apps              : {@{id=*****; app_secret=*****; description=; display_name=*****; name=*****; os=Android;
                        platform=Xamarin; origin=appcenter; icon_url=*****; created_at=2021-04-08T21:44:52.000Z; updated_at=2021-05-19T19:52:18.000Z; release_type=}}

#>

    param (
        [string] $ApiUserToken,
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]    
        [string]$OrgName,
        [int]$apps_limits = 0 #not used at the moment
        )    

    $Uri = "https://api.appcenter.ms/v0.1/orgs/$OrgName/distribution_groups_details"

    $results = curl.exe -X GET $Uri -H "Content-Type: application/json" -H "accept: application/json" -H "X-API-Token: $ApiUserToken" | ConvertFrom-Json

    return $results
}

function Get-AppCenterRecentReleases
{
  <#
 .Synopsis 
 Return basic information about distributed releases in a given distribution group.

 .Description
 Return basic information about distributed releases in a given distribution group. https://openapi.appcenter.ms/#/distribute/releases_listByDistributionGroup

 .Parameter ApiUserToken
 User API tokens work across all apps and apps that you're associated with. https://docs.microsoft.com/en-us/appcenter/api-docs/#creating-an-app-center-user-api-token

 .Example 
 Get-AppCenterRecentReleases -ApiUserToken ***** -OrgName ***** -AppName *****
  
    id                : 2037
    short_version     : 101.00
    version           : 1664304346
    origin            : appcenter
    uploaded_at       : 2022-09-27T18:52:09.790Z
    mandatory_update  : False
    enabled           : True
    is_external_build : False

 #>

    param ([string] $ApiUserToken,
    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]    
    [string]$OrgName,
    [ValidateNotNullOrEmpty()]    
    [string]$AppName)    


    $Uri = "https://api.appcenter.ms/v0.1/apps/$OrgName/$AppName/recent_releases"

    $results = curl.exe -X GET $Uri -H "Content-Type: application/json" -H "accept: application/json" -H "X-API-Token: $ApiUserToken" | ConvertFrom-Json

    return $results
}

function Get-AppCenterDistributionStores
{
  <#
 .Synopsis
 Get all the store details from Storage store table for a particular application.

 .Description
 Get all the store details from Storage store table for a particular application. https://openapi.appcenter.ms/#/distribute/stores_list

 .Parameter ApiUserToken
 User API tokens work across all apps and apps that you're associated with. https://docs.microsoft.com/en-us/appcenter/api-docs/#creating-an-app-center-user-api-token

 .Example
 # Retrieves list of App Center apps. Requires Environment variable 
 Get-AppCenterApp -ApiUserToken YourApiToken -Orgname YourOrgHere -AppName YourAppHere
#>

    param ([string] $ApiUserToken,
    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]    
    [string]$OrgName,
    [ValidateNotNullOrEmpty()]    
    [string]$AppName)    

    $Uri = "https://api.appcenter.ms/v0.1/$OrgName/$AppName/distribution_stores"

    $results = curl.exe -X GET $Uri -H "Content-Type: application/json" -H "accept: application/json" -H "X-API-Token: $ApiUserToken" | ConvertFrom-Json

    return $results
}

function Get-AppCenterDistributionStoresList
{

  <#
 .Synopsis
 Enumerate a list of all to get all the store details from Storage store table for each.

 .Description
 Enumerate a list of all to get all the store details from Storage store table for each. https://openapi.appcenter.ms/#/distribute/stores_list

 .Parameter ApiUserToken
 User API tokens work across all apps and apps that you're associated with. https://docs.microsoft.com/en-us/appcenter/api-docs/#creating-an-app-center-user-api-token

 .Example
 # Retrieves list of App Center apps. Requires Environment variable 
 Get-AppCenterApp -ApiUserToken YourApiToken -OrgAppList OrgAppList
#>

    param ([string] $ApiUserToken,
    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]    
    $OrgAppList)    

    $Global:StoreList = New-Object 'Collections.Generic.List[psobject]' #Variable storing Orgs and Apps list

    foreach ($app in $AppList)
    {
      Write-Host "Retriving Store Information for $OrgAppList.owner.id/$OrgAppList.name"
      $store = Get-AppCenterDistributionStores -ApiUserToken $ApiUserToken -OrgName $OrgAppList.owner.id -$OrgAppList.name
      $Global:StoreList.Add($store)
    }

    return $Global:StoreList
}

function Get-AppCenterReleaseDetails 
{    
    <#
    .Synopsis
    Get a release with id release_id. If release_id is latest, return the latest release that was distributed to the current user (from all the distribution groups).

    .Description
    Get a release with id release_id. If release_id is latest, return the latest release that was distributed to the current user (from all the distribution groups). https://openapi.appcenter.ms/#/distribute/releases_getLatestByUser

    .Parameter ApiUserToken
    User API tokens work across all organizations and apps that you're associated with. https://docs.microsoft.com/en-us/appcenter/api-docs/#creating-an-app-center-user-api-token

    .Example
    Get-AppCenterReleaseDetails -ApiUserToken ******* -OrgName "*******" -AppName "*******" -Release_Id *******
    % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                    Dload  Upload   Total   Spent    Left  Speed
    100  1359  100  1359    0     0   3074      0 --:--:-- --:--:-- --:--:--  3074


    app_name              : *******
    app_display_name      : *******
    app_os                : Android
    app_icon_url          : https://appcenter-filemanagement-distrib1ede6f06e.azureedge.net/*******
    is_external_build     : False
    origin                : appcenter
    id                    : 2010
    version               : 1
    short_version         : 1.0
    size                  : 86893069
    min_os                : 5.0
    android_min_api_level : 21
    device_family         :
    bundle_identifier     : com.companyname.*******
    fingerprint           : *******
    uploaded_at           : 2022-05-27T20:29:34.686Z
    download_url          : https://appcenter-filemanagement-distrib4ede6f06e.azureedge.net/*******
    install_url           : https://appcenter-filemanagement-distrib4ede6f06e.azureedge.net/*******
                            7518f/aligned-com.companyname.*******
    enabled               : True
    fileExtension         : apk
    package_hashes        : {*******}
    destinations          : {}

    #>

         param (
        [string] $ApiUserToken,
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]    
        [string]$OrgName,
        [ValidateNotNullOrEmpty()]    
        [string]$AppName,
        [Parameter(Mandatory)]
        [string]$Release_Id
        )

    $Uri = 'https://api.appcenter.ms/v0.1/apps/' + $OrgName + '/' + $AppName + '/releases/' + $Release_Id   
    $results = curl.exe -X GET $Uri -H "Content-Type: application/json" -H "accept: application/json" -H "X-API-Token: $ApiUserToken" | ConvertFrom-Json   
    return $results
    
}

function Get-AppCenterReleases
{
    <#
    .Synopsis
    Return basic information about releases.

    .Description
    Return basic information about releases. Open API https://openapi.appcenter.ms/#/distribute/releases_list

    .Parameter ApiUserToken
    User API tokens work across all organizations and apps that you're associated with. https://docs.microsoft.com/en-us/appcenter/api-docs/#creating-an-app-center-user-api-token

    .Example
    Get-AppCenterReleases -ApiUserToken ******* -OrgName "*******" -AppName "*******"

    origin              : appcenter
    id                  : 67
    short_version       : 1.2
    version             : 1609891462
    uploaded_at         : 2021-01-22T00:31:31.281Z
    enabled             : False
    is_external_build   : False
    file_extension      : apk
    destinations        : {@{id=*******; name=TESTERS; destination_type=group}}
    distribution_groups : {@{id=*******; name=TESTERS}}

    #>
    param ([string] $ApiUserToken,
    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]    
    [string]$OrgName,
    [ValidateNotNullOrEmpty()]    
    [string]$AppName,
    $Published_Only = $false,
    $Scope="")   
    
    $Uri = 'https://api.appcenter.ms/v0.1/apps/' + $OrgName + '/' + $AppName + '/releases?published_only=' + $Published_Only + '&scope=' + $Scope
    $results = curl.exe -X GET $Uri -H "Content-Type: application/json" -H "accept: application/json" -H "X-API-Token: $ApiUserToken" | ConvertFrom-Json

    return $results

}

function Update-AppCenterReleaseEnabledStatus
{
    <#
    .Synopsis
    Disable details of a release.

    .Description
    Disable details of a release. Open API https://openapi.appcenter.ms/#/distribute/releases_updateDetails

    .Parameter ApiUserToken
    User API tokens work across all organizations and apps that you're associated with. https://docs.microsoft.com/en-us/appcenter/api-docs/#creating-an-app-center-user-api-token

    .Example
    Get-AppCenterReleaseDetails -ApiUserToken ***** -OrgName ***** -AppName ***** -Release_Id 2010

    app_name              : *****
    app_display_name      : *****
    app_os                : Android
    app_icon_url          : *****
    is_external_build     : False
    origin                : appcenter
    id                    : 2010
    version               : 1
    short_version         : 1.0
    size                  : 86893069
    min_os                : 5.0
    android_min_api_level : 21
    device_family         :
    bundle_identifier     : com.companyname.*****
    fingerprint           : *****
    uploaded_at           : 2022-05-27T20:29:34.686Z
    download_url          : https://appcenter-filemanagement-distrib4ede6f06e.azureedge.net/*****
    install_url           : https://appcenter-filemanagement-distrib4ede6f06e.azureedge.net/*****

    enabled               : True
    
    fileExtension         : apk
    package_hashes        : {bcef3fd816792a1f5e5db6ff97ee0a83f6b0c2653e09bd2cafa1a99fc4d96f67}
    destinations          : {}

    Update-AppCenterReleaseEnabledStatus -ApiUserToken ***** -OrgName ***** -AppName ***** -Release_Id 2010
    
    enabled               : False    

    .Example
    
    #datetime to pick from the last of releases to disable   
    [DateTime]$DisableReleasesOnAndBefore = (Get-Date).AddDays(-180) 

    Get a list of old releases
    $old_relesaes = $releases | ForEach-Object 
    {
        if ($_.enabled -eq $true) 
        {
            [DateTime]$uploadedDateTime = $_.uploaded_at
        
            if ((Get-Date $uploadedDateTime) -le (Get-Date $DisableReleasesOnAndBefore)) 
            {
                $_ #Or Try to Disable the relase? Disable-AppCenterRelease
            }
        }
    }

    #>
    param ([string] $ApiUserToken,
    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]    
    [string]$OrgName,
    [ValidateNotNullOrEmpty()]    
    [string]$AppName,
    [ValidateNotNullOrEmpty()] 
    $Release_Id,
    $Published_Only = $false,
    [ValidateNotNullOrEmpty()]
    [bool]$enable)   
    
    if($enable)
    {
    
        $disableReleaseJson = '"{\"enabled\": true}"' 

    }
    else
    {
        $disableReleaseJson = '"{\"enabled\": false}"' 

    }
    
    $Uri = 'https://api.appcenter.ms/v0.1/apps/' + $OrgName + '/' + $AppName + '/releases/' + $Release_Id   
    $results = curl.exe -X PUT $Uri -H "X-API-Token: $ApiUserToken" -H "Content-Type: application/json" -H "accept: application/json" -d $disableReleaseJson | ConvertFrom-Json 

    return $results

}

Export-ModuleMember -Function Get-AppCenterDistributionGroups
Export-ModuleMember -Function Get-AppCenterDistributionGroupsDetails
Export-ModuleMember -Function Get-AppCenterDistributionGroupReleases
Export-ModuleMember -Function Get-AppCenterRecentReleases
Export-ModuleMember -Function Get-AppCenterDistributionStores
Export-ModuleMember -Function Get-AppCenterDistributionStoresList
Export-ModuleMember -Function Get-AppCenterReleases 
Export-ModuleMember -Function Get-AppCenterReleaseDetails 
Export-ModuleMember -Function Update-AppCenterReleaseEnabledStatus