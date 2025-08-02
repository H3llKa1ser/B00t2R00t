# Network-AD Environment

## NETWORK ENUMERATION

#### 1) 

    netstat -ano

#### 2) 

    arp -a

## ACTIVE DIRECTORY

#### 1) 

    systeminfo | findstr Domain

#### 2) 

    Get-ADUser -Filter *

#### 3) 

    Get-ADUser -Filter * -SearchBae "CN=Users,DC=EXAMPLE,DC=com"
