# Plaintext password credentials (Password reuse)

When we land on a machine, we might look for easy wins like hard-coded credentials or default credentials.

### 1) Enumerate users on the machine

Linux

    cat /etc/password

Windows

    dir C:\Users\

### 2) Files that might contain credentials

WordPress installation

    wp-config.php
