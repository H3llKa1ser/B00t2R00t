# IIS Windows

### 1) Tilde Enumeration

Tool: https://github.com/lijiejie/iis_shortname_Scanner

    python3 iis_shortname_scan.py http://TARGET_IP/

Examples

| Short Name Discovered                                  | Likely Full Name                      | Why It Matters                                                                   |
|--------------------------------------------------------|----------------------------------------|----------------------------------------------------------------------------------|
| `BACKUP~1/BackupFiles/`, `Backup_2024/`                | Backup data                            | Likely contains sensitive information                                           |
| `ADMINI~1/AdminInterface/`, `Administration/`          | Admin panel                            | Restricted access; potential control over the system                            |
| `CONFIG~1.ASPconfiguration.asp`, `config_old.asp`      | Configuration file                      | May contain credentials or other sensitive system settings                      |
| `USERS_~1.XLSusers_backup.xlsx`                         | User data export                        | High‑value target containing personally identifiable information (PII)          |
