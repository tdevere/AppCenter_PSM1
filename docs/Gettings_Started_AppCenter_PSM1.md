# Getting Started with App Center PowerShell Modules

## Examples

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