# PowerShell Script Module Library - AppCenter Administration Tools

## Setup
Run the [Setup Script](/Setup.ps1) as an administrator. This script copies the PowerShell modules within this repository to the Powershell modules directory on your system. This makes running the commands natively to your PowerShell session simple and easy to use. 

``` To increase productiviy create an environment variable to store your App Center User Token named: ApiUserToken. Doing so allows you to avoid having to pass this paramter in each PowerShell module ```

Remember to run setup each time you make updates to your local clone so that script changes are immediately available to you. 

## Getting Started

Try running the following commands to get started with the AppCenter PS Modules for PowerShell

### Populate Your Organizations
``` $orgs = Get-AppCenterOrgs ```

### Populate Your Apps
``` $apps = $orgs | ForEach-Object { Get-AppCenterApps -OrgName $_.name } ``~

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

    To Do: Implement Single App Check

    ``` Get-AppCenterAppDetails -OrgName "" -AppName "" ```


## PowerShell Module List
| Function | Synopsis |
|----------|----------|
| [Get-AppCenterAppsByOrg](/Get-AppCenterAppsByOrg.psm1) | Retrieves list of App Center Apps. |
|[Get-AppCenterOrganizations](/Get-AppCenterOrganizations.psm1) |Retrieves list of App Center Organazations.
|[Get-AppCenterExportApps](/Get-AppCenterExportApps.psm1) | Retrieves list of App Center Apps that have Export enabled (Blob or Application Insights) |


## Roadmap

1. Support for Mac | Linux
* We need to determine which platform we're running on. If Mac/Linux, we'll need to change details which support those platforms. Currently (8/9/2022) we only support the Windows Platform. However, there's nothing to prevent us from supporting any Platform PowerShell is supported. 

2. Add List Paramater
* It would be better if we can pass a list into many functions, rather than rely on ForEach-Object commands. This will just make the process of managing larger collections easier.

``` Contributions are welcomed. ```