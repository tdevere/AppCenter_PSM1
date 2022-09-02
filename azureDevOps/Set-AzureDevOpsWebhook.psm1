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

  .Parameter AzureDevOpsOrganization
  #>

#Configure Environment Variables or Override at runtime
$AzureDevOpsPAT = $env:AzureDevOpsPAT
$AzureSubscriptionId = $env:AzureSubscriptionId
$AzureDevOpsOrganization = $env:AzureDevOpsOrganization
$AzureDevOpsProjectId = $env:AzureDevOpsProjectId
$AzureDevOpsWebHookReceiverUri = $env:AzureDevOpsWebHookReceiverUri


function Set-AzureDevOpsWebhook 
{
    #https://docs.microsoft.com/en-us/rest/api/azure/devops/hooks/Subscriptions/Create?view=azure-devops-rest-6.0&tabs=HTTP
    param 
    (
        [ValidateNotNullOrEmpty()]
        [string]$AzureDevOpsPAT = $env:AzureDevOpsPAT,
        [ValidateNotNullOrEmpty()]
        [string]$AzureDevOpsOrganization = $env:AzureDevOpsOrganization,
        [string]$uri,
        [ValidateNotNullOrEmpty()]
        [string]$AzureDevOpsWebHookReceiverUri = $env:AzureDevOpsWebHookReceiverUri,
        [ValidateNotNullOrEmpty()]
        [string]$AzureDevOpsProjectId = $env:AzureDevOpsProjectId
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