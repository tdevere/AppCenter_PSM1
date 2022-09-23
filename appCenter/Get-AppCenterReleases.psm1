function Get-AppCenterReleaseDetails 
{    
    <#
    .Synopsis
    Get a release with id release_id. If release_id is latest, return the latest release that was distributed to the current user (from all the distribution groups).

    .Description
    Get a release with id release_id. If release_id is latest, return the latest release that was distributed to the current user (from all the distribution groups). https://openapi.appcenter.ms/#/distribute/releases_getLatestByUser

    .Parameter ApiUserToken
    User API tokens work across all organizations and apps that you're associated with. https://docs.microsoft.com/en-us/appcenter/api-docs/#creating-an-app-center-user-api-token

    .Example
    Get-AppCenterReleaseDetails -ApiUserToken ******* -OrgName "*******" -AppName "*******" -Release_Id *******
    % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                    Dload  Upload   Total   Spent    Left  Speed
    100  1359  100  1359    0     0   3074      0 --:--:-- --:--:-- --:--:--  3074


    app_name              : *******
    app_display_name      : *******
    app_os                : Android
    app_icon_url          : https://appcenter-filemanagement-distrib1ede6f06e.azureedge.net/*******
    is_external_build     : False
    origin                : appcenter
    id                    : 2010
    version               : 1
    short_version         : 1.0
    size                  : 86893069
    min_os                : 5.0
    android_min_api_level : 21
    device_family         :
    bundle_identifier     : com.companyname.*******
    fingerprint           : *******
    uploaded_at           : 2022-05-27T20:29:34.686Z
    download_url          : https://appcenter-filemanagement-distrib4ede6f06e.azureedge.net/*******
    install_url           : https://appcenter-filemanagement-distrib4ede6f06e.azureedge.net/*******
                            7518f/aligned-com.companyname.*******
    enabled               : True
    fileExtension         : apk
    package_hashes        : {*******}
    destinations          : {}

    #>

         param (
        [string] $ApiUserToken,
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]    
        [string]$OrgName,
        [ValidateNotNullOrEmpty()]    
        [string]$AppName,
        [Parameter(Mandatory)]
        [string]$Release_Id
        )

    $Uri = 'https://api.appcenter.ms/v0.1/apps/' + $OrgName + '/' + $AppName + '/releases/' + $Release_Id   
    $results = curl.exe -X GET $Uri -H "Content-Type: application/json" -H "accept: application/json" -H "X-API-Token: $ApiUserToken" | ConvertFrom-Json   
    return $results
    
}

function Get-AppCenterReleases
{
    <#
    .Synopsis
    Return basic information about releases.

    .Description
    Return basic information about releases. Open API https://openapi.appcenter.ms/#/distribute/releases_list

    .Parameter ApiUserToken
    User API tokens work across all organizations and apps that you're associated with. https://docs.microsoft.com/en-us/appcenter/api-docs/#creating-an-app-center-user-api-token

    .Example
    Get-AppCenterReleases -ApiUserToken ******* -OrgName "*******" -AppName "*******"

    origin              : appcenter
    id                  : 67
    short_version       : 1.2
    version             : 1609891462
    uploaded_at         : 2021-01-22T00:31:31.281Z
    enabled             : False
    is_external_build   : False
    file_extension      : apk
    destinations        : {@{id=*******; name=TESTERS; destination_type=group}}
    distribution_groups : {@{id=*******; name=TESTERS}}

    #>
    param ([string] $ApiUserToken,
    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]    
    [string]$OrgName,
    [ValidateNotNullOrEmpty()]    
    [string]$AppName,
    $Published_Only = $false,
    $Scope="")   
    
    $Uri = 'https://api.appcenter.ms/v0.1/apps/' + $OrgName + '/' + $AppName + '/releases?published_only=' + $Published_Only + '&scope=' + $Scope
    $results = curl.exe -X GET $Uri -H "Content-Type: application/json" -H "accept: application/json" -H "X-API-Token: $ApiUserToken" | ConvertFrom-Json

    return $results

}


Export-ModuleMember -Function Get-AppCenterReleases 
Export-ModuleMember -Function Get-AppCenterReleaseDetails 