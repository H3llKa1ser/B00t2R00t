# Cloudfox

## Link: https://github.com/BishopFox/cloudfox

### Commands

 - ./cloudfox (Runs the program to see available usage)

 - ./cloudfox aws/azure/gcp (Lists available commands based on the platform specified)

### Loot output

 - ~/.cloudfox/cloudfox-output/aws/ID/json

## PROTIP: In some uses, cloudfox writes a file that contains the commands to use your loot more efficiently.

### Example: /home/USER/.cloudfox/cloudfox-output/aws/909174020271-AIDA5HLX6TCX4JECDJQRL-909174020271/loot/pull-secrets-commands.txt

## AWS (All commands are run based on authenticated account context)

 - cloudfox aws inventory (Enumerates various AWS resources)

 - cloudfox aws access-keys (Maps IAM users to keys)

 - cloudfox aws lambda (Enumerates lambda instances)

 - cloudfox aws secrets (Returns all stored secrets from SecretsManager and SSM (AWS Systems Manager) that are accessible to us)
