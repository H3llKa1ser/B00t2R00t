## Borg backups might contain sensitive credentials for horizontal/vertical privilege escalation

### COMMANDS

#### 1) borg list /LOCATION/OF/BACKUP/FOLDER/

#### 2) borg extract /BACKUP/FOLDER/::EXTRACTED_BACKUP_ID7382638726

#### Borgmatic config file might contain a password to use for extracting backup data

#### Possible location: /etc/borgmatic/config.yaml

