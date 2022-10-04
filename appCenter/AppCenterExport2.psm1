<<<<<<< HEAD
function Get-AppCenterExportConfiguration
=======
function Get-AppCenterExportApps
>>>>>>> export_configurations
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
<<<<<<< HEAD
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
=======
   Get-AppCenterExportApps -ApiUserToken YourApiToken 

#>

    param (
      [string] $ApiUserToken,
      [Parameter(Mandatory)]
>>>>>>> export_configurations
      [ValidateNotNullOrEmpty()]
      [string] $AppName,
      [Parameter(Mandatory)]
      [ValidateNotNullOrEmpty()]    
<<<<<<< HEAD
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
=======
      [string]$OrgName
    )    

    $uri = 'https://api.appcenter.ms/v0.1/apps/' + $OrgName + '/' + $AppName + '/export_configurations'

    $finalResult = New-Object -TypeName PSObject
    $finalResult | Add-Member -NotePropertyName Owner -NotePropertyValue $OrgName 
    $finalResult | Add-Member -NotePropertyName AppName -NotePropertyValue $AppName
    try 
    {
      $results = curl.exe -X GET $Uri -H "Content-Type: application/json" -H "accept: application/json" -H "X-API-Token: $ApiUserToken" | ConvertFrom-Json  
      $finalResult | Add-Member -NotePropertyName ExportDetails -NotePropertyValue ($results | Where-Object { [string]::IsNullOrEmpty($_.values.state) -eq $false })
    }
    catch
    {
      $finalResult | Add-Member -NotePropertyName "GetAppCenterExportAppsFailure" -NotePropertyValue $_      
    }    
    
    return $finalResult
>>>>>>> export_configurations
}

function Set-AppCenterExport
{

    #TODO: "Subscription ID is in invalid format."
    # Apparently you need to pass in a connection string - not set the type alone - not sure what the correct json should be here

  <#
 .Synopsis
  Retrieves list of App Center Apps that have Export enabled (Blob or Application Insights)
<<<<<<< HEAD
 .Description
  Retrieves list of App Center Apps that have Export enabled (Blob or Application Insights)
 .Parameter ApiUserToken
  User API tokens work across all apps and apps that you're associated with. https://docs.microsoft.com/en-us/appcenter/api-docs/#creating-an-app-center-user-api-token
 .Parameter type
 application_insights_linked_subscription or blob_storage_linked_subscription
 .Parameter export_entities
 crashes, errors, attachments, no_logs - Default value "crashes, errors, attachments"
 .Parameter resource_name
 Name of the Azure Resource to be set.
 .Parameter resource_group
 Name of the Azure Resource Group to be set.
 .Parameter backfill
 True or False. True by default. 
 .Example
   # Retrieves list of App Center Apps that have Export enabled (Blob or Application Insights).
   Set-AppCenterExport -ApiUserToken YourApiToken 
=======

 .Description
  Retrieves list of App Center Apps that have Export enabled (Blob or Application Insights)

 .Parameter ApiUserToken
  User API tokens work across all apps and apps that you're associated with. https://docs.microsoft.com/en-us/appcenter/api-docs/#creating-an-app-center-user-api-token

 .Parameter type
 application_insights_linked_subscription or blob_storage_linked_subscription

 .Parameter export_entities
 crashes, errors, attachments, no_logs - Default value "crashes, errors, attachments"

 .Parameter resource_name
 Name of the Azure Resource to be set.

 .Parameter resource_group
 Name of the Azure Resource Group to be set.

 .Parameter backfill
 True or False. True by default. 

 .Example
   # Retrieves list of App Center Apps that have Export enabled (Blob or Application Insights).
   Set-AppCenterExport -ApiUserToken YourApiToken 

>>>>>>> export_configurations
#>

    param (
      [string] $ApiUserToken,
      [Parameter(Mandatory)]
      [ValidateNotNullOrEmpty()]    
      [string]$OrgName,
      [Parameter(Mandatory)]
      [ValidateNotNullOrEmpty()]
      [string] $AppName,
      [Parameter(Mandatory)]
      [ValidateNotNullOrEmpty()]
      [string] $type = "application_insights_linked_subscription",
      [Parameter(Mandatory)]
      [ValidateNotNullOrEmpty()]    
      [string]$export_entities = "crashes, errors, attachments",
      [Parameter(Mandatory)]
      [ValidateNotNullOrEmpty()]    
      [string]$resource_name,
      [Parameter(Mandatory)]
      [ValidateNotNullOrEmpty()]    
      [string]$resource_group,
      [Parameter(Mandatory)]
      [ValidateNotNullOrEmpty()]    
      [bool]$backfill= $true
    )    

    $json = '{"type":"' + $type + '", "export_entities": ["' + $export_entities + '],"resource_name": "' + $resource_name + ',"resource_group": "' + $resource_group + ',"backfill": "' + $backfill + '"}'

    #$uri = 'https://api.appcenter.ms/v0.1/apps/' + $OrgName + '/' + $AppName + '/export_configurations'

    #$results = curl.exe -X POST $Uri -H "Content-Type: application/json" -H "accept: application/json" -H "X-API-Token: $ApiUserToken" | ConvertFrom-Json    
    
    return $finalResult
}

<<<<<<< HEAD
Export-ModuleMember -Function Update-AppCenterBlobStorageExportConfiguration
Export-ModuleMember -Function Remove-AppCenterExportConfiguration
Export-ModuleMember -Function Get-AppCenterExportConfiguration
Export-ModuleMember -Function Set-AppCenterExport
=======
Export-ModuleMember -Function Set-AppCenterExport
Export-ModuleMember -Function Get-AppCenterExportApps

>>>>>>> export_configurations
