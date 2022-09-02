# Set-AzureDevOpsWebhook Documentation

## Setup Environment Variables

1. Create your [personal access token](https://docs.microsoft.com/en-us/azure/devops/organizations/accounts/use-personal-access-tokens-to-authenticate?view=azure-devops&tabs=Windows)

2. Get your Azure Subscription ID
```
PS C:\> Connect-AzAccount  

PS C:\> Get-AzSubscription | FT -AutoSize -Wrap

Name                                            Id       TenantId State  
----                                            --       -------- -----
MSFT-********                          ******** ******** Enabled
```

3. Log into [Azure DevOps](https://dev.azure.com/), get the organization name you wish to use
4. Get your DevOps Project ID. You can use the PowerShell module included in this repository [Get-AzureDevOpsProjects](/azureDevOps/Get-AzureDevOpsProjects.psm1)

```
PS C:\> Get-AzureDevOpsProjects -AzureDevOpsPAT $env:DevOpsPat -AzureDevOpsOrganization ******
  
        Requesting Projects from ****** via https://dev.azure.com/*****/_apis/projects?api-version=6.0

        id             : *****
        name           : AppCenter_Repros
        url            : https://dev.azure.com/******/_apis/projects/******
        state          : wellFormed
        revision       : 319
        visibility     : private
        lastUpdateTime : 2021-07-09T22:08:14.67Z
```
5. Last setup step is define the Webhook Receiver Uri. This can be any valid URI which is responding to the webhook request. 

# Example

```
PS C:\> Set-AzureDevOpsWebhook -AzureDevOpsPAT ******** -AzureDevOpsOrganization ******** -AzureDevOpsWebHookReceiverUri ******** -AzureDevOpsProjectId ********

Creating Webhook for https://dev.azure.com/********/_apis/hooks/subscriptions?api-version=6.0

Project Configuration
{
    "publisherId": "tfs",
    "consumerActionId": "httpRequest",
    "consumerId": "webHooks",
    "consumerInputs": {
        "url": "********",
        "httpHeaders": "Key:637977165124103599"
    },
    "eventType": "build.complete",

    "publisherInputs": {
        "definitionName": "",
        "buildStatus": "",
        "projectId": "********"
    }
}


id                     : ********
url                    : https://dev.azure.com/********/_apis/hooks/subscriptions/********
status                 : enabled
publisherId            : tfs
eventType              : build.complete
subscriber             :
resourceVersion        :
eventDescription       : Any completed build.
consumerId             : webHooks
consumerActionId       : httpRequest
actionDescription      : To host fbg-monitor.azurewebsites.net
createdBy              : @{displayName=********; id=********; uniqueName=********; descriptor=********}
createdDate            : 2022-09-02T16:55:13.177Z
modifiedBy             : @{displayName=********; id=********; uniqueName=********; descriptor=********}
modifiedDate           : 2022-09-02T16:55:13.177Z
lastProbationRetryDate : 0001-01-01T00:00:00
publisherInputs        : @{buildStatus=; definitionName=; projectId=********; tfsSubscriptionId=********}
consumerInputs         : @{httpHeaders=Key:637977165124103599; url=********}
_links                 : @{self=; consumer=; actions=; notifications=; publisher=}

```