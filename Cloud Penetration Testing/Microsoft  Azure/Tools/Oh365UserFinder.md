# Oh365UserFinder

## Link: https://github.com/dievus/Oh365UserFinder

### Usage:

#### 1) Check for a single user

    python3 oh365userfinder.py -e USER.NAME@DOMAIN.CORP 

#### 2) Enumerate the mail format of a target. Check for various different emails on different formats by reading a single file.

    python3 oh365userfinder.py -r emails.txt 

#### 3) Perform a password spray attack

    python3 oh365userfinder.py -p PASSWORD --pwspray --elist VALID_USERS.txt 
