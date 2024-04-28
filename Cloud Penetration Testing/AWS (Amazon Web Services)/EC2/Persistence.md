# AWS EC2 Persistence

### All the persistence techniques works here, SSH persistence, vim backdoor and so on.

# Example: SSH

#### 1) Generate SSH Key pair

 - ssh-keygen

#### 2) Add publick key to authorized_keys

 - echo "PUBLIC_Key" >> /home/user/.ssh/authorized_keys

#### 3) Use the private key to connect

 - ssh -i PRIVATE_KEY USER@INSTANCE
