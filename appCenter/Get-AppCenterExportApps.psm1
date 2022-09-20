<#
 .Synopsis
  Retrieves list of App Center Apps that have Export enabled (Blob or Application Insights)

 .Description
  Retrieves list of App Center Apps that have Export enabled (Blob or Application Insights)

 .Parameter ApiUserToken
  User API tokens work across all apps and apps that you're associated with. https://docs.microsoft.com/en-us/appcenter/api-docs/#creating-an-app-center-user-api-token

 .Example
   # Retrieves list of App Center Apps that have Export enabled (Blob or Application Insights).
   Get-AppCenterExportApps 

 .Example
# Retrieves list of App Center Apps that have Export enabled (Blob or Application Insights).
   Get-AppCenterExportApps
 
 .Example
  # Build list of Apps by Org. $orgs can be obtained by storing the results from Get-AppCenterOrganizations
  Get-AppCenterExportApps
#>

$Global:OrgAppList = New-Object 'Collections.Generic.List[psobject]' #Variable storing Orgs and Apps list


function Get-AppCenterExportApps
{
    param ([string] $ApiUserToken,
    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]
    [string] $AppName,
    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]    
    [string]$OrgName)    

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
}

Export-ModuleMember -Function Get-AppCenterExportApps

