# MONGODB SHELL NAVIGATION

## Commands

#### 1) mongo

#### 2) show databases;

#### 3) use DATABASE;

#### 4) show tables;

#### 5) db.TABLE.find() (Dump everything from table)

# MYSQL SHELL NAVIGATION

#### 1) mysql -u USER -h HOST -p PASSWORD

#### 2) show databases;

#### 3) use DATABASE;

#### 4) show tables;

#### 5) SELECT * FROM TABLE; (Dump everything from table)

## For root authentication there is a small detail:

#### mysql -h HOST -u root -proot ROOT_PASS -e 'SQL_QUERY;' (Use the -proot flag for the password of the root user in a db)

# POSTGRESQL SHELL NAVIGATION

#### 1) psql -h IP_ADDRESS -U USER DATABASE

#### psql.exe -h 127.0.0.1 -p 65432 -U postgres -d DATABASE -c "SQL COMMAND" (Default port for postgresql is 65432)

#### 2) \list (List all databases)

#### 3) \dt (Shows tables of the database)

#### 4) select * from TABLE;

# REDIS-CLI SHELL NAVIGATION

#### 1) redis-cli -h HOST -u USER -a PASSWORD -p PORT

#### 2) CONFIG GET * (Query the configuration of the redis instance)

# KPCLI SHELL NAVIGATION (ALTERNATIVE: KEEPASS2 WHICH IS A GUI)

#### 1) kpcli

#### 2) open DATABASE.kdbx (Connect to the Keepass database. Keep in mind you need to enter credentials to successfully connect)

#### 3) ls (List files)

#### 4) cd DIR (Change directory)

#### 5) show NUM -f (Print contents of the specified file)
