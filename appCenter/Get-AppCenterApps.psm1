<#
 .Synopsis
    Return all apps which belongs to the given owner.

 .Description
    Return all apps which belongs to the given owner. https://openapi.appcenter.ms/#/account/apps_list

 .Parameter ApiUserToken
  User API tokens work across all apps and apps that you're associated with. https://docs.microsoft.com/en-us/appcenter/api-docs/#creating-an-app-center-user-api-token

 .Example
   # Retrieves list of App Center apps. Requires Environment variable 
   Get-AppCenterApps -Orgname YourOrgHere -AppName YourAppHere
#>

$Global:OrgAppList = New-Object 'Collections.Generic.List[psobject]' #Variable storing Orgs and Apps list


function Get-AppCenterApps
{
    param ([string] $ApiUserToken = $env:ApiUserToken)    

    $Uri = "https://api.appcenter.ms/v0.1/apps/"

    $results = curl.exe -X GET $Uri -H "Content-Type: application/json" -H "accept: application/json" -H "X-API-Token: $ApiUserToken" | ConvertFrom-Json

    return $results
}

Export-ModuleMember -Function Get-AppCenterApps

