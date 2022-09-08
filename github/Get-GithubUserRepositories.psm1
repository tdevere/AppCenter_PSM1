<#
 .Synopsis
    Get list of user repositories

 .Description
   Get list of user repositories. https://docs.github.com/en/rest/repos/repos#list-repositories-for-a-user

 .Parameter ApiUserToken
  GitHub PAT. For information on creating a PAT see https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/creating-a-personal-access-token

 .Example
# List GitHub Repositories 

$github = Get-GithubUserRepositories -ApiUserToken $env:GitHubPat
$github | Select-Object -Property full_name, permissions | Sort-Object -Property full_name

full_name                                      permissions
---------                                      -----------
tdevere/AppCenter_PSM1                         @{admin=True; maintain=True; push=True; triage=True; pull=True}
tdevere/AppCenter_Unity                        @{admin=True; maintain=True; push=True; triage=True; pull=True}
tdevere/AppCenter_WinForm                      @{admin=True; maintain=True; push=True; triage=True; pull=True}
tdevere/AppCenter_WPF_Sample                   @{admin=True; maintain=True; push=True; triage=True; pull=True}
tdevere/AppCenterAzureFunctionProxy            @{admin=True; maintain=True; push=True; triage=True; pull=True}

#>

function Get-GithubUserRepositories
{
    #https://docs.github.com/en/rest/collaborators/collaborators#get-repository-permissions-for-a-user
    param (
    
    [Parameter(Mandatory)]
    [string] $ApiUserToken,
    [Parameter(Mandatory)]    
    [string]$username)
    
    #/repos/{owner}/{repo}/collaborators/{username}/permission
    $Uri = "https://api.github.com/user/repos"

    $results = curl.exe -X GET $Uri -H "Content-Type: application/json" -H "Accept: application/vnd.github+json" -H "Authorization: Bearer $ApiUserToken" | ConvertFrom-Json

    return $results
}

#endregion 

Export-ModuleMember -Function Get-GithubUserRepositories