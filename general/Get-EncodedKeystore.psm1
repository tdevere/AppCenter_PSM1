function Get-EncodedKeystore 
{
    <#
        .Synopsis
        Return [DateTimeOffset]::UtcNow.ToUnixTimeMilliseconds()

        .Description
        Return [DateTimeOffset]::UtcNow.ToUnixTimeMilliseconds()

    #>
    param
    (
        [Parameter(Mandatory)]
        [String]
        $KeystorePath
    )
    
    $EncodedText = "File Does Not Exists: $KeystorePath" #Automatic error message returned or the encoded text.

    if (Test-Path $KeystorePath)
    {
        $keystore = Get-Content $KeystorePath
        $bytes = [System.Text.Encoding]::Unicode.GetBytes($keystore)
        $EncodedText = [Convert]::ToBase64String($bytes)
    }

    return $EncodedText 
}

Export-ModuleMember -Function Get-EncodedKeystore 