<#
 .Synopsis
  Retrieves list of App Center Apps for a specifc Organization.

 .Description
  Retrieves list of App Center Apps for a specifc Organization. https://openapi.appcenter.ms/#/account/apps_listForOrg

 .Parameter ApiUserToken
  User API tokens work across all apps and apps that you're associated with. https://docs.microsoft.com/en-us/appcenter/api-docs/#creating-an-app-center-user-api-token

 .Example
   # Retrieves list of App Center Apps for a specifc Organization. Requires Environment variable 
   Get-AppCenterAppsByOrg 

 .Example
   # Retrieves list of App Center Apps by Org.
   Get-AppCenterAppsByOrg -ApiUserToken InsertYourTokenHere -OrgName InsertYourOrgNameHere
 
 .Example
  # Build list of Apps by Org. $orgs can be obtained by storing the results from Get-AppCenterOrganizations
  $apps = $orgs | ForEach-Object { Get-AppCenterAppsByOrg -OrgName $_.name }
#>

$Global:OrgAppList = New-Object 'Collections.Generic.List[psobject]' #Variable storing Orgs and Apps list


function Get-AppCenterAppsByOrg
{
    param ([string] $ApiUserToken = $env:ApiUserToken,
    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]    
    [string]$OrgName)    

    $Uri = "https://api.appcenter.ms/v0.1/orgs/$OrgName/apps"

    $results = curl.exe -X GET $Uri -H "Content-Type: application/json" -H "accept: application/json" -H "X-API-Token: $ApiUserToken" | ConvertFrom-Json

    return $results
}

Export-ModuleMember -Function Get-AppCenterAppsByOrg

