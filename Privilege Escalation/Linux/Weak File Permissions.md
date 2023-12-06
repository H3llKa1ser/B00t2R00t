# Example:

## Readable/writeable /etc/shadow

### Use JohnTheRipper to crack it ( Readable)

### mkpasswd -m sha-512 PASSWORD

### edit /etc/shadow and replace root password with yours ( Writeable )

## Writeable /etc/passwd

### openssl passwd PASSWORD

### Edit passwd file and place generated password to root user's row replacing X

### OR copy root user's row to the bottom of the file, change first instance to any name and place generated password hash replacing the X

## TIP: Config files may contain sensitive information (passwords) to privesc as well.
