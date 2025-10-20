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

## SMTP Relay Attacks

An SMTP relay attack occurs when an attacker takes advantage of an improperly configured SMTP server that allows unauthorized third parties to send emails through it (known as an open relay). These attacks often result in the server being used to send spam or malicious emails.

### Attack process

1. The attacker identifies an SMTP server with open relay functionality.

2. They craft an email with a spoofed sender address and send it via the open relay server.

3. The SMTP server forwards the email to the recipient as though it came from the spoofed address, potentially bypassing spam filters.

### Tools to detect it:

Nmap 

    nmap -p 25 --script smtp-open-relay IP

Open Relay Test Tools

Several online tools are available to test whether an SMTP server is configured as an open relay.

## Brute force attack

Hydra

    hydra -l user -P /path/to/passwords.txt smtp://IP -V

Medusa

    medusa -h IP -u user -P /path/to/passwords.txt -M smtp

Metasploit

    use auxiliary/scanner/smtp/smtp_login 
    set RHOSTS IP 
    set USER_FILE /path/to/usernames.txt 
    set PASS_FILE /path/to/passwords.txt 
    run

