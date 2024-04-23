# Directory Service Restore Mode (DSRM)

 - Powershell New-ItemProperty "HKLM:\System\CurrentControlSet\Control\Lsa\* -Name "DsrmAdminLogonBehavior" -Value 2 -PropertyType DWORD
