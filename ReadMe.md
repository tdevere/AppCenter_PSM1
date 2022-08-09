# PowerShell Script Module Library - AppCenter Administration Tools

## Setup
Run the [Setup Script](/Setup.ps1) as an administrator. This script copies the PowerShell modules within this repository to the Powershell modules directory on your system. This makes running the commands natively to your PowerShell session simple and easy to use. 

``` To increase productiviy create an environment variable to store your App Center User Token named: ApiUserToken. Doing so allows you to avoid having to pass this paramter in each PowerShell module ```

## PowerShell Module List
| Function | Synopsis |
|----------|----------|
| [Get-AppCenterAppsByOrg](/Get-AppCenterAppsByOrg.psm1) | Retrieves list of App Center Apps. |
|[Get-AppCenterOrganizations](/Get-AppCenterOrganizations.psm1) |Retrieves list of App Center Organazations.
## To-Do
We need to determine which platform we're running on. If Mac/Linux, we'll need to change details which support those platforms. Currently (8/9/2022) we only support the Windows Platform. However, there's nothing to prevent us from supporting any Platform PowerShell is supported.