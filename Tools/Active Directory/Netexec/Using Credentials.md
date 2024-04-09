# Using Credentials

### Every protocol supports using credentials in one form or another. For details on using credentials with a specific protocol, see the appropriate wiki section.

#### netexec <protocol> <target(s)> -u username -p password

## When using usernames or passwords that contain special symbols (especially exclaimation points!), wrap them in single quotes to make your shell interpret them as a string.

#### Example: netexec <protocol> <target(s)> -u username -p 'October2022!'

## Due to a bug in Python's argument parsing library, credentials beginning with a dash (-) will throw an expected at least one argument error message. To get around this, specify the credentials by using the 'long' argument format (note the = sign):

#### netexec <protocol> <target(s)> -u='-username' -p='-October2022'

# Using a Credential Set from the database

### By specifying a credential ID (or multiple credential IDs) with the -id flag nxc will automatically pull that credential from the back-end database and use it to authenticate (saves a lot of typing):

#### netexec <protocol> <target(s)> -id <cred ID(s)>
