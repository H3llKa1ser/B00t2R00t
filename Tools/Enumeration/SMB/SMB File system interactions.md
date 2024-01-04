## TOOLS:

### smbmap, smbget, smbclient

## SMBMAP/SMBGET:

#### 1) smbmap -H TARGET_IP/DOMAIN -r SHARE

#### 2) smbget -R smb://TARGET_IP/DOMAIN/SHARE (Download everything in the specific share)

## SMBCLIENT:

#### 1) smbclient -L \\\\TARGET_IP\\ (Enumerate shares)

#### 2) smbclient -U USER \\\\TARGET_IP\\SHARE 

### TIP: If SMB accepts anonymous sessions, we can use the username "anonymous" with no password, or just login with no username/password (Null session)
