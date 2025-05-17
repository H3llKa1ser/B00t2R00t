# Disable System Firewall

## Permissions: Administrator | SYSTEM

### 1) Cmd

##### Disable all profiles

    netsh advfirewall set allprofiles state off

##### Disable public profile

    netsh advfirewall set publicprofile state off

##### Disable domain profile

    netsh advfirewall set domainprofile state off

##### Disable current profile

    netsh advfirewall set  currentprofile state off

##### Enable all profiles

    netsh advfirewall set allprofiles state on

### 2) Powershell

##### Disable all profiles

    Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled False

##### Disable public profile

    Set-NetFirewallProfile -Profile public -Enabled False

##### Disable domain profile

    Set-NetFirewallProfile -Profile domain -Enabled False

##### Disable private profile

    Set-NetFirewallProfile -Profile private -Enabled False

##### Enable all profiles

    Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled True
