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

#>

function Get-AppCenterAppsByOrg
{
    param ([string] $ApiUserToken,
    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]    
    [string]$OrgName)    

    $Uri = "https://api.appcenter.ms/v0.1/orgs/$OrgName/apps"

    $results = curl.exe -X GET $Uri -H "Content-Type: application/json" -H "accept: application/json" -H "X-API-Token: $ApiUserToken" | ConvertFrom-Json

    if ($results.psobject.properties.match('statusCode').Count)
    {
        write-host "Error: $results"
    }
    
    return $results
}

function Get-AppCenterAppsByOrgList
{
    param ([string] $ApiUserToken = $env:ApiUserToken,
    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]    
    $OrgList)    

    $Global:OrgAppList = New-Object 'Collections.Generic.List[psobject]' #Variable storing Orgs and Apps list

    Write-Host "Org names: $OrgList"

    foreach ($org in $OrgList)
    {
      Write-Host "Getting Results for App Center Organization: $org.name"
      $apps = Get-AppCenterAppsByOrg -ApiUserToken $ApiUserToken -OrgName $org.name

      if (!$apps.psobject.properties.match('statusCode').Count)
      {
        $Global:OrgAppList.Add($apps) 
      }
      
    }

    return $Global:OrgAppList.ToArray()
}


Export-ModuleMember -Function Get-AppCenterAppsByOrg
Export-ModuleMember -Function Get-AppCenterAppsByOrgList

