# Manual Enumeration


Approach permission checker/cron job/

cmd: ls -la /etc/passwd/ | ls -la /etc/shadow -- > check read/write permission | sudo su

sudo -l ( https://gtfobins.github.io/#)

find / -user root -perm -4000 -print 2>/dev/null

getcap -r / 2>/dev/null (capabilities)(cap_setuid+ep)

find / -perm -u=s -type f 2>/dev/null

find / -type f -perm 0777 | find / -writable -type d 2>/dev/null

cat /etc/crontab (normal) | grep "CRON" /var/log/syslog (wildcards)

history | cat .bashrc

GoldMine Password/plaintext

Backup files

Kernel Search with Google
