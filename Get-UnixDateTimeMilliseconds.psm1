<#
 .Synopsis
  Return [DateTimeOffset]::UtcNow.ToUnixTimeMilliseconds()

 .Description
  Return [DateTimeOffset]::UtcNow.ToUnixTimeMilliseconds()

#>

function Get-UnixDateTimeMilliseconds
{
    return [DateTimeOffset]::UtcNow.ToUnixTimeMilliseconds()
}

Export-ModuleMember -Function Get-UnixDateTimeMilliseconds