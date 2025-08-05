# Dumping User Profiles from an SMB share

### Example:

#### 1) 

    smbclient -N \\\\TARGET_IP\\profiles$ -c ls | awk '{ print $1 }' > users.txt 
