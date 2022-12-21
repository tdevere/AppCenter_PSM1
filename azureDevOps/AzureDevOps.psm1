function Get-AzureDevOpsSubscriptions 
{
    <#
        .Synopsis
        Get a list of subscriptions.

        .Description
        Get a list of subscriptions. #https://learn.microsoft.com/en-us/rest/api/azure/devops/hooks/subscriptions/list?view=azure-devops-rest-7.1&tabs=HTTP

        .Parameter AzureDevOpsPAT
        https://docs.microsoft.com/en-us/azure/devops/organizations/accounts/use-personal-access-tokens-to-authenticate?view=azure-devops&tabs=Windows
        You can use a personal access token (PAT) as an alternate password to authenticate into Azure DevOps.

        .Parameter AzureDevOpsOrganization

        .Example 

        Measure-Command { $AzureSubscriptions = Get-AzureDevOpsSubscriptions -AzureDevOpsPAT **** -AzureDevOpsOrganization **** }
        Preparing Call Get-AzureDevOpsSubscriptions https://dev.azure.com/YOURORGHERE/_apis/hooks/subscriptions?api-version=7.1-preview.1

        Days              : 0
        Hours             : 0
        Minutes           : 0
        Seconds           : 1
        Milliseconds      : 101
        Ticks             : 11011087
        TotalDays         : 1.27443136574074E-05
        TotalHours        : 0.000305863527777778
        TotalMinutes      : 0.0183518116666667
        TotalSeconds      : 1.1011087
        TotalMilliseconds : 1101.1087


    #>
    
    param 
    (
        [ValidateNotNullOrEmpty()]
        [string]$AzureDevOpsPAT,
        [ValidateNotNullOrEmpty()]
        [string]$AzureDevOpsOrganization
    )

    $uri = "https://dev.azure.com/$AzureDevOpsOrganization/_apis/hooks/subscriptions?api-version=7.1-preview.1"

    Write-Host "Preparing Call Get-AureDevOpsSubscriptions $uri"

    $AzureDevOpsAuthenicationHeader = @{Authorization = 'Basic ' + [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(":$($AzureDevOpsPAT)")) }
    
    $results = Invoke-RestMethod -Uri $uri -Method Get -Headers $AzureDevOpsAuthenicationHeader -ContentType "application/json"

    return $results
    
}

function Set-AzureDevOpsWebhook 
{
    <#
 .Synopsis
  Created Azure Webhook

 .Description
  Script to test creation of Azure Webhook

 .Parameter AzureDevOpsPAT
  https://docs.microsoft.com/en-us/azure/devops/organizations/accounts/use-personal-access-tokens-to-authenticate?view=azure-devops&tabs=Windows
  You can use a personal access token (PAT) as an alternate password to authenticate into Azure DevOps.

 .Parameter AzureSubscriptionId
  https://docs.microsoft.com/en-us/azure/azure-portal/get-subscription-tenant-id
  Each subscription has an ID associated with it, as does the tenant to which a subscription belongs. As you perform different tasks, you may need the ID for a subscription or tenant. You can find these values in the Azure portal.
 
  .Parameter AzureDevOpsProjectId
    Call https://dev.azure.com/<orgname>/_apis/projects to retrieve a list of project Id's

  .Parameter AzureDevOpsOrganization
#>
    #https://docs.microsoft.com/en-us/rest/api/azure/devops/hooks/Subscriptions/Create?view=azure-devops-rest-6.0&tabs=HTTP
    param 
    (
        [ValidateNotNullOrEmpty()]
        [string]$AzureDevOpsPAT,
        [ValidateNotNullOrEmpty()]
        [string]$AzureDevOpsOrganization,
        [string]$uri,
        [ValidateNotNullOrEmpty()]
        [string]$AzureDevOpsWebHookReceiverUri,
        [ValidateNotNullOrEmpty()]
        [string]$AzureDevOpsProjectId
    )

    $uri = "https://dev.azure.com/$AzureDevOpsOrganization/_apis/hooks/subscriptions?api-version=6.0"

    Write-Host "Creating Webhook for $uri"

    $AzureDevOpsAuthenicationHeader = @{Authorization = 'Basic ' + [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(":$($AzureDevOpsPAT)")) }

    $customHeader = [datetime]::now.Ticks #Ensure you can get the creation time

$WebHookConfiguration = @"
{
    "publisherId": "tfs",    
    "consumerActionId": "httpRequest",
    "consumerId": "webHooks",
    "consumerInputs": {
        "url": "$AzureDevOpsWebHookReceiverUri",
        "httpHeaders": "Key:$customHeader"
    },
    "eventType": "build.complete",
    
    "publisherInputs": {
        "definitionName": "",
        "buildStatus": "",
        "projectId": "$AzureDevOpsProjectId"     
    }
}
"@

    Write-Host "Project Configuration"
    Write-Host $WebHookConfiguration 

    $results = Invoke-RestMethod -Uri $uri -Method Post -Headers $AzureDevOpsAuthenicationHeader -Body $WebHookConfiguration -ContentType "application/json"
    return $results
    
}
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

function Get-AzureDevOpsSourceProviders
{   
    param 
    (
        [ValidateNotNullOrEmpty()]
        [string]$AzureDevOpsPAT,        
        [ValidateNotNullOrEmpty()]
        [string]$AzureDevOpsProject,
        [ValidateNotNullOrEmpty()]
        [string]$AzureDevOpsOrganization
    )

    $uri = "https://dev.azure.com/$AzureDevOpsOrganization/$AzureDevOpsProject/_apis/sourceproviders?api-version=6.0-preview.1"

    Write-Host "Requesting Source Providers from $AzureDevOpsOrganization/$AzureDevOpsProject via $uri"

    $AzureDevOpsAuthenicationHeader = @{Authorization = 'Basic ' + [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(":$($AzureDevOpsPAT)")) }
    
    $results = Invoke-RestMethod -Uri $uri -Method Get -Headers $AzureDevOpsAuthenicationHeader -ContentType "application/json"
    
    return $results.value
    
}

function Get-AzureDevOpsListBranches
{   
    param 
    (
        [ValidateNotNullOrEmpty()]
        [string]$AzureDevOpsPAT,        
        [ValidateNotNullOrEmpty()]
        [string]$AzureDevOpsProject,
        [ValidateNotNullOrEmpty()]
        [string]$AzureDevOpsOrganization,        
        [ValidateNotNullOrEmpty()]
        [string]$ProviderName="Git"
    )

    #GET    GET https://dev.azure.com/{organization}/{project}/_apis/sourceProviders/{providerName}/branches?api-version=6.0-preview.1
    $uri = "https://dev.azure.com/$AzureDevOpsOrganization/$AzureDevOpsProject/_apis/sourceProviders/$ProviderName/branches?api-version=6.0-preview.1"

    Write-Host "Requesting Source Providers from $AzureDevOpsOrganization/$AzureDevOpsProject via $uri"

    $AzureDevOpsAuthenicationHeader = @{Authorization = 'Basic ' + [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(":$($AzureDevOpsPAT)")) }
    
    $results = Invoke-RestMethod -Uri $uri -Method Get -Headers $AzureDevOpsAuthenicationHeader -ContentType "application/json"
    $results 
    return $results.value
    
}


Export-ModuleMember -Function Get-AzureDevOpsSubscriptions
Export-ModuleMember -Function Set-AzureDevOpsWebhook
Export-ModuleMember -Function Get-AzureDevOpsProjects
#Export-ModuleMember -Function Get-AzureDevOpsSourceProviders
#Export-ModuleMember -Function Get-AzureDevOpsListBranches