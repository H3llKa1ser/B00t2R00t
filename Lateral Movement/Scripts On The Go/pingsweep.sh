for i in {1..255};do (ping -c 1 172.16.2.$i | grep "bytes from"|cut -d ' ' -f4|tr -d ':' &);done
