# AD Pentesting Methodologies 

## PASSWORD ATTACKS:

### Check C:\Users\ directory to add local users to a users.txt file (Post exploitation. Used for pivoting/lateral movement)

### net user /domain (Enumerate all domain users)

### Let’s say we have smb and winrm open. We will run it like this:

#### Spray with continue on success users.txt and passwords.txt.

#### Same as #1 but with local-auth

#### Spray uncracked ntlm hashes to all users in users.txt (If we dumped them with secretsdump)

#### Same as #3 but with local-auth
