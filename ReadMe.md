# PowerShell Script Module Library for Azure DevOps and AppCenter Administration

## Windows Setup
Run the [Setup Script](/Setup.ps1) to copy the PowerShell modules to the modules directory to "$env:userprofile\Documents\WindowsPowerShell\Modules". After restarting your Powershell session, these commands are natively loaded (Windows 10+). 

 ``` When you make changes to a script, you will need to rerun ``` [Setup Script](/Setup.ps1) 
 ```and restart your PowerShell session to reflect updates.  ```

## PowerShell Module List 

### AppCenter [Getting started documentation](/docs/Gettings_Started_AppCenter_PSM1.md)

| Function | Synopsis |
|----------|----------|
|[Get-AppCenterApp](/appCenter/Get-AppCenterApp.psm1) | Return a specific app with the given app name which belongs to the given owner. |
|[Get-AppCenterApps](/appCenter/Get-AppCenterApps.psm1) | Return all apps which belongs to the given owner. |
|[Get-AppCenterAppsByOrg](/appCenter/Get-AppCenterAppsByOrg.psm1) | Retrieves list of App Center Apps for a specifc Organization. |
|[Get-AppCenterAppsByOrgList](/appCenter/Get-AppCenterAppsByOrg.psm1)| Same as [Get-AppCenterAppsByOrg](/Get-AppCenterAppsByOrg.psm1) however this takes a list of Orgs and returns a list.
|[Get-AppCenterExportApps](/appCenter/Get-AppCenterExportApps.psm1) | Retrieves list of App Center Apps that have Export enabled (Blob or Application Insights). |
|[Get-AppCenterOrg](/appCenter/Get-AppCenterOrg.psm1) | Returns the details of a single organization. |
|[Get-AppCenterOrgs](/appCenter/Get-AppCenterOrgs.psm1) | Retrieves list of App Center Organazations. |
|[Get-AppCenterServiceConnections](/appCenter/Get-AppCenterServiceConnections.psm1) | Returns the list of store connections related to your App Center account. |
|[Get-AppCenterRepoConfig](/appCenter/Get-AppCenterRepoConfig.psm1) | Returns the repository build configuration status of the app. |
|[Get-AppCenterRepoConfigByList](/appCenter/Get-AppCenterRepoConfig.psm1) | Pass a list of owners and names, to process bulk repository build configuration status of the app. |
|[Get-AppCenterDeviceConfigurations](/appCenter/Get-AppCenterDeviceConfigurations.psm1) | Returns a list of available devices for an application. |
|[Get-AppCenterAnalyticEvents](/appCenter/Get-AppCenterAnalytics.psm1) | Count of active events in the time range ordered by event. |
|[Get-AppCenterOrgUsers](/appCenter/Get-AppCenterOrgUsers.psm1) | Returns a list of users that belong to an organization. |
|[Get-AppCenterOrgTesters](/appCenter/Get-AppCenterOrgUsers.psm1) | Returns a list of testers that belong to an organization. |
|[Get-AppCenterReleases](/appCenter/Get-AppCenterReleases.psm1) | Return basic information about releases. |
|[Get-AppCenterReleaseDetails](/appCenter/Get-AppCenterReleases.psm1) | Get a release with id release_id. |
|[Disable-AppCenterRelease](/appCenter/Get-AppCenterReleases.psm1) | Disable a release. |
|[Get-AppCenterDistributionGroups](/appCenter/AppCenterDistribution.psm1) | Returns a list of distribution groups in the Org or App specified. |
|[Get-AppCenterDistributionGroupsDetails](/appCenter/AppCenterDistribution.psm1) | Returns a list of distribution groups in the org specified. |
|[Get-AppCenterDistributionGroupReleases](/appCenter/AppCenterDistribution.psm1) |Return basic information about distributed releases in a given distribution group. |
|[Get-AppCenterRecentReleases](/appCenter/AppCenterDistribution.psm1) |Get all the store details from Storage store table for a particular application. |
|[Get-AppCenterDistributionStores](/appCenter/AppCenterDistribution.psm1) | Get Store information for App. |


### Azure [Getting started documentation](/docs/Getting_Started_AzureDevOps.md)

| Function | Synopsis |
|----------|----------|
|[Get-AzureDevOpsProjects](/azureDevOps/Set-AzureDevOpsWebhook.psm1) | Return list of projects in Azure DevOps. |
|[Set-AzureDevOpsWebhook](/docs/Set-AzureDevOpsWebhook.md) | Create a webhook for an Azure DevOps Project. |
|[Get-AzureDevOpsSubscriptions](/azureDevOps/Get-AzureDevOpsSubscriptions.psm1) | Disable details of a release. |

### GitHub [Getting started documentation](/docs/Getting_Started_GitHub.md)

| Function | Synopsis |
|----------|----------|
|[Get-GithubRepositoryPermissions](/github/Get-GithubRepositoryPermissions.psm1) | Check your repository access to GitHub using a PAT |
|[Get-GithubUserRepositories](/github/Get-GithubUserRepositories.psm1) | Get list of your repositories using a PAT |

### General [Getting started documentation](/docs/Getting_Started_General.md)

| Function | Synopsis |
|----------|----------|
|[Get-UnixDateTimeSeconds](/general/Get-UnixDateTimeSeconds.psm1) | [DateTimeOffset]::UtcNow.ToUnixTimeSeconds()
|[Get-UnixDateTimeMilliseconds](/general/Get-UnixDateTimeSeconds.psm1) | [DateTimeOffset]::UtcNow.ToUnixTimeMilliseconds() |
|[Get-UnixStartOfDayDateTimeSeconds](/general/Get-UnixStartOfDayDateTimeSeconds.psm1) | Return Start of Day DateTime in Seconds
|[Write-ColorfulHost](/general/Write-ColorfulHost.psm1) | Print collections with mulitple colors |
<!-- |[PSM1-Registration.psm1](/PSM1-Registration.psm1) | Register or Unregister all PSM1 modules within a single directory. Also show list of currently instaled PSM1 modules. | -->


## Roadmap

1. Needs support for Mac | Linux
* We need to determine which platform we're running on. If Mac/Linux, we'll need to change details which support those platforms. Currently (8/9/2022) we only support the Windows Platform. However, there's nothing to prevent us from supporting any Platform PowerShell is supported. 

2. Update all relevant methods to include collections
* It would be better if we can pass a list into many functions, rather than rely on ForEach-Object commands. 

## Contributions are welcomed

