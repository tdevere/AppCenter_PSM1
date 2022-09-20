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

function Add-AppCenterCollaborator {
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
    

    $results = Invoke-WebRequest -Uri $uri -Method Post -Body  $finalJson -Headers  $headers -ContentType "application/json" | ConvertFrom-Json 
    
    return $results;

}

Export-ModuleMember -Function Add-AppCenterCollaborator