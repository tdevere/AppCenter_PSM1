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

Export-ModuleMember -Function Get-AppCenterDistributionGroups
Export-ModuleMember -Function Get-AppCenterDistributionGroupsDetails
Export-ModuleMember -Function Get-AppCenterDistributionGroupReleases
Export-ModuleMember -Function Get-AppCenterRecentReleases
Export-ModuleMember -Function Get-AppCenterDistributionStores
Export-ModuleMember -Function Get-AppCenterDistributionStoresList