# HYDRA ONLINE PASSWORD CRACKER

## Supports A LOT of protocols

### Commands:

#### -t 4 = Number of parallel connections per target

#### -l USER = Points to the user who's account to compromise (Brute-force)

#### -L = Wordlist for users

#### -p PASSWORD = Points to password to find user (Password spray)

#### -P = Wordlist for passwords

#### -vv = Very verbose

#### protocol = ftp, ssh, http-post-form (Requires login error to work), http-get, etc.

### Example: hydra -l USER -P LIST -f TARGET_IP http-get /directory/

## JSON brute force with hydra

### Example:

#### hydra -l USER -P rockyou.txt TARGET_IP -s TARGET_PORT http-post-form "/api/session/authenticate{\"username\"\:\"^USER^\",\"password\"\:\"^PASS^\"}:Authentication failed:H=Content-Type\: application/json" -t 64
