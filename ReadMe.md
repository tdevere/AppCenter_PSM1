# PowerShell Script Module Library for Azure DevOps and AppCenter Administration

## Setup
Run the [Setup Script](/Setup.ps1) as an administrator. This script copies the PowerShell modules within this repository to the Powershell modules directory on your system. This makes running the commands natively to your PowerShell session simple and easy to use. 

 ``` Remember to run setup each time you make updates to your local clone so that script changes are immediately available to you.  ```

## PowerShell Module List

### AppCenter

[Getting started documentation](/docs/Gettings_Started_AppCenter_PSM1.md)

| Function | Synopsis |
|----------|----------|
|[Get-AppCenterApp](/appCenter/Get-AppCenterApp.psm1) | Return a specific app with the given app name which belongs to the given owner. |
|[Get-AppCenterApps](/appCenter/Get-AppCenterApps.psm1) | Return all apps which belongs to the given owner. |
|[Get-AppCenterAppsByOrg](/appCenter/Get-AppCenterAppsByOrg.psm1) | Retrieves list of App Center Apps for a specifc Organization. |
|[Get-AppCenterAppsByOrgList](/appCenter/Get-AppCenterAppsByOrg.psm1)| Same as [Get-AppCenterAppsByOrg](/Get-AppCenterAppsByOrg.psm1) however this takes a list of Orgs and returns a list.
|[Get-AppCenterExportApps](/appCenter/Get-AppCenterExportApps.psm1) | Retrieves list of App Center Apps that have Export enabled (Blob or Application Insights). |
|[Get-AppCenterOrg](/appCenter/Get-AppCenterOrg.psm1) | Returns the details of a single organization. |
|[Get-AppCenterOrgs](/appCenter/Get-AppCenterOrgs.psm1) | Retrieves list of App Center Organazations. |
|[Get-AppCenterDistributionStores](/appCenter/Get-AppCenterDistributionStores.psm1) | Get Store information for App. |
|[Get-AzureDevOpsProjects](/appCenter/Get-AzureDevOpsProjects.psm1) | Returns the list of projects in your organization. |

### Azure

| Function | Synopsis |
|----------|----------|
|[Get-AzureDevOpsProjects](/azureDevOps/Set-AzureDevOpsWebhook.psm1) | Return list of projects in Azure DevOps. |
|[Set-AzureDevOpsWebhook](/docs/Set-AzureDevOpsWebhook.md) | Create a webhook for an Azure DevOps Project. |

### GitHub

| Function | Synopsis |
|----------|----------|
|[Get-GithubRepositoryPermissions](/general/Get-GithubRepositoryPermissions.psm1) | Check your repository access to GitHub using a PAT |

### General

| Function | Synopsis |
|----------|----------|
|[Get-UnixDateTimeSeconds](/general/Get-UnixDateTimeSeconds.psm1) | [DateTimeOffset]::UtcNow.ToUnixTimeSeconds()
|[Get-UnixDateTimeMilliseconds](/general/Get-UnixDateTimeSeconds.psm1) | [DateTimeOffset]::UtcNow.ToUnixTimeMilliseconds() |
|[Get-UnixStartOfDayDateTimeSeconds](/general/Get-UnixStartOfDayDateTimeSeconds.psm1) | Return Start of Day DateTime in Seconds
|[Write-ColorfulHost](/general/Write-ColorfulHost.psm1) | Print collections with mulitple colors |
<!-- |[PSM1-Registration.psm1](/PSM1-Registration.psm1) | Register or Unregister all PSM1 modules within a single directory. Also show list of currently instaled PSM1 modules. | -->


## Roadmap

1. Support for Mac | Linux
* We need to determine which platform we're running on. If Mac/Linux, we'll need to change details which support those platforms. Currently (8/9/2022) we only support the Windows Platform. However, there's nothing to prevent us from supporting any Platform PowerShell is supported. 

2. Add List Paramater
* It would be better if we can pass a list into many functions, rather than rely on ForEach-Object commands. This will just make the process of managing larger collections easier.

``` Contributions are welcomed. ```