
function Get-UnixDateTimeMilliseconds
{
  <#
 .Synopsis
  Return [DateTimeOffset]::UtcNow.ToUnixTimeMilliseconds()

 .Description
  Return [DateTimeOffset]::UtcNow.ToUnixTimeMilliseconds()

#>
    return [DateTimeOffset]::UtcNow.ToUnixTimeMilliseconds()
}

Export-ModuleMember -Function Get-UnixDateTimeMilliseconds