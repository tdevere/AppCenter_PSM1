
function Disable-AppCenterSymbol
{
  <#
 .Synopsis
  Marks a symbol by id (uuid) as ignored. https://openapi.appcenter.ms/#/crash/symbols_ignore

 .Description
  Marks a symbol by id (uuid) as ignored. https://openapi.appcenter.ms/#/crash/symbols_ignore

 .Parameter ApiUserToken
  User API tokens work across all apps and apps that you're associated with. https://docs.microsoft.com/en-us/appcenter/api-docs/#creating-an-app-center-user-api-token

 .Example
#1. Read symbol group data; F12 Developer tools in the browser to errorGroups will contain the top 500 
https://appcenter.ms/api/v0.1/apps/SampleOrg/SampleApps/diagnostics/symbol_groups?top=500
$jsonFull = Get-Content C:\data\symbol_groups.json | ConvertFrom-Json 

#2. Get list of missing symbols by app_ver
$missing = ($jsonFull.groups | Where-Object { $_.app_ver -eq "6.72.0" } | Select-Object -Property last_modified, symbol_group_id, missing_symbols | sort-Object -Property last_modified).missing_symbols

#3. Disable each missing symbol
$missing | ForEach-Object { Disable-AppCenterSymbol -ApiUserToken ******* -OrgName 'Examples' -AppName 'Android_Xamarin' -symbol_id  $_.symbol_id }
https://api.appcenter.ms/v0.1/apps/Examples/Android_Xamarin/symbols/*******/ignore
https://api.appcenter.ms/v0.1/apps/Examples/Android_Xamarin/symbols/*******/ignore
https://api.appcenter.ms/v0.1/apps/Examples/Android_Xamarin/symbols/*******/ignore
https://api.appcenter.ms/v0.1/apps/Examples/Android_Xamarin/symbols/*******/ignore
https://api.appcenter.ms/v0.1/apps/Examples/Android_Xamarin/symbols/*******/ignore
https://api.appcenter.ms/v0.1/apps/Examples/Android_Xamarin/symbols/*******/ignore
https://api.appcenter.ms/v0.1/apps/Examples/Android_Xamarin/symbols/*******/ignore
https://api.appcenter.ms/v0.1/apps/Examples/Android_Xamarin/symbols/*******/ignore


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
      $symbol_id
    ) 
    
    $uri = 'https://api.appcenter.ms/v0.1/apps/' + $OrgName + '/' + $AppName + '/symbols/' + $symbol_id + '/ignore'
    $results = curl.exe -X POST $Uri -H "Content-Type: application/json" -H "accept: application/json" -H "X-API-Token: $ApiUserToken" | ConvertFrom-Json  
    
    return $results
}

function Get-AppCenterMissingSymbolCrashGroup
{
  <#
 .Synopsis
  Gets missing symbol crash group by its id. https://openapi.appcenter.ms/#/crash/missingSymbolGroups_get

 .Description
  Gets missing symbol crash group by its id. https://openapi.appcenter.ms/#/crash/missingSymbolGroups_get

 .Parameter ApiUserToken
  User API tokens work across all apps and apps that you're associated with. https://docs.microsoft.com/en-us/appcenter/api-docs/#creating-an-app-center-user-api-token

 .Example
   

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
      $symbol_group_id
    ) 
    
    $uri = 'https://api.appcenter.ms/v0.1/apps/' + $OrgName + '/' + $AppName + '/diagnostics/symbol_groups/' + $symbol_group_id
    $results = curl.exe -X GET $Uri -H "Content-Type: application/json" -H "accept: application/json" -H "X-API-Token: $ApiUserToken" | ConvertFrom-Json  
    
    return $results
}

Export-ModuleMember -Function Disable-AppCenterSymbol
Export-ModuleMember -Function Get-AppCenterMissingSymbolCrashGroup