Clear-Host
Write-Host "Use this for quick test work."

function Get-AppCenterDistributionStores
{
    param ([string] $ApiUserToken = $env:ApiUserToken,
    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]    
    [string]$OrgName,
    [ValidateNotNullOrEmpty()]    
    [string]$AppName)    

    $Uri = "https://api.appcenter.ms/v0.1/apps/$OrgName/$AppName/distribution_stores"

    Write-Host "Calling $Uri"

    $results = curl.exe -X GET $Uri -H "Content-Type: application/json" -H "accept: application/json" -H "X-API-Token: $ApiUserToken" | ConvertFrom-Json

    return $results
}

function Get-AppCenterDistributionStoresList
{
    param ([string] $ApiUserToken = $env:ApiUserToken,
    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]    
    $OrgAppList)    

    $Global:StoreList = New-Object 'Collections.Generic.List[psobject]' #Variable storing Orgs and Apps list

    $apps = $OrgAppList.value

    foreach ($a in $apps)
    {
        $appName = $a.name
        
        #BUG||ISSUE: For some reason, not able to do a property lookup. This is treated as a string.
        #No conversion I've tried will allow me to simply query by name property. 
        #Temp Fix: terrible but I'm simply parsing the string for the specific value - dirty but will do the trick for now
        $ownerName = $a.owner.Replace('@',"").Replace('{',"").Replace('}',"").Split(";").Split("=")[7]
        
        if ($null -ne $ownerName)
        {
            Write-Host "Retriving Store Information for $ownerName/$appName"
            $store = Get-AppCenterDistributionStores -ApiUserToken $ApiUserToken -OrgName $ownerName -AppName $appName
            $Global:StoreList.Add($store)
        }
    }

    return $Global:StoreList
}

#$apps = Get-Content C:\temp\tdevere_appcenter_apps_all.json | ConvertFrom-Json

$stores = Get-AppCenterDistributionStoresList -OrgAppList (Get-Content C:\temp\tdevere_appcenter_apps_all.json | ConvertFrom-Json)
$stores.Count

