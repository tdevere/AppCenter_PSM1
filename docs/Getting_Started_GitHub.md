# Getting Started with GitHub

You can install the [GitHub Module](/github/GitHub.psm1) or just copy the method found in the same file and move into your favorite Power Shell IDE. [More Details](/ReadMe.md#windows-setup)

You will also need to get a [token](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/creating-a-personal-access-token) for communicating with the GitHub API Services.

## Sample: List GitHub Repositories and Permissions
[List GitHub Repositories and Permissions](https://docs.github.com/en/rest/collaborators/collaborators#get-repository-permissions-for-a-user)

``` ps 
$github = Get-GithubUserRepositories -ApiUserToken $env:GitHubPat
$github | Select-Object -Property full_name, permissions | Sort-Object -Property full_name

full_name                                      permissions
---------                                      -----------
tdevere/AppCenter_PSM1                         @{admin=True; maintain=True; push=True; triage=True; pull=True}
tdevere/AppCenter_Unity                        @{admin=True; maintain=True; push=True; triage=True; pull=True}
tdevere/AppCenter_WinForm                      @{admin=True; maintain=True; push=True; triage=True; pull=True}
tdevere/AppCenter_WPF_Sample                   @{admin=True; maintain=True; push=True; triage=True; pull=True}
tdevere/AppCenterAzureFunctionProxy            @{admin=True; maintain=True; push=True; triage=True; pull=True}

```