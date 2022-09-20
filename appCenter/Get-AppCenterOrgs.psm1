<#
 .Synopsis
  Retrieves list of App Center Organazations.

 .Description
  Retrieves list of App Center Organazations.

 .Parameter ApiUserToken
  User API tokens work across all organizations and apps that you're associated with. https://docs.microsoft.com/en-us/appcenter/api-docs/#creating-an-app-center-user-api-token

 .Example
   # Retrieves list of App Center Organazations. Requires Environment variable 
   Get-AppCenterOrgs 

 .Example
   # Retrieves list of App Center Organazations.
   Get-AppCenterOrgs -ApiUserToken
 
 .Example
  # Select Organization Names only
  Get-AppCenterOrgs | Select-Object -Property name
#>

function Get-AppCenterOrgs
{
    param([string] $ApiUserToken)

    $Uri = "https://api.appcenter.ms/v0.1/orgs"
    
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

Export-ModuleMember -Function Get-AppCenterOrgs