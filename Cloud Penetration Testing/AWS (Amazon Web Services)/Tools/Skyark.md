# Skyark

## Github repo: https://github.com/cyberark/SkyArk

### Discover the most privileged users in the scanned AWS environment, including the AWS Shadow Admins

#### 1) Requires read-Only permissions over IAM service

 - powershell -ExecutionPolicy Bypass -NoProfile

 - Import-Module .\Skyark.ps1 -force

 - Start-AWStealth

## OR in the Cloud Console

 - Scan-AWShadowAdmins
