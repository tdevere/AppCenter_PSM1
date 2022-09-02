<#
 .Synopsis
 Get all the store details from Storage store table for a particular application.

 .Description
 Get all the store details from Storage store table for a particular application. https://openapi.appcenter.ms/#/distribute/stores_list

 .Parameter ApiUserToken
 User API tokens work across all apps and apps that you're associated with. https://docs.microsoft.com/en-us/appcenter/api-docs/#creating-an-app-center-user-api-token

 .Example
 # Retrieves list of App Center apps. Requires Environment variable 
 Get-AppCenterApp -Orgname YourOrgHere -AppName YourAppHere
#>


function Get-AppCenterDistributionStores
{
    param ([string] $ApiUserToken = $env:ApiUserToken,
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
    param ([string] $ApiUserToken = $env:ApiUserToken,
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

Export-ModuleMember -Function Get-AppCenterDistributionStores
Export-ModuleMember -Function Get-AppCenterDistributionStoresList

