<#
 .Synopsis
  Return list of projects in Azure DevOps

 .Description
  Return list of projects in Azure DevOps - https://docs.microsoft.com/en-us/rest/api/azure/devops/core/Projects/List?view=azure-devops-rest-6.0&tabs=HTTP

 .Parameter AzureDevOpsPAT
  https://docs.microsoft.com/en-us/azure/devops/organizations/accounts/use-personal-access-tokens-to-authenticate?view=azure-devops&tabs=Windows
  You can use a personal access token (PAT) as an alternate password to authenticate into Azure DevOps.

 .Parameter AzureDevOpsOrganization
  Name of your Azure DevOps Organization
  #>

#Configure Environment Variables or Override at runtime
$AzureDevOpsPAT = $env:AzureDevOpsPAT
$AzureDevOpsOrganization = $env:AzureDevOpsOrganization

function Get-AzureDevOpsProjects 
{    
    param 
    (
        [ValidateNotNullOrEmpty()]
        [string]$AzureDevOpsPAT = $env:AzureDevOpsPAT,
        [ValidateNotNullOrEmpty()]
        [string]$AzureDevOpsOrganization = $env:AzureDevOpsOrganization,
        [string]$uri
    )

    $uri = "https://dev.azure.com/$AzureDevOpsOrganization/_apis/projects?api-version=6.0"

    Write-Host "Requesting Projects from $AzureDevOpsOrganization via $uri"

    $AzureDevOpsAuthenicationHeader = @{Authorization = 'Basic ' + [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(":$($AzureDevOpsPAT)")) }
    
    $results = Invoke-RestMethod -Uri $uri -Method Get -Headers $AzureDevOpsAuthenicationHeader -ContentType "application/json"
    
    return $results
    
}


Export-ModuleMember -Function Get-AzureDevOpsProjects