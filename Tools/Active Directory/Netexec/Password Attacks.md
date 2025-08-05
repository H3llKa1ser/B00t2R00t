# Password Attacks

### All protocols support brute-forcing and password spraying. For details on brute-forcing/password spraying with a specific protocol, see the appropriate wiki section.

### By specifying a file or multiple values nxc will automatically brute-force logins for all targets using the specified protocol:

# Brute Force and Password Spray

    netexec <protocol> <target(s)> -u username1 -p password1 password2 (Brute Force)

    netexec <protocol> <target(s)> -u username1 username2 -p password1 (Password Spray)

    netexec <protocol> <target(s)> -u ~/file_containing_usernames -p ~/file_containing_passwords

    netexec <protocol> <target(s)> -u ~/file_containing_usernames -H ~/file_containing_ntlm_hashes 

# Password Spraying without Bruteforce

### Can be usefull for protocols like WinRM and MSSQL. This option avoid the bruteforce when you use files (-u file -p file)

    netexec <protocol> <target(s)> -u ~/file_containing_usernames -H ~/file_containing_ntlm_hashes --no-bruteforce

    netexec <protocol> <target(s)> -u ~/file_containing_usernames -p ~/file_containing_passwords --no-bruteforce

##### user1 -> pass1

##### user2 -> pass2

## By default nxc will exit after a successful login is found. Using the --continue-on-success flag will continue spraying even after a valid password is found. Usefull for spraying a single password against a large user list.

#### Example: 

    netexec <protocol> <target(s)> -u ~/file_containing_usernames -H ~/file_containing_ntlm_hashes --no-bruteforce --continue-on-success
