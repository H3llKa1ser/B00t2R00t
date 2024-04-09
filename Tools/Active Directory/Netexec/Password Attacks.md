# Password Attacks

### All protocols support brute-forcing and password spraying. For details on brute-forcing/password spraying with a specific protocol, see the appropriate wiki section.

### By specifying a file or multiple values nxc will automatically brute-force logins for all targets using the specified protocol:

# Brute Force and Password Spray

#### netexec <protocol> <target(s)> -u username1 -p password1 password2 (Brute Force)

#### netexec <protocol> <target(s)> -u username1 username2 -p password1 (Password Spray)

#### netexec <protocol> <target(s)> -u ~/file_containing_usernames -p ~/file_containing_passwords

#### netexec <protocol> <target(s)> -u ~/file_containing_usernames -H ~/file_containing_ntlm_hashes 
