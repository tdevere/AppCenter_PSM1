function Get-AzureDevOpsSubscriptions 
{
    <#
        .Synopsis
        Get a list of subscriptions.

        .Description
        Get a list of subscriptions. #https://learn.microsoft.com/en-us/rest/api/azure/devops/hooks/subscriptions/list?view=azure-devops-rest-7.1&tabs=HTTP

        .Parameter AzureDevOpsPAT
        https://docs.microsoft.com/en-us/azure/devops/organizations/accounts/use-personal-access-tokens-to-authenticate?view=azure-devops&tabs=Windows
        You can use a personal access token (PAT) as an alternate password to authenticate into Azure DevOps.

        .Parameter AzureDevOpsOrganization

        .Example 

        Measure-Command { $AzureSubscriptions = Get-AzureDevOpsSubscriptions -AzureDevOpsPAT **** -AzureDevOpsOrganization **** }
        Preparing Call Get-AzureDevOpsSubscriptions https://dev.azure.com/YOURORGHERE/_apis/hooks/subscriptions?api-version=7.1-preview.1

        Days              : 0
        Hours             : 0
        Minutes           : 0
        Seconds           : 1
        Milliseconds      : 101
        Ticks             : 11011087
        TotalDays         : 1.27443136574074E-05
        TotalHours        : 0.000305863527777778
        TotalMinutes      : 0.0183518116666667
        TotalSeconds      : 1.1011087
        TotalMilliseconds : 1101.1087


    #>
    
    param 
    (
        [ValidateNotNullOrEmpty()]
        [string]$AzureDevOpsPAT,
        [ValidateNotNullOrEmpty()]
        [string]$AzureDevOpsOrganization
    )

    $uri = "https://dev.azure.com/$AzureDevOpsOrganization/_apis/hooks/subscriptions?api-version=7.1-preview.1"

    Write-Host "Preparing Call Get-AureDevOpsSubscriptions $uri"

    $AzureDevOpsAuthenicationHeader = @{Authorization = 'Basic ' + [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(":$($AzureDevOpsPAT)")) }
    
    $results = Invoke-RestMethod -Uri $uri -Method Get -Headers $AzureDevOpsAuthenicationHeader -ContentType "application/json"

    return $results
    
}


Export-ModuleMember -Function Get-AzureDevOpsSubscriptions