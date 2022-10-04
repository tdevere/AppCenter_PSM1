function NameOfFunctionHere
{
    <#
    .Synopsis
    
    .Description
    
    .Parameter ApiUserToken
    
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