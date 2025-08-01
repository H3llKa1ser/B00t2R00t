# Ansible Vault Credentials Recovery

## Tool: https://pypi.org/project/ansible-vault/

### Possible location: main.yml file of an ansible playbook

### Steps:

#### 1) Place hash to a file


#### 2) 
       
    sed -i 's/^[ \t]*//' vault_hash.txt (Removes whitespaces)

#### 3) 

    ansible2john vault_hash.txt > john_hash.txt

#### 4) 

    john john_hash.txt --wordlist=/usr/share/wordlists/rockyou.txt

#### 5) Decrypt ansible vault hash using the cracked password from John

    cat vault_hash.txt | ansible-vault decrypt 
