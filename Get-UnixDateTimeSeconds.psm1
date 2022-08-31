<#
 .Synopsis
  Return [DateTimeOffset]::UtcNow.ToUnixTimeSeconds()

 .Description
  Return [DateTimeOffset]::UtcNow.ToUnixTimeSeconds()
#>

function Get-UnixDateTimeSeconds
{
    return [DateTimeOffset]::UtcNow.ToUnixTimeSeconds()
}


Export-ModuleMember -Function Get-UnixDateTimeSeconds
