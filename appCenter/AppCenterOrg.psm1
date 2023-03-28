function Get-AppCenterOrg
{
  <#
 .Synopsis
  Returns the details of a single organization

 .Description
  Retrieves App Center Organazation. https://openapi.appcenter.ms/#/account/organizations_get

 .Parameter ApiUserToken
  User API tokens work across all organization and apps that you're associated with. https://docs.microsoft.com/en-us/appcenter/api-docs/#creating-an-app-center-user-api-token

 .Example
   # Retrieves App Center Organazation. Requires Environment variable 
   Get-AppCenterOrg -ApiUserToken YourApiToken -OrgName InsertYourOrgNameHere
#>
    param([string] $ApiUserToken,
    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]    
    [string]$OrgName)

    $Uri = "https://api.appcenter.ms/v0.1/orgs/$OrgName"
    
    $results = curl.exe -X GET $Uri -H "Content-Type: application/json" -H "accept: application/json" -H "X-API-Token: $ApiUserToken" | ConvertFrom-Json

    if ($results.Length -eq 0)
    {
        return "Failed to get results."
    }
    else 
    {
      return $results
    }
}

function Get-AppCenterOrgs
{
  <#
 .Synopsis
  Retrieves list of App Center Organazations.

 .Description
  Retrieves list of App Center Organazations.

 .Parameter ApiUserToken
  User API tokens work across all organizations and apps that you're associated with. https://docs.microsoft.com/en-us/appcenter/api-docs/#creating-an-app-center-user-api-token

 .Example
   # Retrieves list of App Center Organazations. Requires Environment variable 
   Get-AppCenterOrgs -ApiUserToken YourApiToken 

#>

    param([string] $ApiUserToken)

    $Uri = "https://api.appcenter.ms/v0.1/orgs"
    
    $results = curl.exe -X GET $Uri -H "Content-Type: application/json" -H "accept: application/json" -H "X-API-Token: $ApiUserToken" | ConvertFrom-Json

    if ($results.Length -eq 0)
    {
        return "Failed to get results."
    }
    else 
    {
      return $results
    }
}
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

   Get-AppCenterOrgTesters -ApiUserToken $env:ApiUserToken -OrgName "YourOrgNameHere"

   display_name                email              name
   ------------                -----              ----
   Sample User               sample@user.com      sample@user.com
#>
    param ([string] $ApiUserToken,
    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]    
    [string]$OrgName)    

    $Uri = "https://api.appcenter.ms/v0.1/orgs/$OrgName/testers"

    $results = curl.exe -X GET $Uri -H "Content-Type: application/json" -H "accept: application/json" -H "X-API-Token: $ApiUserToken" | ConvertFrom-Json

    return $results
}

function Add-AppCenterCollaborator 
{
    <#
 .Synopsis
  Add new collborator to App Center organization.

 .Description
  Add new collborator to App Center organization.

 .Parameter ApiUserToken
  User API tokens work across all apps and apps that you're associated with. https://docs.microsoft.com/en-us/appcenter/api-docs/#creating-an-app-center-user-api-token  

 .Parameter newCollaboratorEmailAddress
  Email address of new collaborator

 .Parameter orgName
  Email address of new collaborator

 .Parameter AppCenterRole
  Valid options: { member, admin, collaborator }. Make sure to use lowercase lettering.

 .Example
   # Retrieves list of App Center apps. Requires Environment variable 
   Add-AppCenterCollaborator -$orgName "" -newCollaboratorEmailAddress "some@address.com"
 
#>
    Param
    (
        [string] $ApiUserToken,
        [string] $orgName, 
        [string] $AppCenterRole = "member", 
        [string] $newCollaboratorEmailAddress
    )
   
    #API: https://openapi.appcenter.ms/#/account/orgInvitations_create

    $uri = "https://appcenter.ms/api/v0.1/orgs/$orgName/invitations"

    $headers = @{    
        "X-API-Token" = $ApiUserToken
    }
    
    #region BUG on Windows using CURL.exe
    <#

    #Bug: CURL.EXE on Windows has trouble parsing " and I never found a way around it. But sticking with native Invoke-WebRequest the problem was avoided. 
    #To chase this down, I would get tracing from the platform and see what the difference is with how the " is encoded for post data
    #$jsonStr = '{ "user_email": "'+$newCollaboratorEmailAddress+'", "role": "$AppCenterRole" }'
    #$jsonStr = '{ \"user_email\": \"' + $newCollaboratorEmailAddress +'\", \"role\": \"' + $AppCenterRole + '\" }'
    $results = curl.exe -X POST $uri --data-raw ('{"user_email": "' + $newCollaboratorEmailAddress + '","role": "' + $AppCenterRole + '"}') -H "Content-Type: application/json" -H "accept: application/json" -H "X-API-Token: $ApiUserToken" | ConvertFrom-Json 
    #$results = curl.exe -X POST $uri --data-ascii ($json) -H "Content-Type: application/json" -H "accept: application/json" -H "X-API-Token: $ApiUserToken" | ConvertFrom-Json     
    #$results = curl.exe -X POST $uri -d $jsonStr  -H "Content-Type: application/json" -H "accept: application/json" -H "X-API-Token: $ApiUserToken" | ConvertFrom-Json 
    #>
    #endregion 

    $jsonStr = '{ "user_email": "' + $newCollaboratorEmailAddress + '", "role": "' + $AppCenterRole + '" }'
    $converedtJson = $jsonStr | ConvertFrom-Json
    $finalJson = ConvertTo-Json -InputObject $converedtJson
    

    $results = Invoke-WebRequest -Uri $uri -Method Post -Body $finalJson -Headers  $headers -ContentType "application/json" | ConvertFrom-Json 
    
    return $results;

}

Export-ModuleMember -Function Get-AppCenterOrg
Export-ModuleMember -Function Get-AppCenterOrgs
Export-ModuleMember -Function Get-AppCenterOrgTesters
Export-ModuleMember -Function Get-AppCenterOrgUsers
Export-ModuleMember -Function Add-AppCenterCollaborator