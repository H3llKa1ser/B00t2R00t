### Use our own SMB server on linux to host files:

### Location: /etc/samba/smb.conf

### Steps:

#### 1) sudo nano /etc/samba/smb.conf

#### 2) In the configuration file, make these changes:

#### [profiles] (Name it whatever you want)
####   comment = Insert whatever you want here
####   path = /srv/smb
####   guest ok = yes
####   browseable = yes
####   create mask = 0600

#### 3)  cd /srv/smb (Go into the directory you configured in the smb.conf file)

#### 4) Create any file of your choice

#### 5) sudo systemctl start smbd (Start SMB server)
