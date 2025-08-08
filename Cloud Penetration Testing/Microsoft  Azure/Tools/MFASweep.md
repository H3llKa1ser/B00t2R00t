# MFASweep

## Github repo: https://github.com/dafthack/MFASweep

### Use this tool to bypass MFA from users we have already guessed their credentials but have MFA enabled

### Example usage:

#### 1) Import MFASweep Module

    Import-Module .\MFASweep.ps1

#### 2) Use this to bypass Conditional Access policy

    Invoke-MFASweep -Username USERNAME@DOMAIN.LOCAL -Password test1234 

#### 3) Enumerate the presence of MFA on various online services, including Active Directory Federated Services ADFS

    Invoke-MFASweep -Username USER.NAME@DOMAIN.LOCAL -Password PASSWORD -Recon -IncludeADFS 
