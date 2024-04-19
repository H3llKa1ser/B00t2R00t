# Pre-Created Computer Account password

### When Assign this computer account as a pre-Windows 2000 computer checkmark is checked, the password for the computer account becomes the same as the computer account in lowercase. For instance, the computer account SERVERDEMO$ would have the password serverdemo.

#### 1) Create a machine with default password

### Must be run from a domain joined device connected to the domain

 - djoin /PROVISION /DOMAIN <fqdn> /MACHINE evilpc /SAVEFILE C:\temp\evilpc.txt /DEFPWD

#### 2) When you attempt to login using the credential you should have the following error code : STATUS_NOLOGON_WORKSTATION_TRUST_ACCOUNT .

#### 3) Then you need to change the password with rpcchangepwd.py
