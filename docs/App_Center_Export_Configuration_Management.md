# App Center Export Configuration Management

Sample usage for managing [App Center Analytic Export](https://learn.microsoft.com/en-us/appcenter/analytics/export)

## Requirements

* [Azure Subscription](https://learn.microsoft.com/en-us/appcenter/general/azure-subscriptions)
* [App Center API Token](https://learn.microsoft.com/en-us/appcenter/api-docs/#section02)
* [PowerShell](https://learn.microsoft.com/en-us/powershell/scripting/windows-powershell/install/installing-windows-powershell?view=powershell-7.2)
* Organziation or Owner Name
* Application Name


## Org and App Name

The URI format for organization or owner name and application name in the App Center portal is `https://appcenter.ms/orgs/{Owner_Name}}/apps/{App_Name}}`. The organization and owner_name are interchanagable terms. Apps can either belong to an [Organization](https://learn.microsoft.com/en-us/appcenter/dashboard/creating-and-managing-organizations) or a indidivual App Center user, otherwise known in the API as `Owner_Name`.

### Example

* Organization Name = "`Examples`"
* Application Name = "`Android_Xamarin`"
* App Center URL = `https://appcenter.ms/orgs/Examples/apps/Android_Xamarin`


## Get Export Configuration 

```

$config = Get-AppCenterExportConfiguration -ApiUserToken ****** -OrgName Examples -AppName Android_Xamarin

$config.values


id                   : ******
export_type          : AppInsights
creation_time        : 2022-09-23T17:06:14.5901576Z
last_run_time        : 2022-09-30T16:41:00Z
state                : Enabled
resource_group       : appcenter-export-Android_Xamarin
resource_name        : AppCenterExport-Android_Xamarin
export_configuration : @{type=application_insights_linked_subscription; subscription_id=******; export_entities=System.Object[]}

id                   : ******
export_type          : BlobStorage
creation_time        : 2022-09-23T17:06:20.036948Z
last_run_time        : 2022-09-30T16:41:00Z
state                : Enabled
resource_group       : appcenter-export-Android_Xamarin
resource_name        : ******
export_configuration : @{type=blob_storage_linked_subscription; subscription_id=******; blob_path_format_kind=WithoutAppId; export_entities=System.Object[]}


```


## Configure Blob Storage to Export Diagnostics 

By default, a new blob storage export configuration exports Analytics data only. To begin exporting errors, attachments, or to turn off anaytic export, check out this example using [Update-AppCenterBlobStorageExportConfiguration](/appCenter/AppCenterExportConfiguration.psm1).


```
$return = Update-AppCenterBlobStorageExportConfiguration -ApiUserToken $env:ApiUserToken `
-OrgName Examples -AppName Android_Xamarin -export_configuration_id "********" `
-crashes $true -errors $false -attachments $true `
-resource_name "********" `
-resource_group "********"
```

Access the results of a successful call:

```
$return
$return.export_configuration

id                   : ab5a0975-b830-4b8a-be17-9ca377d4b48e
export_type          : BlobStorage
creation_time        : 2022-09-23T17:06:20.036948Z
last_run_time        : 2022-09-30T18:31:00Z
state                : Enabled
resource_group       : appcenter-export-Android_Xamarin
resource_name        : ex005f0a5ce8e08f7fb33898
export_configuration : @{type=blob_storage_linked_subscription; subscription_id=1330b91c-617c-47c8-ab66-5b3bd942c9de; blob_path_format_kind=WithoutAppId; export_entities=System.Object[]}

type                  : blob_storage_linked_subscription
subscription_id       : 1330b91c-617c-47c8-ab66-5b3bd942c9de
blob_path_format_kind : WithoutAppId
export_entities       : {attachments, crashes}

```

## Remove Export Configuration

```
Remove-AppCenterExportConfiguration -ApiUserToken ****** -OrgName Examples -AppName Android_Xamarin -Export_Config_Id ********
```

## Errors

`Exporting diagnostics entitires is not supported for Application Insight.`

[Choosing what kind of data to export](https://learn.microsoft.com/en-us/appcenter/analytics/export#choosing-what-kind-of-data-to-export) indicates the following 

``` 
By default, a new export configuration exports Analytics data only (events, sessions, and so on) Diagnostics-related data can be exported by setting Entities property (export_entity model) to a combination of errors, crashes, and attachments. The property also allows excluding Analytics data from being exported by adding no_logs value to the Entities array.
```

However, App Insights does not support diagnostics exports from App Center. These options are only possible for Blobstorage export. However, it is possible to exclude Analytic datat from Blobstorage and keep only diagnostic details using the "no_logs" entity value. 




