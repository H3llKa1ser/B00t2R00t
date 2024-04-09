# Bloodhound Integration

### NetExec will set user as 'owned' on BloodHound when an account is found ! Very usefull when lsassy finds 20 credentials in one dump :)

### First you need to configure your config file in you home folder: ~/.nxc/nxc.conf and add the following lines:

[BloodHound]

bh_enabled = True

bh_uri = 127.0.0.1

bh_port = 7687

bh_user = user

bh_pass = pass

# Bloodhound Ingestor

### To ingest the data of the Active Directory

#### nxc ldap <ip> -u user -p pass --bloodhound -ns <ns-ip> --collection All 

## Note: If it doesn't work, use the fakedns tool
