# Cloudfox

## Link: https://github.com/BishopFox/cloudfox

### Commands

#### 1) Runs the program to see available usage

    ./cloudfox 

#### 2) Lists available commands based on the platform specified

    ./cloudfox aws/azure/gcp 

### Loot output

    ~/.cloudfox/cloudfox-output/aws/ID/json

## PROTIP: In some uses, cloudfox writes a file that contains the commands to use your loot more efficiently.

### Example: 

    /home/USER/.cloudfox/cloudfox-output/aws/909174020271-AIDA5HLX6TCX4JECDJQRL-909174020271/loot/pull-secrets-commands.txt

## AWS (All commands are run based on authenticated account context)

#### 1) Enumerates various AWS resources

    cloudfox aws inventory 

#### 2) Maps IAM users to keys

    cloudfox aws access-keys 

#### 3) Enumerates lambda instances

    cloudfox aws lambda 

#### 4) Returns all stored secrets from SecretsManager and SSM (AWS Systems Manager) that are accessible to us

    cloudfox aws secrets 

#### 5) Returns environmental variables that might have been configured from a lambda instance

    cloudfox aws env-vars 
