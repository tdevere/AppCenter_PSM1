<#
 .Synopsis
  Return Unix DateTime UtcNow

 .Description
  Return Unix DateTime UtcNow

#>

function Get-UnixDateTime
{
    return [DateTimeOffset]::UtcNow.ToUnixTimeMilliseconds()
}

Export-ModuleMember -Function Get-UnixDateTime