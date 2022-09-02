<#
 .Synopsis
  Returns the details of a single organization

 .Description
  Retrieves App Center Organazation. https://openapi.appcenter.ms/#/account/organizations_get

 .Parameter ApiUserToken
  User API tokens work across all organization and apps that you're associated with. https://docs.microsoft.com/en-us/appcenter/api-docs/#creating-an-app-center-user-api-token

 .Example
   # Retrieves App Center Organazation. Requires Environment variable 
   Get-AppCenterOrg 

 .Example
   # Retrieves App Center Organazation.
   Get-AppCenterOrg -OrgName InsertYourOrgNameHere
 
 .Example
  # Select Organization Names only
  Get-AppCenterOrg | Select-Object -Property name
#>

function Get-AppCenterOrg
{
    param([string] $ApiUserToken = $env:ApiUserToken,
    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]    
    [string]$OrgName)

    $Uri = "https://api.appcenter.ms/v0.1/orgs/$OrgName"
    
    $results = curl.exe -X GET $Uri -H "Content-Type: application/json" -H "accept: application/json" -H "X-API-Token: $ApiUserToken" | ConvertFrom-Json

    if ($results.Length -eq 0)
    {
        return "Failed to get results."
    }
    else 
    {
      return $results
    }
}

Export-ModuleMember -Function Get-AppCenterOrg