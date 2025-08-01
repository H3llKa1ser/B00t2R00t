## AD Group Templates (AdminSDHolder)

#### 1) RDP with low-pruv credentials

#### 2) runas /netonly /user:Administrator cmd.exe

#### 3) mmc

#### 4) File -> Add Snap-in -> Active Directory Users and Groups 

#### 5) View -> Advnaced Features

#### 6) Right-click -> Properties -> Security 

#### 7) Add

#### 8) Search for your low-priv username and click Check Names 

#### 9) OK

#### 10) Allow on Full Control

#### 11) Apply

#### 12) OK

# SDPROP

### We can wait for 60 minutes to apply or we can manually kick off the process.

#### 1) 

    Import-Module .\Invoke-ADSDPropagation.ps1

#### 2) 

    Invoke-ADSDPropagation

#### 3) Wait a minute and GG!

