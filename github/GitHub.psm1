function Get-GithubRepositoryPermissions
{
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

function Get-GithubUserRepositories
{
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

function Get-GithubBranches
{
   <#
 .Synopsis
    List of branches for repository

 .Description
   List of branches for repository. https://docs.github.com/en/rest/repos/repos#list-repositories-for-a-user

 .Parameter ApiUserToken
  GitHub PAT. For information on creating a PAT see https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/creating-a-personal-access-token

 .Example
   
   Get-GithubBranches -ApiUserToken $env:GH_TOKEN -OWNER "tdevere" -REPO "BranchClone"

   Calling https://api.github.com/repos/tdevere/BranchClone/branches?per_page=100&page=1
   Calling https://api.github.com/repos/tdevere/BranchClone/branches?per_page=100&page=2
   Calling https://api.github.com/repos/tdevere/BranchClone/branches?per_page=100&page=3
   Paging Complete
   
   name commit
   ---- ------
   0    @{sha=4e589cb46da19ab638bfb28aa1b5d57cbfb11df3; url=https://api.github.com/repos/tdevere/BranchClone/commits/4e589cb46da19ab638bfb28aa1b5d57cb... 
   1    @{sha=1c2ef55a05212482da60e877eaa6a2a73df1e384; url=https://api.github.com/repos/tdevere/BranchClone/commits/1c2ef55a05212482da60e877eaa6a2a73... 
   2    @{sha=df38e7eef2f1e328cce9ea702c43cb55f1b7763d; url=https://api.github.com/repos/tdevere/BranchClone/commits/df38e7eef2f1e328cce9ea702c43cb55f...
   3    @{sha=272d4e7965e6d4224665eb3ab7a42fc5b64ba42c; url=https://api.github.com/repos/tdevere/BranchClone/commits/272d4e7965e6d4224665eb3ab7a42fc5b... 
   4    @{sha=a1676bdc620777bd8d1a52fb78016fb0e1a12795; url=https://api.github.com/repos/tdevere/BranchClone/commits/a1676bdc620777bd8d1a52fb78016fb0e... 
   5    @{sha=b64d20414e4cd847a63196319a24cbc8ec52b37c; url=https://api.github.com/repos/tdevere/BranchClone/commits/b64d20414e4cd847a63196319a24cbc8e... 
   6    @{sha=25cec9687d1b78a52618daacff54dfcf185d3870; url=https://api.github.com/repos/tdevere/BranchClone/commits/25cec9687d1b78a52618daacff54dfcf1... 
   7    @{sha=4c5fccc7bd5feedbd73378e5c2d4e86acc3aabe6; url=https://api.github.com/repos/tdevere/BranchClone/commits/4c5fccc7bd5feedbd73378e5c2d4e86ac...
   8    @{sha=4a0fab1505b0f5b4022e5d5367038d0d0ca9512b; url=https://api.github.com/repos/tdevere/BranchClone/commits/4a0fab1505b0f5b4022e5d5367038d0d0... 
   9    @{sha=aca6190ac18b6e314348d30fcdd244c024da208b; url=https://api.github.com/repos/tdevere/BranchClone/commits/aca6190ac18b6e314348d30fcdd244c02... 
   10   @{sha=d74f5f537433932e62d2dd3f6fa3b19b74133168; url=https://api.github.com/repos/tdevere/BranchClone/commits/d74f5f537433932e62d2dd3f6fa3b19b7...

 .Example 

   Measure-command { $BranchResponses = Get-GithubBranches -ApiUserToken $env:GH_TOKEN -OWNER "tdevere" -REPO "BranchClone" }
   Calling https://api.github.com/repos/tdevere/BranchClone/branches?per_page=100&page=1
   Calling https://api.github.com/repos/tdevere/BranchClone/branches?per_page=100&page=2
   Calling https://api.github.com/repos/tdevere/BranchClone/branches?per_page=100&page=3
   Paging Complete


   Days              : 0
   Hours             : 0
   Minutes           : 0
   Seconds           : 2
   Milliseconds      : 364
   Ticks             : 23647481
   TotalDays         : 2.73697696759259E-05
   TotalHours        : 0.000656874472222222
   TotalMinutes      : 0.0394124683333333
   TotalSeconds      : 2.3647481
   TotalMilliseconds : 2364.7481
   #>
  
    param (    
    [Parameter(Mandatory)]
    [string] $ApiUserToken,
    [Parameter(Mandatory)]    
    [string]$OWNER,
    [Parameter(Mandatory)]    
    [string]$REPO,
    [int]$sleepTime = 500,
    [int]$PAGE = 0)

    $Responses = New-Object "System.Collections.Generic.List[PSObject]"
    $bDiscontinue = $false
    $headers = @{ 
      'Authorization' = "Authorization: Bearer " + $ApiUserToken
      'Content-Type'  = 'application/json'
      'Accept'  = 'application/vnd.github+json'
      'X-GitHub-Api-Version' = '2022-11-28'
    }

    do 
    {
      $PAGE++

      #Using Max Page settings
      $URL = "https://api.github.com/repos/" + $OWNER + "/" + $REPO + "/branches?per_page=100&page=" + $PAGE      
      Write-Host "Calling $URL"
      $response = Invoke-WebRequest -UseBasicParsing -Uri $URL -Headers $headers

      #hard coded limit (you may need top adjust if you have more than 1000 branches)
      #also, you may hit api rate limits if there are many branches, may add a sleep statement to reduce the calls
      if ($PAGE -le 10) 
      {
        try
        {        
          if ($response.StatusCode -eq 200)
          {
            $Responses.Add(($response.Content | ConvertFrom-Json))

            if (!$response.Headers.Item('Link').ToString().Contains('next'))
            {
              $bDiscontinue  = $true #No More Pages
              Write-Host "Paging Complete"
            }
          }
          else
          {
            $bDiscontinue  = $true
          }
  
        }
        catch
        {
          Write-Host "Stopping" -ForegroundColor Red
          $bDiscontinue = $true
        }
      }
      else
      {
        $bDiscontinue = $true
      }

      [System.Threading.Thread]::Sleep($SleepTime)
    }
    Until($bDiscontinue)

    #$Responses | ForEach-Object { Write-Host $_ }

    return $Responses

}
Export-ModuleMember -Function Get-GithubBranches
Export-ModuleMember -Function Get-GithubUserRepositories
Export-ModuleMember -Function Get-GithubRepositoryPermissions