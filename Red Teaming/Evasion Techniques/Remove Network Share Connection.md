# Remove Network Share Connection

## Permissions: Administrator | User

### 1) Net

    net use i: /delete
    net use l: /delete

### 2) Registry

##### Query for mapped drives
 
    reg query HKEY_CURRENT_USER\Network

    reg delete HKEY_CURRENT_USER\Network\i /f

##### Query secondary mapped drive keys

    reg query HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\MountPoints2

##### Delete secondary mapped drive keys

    reg delete HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\MountPoints2\##DC01#IT /f
