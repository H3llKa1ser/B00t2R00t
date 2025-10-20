# Simple Mail Transfer Protocol (SMTP) Penetration Testing

Port: 25

## Enumeration

#### 1) Check for information about the server version, etc

Telnet

    telnet IP 25

Netcat (nc)

    nc IP 25

Nmap

    nmap -sV -p 25 IP

#### 2) User enumeration

SMTP commands

VRFY (250 OK means the user is valid)

    VRFY admin@domain.com

EXPN (Reveal the members of a mailing list)

    EXPN staff@domain.com

RCPT TO

    RCPT TO:whatever@domain.com

### Tools:

Metasploit

    use auxiliary/scanner/smtp/smtp_enum 
    set RHOSTS IP  
    set USER_FILE /path/to/usernames.txt 
    run

Nmap

    nmap --script smtp-enum-users -p IP

SMTP User Enum

    smtp-user-enum -M VRFY -U /path/to/userlist.txt -t IP

#### 3) Timing-based enumeration

The attacker sends an email using RCPT TO commands for different users and measures the time taken for the server to respond. A slower response for invalid users can indicate successful user enumeration.

Example:

    RCPT TO:valid_user@domain.com

Response time: 150ms

    RCPT TO:invalid_user@domain.com

Response time: 100ms

#### 4) SMTP Response Code Analysis

Even when VRFY and EXPN are disabled, variations in the SMTP server’s response codes can indicate whether a user exists. For example:

    250 OK: Valid user.
    550 No such user: Invalid user.

#### 5) Email Headers

Analyzing email headers can sometimes reveal internal information about the mail server, including valid email addresses or internal forwarding addresses.

