<#
 .Synopsis
  Return Start of Day DateTime in Seconds

 .Description
  Return Start of Day DateTime in Seconds
  [DateTimeOffset]::UtcNow.ToUnixTimeSeconds()
  
#>

function Get-UnixStartOfDayDateTimeSeconds
{
  [System.DateTimeOffset]$time = ([System.DateTime]::SpecifyKind([System.DateTime]::new((get-date).AddHours(-(Get-Date).Hour).AddMinutes(-(Get-Date).Minute).AddMilliseconds(-(Get-Date).Millisecond).Ticks), [System.DateTimeKind]::Utc))

  return $time.ToUnixTimeSeconds()

}


Export-ModuleMember -Function Get-UnixStartOfDayDateTimeSeconds
