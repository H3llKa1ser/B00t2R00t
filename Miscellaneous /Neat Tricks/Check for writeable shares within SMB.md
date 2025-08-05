# heck for writeable shares within SMB

### STEPS:

#### 1) 

    mount -t cifs -o rw,username=guest,password= '//TARGET_IP/SHARE' /mnt

#### Mount the share we have access to, on our machine

    cd /mnt 

#### 2) Run smbwriteableenum.sh script (Script located in Scripts folder in this repo)
