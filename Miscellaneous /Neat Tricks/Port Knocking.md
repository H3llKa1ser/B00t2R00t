# Port Knocking

If you have the suspicion that a port (like 22 for example) needs to be "knocked" with a proper sequence for it to be opened, you should do these steps.

### 1) Find the configuration file via an LFI vulnerability for example 

    /etc/knockd.conf

Wordlist

    /usr/share/seclists/Fuzzing/LFI/LFI-etc-files-of-all-linux-packages.txt

### 2) According to the contents of the configuration file, activate the sequence

    knockd IP PORT1 PORT2 PORT3

### 3) Verify that the port is open

    nc -zv IP 22
