## TOOLS:

### smbmap, smbget, smbclient

## SMBMAP/SMBGET:

#### 1) smbmap -H TARGET_IP/DOMAIN -r SHARE

#### 2) smbget -R smb://TARGET_IP/DOMAIN/SHARE (Download everything in the specific share)

## SMBCLIENT:

#### 1) smbclient -L \\\\TARGET_IP\\ (Enumerate shares)

#### 2) smbclient -U USER \\\\TARGET_IP\\SHARE 

#### Upon login into an SMB session:

#### 3) RECURSE ON

#### 4) PROMPT OFF

#### 5) mget * (Download ALL files/directories within the share)

### TIP: If SMB accepts anonymous sessions, we can use the username "anonymous" with no password, or just login with no username/password (Null session)

#### 1) allinfo FILE.TXT (Check the information about a file, it might contain data within Alternate Data Streams (ADS)

#### 2) get FILE.TXT (Download file to our machine)

#### 3) cat FILE.txt:VARIABLE (Print the output of the file with the ADS variable data)
