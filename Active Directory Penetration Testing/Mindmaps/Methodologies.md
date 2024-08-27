# AD Pentesting Methodologies 

## PASSWORD ATTACKS, POST-EXPLOITATION AND PIVOTING EXAMPLE:

- Check C:\Users\ directory to add local users to a users.txt file (Post exploitation. Used for pivoting/lateral movement)

- net user /domain (Enumerate all domain users)

- impacket-secretsdump administrator@IP_ADDRESS (Dump hashes locally to our machine if we have admin access).

### Then

 - hashcat -m 1000 -a 0 hashes.txt /usr/share/wordlist/rockyou.txt (Attempt to crack dumped hashes offline)

### Let’s say we have smb and winrm open. We will run it like this:

- Spray with continue on success users.txt and passwords.txt.

- Same as #1 but with local-auth

- Spray uncracked ntlm hashes to all users in users.txt (If we dumped them with secretsdump)

- Same as #3 but with local-auth

- If spraying does not give any good results, then we have the list of users and we can attempt to do an ASREP Roasting attack. If that doesn’t work and we have a username and password we can do a kerberoasting attack.

- If roasting does not provide us with anything. Then we go back to ms01 and enumerate every single thing we possibly can no matter how stupid it is. We might have missed a credential somewhere.

## AD ENUMERATION WITH CREDENTIALS OR HAVE A SESSION OF OUR COMPROMISED USER EXAMPLE:

 - Enumerate users (who are high priv. users -> your targets)

 - Enumerate groups

 - Are you part of any high priv. groups: DNSAdmins, Backup Operator....

 - Get Domain ACL ( you might have genericALL on important group/user,...)

 - Enumerate Service accounts ( Silver-ticket attack)

 - Do you have access to any shares

 - What services are in domain ?

 - Most of the times if you get foothold on one PC in domain you will have to escalate priv. so you can run mimikatz, this gives you option to: Get LSASS or LSA hash ( overpass the hash, pass the hash, crack hash with hashcat),

 - Also run responder: you never know, you might catch high value hash or hash of user that will enable you to move in DC domain or he might be part of some high priv. groups that will enable you to escalate to NT sys/ authority.
