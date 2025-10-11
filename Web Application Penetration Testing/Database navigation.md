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

    \dt (Shows tables of the database)

#### 4) 

    select * from TABLE;

# REDIS-CLI SHELL NAVIGATION

#### 1) 

    redis-cli -h HOST -u USER -a PASSWORD -p PORT

#### 2) 

    CONFIG GET * (Query the configuration of the redis instance)

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
