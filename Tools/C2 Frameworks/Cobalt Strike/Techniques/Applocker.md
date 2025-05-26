# Applocker

# Enumerate the Applocker policy via GPO

    beacon> powershell Get-DomainGPO -Domain dev-studio.com | ? { $_.DisplayName -like "*AppLocker*" } | select displayname, gpcfilesyspath

    beacon> download \\dev-studio.com\SysVol\dev-studio.com\Policies\{7E1E1636-1A59-4C35-895B-3AEB1CA8CFC2}\Machine\Registry.pol

    PS C:\Users\Attacker> Parse-PolFile .\Desktop\Registry.pol

# Enumerate the Applocker policy via Local Windows registry on machine 

    PS C:\Users\Administrator> Get-ChildItem "HKLM:Software\Policies\Microsoft\Windows\SrpV2"

    PS C:\Users\Administrator> Get-ChildItem "HKLM:Software\Policies\Microsoft\Windows\SrpV2\Exe"

# Using powershell on local system

    PS C:\Users\Administrator> $ExecutionContext.SessionState.LanguageMode
    ConstrainedLanguage

# Navigating Laterally via PSEXEC is fine, as service binary is uploaded in C:\Winodws path which is by default whitelisted

# Find the writable path within C:\winodws to bypass Applocker

    beacon> powershell Get-Acl C:\Windows\Tasks | fl

