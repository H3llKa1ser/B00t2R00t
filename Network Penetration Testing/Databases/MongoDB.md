# MongoDB

#### 1) Run nmap 

Brute-force attacl

    nmap -sV --script mongodb-brute -n -p 27017 <IP>

Enumeration

    nmap -sV --script "mongo* and default" -p 27017 <IP>

#### 2) Metasploit MongoDB Login Scanner

    use auxiliary/scanner/mongodb/mongodb_login
    set RHOSTS <target_ip>
    set RPORT 27017
    run

#### 3) Manual Interaction via PyMongo



    from pymongo import MongoClient
    client = MongoClient('host', 27017, username='username',
    password='password')
    client.server_info() # Retrieve basic server info
    admin = client.admin #If we have admin creds available
    admin_info = admin.command("serverStatus")
    
    # List databases
    cursor = client.list_databases()
    for db in cursor:
    print(db)
    print(client[db["name"]].list_collection_names())

#### 4) MongoDB commands

    show dbs # List databases
    use <db> # Switch to the desired database
    show collections # List collections in the selected database
    db.<collection>.find() # Dump the contents of a collection
    db.<collection>.count() # Get the number of records in the collection
    db.current.find({"username":"admin"}) # Search for a specific user

#### 5) MongoDB Login methods

Basic MongoDB login without specifying a database:

    mongo <HOST>

Specify both host and port:

    mongo <HOST>:<PORT>

Specify a particular database:

    mongo <HOST>:<PORT>/<DB>

Login with a username and password:

    mongo <database> -u <username> -p '<password>'

If no credentials are required, you’ll gain access to the instance. However, if
authentication is enabled, you’ll need valid credentials

#### 6) Manual Inspection

Configuration file: mongo.db

Bitnami MongoDB setup

    /opt/bitnami/mongodb/mongodb.conf

Check if authentication is not required (noauth enabled). If true, then MongoDB is running without authentication.

    grep "noauth.*true" /opt/bitnami/mongodb/mongodb.conf | grep -v "^#"

Connect to MongoDB without authentication

    mongo <TARGET_IP>:27017

