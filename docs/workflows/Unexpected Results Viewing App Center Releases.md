# Unexpected Results Viewing App Center Releases

## Common Issues

Differences bewteen releases sorting emrge for several reasons.

<details>
<summary>Different APIs Used for Comparision</summary>

Viewing releases using different search criteria is a common cause for seeing different results. Compare Apples to Apples, API call to API call, and with the appropreiate group details. 

</details>

<details>
<summary>Sort / Search Criteria</summary>

Sorting is essentially is based on these three values: ` sortVersion, buildVersion, and createdAt `

`sortVersion` is 24 character sortable rendition of the original version number or if the attempt to build this string falls through, it will be set to "000000000000000000000000". There are conditions which make this value sort first in some result sets. In those cases, older releases will come to the top of results which you might expect. 

`buildVersion` can sometimes also not sort as you might expect most frequently when the pattern used is changed from say, a string to a X.X.X.X format. 

`In either case`, once this occurrs, you cannot modify sortVersion or filter it out of the results from the portal view. Your best case here is to disable the older releases so they are not returned in the release list at all.  

</details>

## Common Releases Endpoints

Review the common locations for viewing releases. 

<details>
<summary>Overview Page</summary>

The overview Page [Latest Releases](https://appcenter.ms/orgs/{org_name}}/apps/{app_name})
![](/docs/images/latest_release.png)

This view is built via the following API CAll

``` https://appcenter.ms/api/v0.1/apps/{org_name}/{app_name}}/recent_releases ```

</details>

<details>
<summary>Distribute Page</summary>

[Releases](https://appcenter.ms/orgs/{org_name}}/apps/{app_name}/distribute/releases)
![](/docs/images/portal_distirbute_page.png)

</details>

<details>
<summary>Distribute Group Page </summary>

[Releases](https://appcenter.ms/orgs/{org_name}}/apps/{app_name}/distribute/distribution-groups/{group_name}}/releases)
![](/docs/images/portal_distirbute_group_page.png)

</details>

<details>
<summary>Install Portal Page</summary>

[Install Portal](https://install.appcenter.ms/orgs/{owner_name/apps/{app_name}})
![](/docs/images/install_portal.png)

This view is commonly built via the following API CAll

``` https://install.appcenter.ms/api/v0.1/apps/{org_name}/{app_name}}/distribution_groups/public/public_releases?scope=tester&top=1000 ```

 </details>

## Alternatives

Review these workarounds to common sorting issues.

<details>
<summary>Disable Old Releases</summary>

Disable older releases to avoid these in search / sort results. (PowerShell Example)

[DateTime]$DisableReleasesOnAndBefore = (Get-Date).AddDays(-180) #180 days before today

[Disable-AppCenterRelease](/appCenter/Get-AppCenterReleases.psm1) 

Example: 

1. Set the Date Limit

`[DateTime]$DisableReleasesOnAndBefore = (Get-Date).AddDays(-180) `

2. [Get-AppCenterReleases](/appCenter/Get-AppCenterReleases.psm1)

 ` $Releases =  Get-AppCenterReleases -ApiUserToken ***** -OrgName ***** -AppName ***** `

3. Extract Releases with Date Limit and Disable Each

` $Releases | Where-Object { [DateTime]$_.uploaded_at -le $DisableReleasesOnAndBefore } | ForEach-Object { Disable-AppCenterRelease -ApiUserToken -OrgName ***** -AppName ***** -Release_Id $_.id } `

</details>

<details>
<summary>Extract Direct Download Links</summary>

1. [(Get-AppCenterReleaseDetails](/appCenter/Get-AppCenterReleases.psm1)

 ` $ReleaseDetail =  Get-AppCenterReleases -ApiUserToken ***** -OrgName ***** -AppName ***** -Release_Id 2 `

2. Extract Download Url

` $ReleaseDetail.download_url `

</details>


## Contact Support

Still having trouble? Reach out to App Center support. To better assist you, save the result of each of these recommendated calls to json file. Use the name of the function step to save the results, zip each, and share with App Center support team. 

* An alternative to PowerShell is to use the [App Center Open API.](https://openapi.appcenter.ms) 

How to save results via PowerShell

This step below Converts the results of a call into a JSON format and then saves the data to a file on the local drive under the logs folder:

 ` Get-AppCenterDistributionGroups -ApiUserToken ***** -OrgName ***** -AppName ***** | ConvertTo-Json | Out-File -FilePath 'c:\logs\Get-AppCenterDistributionGroups.json' `



<details>
<summary>Get-AppCenterDistributionGroups</summary>

[Get-AppCenterDistributionGroups](/appCenter/AppCenterDistribution.psm1) 

</details>

<details>
<summary>Get-AppCenterDistributionGroupsDetails</summary>

[Get-AppCenterDistributionGroupsDetails](/appCenter/AppCenterDistribution.psm1) 


</details>

<details>
<summary>Get-AppCenterDistributionGroupReleases</summary>

[Get-AppCenterDistributionGroupReleases](/appCenter/AppCenterDistribution.psm1)


</details>

<details>
<summary>Get-AppCenterRecentReleases</summary>

[Get-AppCenterRecentReleases](/appCenter/AppCenterDistribution.psm1) 

</details>

<details>
<summary>Relevant Screen Shots</summary>

App Center support cannot see your portal or install views. Please share relavant screen shots and take a moment to mark them for specific callouts. 

</details>

<details>
<summary>Browser Trace</summary>

If the issue you see only happens for a specific user or only through the browser, consider collecting a [Browser Trace](https://learn.microsoft.com/en-us/azure/azure-portal/capture-browser-trace)

</details>