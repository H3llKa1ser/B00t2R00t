## Commands

#### 1) 

    cmdkey /list

#### 2) 

    runas /savecred /user:USER\DOMAIN cmd.exe

## Credential Injection

    runas.exe /netonly /user:DOMAIN\USERNAME cmd.exe


#### Use credentials we found in case that we don't know where to exactly use them.

### TIP:

#### With /netonly, it can accept any password.

