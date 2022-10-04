function Set-AppCenterExport
{

    #TODO: "Subscription ID is in invalid format."
    # Apparently you need to pass in a connection string - not set the type alone - not sure what the correct json should be here

  <#
 .Synopsis
  Retrieves list of App Center Apps that have Export enabled (Blob or Application Insights)

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

Export-ModuleMember -Function Set-AppCenterExport

