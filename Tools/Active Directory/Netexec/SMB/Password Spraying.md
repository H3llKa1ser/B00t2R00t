# Password Spraying

### Using NetExec for password spraying

# Using Username/Password Lists

### You can use multiple usernames or passwords by seperating the names/passwords with a space.

#### nxc smb 192.168.1.101 -u user1 user2 user3 -p Summer18

#### nxc smb 192.168.1.101 -u user1 -p password1 password2 password3

## nxc accepts txt files of usernames and passwords. One user/password per line. Watch out for account lockout!

#### nxc smb 192.168.1.101 -u /path/to/users.txt -p Summer18

#### nxc smb 192.168.1.101 -u Administrator -p /path/to/passwords.txt

## NOTE: By default nxc will exit after a successful login is found. Using the --continue-on-success flag will continue spraying even after a valid password is found. Usefull for spraying a single password against a large user list Usage example:

#### nxc smb 192.168.1.101 -u /path/to/users.txt -p Summer18 --continue-on-success

# Checking 'username == password' using wordlist

#### nxc smb 192.168.1.101 -u user.txt -p user.txt --no-bruteforce --continue-on-success

# Checking multiple usernames/passwords using wordlist

#### nxc smb 192.168.1.101 -u user.txt -p password.txt

### The result will be:

 - user1 => password1

 - user1 => password2

 - user2 => password1

 - user2 => password2

## Be careful to not lock accounts using this technique!

# Checking one login equal one password using wordlist

### No bruteforce possible with this one as 1 user = 1 password

####  nxc smb 192.168.1.101 -u user.txt -p password.txt --no-bruteforce --continue-on-success

### The result will be:

 - user1 => password1

 - user2 => password2

## Avoid range or a list of IP when using option --no-bruteforce

