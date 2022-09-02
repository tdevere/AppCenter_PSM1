# PowerShell Script Module Library for AppCenter Administration

## Setup
Run the [Setup Script](/Setup.ps1) as an administrator. This script copies the PowerShell modules within this repository to the Powershell modules directory on your system. This makes running the commands natively to your PowerShell session simple and easy to use. 

``` To increase productiviy create an environment variable to store your App Center User Token named: ApiUserToken. Doing so allows you to avoid having to pass this paramter in each PowerShell module ```

Remember to run setup each time you make updates to your local clone so that script changes are immediately available to you. 

## Getting Started
<details>
<summary>
    Get started with the AppCenter PS Modules for PowerShell
</summary>

### Populate Your Organizations
``` $orgs = Get-AppCenterOrgs ```

### Populate Your Apps
``` $apps = $orgs | ForEach-Object { Get-AppCenterApps -OrgName $_.name } ```

### Get Status of All Export Services
1. Populate a list of Apps with one ore more export services enabled

    ``` $exportApps = $apps | ForEach-Object { Get-AppCenterExportApps -OrgName $_.owner.name -AppName $_.name } ```

2. Show a complete list of Export Details

    ``` $exportApps.ExportDetails  ```

3. Examine only "BlobStorage" Export details

    ``` $exportApps | Where-Object { $_.ExportDetails.values.export_type -eq "BlobStorage" } ```

4. Exammine only "AppInsights" Export Details

    ``` $exportApps | Where-Object { $_.ExportDetails.values.export_type -eq "AppInsights" } ```

### Remove-AppCenterExport Service
``` Warning: This step will remove, not disable, the export service if it exists ```

1. Create a Temp variable from $exportApps

    ``` $sampleApp = $exportApps | Where-Object { $_.ExportDetails.values.export_type -eq "BlobStorage" } | Select-Object -First 1 ```

2. Remove the Export Services

    ``` $sampleApp.ExportDetails.Values | ForEach-Object { Remove-AppCenterExport -AppName $sampleApp.AppName -OrgName $sampleApp.Owner -Export_Config_Id $_.id} ```

3. Check the results of removal export operation

    ``` Get-AppCenterApp -OrgName "" -AppName "" ```

</details>

## PowerShell Module List

### AppCenter 
| Function | Synopsis |
|----------|----------|
|[Get-AppCenterApp](/Get-AppCenterApp.psm1) | Return a specific app with the given app name which belongs to the given owner. |
|[Get-AppCenterApps](/Get-AppCenterApps.psm1) | Return all apps which belongs to the given owner. |
|[Get-AppCenterAppsByOrg](/Get-AppCenterAppsByOrg.psm1) | Retrieves list of App Center Apps for a specifc Organization. |
|[Get-AppCenterAppsByOrgList](/Get-AppCenterAppsByOrg.psm1)| Same as [Get-AppCenterAppsByOrg](/Get-AppCenterAppsByOrg.psm1) however this takes a list of Orgs and returns a list.
|[Get-AppCenterExportApps](/Get-AppCenterExportApps.psm1) | Retrieves list of App Center Apps that have Export enabled (Blob or Application Insights). |
|[Get-AppCenterOrg](/Get-AppCenterOrg.psm1) | Returns the details of a single organization. |
|[Get-AppCenterOrgs](/Get-AppCenterOrgs.psm1) | Retrieves list of App Center Organazations. |
|[Get-AppCenterDistributionStores](/Get-AppCenterDistributionStores.psm1) | Get Store information for App. |
|[Get-AzureDevOpsProjects](/Get-AzureDevOpsProjects.psm1) | Returns the list of projects in your organization. |

### Azure

| Function | Synopsis |
|----------|----------|
|[Set-AzureDevOpsWebhook](/Set-AzureDevOpsWebhook.psm1) | Create a webhook for an Azure DevOps Project. |

### GitHub

| Function | Synopsis |
|----------|----------|
|[Get-GithubRepositoryPermissions](/Get-GithubRepositoryPermissions.psm1) | Check your repository access to GitHub using a PAT |

### General

| Function | Synopsis |
|----------|----------|
|[Get-UnixDateTimeSeconds](/Get-UnixDateTimeSeconds.psm1) | [DateTimeOffset]::UtcNow.ToUnixTimeSeconds()
|[Get-UnixDateTimeMilliseconds](/Get-UnixDateTimeSeconds.psm1) | [DateTimeOffset]::UtcNow.ToUnixTimeMilliseconds() |
|[Get-UnixStartOfDayDateTimeSeconds](/Get-UnixStartOfDayDateTimeSeconds.psm1) | Return Start of Day DateTime in Seconds
|[Write-ColorfulHost](/Write-ColorfulHost.psm1) | Print collections with mulitple colors |
<!-- |[PSM1-Registration.psm1](/PSM1-Registration.psm1) | Register or Unregister all PSM1 modules within a single directory. Also show list of currently instaled PSM1 modules. | -->


## Roadmap

1. Support for Mac | Linux
* We need to determine which platform we're running on. If Mac/Linux, we'll need to change details which support those platforms. Currently (8/9/2022) we only support the Windows Platform. However, there's nothing to prevent us from supporting any Platform PowerShell is supported. 

2. Add List Paramater
* It would be better if we can pass a list into many functions, rather than rely on ForEach-Object commands. This will just make the process of managing larger collections easier.

``` Contributions are welcomed. ```