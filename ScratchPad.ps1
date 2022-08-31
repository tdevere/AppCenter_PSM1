Clear-Host
Write-Host "Use this for quick test work."

#region Browser Traces
<# 

[int]$Global:colorwheel = 0

function Set-Configuration
{
    param (
     [Parameter(Mandatory)]
     [ValidateNotNullOrEmpty()]     
     $setup,
     [Parameter(Mandatory)]
     [ValidateNotNullOrEmpty()]     
     $traceFilePath)

    $Global:setup = $setup
    
    if ($setup = 1)
    {
        $Global:traceFilePath = $traceFilePath

        if (Test-Path $Global:traceFilePath)
        {
            $Global:trace = Get-Content -Path $Global:traceFilePath | ConvertFrom-Json        
            Write-Information "Configuration Set: $Global:traceFilePath"
        }
        else 
        {
            Write-Warning "File Not Found: $Global:traceFilePath"
            exit
        }
    }
    else
    {
        if (Test-Path $Global:traceFilePath)
        {
            Write-Information "Configuration Set: $Global:traceFilePath"
        }
        else 
        {
            Write-Warning "Configuration Set but Trace File Missing: $Global:traceFilePath"
        }
    }
}

function Get-MatchingTracesRequests
{
    param(# Parameter help description
    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]    
    $Trace,
    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]    
    $searchTerm)

    $symbol_groups = $Trace | Where-Object { $_.request.url.ToString().ToLower().Contains($searchTerm) }
    return $symbol_groups
}

function Write-ColorfulHost
{
    param(# Parameter help description
    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]    
    $object,
    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]
    $counter)
    
    foreach ($obj in $object)
    {
        if ($counter -eq 0)
        {
            Write-Host $obj -ForegroundColor Green            
        }
        elseif ($counter -eq 1) 
        {
            Write-Host $obj -ForegroundColor DarkMagenta            
        }
        elseif ($counter -eq 2) 
        {
            Write-Host $obj -ForegroundColor Blue
        }
        elseif ($counter -eq 3) 
        {
            Write-Host $obj -ForegroundColor White
            $counter = -1
        }

        $counter++
        
    }
}

function Get-ErrorGroups
{
    param(# Parameter help description
    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]    
    $Trace)

    $errors = $Trace | Where-Object { $_.request.url.ToString().ToLower().Contains("errors?") }
    $errorText = $errors.response.content.text | ConvertFrom-Json

    return $errorText

} 

function Get-AppCenterApiCalls
{

    if ($null -ne $Global:trace.log.entries.request.url)
    {
        $AppCenterApiCalls = $Global:trace.log.entries.request.url | Where-Object { $_.ToString().ToLower().StartsWith('https://appcenter.ms/api/v0.1/') } | Group-Object | Format-Table -AutoSize
        return $AppCenterApiCalls        
    }
    else
    {
        Write-Host "Run Setup and ensure you provide a complete path to the Browser Trace"
    }
   
}

function Get-TraceRequestMatchingUrls
{

    param(# Parameter help description
    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]    
    $SearchText)

    if ($null -ne $Global:trace.log.entries)
    {
        $requests = $Global:trace.log.entries | Where-Object { $_.request.url.ToString().ToLower().Contains($SearchText) -or $_.response.url.ToString().ToLower().Contains($SearchText) }      
        return $requests
    }
    else
    {
        Write-Host "Run Setup and ensure you provide a complete path to the Browser Trace"
    }
   
}

function Get-TraceResponseMatchingUrls
{

    param(# Parameter help description
    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]    
    $SearchText)

    if ($null -ne $Global:trace.log.entries)
    {
        $Global:trace.log.entries.response | select -first 1
        $responses = $Global:trace.log.entries | Where-Object { $_.response.ToString().ToLower().Contains($SearchText) } 
        return $responses      
    }
    else
    {
        Write-Host "Run Setup and ensure you provide a complete path to the Browser Trace"
    }
   
}

#Set-Configuration -setup 1 -traceFilePath 'C:\Customer\53577900994246\appcenter.ms (1).har'
#$entry = $Global:trace.log.entries #| ForEach-Object { Write-ColorfulHost -object $_  -counter ([int]$Global:colorwheel++) }
#Get-AppCenterApiCalls

#Get-TraceResponseMatchingUrls -SearchText "appcenter"
#Get-TraceRequestMatchingUrls -SearchText "appcenter"
#$entry.request.url | Select-Object -Unique -Property Name| Group-Object | FT -AutoSize
#$requests | ForEach-Object { Write-ColorfulHost -object $_  -counter ([int]$Global:colorwheel++) }
#$response = $Global:trace.log.entries #| Select-Object -Property response #| ForEach-Object { Write-ColorfulHost -object $_  -counter ([int]$Global:colorwheel++) }
#$response.response | ForEach-Object { Write-ColorfulHost -object $_  -counter ([int]$Global:colorwheel++) }

#$entry.request.url | Select-Object -ExcludeProperty content
#$entry.response | Select-Object -ExcludeProperty content

#>

#endregion

#region GitHub Access Checker

<#
function Get-GithubRepositoryPermissions
{
    #https://docs.github.com/en/rest/collaborators/collaborators#get-repository-permissions-for-a-user
    param (
    [string] $ApiUserToken = $env:GitHubPat,
    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]
    [string] $owner,
    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]    
    [string]$repo,
    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]    
    [string]$username)
    
    #/repos/{owner}/{repo}/collaborators/{username}/permission
    $Uri = "https://api.github.com/repos/$owner/$repo/collaborators/$username/permission"

    $results = curl.exe -X GET $Uri -H "Content-Type: application/json" -H "accept: application/json" -H "Authorization: Bearer $ApiUserToken" | ConvertFrom-Json

    return $results
}

#endregion 

Get-GithubRepositoryPermissions -ApiUserToken "" -owner "tdevere" -repo "AppCenterSupportDocs" -username "tdevere"

#>


