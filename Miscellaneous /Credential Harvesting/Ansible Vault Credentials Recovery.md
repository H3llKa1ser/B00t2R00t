# Ansible Vault Credentials Recovery

### Possible location: main.yml file of an ansible playbook

### Steps:

 - Place hash to a file

 - sed -i 's/^[ \t]*//' vault_hash.txt (Removes whitespaces)

 - ansible2john vault_hash.txt > john_hash.txt

 - john john_hash.txt --wordlist=/usr/share/wordlists/rockyou.txt
