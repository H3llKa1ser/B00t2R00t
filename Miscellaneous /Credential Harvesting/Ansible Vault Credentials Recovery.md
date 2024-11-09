# Ansible Vault Credentials Recovery

## Tool: https://pypi.org/project/ansible-vault/

### Possible location: main.yml file of an ansible playbook

### Steps:

 - Place hash to a file

 - sed -i 's/^[ \t]*//' vault_hash.txt (Removes whitespaces)

 - ansible2john vault_hash.txt > john_hash.txt

 - john john_hash.txt --wordlist=/usr/share/wordlists/rockyou.txt

 - cat vault_hash.txt | ansible-vault decrypt (Decrypt ansible vault hash using the cracked password from John)
