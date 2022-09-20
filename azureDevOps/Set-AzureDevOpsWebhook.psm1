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


Export-ModuleMember -Function Set-AzureDevOpsWebhook