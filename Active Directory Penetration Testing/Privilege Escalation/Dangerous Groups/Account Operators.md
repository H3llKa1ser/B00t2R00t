# Account Operators

The members of this group can add and modify all the non admin users and groups. Since LAPS ADM and LAPS READ are considered as non admin groups, it's possible to add an user to them, and read the LAPS admin password. They also can manage the Server Operators group members which can authenticate on the DC.

## 1) Add user to LAPS groups

    Add-DomainGroupMember -Identity 'LAPS ADM' -Members 'user1' -Credential $cred -Domain "domain.local"
    Add-DomainGroupMember -Identity 'LAPS READ' -Members 'user1' -Credential $cred -Domain "domain.local"

## 2) Read LAPS password

    Get-DomainComputer <computername> -Properties ms-mcs-AdmPwd,ComputerName,ms-mcs-AdmPwdExpirationTime

