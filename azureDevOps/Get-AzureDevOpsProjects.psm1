function Get-AzureDevOpsProjects 
{
    <#
 .Synopsis
  Return list of projects in Azure DevOps

 .Description
  Return list of projects in Azure DevOps
  https://docs.microsoft.com/en-us/rest/api/azure/devops/core/Projects/List?view=azure-devops-rest-6.0&tabs=HTTP

 .Parameter AzureDevOpsPAT
  You can use a personal access token (PAT) as an alternate password to authenticate into Azure DevOps.
  https://docs.microsoft.com/en-us/azure/devops/organizations/accounts/use-personal-access-tokens-to-authenticate?view=azure-devops&tabs=Windows
 

 .Parameter AzureDevOpsOrganization
  Name of your Azure DevOps Organization. Log into https://dev.azure.com to find your organization name

  .Example 
  PS C:\> Get-AzureDevOpsProjects -AzureDevOpsPAT ***** -AzureDevOpsOrganization ******
  
        Requesting Projects from ****** via https://dev.azure.com/*****/_apis/projects?api-version=6.0

        id             : *****
        name           : AppCenter_Repros
        url            : https://dev.azure.com/******/_apis/projects/******
        state          : wellFormed
        revision       : 319
        visibility     : private
        lastUpdateTime : 2021-07-09T22:08:14.67Z

        id             : ******
        name           : FailedBuildGuide
        description    : This project wraps VS App Center Failed Build Docs and Scripts work within CSS.
        url            : https://dev.azure.com/******/_apis/projects/******
        state          : wellFormed
        revision       : 333
        visibility     : private
        lastUpdateTime : 2022-08-12T00:05:51.433Z

        id             : ******
        name           : DAS Mobile Sync
        description    : Welcome to the DAS Mobile V-Team.  With the re-org to our new DAS organization, we are trying to identify
                        areas where our teams may have some overlap in troubleshooting scenarios, skillset, tools, etc.  Our
                        principle TAs came up with the below categories for us to dive deeper into and you have been nominated to
                        represent your POD in the Mobile support workstream.  I know that some of you have already met with the
                        PTAs early in the year, so for you, consider this a re-launch to get this kicked off once more.
        url            : https://dev.azure.com/******/_apis/projects/******
        state          : wellFormed
        revision       : 331
        visibility     : organization
        lastUpdateTime : 2022-06-28T07:42:16.867Z

        id             : ******
        name           : IntercomTools
        url            : https://dev.azure.com/******/_apis/projects******
        state          : wellFormed
        revision       : 228
        visibility     : private
        lastUpdateTime : 2021-04-14T21:17:27.563Z
#>    
    param 
    (
        [ValidateNotNullOrEmpty()]
        [string]$AzureDevOpsPAT,
        [ValidateNotNullOrEmpty()]
        [string]$AzureDevOpsOrganization
    )

    $uri = "https://dev.azure.com/$AzureDevOpsOrganization/_apis/projects?api-version=6.0"

    Write-Host "Requesting Projects from $AzureDevOpsOrganization via $uri"

    $AzureDevOpsAuthenicationHeader = @{Authorization = 'Basic ' + [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(":$($AzureDevOpsPAT)")) }
    
    $results = Invoke-RestMethod -Uri $uri -Method Get -Headers $AzureDevOpsAuthenicationHeader -ContentType "application/json"
    
    return $results.value
    
}


Export-ModuleMember -Function Get-AzureDevOpsProjects