# SMTP

PORT 25 (relying server to server) 465 (mail client to server)

You can send phishing email with this port to get reverse shell.

### 1) Enumeration

Used to send, receive, and relay outgoing emails and Main attacks are user enumeration and using an open relay to send spam

    nmap 192.168.10.10 --script=smtp* -p 25

Enumerate existing users 

    smtp-user-enum -M VRFY -U /usr/share/seclists/Usernames/Names/names.txt -t domain.local

#### Default results from this wordlist

    bin
    irc
    mail
    man
    root
    sys

### 2) Username Generation

Upon finding potential users by browsing on a web app, use this generator script

    wget https://raw.githubusercontent.com/jseidl/usernamer/master/usernamer.py

Run the script by creating a permutated wordlist of a username

    python2 usernamer.py -n 'user name'

OR gather any names you find in a text file, and run the script to generate permutations for all of the names in the file

    python2 usernamer.py -f usernames.txt

Now, validate them by running smtp-user-enum, then add the users found in a validusers.txt file

    smtp-user-enum -M VRFY -U usernames.txt -t domain.local

Create a custom wordlist if you find a lot of content in a web app

    cewl -d 5 -m 3 http://postfish.off/team.html -w /home/kali/Desktop/cewl.txt

Attack with Hydra

Login with

    telnet IP 25
