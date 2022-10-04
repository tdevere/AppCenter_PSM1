
function Get-AppCenterDeviceConfigurations
{

    <#
    .Synopsis
    Returns a list of available devices for an application.

    .Description
    Returns a list of available devices for an application. https://openapi.appcenter.ms/#/test/test_getDeviceConfigurations

    .Parameter ApiUserToken
    User API tokens work across all apps and apps that you're associated with. https://docs.microsoft.com/en-us/appcenter/api-docs/#creating-an-app-center-user-api-token

    .Parameter OwnerName
    App Center Organization or User name

    .Parameter AppName
    App Center Application Name

    .Example
    Get-AppCenterDeviceConfigurations -ApiUserToken ***** -OwnerName ***** -AppName *****    

    name        : Amazon Fire HD 10 (9th Gen) (9)
    id          : b827da70-3841-44fd-9589-3a91211bde46
    tier        : 3
    image       : @{full=https://testcloud-prod-system-files.s3.eu-west-1.amazonaws.com/system_files/b993fd07-ce03-4360-b88c-05fefd7c9475?response-cache-control=max-age%3D157784760&AWSAccessKeyId=AKIAI4UZT4FCOF2OTJY
                Q&Signature=6BvSUajkX4BKn6CBOYj79MBaoFU%3D&Expires=1821458401; thumb=https://testcloud-prod-system-files.s3.eu-west-1.amazonaws.com/system_files/62e12388-fff7-4e4c-b5a7-31be26b174a6?response-cache-
                control=max-age%3D157784760&AWSAccessKeyId=AKIAI4UZT4FCOF2OTJYQ&Signature=l5rN8X3fNQzxk0DSZBhSzv8i8xU%3D&Expires=1821458401}
    osName      : Android 9
    os          : 9
    marketShare : 0
    model       : @{name=Amazon Fire HD 10 (9th Gen); manufacturer=Amazon; model=KFMAWI; platform=android; dimensions=; resolution=; cpu=; memory=; screenRotation=270; releaseDate=October 2019; formFactor=tablet;
                screenSize=; availabilityCount=1; deviceFrame=}

    name        : Asus Google Nexus 7 (2013) (5.1.1)
    id          : 601715a9-0bbb-43f6-83eb-63f01137fd92
    tier        : 1
    image       : @{full=https://testcloud-prod-system-files.s3.eu-west-1.amazonaws.com/system_files/4d4d5432-1d37-4001-990e-f49cb4217d30?response-cache-control=max-age%3D157784760&AWSAccessKeyId=AKIAI4UZT4FCOF2OTJY
                Q&Signature=uYPZVPICc4JT4hP7ZZmcGnpLj2U%3D&Expires=1821458401; thumb=https://testcloud-prod-system-files.s3.eu-west-1.amazonaws.com/system_files/c49bb31e-dc0c-4c57-8778-0657a66d178b?response-cache-
                control=max-age%3D157784760&AWSAccessKeyId=AKIAI4UZT4FCOF2OTJYQ&Signature=5h2Oli2gPMYI6kQeoxLKkDrTDlA%3D&Expires=1821458401}
    osName      : Android 5.1.1
    os          : 5.1.1
    marketShare : 0
    model       : @{name=Asus Google Nexus 7 (2013); manufacturer=Asus; model=Nexus 7; platform=android; dimensions=; resolution=; cpu=; memory=; screenRotation=0; releaseDate=July 2013; formFactor=tablet;
                screenSize=; availabilityCount=5; deviceFrame=}

    #>
    param (
    [string] $ApiUserToken,
    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]
    [string] $AppName,
    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]    
    [string]$OrgName)

    #https://openapi.appcenter.ms/#/test/test_getDeviceConfigurations
    $uri = 'https://api.appcenter.ms/v0.1/apps/' + $OrgName + '/' + $AppName + '/device_configurations/'

    try 
    {
      $results = curl.exe -X GET $Uri -H "Content-Type: application/json" -H "accept: application/json" -H "X-API-Token: $ApiUserToken" | ConvertFrom-Json  
    }
    catch 
    {
      $results = "Get-AppCenterDeviceConfigurations failed for $OrgName/$AppName"
    }    

    return $results
}

Export-ModuleMember -Function Get-AppCenterDeviceConfigurations

