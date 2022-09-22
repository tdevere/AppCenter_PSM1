function Get-AppCenterOrgUsers
{
   <#
 .Synopsis
    Returns a list of users that belong to an organization.

 .Description
    Returns a list of users that belong to an organization. https://openapi.appcenter.ms/#/account/users_listForOrg

 .Parameter ApiUserToken
  User API tokens work across all apps and apps that you're associated with. https://docs.microsoft.com/en-us/appcenter/api-docs/#creating-an-app-center-user-api-token

 .Example

   Get-AppCenterOrgUsers -ApiUserToken $env:ApiUserToken -OrgName "YourOrgNameHere"

   email        : sample@user.com
   name         : sample@user.com
   display_name : Sample User
   joined_at    : 2022-04-22T23:55:14.918Z
   role         : admin
#>
    param ([string] $ApiUserToken,
    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]    
    [string]$OrgName)    

    $Uri = "https://api.appcenter.ms/v0.1/orgs/$OrgName/users"

    $results = curl.exe -X GET $Uri -H "Content-Type: application/json" -H "accept: application/json" -H "X-API-Token: $ApiUserToken" | ConvertFrom-Json

    return $results
}

function Get-AppCenterOrgTesters
{
   <#
 .Synopsis
    Returns a list of testers that belong to an organization.

 .Description
    Returns a list of testers that belong to an organization. https://openapi.appcenter.ms/#/account/distributionGroups_listAllTestersForOrg

 .Parameter ApiUserToken
  User API tokens work across all apps and apps that you're associated with. https://docs.microsoft.com/en-us/appcenter/api-docs/#creating-an-app-center-user-api-token

 .Example

   Get-AppCenterOrgUsers -ApiUserToken $env:ApiUserToken -OrgName "YourOrgNameHere"

   email        : sample@user.com
   name         : sample@user.com
   display_name : Sample User
   joined_at    : 2022-04-22T23:55:14.918Z
   role         : admin
#>
    param ([string] $ApiUserToken,
    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]    
    [string]$OrgName)    

    $Uri = "https://api.appcenter.ms/v0.1/orgs/$OrgName/testers"

    $results = curl.exe -X GET $Uri -H "Content-Type: application/json" -H "accept: application/json" -H "X-API-Token: $ApiUserToken" | ConvertFrom-Json

    return $results
}

Export-ModuleMember -Function Get-AppCenterOrgTesters
Export-ModuleMember -Function Get-AppCenterOrgUsers
