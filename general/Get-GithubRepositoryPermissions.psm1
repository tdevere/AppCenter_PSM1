<#
 .Synopsis
    Check your access level for a specfic GitHub Repository

 .Description
    Check your access level for a specfic GitHub Repository https://docs.github.com/en/rest/collaborators/collaborators#get-repository-permissions-for-a-user

 .Parameter ApiUserToken
  GitHub PAT. For information on creating a PAT see https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/creating-a-personal-access-token

  .Parameter owner
  The owner of the repository. For example, within this URL "https://github.com/tdevere/AppCenterSupportDocs" "tdevere is the owner"

  .Parameter repo
  The repo name in GitHub. For example, within this URL "https://github.com/tdevere/AppCenterSupportDocs" "AppCenterSupportDocs is the name of the repo"

  .Parameter username
  The username by which you log into GitHub. Browse to https://github.com/settings/profile and your username is on the the right side of the screen to the side of your profile pic.

 .Example
   # Check GitHub Repository Permissions 
   Get-GithubRepositoryPermissions -ApiUserToken "YourGitHubPATGoesHere" -owner "tdevere" -repo "AppCenterSupportDocs" -username "tdevere"

    permission user
    ---------- ----
    admin      @{login=tdevere; id=XXXXXX; node_id=XXXXXXX; avatar_url=https://avatars.githubusercontent.com/u/XXXXXX?v=4; gravatar_id=; url=https://api.github.com/users/tdevere; html_url=https:/...

#>

function Get-GithubRepositoryPermissions
{
    #https://docs.github.com/en/rest/collaborators/collaborators#get-repository-permissions-for-a-user
    param (
    [string] $ApiUserToken = $env:GitHubPat,
    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]
    [string] $owner,
    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]    
    [string]$repo,
    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]    
    [string]$username)
    
    #/repos/{owner}/{repo}/collaborators/{username}/permission
    $Uri = "https://api.github.com/repos/$owner/$repo/collaborators/$username/permission"

    $results = curl.exe -X GET $Uri -H "Content-Type: application/json" -H "accept: application/json" -H "Authorization: Bearer $ApiUserToken" | ConvertFrom-Json

    return $results
}

#endregion 

Export-ModuleMember -Function Get-GithubRepositoryPermissions