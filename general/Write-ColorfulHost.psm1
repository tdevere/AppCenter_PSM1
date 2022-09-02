<#
 .Synopsis
    Send object to write to console and for each item in the collection, cycle between a set of 4 colors. 

 .Description
    Send object to write to console and for each item in the collection, cycle between a set of 4 colors.

 .Parameter Object
  Works on collections. 

 .Example
   # Retrieves list of App Center apps. Requires Environment variable 
   Write-ColorfulHost -Object $ListOfReports #$ListOfReports is fictional list of reports 
#>

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


Export-ModuleMember -Function Write-ColorfulHost