### Use our own SMB server on linux to host files:

### Location: /etc/samba/smb.conf

### Steps:

#### 1) sudo nano /etc/samba/smb.conf

#### 2) In the configuration file, do this configuration:

#### [profiles]
####   comment = Users profiles
####   path = /home/samba/profiles
####   guest ok = no
####   browseable = no
####   create mask = 0600
