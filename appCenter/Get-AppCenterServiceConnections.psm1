<#
 .Synopsis
  Retrieves list of App Center Service Connections.

 .Description
  Retrieves list of App Center Service Connections.

 .Parameter ApiUserToken
  User API tokens work across all organizations and apps that you're associated with. https://docs.microsoft.com/en-us/appcenter/api-docs/#creating-an-app-center-user-api-token

 .Parameter storeName
  Valid store names: "apple", "googleplay"

 .Example
    PS C:\> Get-AppCenterServiceConnections -storeName "apple" -ApiUserToken $env:ApiUserToken
                                                                                                                            
    displayName    :                                                                                                        
    id             : ******                                                                   
    serviceType    : apple                                                                                                  
    data           : @{username=tdevere@microsoft.com; expires=2022-09-11 21:57:37 +0000}
    credentialType : credentials
    isValid        : True
    is2FA          : True



    PS C:\> Get-AppCenterServiceConnections -storeName "googleplay" -ApiUserToken $env:ApiUserToken

    displayName    : Google Play Service Connection
    id             : ******
    serviceType    : googleplay
    data           :
    credentialType : credentials
    isValid        : True
    is2FA          : False

#>


function Get-AppCenterServiceConnections
{
    param 
    (
        [Parameter(Mandatory)]
        [string] $storeName,
        [Parameter(Mandatory)]
        $ApiUserToken
    )

    $headers = @{    
        "X-API-Token" = $ApiUserToken
    }

    $results = Invoke-WebRequest -Method Get -Uri "https://api.appcenter.ms/v0.1/user/serviceConnections?serviceType=$storeName&credentialType=credentials" -Headers $headers -ContentType "application/json" | ConvertFrom-Json  

    return $results
}


Export-ModuleMember -Function Get-AppCenterServiceConnections
