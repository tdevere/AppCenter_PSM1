function NameOfFunctionHere
{
    <#
    .Synopsis
    
    .Description
    
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
      $symbol_id
    ) 
    
    $uri = 'https://api.appcenter.ms/v0.1/apps/' + $OrgName + '/' + $AppName + '/symbols/' + $symbol_id + '/ignore'
    #$results = curl.exe -X POST $Uri -H "Content-Type: application/json" -H "accept: application/json" -H "X-API-Token: $ApiUserToken" | ConvertFrom-Json  
    $uri
    return $results
}

Export-ModuleMember -Function Publish-AppCenterApp