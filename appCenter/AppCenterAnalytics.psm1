function Get-AppCenterAnalyticEvents
{
    <#
    .Synopsis
    Count of active events in the time range ordered by event.

    .Description
    Count of active events in the time range ordered by event. https://openapi.appcenter.ms/#/analytics/Analytics_Events

    .Parameter ApiUserToken
    User API tokens work across all apps and apps that you're associated with. https://docs.microsoft.com/en-us/appcenter/api-docs/#creating-an-app-center-user-api-token  

    .Parameter OrgName
    Organization Name
    
    .Parameter AppNAme
    Application Name

    .Example
    # Retrieves list of App Center apps. Requires Environment variable 
    PS C:\$events = Get-AppCenterAnalyticEvents -ApiUserToken **** -OrgName ***** -AppName *****
    PS C:\$events.events

    id                    : {"ci":"sample"}
    name                  : {"ci":"sample"}
    device_count          : 2
    previous_device_count : 0
    count                 : 12
    previous_count        : 0
    count_per_device      : 6.0

    id                    : Sending ErrorProps
    name                  : Sending ErrorProps
    device_count          : 2
    previous_device_count : 0
    count                 : 12
    previous_count        : 0
    count_per_device      : 6.0

    id                    : BtnEventTest_Click at 1:15:32 PM
    name                  : BtnEventTest_Click at 1:15:32 PM
    device_count          : 1
    previous_device_count : 0
    count                 : 4
    previous_count        : 0
    count_per_device      : 4.0
    
    .Example
    # Export Events  
    PS C:\$events.events | Export-Csv -Path 'c:\temp\events.csv'

    #TYPE System.Management.Automation.PSCustomObject						
    id	name	device_count	previous_device_count	count	previous_count	count_per_device
    {"ci":"sample"}	{"ci":"sample"}	2	0	12	0	6
    Sending ErrorProps	Sending ErrorProps	2	0	12	0	6
    BtnEventTest_Click at 1:15:32 PM	BtnEventTest_Click at 1:15:32 PM	1	0	4	0	4
    BtnEventTest_Click at 1:15:33 PM	BtnEventTest_Click at 1:15:33 PM	1	0	4	0	4
    BtnEventTest_Click at 1:39:56 PM	BtnEventTest_Click at 1:39:56 PM	1	0	3	0	3
    BtnEventTest_Click at 1:39:58 PM	BtnEventTest_Click at 1:39:58 PM	1	0	3	0	3
    BtnEventTest_Click at 1:40:00 PM	BtnEventTest_Click at 1:40:00 PM	1	0	3	0	3
    BtnEventTest_Click at 1:40:01 PM	BtnEventTest_Click at 1:40:01 PM	1	0	3	0	3
    BtnEventTest_Click at 1:40:02 PM	BtnEventTest_Click at 1:40:02 PM	1	0	3	0	3
    BtnEventTest_Click at 1:44:01 PM	BtnEventTest_Click at 1:44:01 PM	1	0	3	0	3

    #>

    param ([string] $ApiUserToken,
    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]    
    [string]$OrgName,
    [ValidateNotNullOrEmpty()]    
    [string]$AppName)   

    #https://openapi.appcenter.ms/#/analytics/Analytics_Events    

    $Uri = "https://api.appcenter.ms/v0.1/apps/$OrgName/$AppName/analytics/events"

    $results = curl.exe -X GET $Uri -H "Content-Type: application/json" -H "accept: application/json" -H "X-API-Token: $ApiUserToken" | ConvertFrom-Json

    return $results
}

Export-ModuleMember -Function Get-AppCenterAnalyticEvents