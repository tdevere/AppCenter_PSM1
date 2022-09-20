
function Get-AppCenterDeviceConfigurations
{

    <#
    .Synopsis
    Returns a list of available devices for an application.

    .Description
    Returns a list of available devices for an application. https://openapi.appcenter.ms/#/test/test_getDeviceConfigurations

    .Parameter ApiUserToken
    User API tokens work across all apps and apps that you're associated with. https://docs.microsoft.com/en-us/appcenter/api-docs/#creating-an-app-center-user-api-token

    .Parameter OwnerName
    App Center Organization or User name

    .Parameter AppName
    App Center Application Name

    .Example
    Get-AppCenterDeviceConfigurations -ApiUserToken ***** -OwnerName ***** -AppName *****

    #>
    param (
    [string] $ApiUserToken,
    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]
    [string] $AppName,
    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]    
    [string]$OrgName)

    #https://openapi.appcenter.ms/#/test/test_getDeviceConfigurations
    $uri = 'https://api.appcenter.ms/v0.1/apps/' + $OrgName + '/' + $AppName + '/device_configurations/'

    try 
    {
      $results = curl.exe -X GET $Uri -H "Content-Type: application/json" -H "accept: application/json" -H "X-API-Token: $ApiUserToken" | ConvertFrom-Json  
    }
    catch 
    {
      $results = "Get-AppCenterDeviceConfigurations failed for $OrgName/$AppName"
    }    

    return $results
}

Export-ModuleMember -Function Get-AppCenterDeviceConfigurations

