<#
 .Synopsis
  Removes Export services on App (Blob or Application Insights). Warning: This deletes the resource.

 .Description
  Removes Export services on App (Blob or Application Insights). This deletes the resource. Use Diable-AppCenterExport if you wish to stop the service rather than remove it completely.

 .Parameter ApiUserToken
  User API tokens work across all apps and apps that you're associated with. https://docs.microsoft.com/en-us/appcenter/api-docs/#creating-an-app-center-user-api-token

 .Example
   # Removes Export services on App (Blob or Application Insights). Warning: This deletes the resource.
   Remove-AppCenterExport -$OrgName "Org" -$AppName "App" -Export_Config_Id "ID"
 
#>

function Remove-AppCenterExport
{
    param (
    [string] $ApiUserToken = $env:ApiUserToken,
    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]
    [string] $AppName,
    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]    
    [string]$OrgName,
    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()] 
    $Export_Config_Id)

    #https://openapi.appcenter.ms/#/export/ExportConfigurations_Delete
    $uri = 'https://api.appcenter.ms/v0.1/apps/' + $OrgName + '/' + $AppName + '/export_configurations/' + $Export_Config_Id

    try 
    {
      $results = curl.exe -X DELETE $Uri -H "Content-Type: application/json" -H "accept: application/json" -H "X-API-Token: $ApiUserToken" | ConvertFrom-Json  
    }
    catch 
    {
      $results = "Remove-AppCenterExport failed for $OrgName/$AppName with Export Config Id = $Export_Config_Id"
    }
    

    return $results
}

Export-ModuleMember -Function Remove-AppCenterExport

