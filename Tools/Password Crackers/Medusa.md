# Medusa

Can be used against various network protocols.

## Usage

#### 1) Brute-force attack

    medusa -h IP -u USER -P WORDLISTPASS.txt -M ftp

#### 2) Password Spraying

    medusa -h IP -U WORDLISTUSERS.txt -p PASSWORD -M ftp

#### 3) Credential Stuffing

    medusa -h IP -U WORDLISTUSERS.txt -P WORDLISTPASS.txt -M ftp

#### 4) Attack on multiple hosts

    medusa -H HOSTS.txt -U USERS.txt -P PASSWORDS.txt -M ftp

#### 5) Attack a specific port than default

    medusa -h IP -u USER -P WORDLISTPASS.txt -M ssh (Default port 22)

    medusa -h IP -u USER -P WORDLISTPASS.txt -M ssh -n 2222 (Attack port 2222)

#### 6) Check for null "" password and Same as Username password

    medusa -h IP -u USER -P WORDLISTPASS.txt -M ftp -e ns

#### 7) Save logs in a file

    medusa -h IP -u USER -P WORDLISTPASS.txt -M ftp -O log.txt

#### 8) Stop on Success

    medusa -h IP -u USER -P WORDLISTPASS.txt -M ftp -f

#### 9) Combo entries

    medusa -M ftp -C userpass.txt

Combinations

    host:user:password
    host:user:
    host::
    username:password
    username:
    password

#### 10) Module usage information

    medusa -h IP -u USER -P WORDLISTPASS.txt -M ftp -q
