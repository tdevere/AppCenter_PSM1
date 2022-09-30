function Get-AppCenterExportConfiguration
{
  <#
 .Synopsis
  Retrieves list of App Center Apps that have Export enabled (Blob or Application Insights)

 .Description
  Retrieves list of App Center Apps that have Export enabled (Blob or Application Insights)

 .Parameter ApiUserToken
  User API tokens work across all apps and apps that you're associated with. https://docs.microsoft.com/en-us/appcenter/api-docs/#creating-an-app-center-user-api-token

 .Example
   # Retrieves list of App Center Apps that have Export enabled (Blob or Application Insights).
   Get-AppCenterExportConfiguration -ApiUserToken ***** YourApiToken -OrgName ***** -AppName *****

#>

    param ([string] $ApiUserToken,
    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]
    [string] $AppName,
    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]    
    [string]$OrgName)    

    $uri = 'https://api.appcenter.ms/v0.1/apps/' + $OrgName + '/' + $AppName + '/export_configurations'

    $results = curl.exe -X GET $Uri -H "Content-Type: application/json" -H "accept: application/json" -H "X-API-Token: $ApiUserToken" | ConvertFrom-Json  
    return $results
}

function Remove-AppCenterExportConfiguration
{
  <#
 .Synopsis
  Removes Export services on App (Blob or Application Insights). Warning: This deletes the resource.

 .Description
  Removes Export services on App (Blob or Application Insights). This deletes the resource. Use Diable-AppCenterExport if you wish to stop the service rather than remove it completely.

 .Parameter ApiUserToken
  User API tokens work across all apps and apps that you're associated with. https://docs.microsoft.com/en-us/appcenter/api-docs/#creating-an-app-center-user-api-token

 .Example
   # Removes Export services on App (Blob or Application Insights). Warning: This deletes the resource.
   Remove-AppCenterExportConfiguration -ApiUserToken **** -$OrgName "Org" -$AppName "App" -Export_Config_Id "ID"
 
#>
    param (
    [string] $ApiUserToken,
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

function Update-AppCenterBlobStorageExportConfiguration
{
  <#
 .Synopsis
  Updates BlobStorage Export Configuration. By default, enables crashes while errors, attachments are not enabled. 

 .Description
  Updates BlobStorage Export Configuration. By default, enables crashes while errors, attachments are not enabled.

 .Parameter ApiUserToken
  User API tokens work across all apps and apps that you're associated with. https://docs.microsoft.com/en-us/appcenter/api-docs/#creating-an-app-center-user-api-token

 .Example
   # Updates BlobStorage Export Configuration. By default, enables crashes, errors, attachments in export.
   Update-AppCenterBlobStorageExportConfiguration -ApiUserToken ***** YourApiToken -OrgName ***** -AppName *****

#>

    param 
    (
      [string] $ApiUserToken,
      [Parameter(Mandatory)]
      [ValidateNotNullOrEmpty()]    
      [string]$OrgName,
      [Parameter(Mandatory)]
      [ValidateNotNullOrEmpty()]
      [string] $AppName,
      [Parameter(Mandatory)]
      [ValidateNotNullOrEmpty()]    
      [string]$export_configuration_id,
      [bool]$crashes = $true, 
      [bool]$errors = $false,
      [bool]$attachments = $false,
      [bool]$no_logs = $false,
      [bool]$backfill = $true,
      [Parameter(Mandatory)]
      [ValidateNotNullOrEmpty()]  
      $resource_name,
      [Parameter(Mandatory)]
      [ValidateNotNullOrEmpty()]  
      $resource_group
    )    

    $status = @{1 = "crashes" ; 2 = "errors" ; 4 = "attachments" ; 8 = "no_logs" }
    $value = 0
    
    if ($crashes)
    {
      $value = $value+1
    }
    if ($errors)
    {
      $value = $value+2
    }
    if ($attachments)
    {
      $value = $value+4
    }
    if ($no_logs)
    {
      $value = $value+8
    }

    $list = $status.Keys | Where-Object { $_ -band $value } | ForEach-Object { $status.Get_Item($_) } | ConvertTo-Json
    $data = '{"type":"blob_storage_linked_subscription","export_entities":' + $list +',"resource_name":"' + $resource_name +'","resource_group":"' + $resource_group +'","backfill":true}'
    $data = $data -replace "`n","" -replace "`r","" -replace " ",""
    
    #BUG: resource_name was not checked properly at the API 
    #I was able to use incorrect value for resource_group and the call completes successfully and returned the correct value for resource_group

    $uri = 'https://api.appcenter.ms/v0.1/apps/' + $OrgName + '/' + $AppName + '/export_configurations/' + $export_configuration_id
    $results = curl.exe -X PATCH $Uri -H "Content-Type: application/json" -H "accept: application/json" -H "X-API-Token: $ApiUserToken" -d ($data | ConvertTo-Json) | ConvertFrom-Json  
    
    return $results
}

Export-ModuleMember -Function Update-AppCenterBlobStorageExportConfiguration
Export-ModuleMember -Function Remove-AppCenterExportConfiguration
Export-ModuleMember -Function Get-AppCenterExportConfiguration
